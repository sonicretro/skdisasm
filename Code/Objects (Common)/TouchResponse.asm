; =============== S U B R O U T I N E =======================================


TouchResponse_CompetitionMode:
		nop
		move.w	x_pos(a0),d2				; Get player's x_pos
		move.w	y_pos(a0),d3				; Get player's y_pos
		subi.w	#4,d2					; Subtract Obj_Sonic2P's x_radius-1 from x_pos
		moveq	#0,d5
		move.b	y_radius(a0),d5
		subq.b	#3,d5
		sub.w	d5,d3
		move.w	#8,d4					; Player's width
		add.w	d5,d5
		bra.s	Touch_Process
; ---------------------------------------------------------------------------

TouchResponse:
		nop
		jsr	(Test_Ring_Collisions).l
		bsr.w	ShieldTouchResponse
		tst.b	character_id(a0)			; Is the player Sonic?
		bne.s	Touch_NoInstaShield			; If not, branch
		move.b	status_secondary(a0),d0
		andi.b	#$73,d0					; Does the player have any shields or is invincible?
		bne.s	Touch_NoInstaShield			; If so, branch

; TouchResponse_InstaShield:
		; By this point, we're focusing purely on the Insta-Shield
		cmpi.b	#1,double_jump_flag(a0)			; Is the Insta-Shield currently in its 'attacking' mode?
		bne.s	Touch_NoInstaShield			; If not, branch
		move.b	status_secondary(a0),d0			; Get status_secondary...
		move.w	d0,-(sp)				; ...and save it
		bset	#Status_Invincible,status_secondary(a0)	; Make the player invincible
		move.w	x_pos(a0),d2				; Get player's x_pos
		move.w	y_pos(a0),d3				; Get player's y_pos
		subi.w	#$18,d2					; Subtract width of Insta-Shield
		subi.w	#$18,d3					; Subtract height of Insta-Shield
		move.w	#$30,d4					; Player's width
		move.w	#$30,d5					; Player's height
		bsr.s	Touch_Process
		move.w	(sp)+,d0				; Get the backed-up status_secondary
		btst	#Status_Invincible,d0			; Was the player already invincible (wait, what? An earlier check ensures that this can't happen)
		bne.s	.alreadyinvincible			; If so, branch
		bclr	#Status_Invincible,status_secondary(a0)	; Make the player vulnerable again

	.alreadyinvincible:
		moveq	#0,d0
		rts
; ---------------------------------------------------------------------------

Touch_NoInstaShield:
		move.w	x_pos(a0),d2				; Get player's x_pos
		move.w	y_pos(a0),d3				; Get player's y_pos
		subi.w	#8,d2					; Subtract Obj_Sonic's x_radius-1 from x_pos (becomes player's left collision boundary)

		moveq	#0,d5
		move.b	y_radius(a0),d5
		subq.b	#3,d5					; Now player's collision height
		sub.w	d5,d3
		; Note the lack of a check for if the player is ducking
		; Height is no longer reduced by ducking
		move.w	#$10,d4					; Player's collision width
		add.w	d5,d5

Touch_Process:
		lea	(Collision_response_list).w,a4
		move.w	(a4)+,d6				; Get number of objects queued
		beq.s	locretK_FF1C				; If there are none, return

Touch_Loop:
		movea.w	(a4)+,a1				; Get address of first object's RAM
		move.b	collision_flags(a1),d0			; Get its collision_flags
		bne.s	Touch_Width				; If it actually has collision, branch

Touch_NextObj:
		subq.w	#2,d6					; Count the object as done
		bne.s	Touch_Loop				; If there are still objects left, loop
		moveq	#0,d0

locretK_FF1C:
		rts
; ---------------------------------------------------------------------------

