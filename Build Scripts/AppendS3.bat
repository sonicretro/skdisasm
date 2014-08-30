@ECHO OFF

pushd %~dp0\..

IF EXIST s3kbuilt.bin del s3kbuilt.bin
IF NOT EXIST skbuilt.bin goto LABLSKMISS
IF NOT EXIST "Build Scripts\s3.bin" goto LABLS3MISS

type skbuilt.bin >> s3kbuilt.bin
type "Build Scripts\s3.bin" >> s3kbuilt.bin
echo s3kbuilt.bin produced
pause
goto LABLEXIT

:LABLSKMISS
ECHO skbuilt.bin is missing
pause
goto LABLEXIT

:LABLS3MISS
echo s3.bin is missing
pause

:LABLEXIT
popd
exit /b
