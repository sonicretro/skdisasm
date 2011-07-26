@ECHO OFF

cd ..

REM // make sure we can write to the file skbuilt.bin
REM // also make a backup to skbuilt.prev.bin
IF NOT EXIST skbuilt.bin goto LABLNOCOPY
IF EXIST skbuilt.prev.bin del skbuilt.prev.bin
IF EXIST skbuilt.prev.bin goto LABLNOCOPY
move /Y skbuilt.bin skbuilt.prev.bin
IF EXIST skbuilt.bin goto LABLERROR2
:LABLNOCOPY

REM // delete some intermediate assembler output just in case
IF EXIST sonic3k.p del sonic3k.p
IF EXIST sonic3k.p goto LABLERROR1

REM // clear the output window
REM cls

REM // run the assembler
REM // -xx shows the most detailed error output
REM // -q makes AS shut up
REM // -A gives us a small speedup
set AS_MSGPATH=AS/Win32
set USEANSI=n

REM // allow the user to choose to output error messages to file by supplying the -logerrors parameter
IF "%1"=="-logerrors" ( "AS/Win32/asw.exe" -xx -q -c -D Sonic3_Complete=0 -E -A sonic3k.asm ) ELSE "AS/Win32/asw.exe" -xx -q -c -D Sonic3_Complete=0 -A sonic3k.asm

REM // if there were errors, a log file is produced
IF "%1"=="-logerrors" ( IF EXIST sonic3k.log goto LABLERROR3 )

REM // combine the assembler output into a rom
IF EXIST sonic3k.p "AS/Win32/s3p2bin" sonic3k.p skbuilt.bin sonic3k.h

REM // done -- pause if we seem to have failed, then exit
IF NOT EXIST sonic3k.p goto LABLPAUSE
IF EXIST skbuilt.bin exit /b
:LABLPAUSE

pause


exit /b

:LABLERROR1
echo Failed to build because write access to sonic3k.p was denied.
pause


exit /b

:LABLERROR2
echo Failed to build because write access to skbuilt.bin was denied.
pause

exit /b

:LABLERROR3
REM // display a noticeable message
echo.
echo ***************************************************************************
echo *                                                                         *
echo *   There were build errors/warnings. See sonic3k.log for more details.   *
echo *                                                                         *
echo ***************************************************************************
echo.
pause

