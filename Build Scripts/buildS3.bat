@ECHO OFF

pushd "%~dp0\.."

REM // make sure we can write to the file s3built.bin
REM // also make a backup to s3built.prev.bin
IF NOT EXIST s3built.bin goto LABLNOCOPY
IF EXIST s3built.prev.bin del s3built.prev.bin
IF EXIST s3built.prev.bin goto LABLNOCOPY
move /Y s3built.bin s3built.prev.bin
IF EXIST s3built.bin goto LABLERROR2

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
set AS_MSGPATH=AS\Win32
set USEANSI=n

REM // allow the user to choose to output error messages to file by supplying the -logerrors parameter
IF "%1"=="-logerrors" ( "AS\Win32\asw.exe" -xx -q -c -o sonic3k.p -olist sonic3k.lst -shareout sonic3k.h -E sonic3k.log -A -L s3.asm ) ELSE "AS\Win32\asw.exe" -xx -q -c -o sonic3k.p -olist sonic3k.lst -shareout sonic3k.h -A -L s3.asm

REM // if there were errors, a log file is produced
IF "%1"=="-logerrors" ( IF EXIST sonic3k.log goto LABLERROR3 )

REM // combine the assembler output into a rom
IF EXIST sonic3k.p "AS\Win32\s3p2bin" sonic3k.p s3built.bin sonic3k.h

REM // done -- pause if we seem to have failed, then exit
IF NOT EXIST sonic3k.p goto LABLPAUSE
IF EXIST s3built.bin goto LABLEXIT

:LABLPAUSE
pause
goto LABLEXIT

:LABLERROR1
echo Failed to build because write access to sonic3k.p was denied.
pause
goto LABLEXIT

:LABLERROR2
echo Failed to build because write access to s3built.bin was denied.
pause
goto LABLEXIT

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

:LABLEXIT
popd
exit /b