Touch_Width:
		andi.w	#$3F,d0					; Get only collision size
		add.w	d0,d0					; Turn into index
		lea	Touch_Sizes(pc,d0.w),a2
		moveq	#0,d1
		move.b	(a2)+,d1				; Get width value from Touch_Sizes
		move.w	x_pos(a1),d0				; Get object's x_pos
		sub.w	d1,d0					; Subtract object's width
		sub.w	d2,d0					; Subtract player's left collision boundary
		bcc.s	.checkrightside				; If player's left side is to the left of the object, branch
		add.w	d1,d1					; Double object's width value
		add.w	d1,d0					; Add object's width*2 (now at right of object)
		bcs.s	Touch_Height				; If carry, branch (player is within the object's boundaries)
		bra.s	Touch_NextObj				; If not, loop and check next object
; ---------------------------------------------------------------------------

	.checkrightside:
		cmp.w	d4,d0					; Is player's right side to the left of the object?
		bhi.s	Touch_NextObj				; If so, loop and check next object

Touch_Height:
		moveq	#0,d1
		move.b	(a2)+,d1				; Get height value from Touch_Sizes
		move.w	y_pos(a1),d0				; Get object's y_pos
		sub.w	d1,d0					; Subtract object's height
		sub.w	d3,d0					; Subtract player's bottom collision boundary
		bcc.s	.checktop				; If bottom of player is under the object, branch
		add.w	d1,d1					; Double object's height value
		add.w	d1,d0					; Add object's height*2 (now at top of object)
		bcs.w	Touch_ChkValue				; If carry, branch (player is within the object's boundaries)
		bra.s	Touch_NextObj				; If not, loop and check next object
; ---------------------------------------------------------------------------

	.checktop:
		cmp.w	d5,d0					; Is top of player under the object?
		bhi.s	Touch_NextObj				; If so, loop and check next object
		bra.w	Touch_ChkValue
; ---------------------------------------------------------------------------
; collision sizes (width,height)
Touch_Sizes:
		dc.b    4,   4
		dc.b  $14, $14
		dc.b   $C, $14
		dc.b  $14,  $C
		dc.b    4, $10
		dc.b   $C, $12
		dc.b  $10, $10
		dc.b    6,   6
		dc.b  $18,  $C
		dc.b   $C, $10
		dc.b  $10,   8
		dc.b    8,   8
		dc.b  $14, $10
		dc.b  $14,   8
		dc.b   $E,  $E
		dc.b  $18, $18
		dc.b  $28, $10
		dc.b  $10, $18
		dc.b    8, $10
		dc.b  $20, $70
		dc.b  $40, $20
		dc.b  $80, $20
		dc.b  $20, $20
		dc.b    8,   8
		dc.b    4,   4
		dc.b  $20,   8
		dc.b   $C,  $C
		dc.b    8,   4
		dc.b  $18,   4
		dc.b  $28,   4
		dc.b    4,   8
		dc.b    4, $18
		dc.b    4, $28
		dc.b  $18, $18
		dc.b  $18, $18
		dc.b   $C, $18
		dc.b  $48,   8
		dc.b  $18, $28
		dc.b  $10,   4
		dc.b  $20,   2
		dc.b  $10, $1C
		dc.b   $C, $24
		dc.b  $10,   2
		dc.b    4, $40
		dc.b  $18, $40
		dc.b  $20, $10
		dc.b  $1C, $14
		dc.b  $10,   2
		dc.b  $10,   1
		dc.b    2,   8
	if ~~Sonic3_Alone
		dc.b  $10, $40
		dc.b   $C,   4
		dc.b    8,  $C
		dc.b  $28, $20
		dc.b  $40,   2
		dc.b  $60,   2
		dc.b  $28, $28
	endif
; ---------------------------------------------------------------------------

Touch_ChkValue:
		move.b	collision_flags(a1),d1			; Get its collision_flags
		andi.b	#$C0,d1					; Get only collision type bits
		beq.w	Touch_Enemy				; If 00, enemy, branch
		cmpi.b	#$C0,d1
		beq.w	Touch_Special				; If 11, "special thing for starpost", branch
		tst.b	d1
		bmi.w	Touch_ChkHurt				; If 10, "harmful", branch
		; If 01...
		move.b	collision_flags(a1),d0			; Get collision_flags
		andi.b	#$3F,d0					; Get only collision size
		cmpi.b	#6,d0					; Is touch response $46 ?
		beq.s	Touch_Monitor				; If yes, branch
		move.b	(Player_1+invulnerability_timer).w,d0	; Get the main character's invulnerability_timer
		tst.w	(Competition_mode).w			; Is the competition mode?
		beq.s	.notcompetition				; If not, branch
		move.b	invulnerability_timer(a0),d0		; Get invulnerability_timer from whoever branched to TouchResponse

	.notcompetition:
		cmpi.b	#90,d0					; Is there more than 90 frames on the timer remaining?
		bhs.w	.return					; If so, branch
		move.b	#4,routine(a1)				; Set target object's routine to 4 (must be reserved for collision response)

	.return:
		rts
; ---------------------------------------------------------------------------

Touch_Monitor:
	if Sonic3_Alone
		tst.w	y_vel(a0)				; Get player's y_vel
		bpl.s	.checkdestroy				; If player is moving down, branch
		move.w	y_pos(a0),d0				; Get player's y_pos
		subi.w	#$10,d0					; Subtract height of monitor from it
		cmp.w	y_pos(a1),d0
		blo.s	.return					; If new value is lower than monitor's y_pos, return
	else
		move.w	y_vel(a0),d0				; Get player's y_vel
		tst.b	(Reverse_gravity_flag).w		; Are we in reverse gravity mode?
		beq.s	.normalgravity				; If not, branch
		neg.w	d0					; Negate player's y_vel

	.normalgravity:
		btst	#1,render_flags(a1)			; Is the monitor upside down?
		beq.s	.monitornotupsidedown			; If not, branch
		tst.w	d0
		beq.s	.checkdestroy				; If player isn't moving up or down at all, branch
		bmi.s	.checkdestroy				; If player is moving up, branch
		bra.s	.checkfall				; If player is moving down, branch
; ---------------------------------------------------------------------------

	.monitornotupsidedown:
		tst.w	d0
		bpl.s	.checkdestroy				; If player is moving down, branch

	.checkfall:
		; This check is responsible for S&K's monitors not falling if hit from below (but only in regular gravity. See below)
		btst	#1,status(a1)				; Is the monitor upside down (different way of checking)?
		beq.s	.checkdestroy				; If not, branch
		btst	#1,render_flags(a1)			; Is the monitor upside down?
		bne.s	.monitorupsidedown			; If so, branch
		move.w	y_pos(a0),d0				; Get player's y_pos
		subi.w	#$10,d0					; Subtract height of monitor from it
		cmp.w	y_pos(a1),d0
		blo.s	.return					; If new value is lower than monitor's y_pos, return
		bra.s	.monitorfall
; ---------------------------------------------------------------------------

	.monitorupsidedown:
		move.w	y_pos(a0),d0				; Get player's y_pos
		addi.w	#$10,d0					; Add height of monitor from it
		cmp.w	y_pos(a1),d0
		bhs.s	.return					; If new value is higher than monitor's y_pos, return

	.monitorfall:
	endif
		; Fun fact: In S3, like the games before it, hitting a monitor from below would make it fall
		; In S&K, that was removed, and they are destroyed as normal.
		; However, according to this code, if a monitor is upside down, and player is in reverse gravity,
		; hitting the monitor from below will still make it fall.
		; Playing with Debug Mode confirms this.
		neg.w	y_vel(a0)				; Reverse Sonic's y-motion
		move.w	#-$180,y_vel(a1)
		tst.b	routine_secondary(a1)
		bne.s	.return
		move.b	#4,routine_secondary(a1)		; Set the monitor's routine_secondary counter
		rts
; ---------------------------------------------------------------------------

	.checkdestroy:
		cmpa.w	#Player_1,a0				; Is this the main character?
		beq.s	.validcharacter				; If so, branch
		tst.w	(Competition_mode).w			; Are we in competition mode?
		beq.s	.return					; If not, return

	.validcharacter:
		cmpi.b	#2,anim(a0)				; Is player in his rolling animation?
	if ~~Sonic3_Alone
		beq.s	.okaytodestroy				; If so, branch
		cmpi.b	#2,character_id(a0)			; Is player Knuckles?
		bne.s	.return					; If not, return
		cmpi.b	#1,double_jump_flag(a0)			; Is Knuckles gliding?
		beq.s	.okaytodestroy				; If so, branch
		cmpi.b	#3,double_jump_flag(a0)			; Is Knuckles sliding across the ground after gliding?
	endif
		bne.s	.return					; If not, branch

	.okaytodestroy:
		neg.w	y_vel(a0)
		move.b	#4,routine(a1)
		move.w	a0,parent(a1)

	.return:
		rts
; ---------------------------------------------------------------------------

Touch_Enemy:
		btst	#Status_Invincible,status_secondary(a0)	; Is player invincible?
		bne.s	.checkhurtenemy				; If so, branch
		cmpi.b	#9,anim(a0)				; Is player in their spin dash animation?
		beq.s	.checkhurtenemy				; If so, branch
		cmpi.b	#2,anim(a0)				; Is player in their rolling animation?
		beq.s	.checkhurtenemy				; If so, branch
	if ~~Sonic3_Alone
		cmpi.b	#2,character_id(a0)			; Is player Knuckles?
		bne.s	.notknuckles				; If not, branch
		cmpi.b	#1,double_jump_flag(a0)			; Is Knuckles gliding?
		beq.s	.checkhurtenemy				; If so, branch
		cmpi.b	#3,double_jump_flag(a0)			; Is Knuckles sliding across the ground after gliding?
		beq.s	.checkhurtenemy				; If so, branch
		bra.w	Touch_ChkHurt
; ---------------------------------------------------------------------------

	.notknuckles:
	endif
		cmpi.b	#1,character_id(a0)			; Is player Tails?
		bne.w	Touch_ChkHurt				; If not, branch
		tst.b	double_jump_flag(a0)			; Is Tails flying ("gravity-affected")?
		beq.w	Touch_ChkHurt				; If not, branch
		btst	#Status_Underwater,status(a0)		; Is Tails underwater?
		bne.w	Touch_ChkHurt				; If not, branch
		move.w	x_pos(a0),d1
		move.w	y_pos(a0),d2
		sub.w	x_pos(a1),d1
		sub.w	y_pos(a1),d2
		jsr	(GetArcTan).l
		subi.b	#$20,d0
		cmpi.b	#$40,d0
		bhs.w	Touch_ChkHurt

	.checkhurtenemy:
		; Boss related? Could be special enemies in general
		tst.b	boss_hitcount2(a1)		; Is this a boss? (?)
		beq.s	Touch_EnemyNormal		; If not, branch
		neg.w	x_vel(a0)			; Bounce player directly off boss
		neg.w	y_vel(a0)
		neg.w	ground_vel(a0)
		move.b	collision_flags(a1),$25(a1)	; ???
	if ~~Sonic3_Alone
		move.w	a0,d0				; Save value of RAM address of which player hit the boss:
		move.b	d0,$1C(a1)			; ($FFFFB000) for main character, ($FFFFB04A) for sidekick
	endif
		move.b	#0,collision_flags(a1)
		subq.b	#1,boss_hitcount2(a1)		; Subtract from boss hit counter
		bne.s	.bossnotdefeated		; If boss is not defeated yet, branch
		bset	#7,status(a1)

	.bossnotdefeated:
	if ~~Sonic3_Alone
		cmpi.b	#2,character_id(a0)		; Is player Knuckles?
		bne.s	.return				; If not, return
		cmpi.b	#1,double_jump_flag(a0)		; Is Knuckles gliding?
		bne.s	.return				; If not, return
		move.b	#2,double_jump_flag(a0)		; Make him stop gliding
		move.b	#$21,anim(a0)			; Put Knuckles in his falling animation
		; Decide which direction to make Knuckles face
		bclr	#Status_Facing,status(a0)
		tst.w	x_vel(a0)
		bmi.s	.directiondecided
		bset	#Status_Facing,status(a0)

	.directiondecided:
		move.b	default_y_radius(a0),y_radius(a0)
		move.b	default_x_radius(a0),x_radius(a0)
	endif

	.return:
		rts
; ---------------------------------------------------------------------------

Touch_EnemyNormal:
		btst	#2,status(a1)			; Should the object remember that it's been destroyed (Remember Sprite State flag)?
		beq.s	.dontremember			; If not, branch
		move.b	ros_bit(a1),d0
		movea.w	ros_addr(a1),a2
		bclr	d0,(a2)				; Mark object as destroyed

	.dontremember:
		bset	#7,status(a1)
		moveq	#0,d0
		move.w	(Chain_bonus_counter).w,d0	; Get copy of chain bonus counter
		addq.w	#2,(Chain_bonus_counter).w	; Add 2 to chain bonus counter
		cmpi.w	#6,d0				; Has the counter already surpassed 5?
		blo.s	.notreachedlimit		; If not, branch
		moveq	#6,d0				; Cap counter at 6

	.notreachedlimit:
		move.w	d0,objoff_3E(a1)
		move.w	Enemy_Points(pc,d0.w),d0	; Get appropriate number of points
		cmpi.w	#16*2,(Chain_bonus_counter).w	; Have 16 enemies been destroyed?
		blo.s	.notreachedlimit2		; If not, branch
		move.w	#1000,d0			; Fix bonus to 10000 points
		move.w	#$A,objoff_3E(a1)

	.notreachedlimit2:
		movea.w	a0,a3
		bsr.w	HUD_AddToScore
		move.l	#Obj_Explosion,(a1)		; Create enemy destruction explosion
		move.b	#0,routine(a1)
		tst.w	y_vel(a0)			; Is player moving up?
		bmi.s	.bounceplayerdown		; If so, branch
		move.w	y_pos(a0),d0
		cmp.w	y_pos(a1),d0			; Was player above, or at the same height as, the enemy when it was destroyed?
		bhs.s	.bounceplayerup			; If so, branch
		neg.w	y_vel(a0)			; Totally negate velocity (???)
		rts
; ---------------------------------------------------------------------------

	.bounceplayerdown:
		addi.w	#$100,y_vel(a0)			; Bounce down
		rts
; ---------------------------------------------------------------------------

	.bounceplayerup:
		subi.w	#$100,y_vel(a0)			; Bounce up
		rts
; ---------------------------------------------------------------------------
Enemy_Points:
		dc.w 10, 20, 50, 100
; ---------------------------------------------------------------------------
	if Sonic3_Alone
; Touch_Caterkiller:
		; Remnant from Sonic 1, this sets a flag that causes the Caterkiller to
		; break apart if the player is hurt by its spiked body.
		bset	#7,status(a1)
	endif

; ---------------------------------------------------------------------------
; Subroutine for checking if Sonic/Tails/Knuckles should be hurt and hurting them if so
; note: character must be at a0
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================

Touch_ChkHurt:
		move.b	status_secondary(a0),d0
		andi.b	#$73,d0					; Does player have any shields or is invincible?
		beq.s	Touch_ChkHurt_NoPowerUp			; If not, branch
		and.b	shield_reaction(a1),d0			; Does one of the player's shields grant immunity to this object??
		bne.s	Touch_ChkHurt_Return			; If so, branch
		btst	#Status_Shield,status_secondary(a0)	; Does the player have a shield (strange time to ask)
		bne.s	Touch_ChkHurt_HaveShield		; If so, branch

Touch_ChkHurt2:
		btst	#Status_Invincible,status_secondary(a0)	; Is player invincible?
		beq.s	Touch_Hurt				; If not, branch

Touch_ChkHurt_Return:
		moveq	#-1,d0
		rts
; ---------------------------------------------------------------------------

Touch_ChkHurt_NoPowerUp:
		; Note that this check could apply to the Insta-Shield,
		; but the check that branches to this requires the player not be invincible.
		; The Insta-Shield grants temporary invincibility. See the problem?
		cmpi.b	#1,double_jump_flag(a0)			; Is player Insta-Shield-attacking (Sonic), flying (Tails) or gliding (Knuckles)?
		bne.s	Touch_ChkHurt2				; If not, branch

Touch_ChkHurt_HaveShield:
		move.b	shield_reaction(a1),d0
		andi.b	#1<<3,d0					; Should the object be bounced away by a shield?
		beq.s	Touch_ChkHurt2				; If not, branch

Touch_ChkHurt_Bounce_Projectile:
		move.w	x_pos(a0),d1
		move.w	y_pos(a0),d2
		sub.w	x_pos(a1),d1
		sub.w	y_pos(a1),d2
		jsr	(GetArcTan).l
		jsr	(GetSineCosine).l
		muls.w	#-$800,d1
		asr.l	#8,d1
		move.w	d1,x_vel(a1)
		muls.w	#-$800,d0
		asr.l	#8,d0
		move.w	d0,y_vel(a1)
		clr.b	collision_flags(a1)
		bra.s	Touch_ChkHurt_Return
; ---------------------------------------------------------------------------

Touch_Hurt:
		nop
		tst.b	invulnerability_timer(a0)	; Is the player invulnerable?
		bne.s	Touch_ChkHurt_Return		; If so, branch
		movea.l	a1,a2

; continue straight to HurtCharacter

; ---------------------------------------------------------------------------
; Hurting Sonic/Tails/Knuckles subroutine
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


HurtCharacter:
		move.w	(Ring_count).w,d0
		cmpa.w	#Player_1,a0
		beq.s	locK_102A8
		tst.w	(Competition_mode).w
		beq.s	locK_102E0
		move.w	(Ring_count_P2).w,d0
; loc3_114CC:
locK_102A8:
		btst	#0,status_secondary(a0)
		bne.s	locK_102DA
		tst.b	status_tertiary(a0)
		bmi.s	locK_102E0
		tst.w	d0
	if Sonic3_Alone
		beq.w	Kill_Character
	else
		beq.w	locK_10350
	endif
		jsr	(AllocateObject).l
		bne.s	locK_102DA
		move.l	#Obj_Bouncing_Ring,(a1)
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		move.w	a0,$3E(a1)
; loc3_114FE:
locK_102DA:
		andi.b	#$8E,status_secondary(a0)
; loc3_11504:
locK_102E0:
		move.b	#4,routine(a0)
		jsr	(Player_TouchFloor).l
		bset	#Status_InAir,status(a0)
		move.w	#-$400,y_vel(a0)
		move.w	#-$200,x_vel(a0)
		btst	#Status_Underwater,status(a0)
		beq.s	locK_10312
		move.w	#-$200,y_vel(a0)
		move.w	#-$100,x_vel(a0)
; loc3_11536:
locK_10312:
		move.w	x_pos(a0),d0
		cmp.w	x_pos(a2),d0
		blo.s	locK_10320
		neg.w	x_vel(a0)
; loc3_11544:
locK_10320:
		move.w	#0,ground_vel(a0)
		move.b	#$1A,anim(a0)
		move.b	#120,invulnerability_timer(a0)
		moveq	#signextendB(sfx_Death),d0
	 if ~~Sonic3_Alone
		cmpi.l	#Obj_Spikes,(a2)
		blo.s	locK_10346
		cmpi.l	#sub_24280,(a2)
		bhs.s	locK_10346
		moveq	#signextendB(sfx_SpikeHit),d0

locK_10346:
	endif
		jsr	(Play_SFX).l
		moveq	#-1,d0
		rts
; ---------------------------------------------------------------------------
	if ~~Sonic3_Alone
locK_10350:
		moveq	#signextendB(sfx_Death),d0
		cmpi.l	#Obj_Spikes,(a2)
		blo.s	locK_10364
		cmpi.l	#sub_24280,(a2)
		bhs.s	locK_10364
		moveq	#signextendB(sfx_SpikeHit),d0

locK_10364:
		bra.s	locK_1036E
	endif
; ---------------------------------------------------------------------------

Kill_Character:
		tst.w	(Debug_placement_mode).w
		bne.s	locK_103B6
	if ~~Sonic3_Alone
		moveq	#signextendB(sfx_Death),d0

locK_1036E:
	endif
		clr.b	status_secondary(a0)
		clr.b	status_tertiary(a0)
		move.b	#6,routine(a0)
	if Sonic3_Alone
		jsr	(Player_TouchFloor).l
	else
		move.w	d0,-(sp)
		jsr	(Player_TouchFloor).l
		move.w	(sp)+,d0
	endif
		bset	#Status_InAir,status(a0)
		move.w	#-$700,y_vel(a0)
		move.w	#0,x_vel(a0)
		move.w	#0,ground_vel(a0)
		move.b	#$18,anim(a0)
	if ~~Sonic3_Alone
		move.w	art_tile(a0),(Debug_saved_art_tile).w
	endif
		bset	#7,art_tile(a0)
	if Sonic3_Alone
		moveq	#signextendB(sfx_Death),d0
	endif
		jsr	(Play_SFX).l
; loc3_115A8:
locK_103B6:
		moveq	#-1,d0
		rts
; ---------------------------------------------------------------------------

Touch_Special:
		move.b	collision_flags(a1),d1	; Get collision_flags
		andi.b	#$3F,d1			; Get only collision size (but that doesn't seems to be its use here)
		cmpi.b	#7,d1
		beq.s	locK_103FA
		cmpi.b	#6,d1
		beq.s	locK_103FA
		cmpi.b	#$A,d1
		beq.s	locK_103FA
		cmpi.b	#$C,d1
		beq.s	locK_103FA
		cmpi.b	#$15,d1
		beq.s	locK_103FA
		cmpi.b	#$16,d1
		beq.s	locK_103FA
		cmpi.b	#$17,d1
		beq.s	locK_103FA
		cmpi.b	#$18,d1
		beq.s	locK_103FA
		cmpi.b	#$21,d1
		beq.s	locK_103FA
		rts
; ---------------------------------------------------------------------------
; loc3_115EC:
locK_103FA:
		move.w	a0,d1				; Get RAM address of what object hit this
		subi.w	#Object_RAM,d1
		beq.s	.ismaincharacter		; If the main character hit it, branch
		addq.b	#1,collision_property(a1)	; Otherwise, it seems everything else does double

	.ismaincharacter:
		addq.b	#1,collision_property(a1)	; So hitting a boss with your Tails sidekick does double damage?
		rts


; =============== S U B R O U T I N E =======================================


Add_SpriteToCollisionResponseList:
		lea	(Collision_response_list).w,a1
		cmpi.w	#$7E,(a1)	; Is list full?
		bhs.s	.return		; If so, return
		addq.w	#2,(a1)		; Count this new entry
		adda.w	(a1),a1		; Offset into right area of list
		move.w	a0,(a1)		; Store RAM address in list

	.return:
		rts
; End of function Add_SpriteToCollisionResponseList


; =============== S U B R O U T I N E =======================================


ShieldTouchResponse:
		move.b	status_secondary(a0),d0
		andi.b	#$71,d0				; Does the player have any shields?
		beq.s	locretK_1045C
		move.w	x_pos(a0),d2			; Get player's x_pos
		move.w	y_pos(a0),d3			; Get player's y_pos
		subi.w	#$18,d2				; Subtract width of shield
		subi.w	#$18,d3				; Subtract height of shield
		move.w	#$30,d4				; Player's width
		move.w	#$30,d5				; Player's height
		lea	(Collision_response_list).w,a4
		move.w	(a4)+,d6			; Get number of objects queued
		beq.s	locretK_1045C			; If there are none, return

ShieldTouch_Loop:
		movea.w	(a4)+,a1			; Get address of first object's RAM
		move.b	collision_flags(a1),d0		; Get its collision_flags
		andi.b	#$C0,d0				; Get only collision type bits
		cmpi.b	#$80,d0				; Is only the high bit set ("harmful")?
		beq.s	ShieldTouch_Width		; If so, branch

ShieldTouch_NextObj:
		subq.w	#2,d6				; Count the object as done
		bne.s	ShieldTouch_Loop		; If there are still objects left, loop
; locret3_1164E:
locretK_1045C:
		rts
; ---------------------------------------------------------------------------

ShieldTouch_Width:
		move.b	collision_flags(a1),d0		; Get collision_flags
		andi.w	#$3F,d0				; Get only collision size
		beq.s	ShieldTouch_NextObj		; If it doesn't have a size, branch
		add.w	d0,d0				; Turn into index
		lea	(Touch_Sizes).l,a2
		lea	(a2,d0.w),a2			; Go to correct entry
		moveq	#0,d1
		move.b	(a2)+,d1			; Get width value from Touch_Sizes
		move.w	x_pos(a1),d0			; Get object's x_pos
		sub.w	d1,d0				; Subtract object's width
		sub.w	d2,d0				; Subtract player's left collision boundary
		bhs.s	.checkrightside			; If player's left side is to the left of the object, branch
		add.w	d1,d1				; Double object's width value
		add.w	d1,d0				; Add object's width*2 (now at right of object)
		blo.s	ShieldTouch_Height		; If carry, branch (player is within the object's boundaries)
		bra.s	ShieldTouch_NextObj		; If not, loop and check next object
; ---------------------------------------------------------------------------

	.checkrightside:
		cmp.w	d4,d0				; Is player's right side to the left of the object?
		bhi.s	ShieldTouch_NextObj		; If so, loop and check next object

ShieldTouch_Height:
		moveq	#0,d1
		move.b	(a2)+,d1			; Get height value from Touch_Sizes
		move.w	y_pos(a1),d0			; Get object's y_pos
		sub.w	d1,d0				; Subtract object's height
		sub.w	d3,d0				; Subtract player's bottom collision boundary
		bcc.s	.checktop			; If bottom of player is under the object, branch
		add.w	d1,d1				; Double object's height value
		add.w	d1,d0				; Add object's height*2 (now at top of object)
		bcs.w	.checkdeflect			; If carry, branch (player is within the object's boundaries)
		bra.s	ShieldTouch_NextObj		; If not, loop and check next object
; ---------------------------------------------------------------------------

	.checktop:
		cmp.w	d5,d0				; Is top of player under the object?
		bhi.s	ShieldTouch_NextObj		; If so, loop and check next object

	.checkdeflect:
		move.b	shield_reaction(a1),d0
		andi.b	#8,d0				; Should the object be bounced away by a shield?
		beq.s	ShieldTouch_NextObj		; If not, branch
		move.w	x_pos(a0),d1
		move.w	y_pos(a0),d2
		sub.w	x_pos(a1),d1
		sub.w	y_pos(a1),d2
		jsr	(GetArcTan).l
		jsr	(GetSineCosine).l
		muls.w	#-$800,d1
		asr.l	#8,d1
		move.w	d1,x_vel(a1)
		muls.w	#-$800,d0
		asr.l	#8,d0
		move.w	d0,y_vel(a1)
		clr.b	collision_flags(a1)
		rts
; End of function ShieldTouchResponse


	if ~~Sonic3_Alone
; =============== S U B R O U T I N E =======================================

; It seems this is used by Hyper Sonic & Hyper Knuckles for their screen-nukes
; (Hyper Dash, and Hyper Knuckles gliding into a wall)

HyperAttackTouchResponse:
		movem.l	a2-a4,-(sp)
		lea	(Collision_response_list).w,a4
		move.w	(a4)+,d6			; Get number of objects queued
		beq.s	HyperTouch_Exit			; If there are none, branch

HyperTouch_Loop:
		movea.w	(a4)+,a1			; Get address of first object's RAM
		move.b	collision_flags(a1),d0		; Get its collision_flags
		beq.s	HyperTouch_NextObj		; If it doesn't have collision, branch
		bsr.s	HyperTouch_ChkValue		; Else, process object

HyperTouch_NextObj:
		subq.w	#2,d6				; Count the object as done
		bne.s	HyperTouch_Loop			; If there are still objects left, loop
		moveq	#0,d0

HyperTouch_Exit:
		movem.l	(sp)+,a2-a4
		rts
; End of function HyperAttackTouchResponse


; =============== S U B R O U T I N E =======================================


HyperTouch_ChkValue:
		tst.b	render_flags(a1)		; Is object on-screen?
		bpl.s	.return				; If not, return (screen-nuke only affects what's on-screen)
		andi.b	#$C0,d0				; Get collision_flags type data
		beq.s	HyperTouch_Enemy		; If 00, enemy, branch
		cmpi.b	#$C0,d0
		beq.w	HyperTouch_Special		; If 11, "special thing for starpost", branch
		tst.b	d0
		bmi.s	HyperTouch_Harmful		; If 10, "harmful", branch

	.return:
		rts
; ---------------------------------------------------------------------------

HyperTouch_Enemy:
		tst.b	collision_property(a1)		; Is this a special enemy?
		beq.s	HyperTouch_DestroyEnemy		; If not, branch
		rts
; ---------------------------------------------------------------------------

; Similar to other enemy destruction subroutines, but this one doesn't make the player bounce

HyperTouch_DestroyEnemy:
		btst	#2,status(a1)			; Should the object remember that it's been destroyed (Remember Sprite State flag)?
		beq.s	.dontremember			; If not, branch
		move.b	ros_bit(a1),d0
		movea.w	ros_addr(a1),a2
		bclr	d0,(a2)				; Mark object as destroyed

	.dontremember:
		bset	#7,status(a1)
		moveq	#0,d0
		move.w	(Chain_bonus_counter).w,d0	; Get copy of chain bonus counter
		addq.w	#2,(Chain_bonus_counter).w	; Add 2 to chain bonus counter
		cmpi.w	#6,d0				; Has the counter already surpassed 5?
		blo.s	.notreachedlimit		; If not, branch
		moveq	#6,d0				; Cap counter at 6

	.notreachedlimit:
		move.w	d0,objoff_3E(a1)
		move.w	HyperEnemy_Score(pc,d0.w),d0	; Get appropriate number of points
		cmpi.w	#16*2,(Chain_bonus_counter).w	; Have 16 enemies been destroyed?
		blo.s	.notreachedlimit2		; If not, branch
		move.w	#1000,d0			; Fix bonus to 10000 points
		move.w	#$A,objoff_3E(a1)

	.notreachedlimit2:
		movea.w	a0,a3
		bsr.w	HUD_AddToScore
		move.l	#Obj_Explosion,(a1)		; Create enemy destruction explosion
		move.b	#0,routine(a1)
		rts
; ---------------------------------------------------------------------------
HyperEnemy_Score:
		dc.w 10, 20, 50, 100
; ---------------------------------------------------------------------------

HyperTouch_Harmful:
		move.b	shield_reaction(a1),d0
		andi.b	#8,d0				; Should the object be bounced away by a shield?
		bne.w	Touch_ChkHurt_Bounce_Projectile	; If so, branch
		rts
; ---------------------------------------------------------------------------

HyperTouch_Special:
		ori.b	#3,collision_property(a1)
		cmpi.w	#3,(Player_mode).w		; Are we in Knuckles Alone mode?
		bne.s	.sonicortails			; If not, branch
		move.w	x_pos(a1),(Player_2+x_pos).w	; ???
		move.w	y_pos(a1),(Player_2+y_pos).w	; ???

	.sonicortails:
		move.b	#2,(Player_2+anim).w		; Put sidekick in his rolling animation
		bset	#Status_InAir,(Player_2+status).w
		rts
; End of function HyperTouch_ChkValue
	endif