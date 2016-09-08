@ECHO OFF

pushd "%~dp0\.."

IF EXIST sonic3k.bin del sonic3k.bin
IF NOT EXIST skbuilt.bin goto LABLSKMISS
IF NOT EXIST "Build Scripts\s3.bin" goto LABLS3MISS

type skbuilt.bin >> sonic3k.bin
type "Build Scripts\s3.bin" >> sonic3k.bin
echo sonic3k.bin produced
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
