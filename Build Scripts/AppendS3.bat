@ECHO OFF

pushd "%~dp0\.."

IF EXIST sonic3k.bin del sonic3k.bin
IF NOT EXIST skbuilt.bin goto skBuiltIsMissing
IF NOT EXIST "Build Scripts\s3.bin" goto s3IsMissing

type skbuilt.bin >> sonic3k.bin
type "Build Scripts\s3.bin" >> sonic3k.bin
echo sonic3k.bin produced
pause
goto exit

:skBuiltIsMissing
ECHO skbuilt.bin is missing
pause
goto exit

:s3IsMissing
echo s3.bin is missing
pause

:exit
popd
exit /b
