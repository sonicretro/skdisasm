@ECHO OFF

cd ..

IF EXIST s3kbuilt.bin del s3kbuilt.bin
IF NOT EXIST skbuilt.bin goto LABLSKMISS
IF NOT EXIST "Build Scripts\s3.bin" goto LABLS3MISS

type skbuilt.bin >> s3kbuilt.bin
type "Build Scripts\s3.bin" >> s3kbuilt.bin
echo s3kbuilt.bin produced
pause

exit /b
:LABLSKMISS
ECHO skbuilt.bin is missing
pause
exit /b

:LABLS3MISS
echo s3.bin is missing
pause
exit /b