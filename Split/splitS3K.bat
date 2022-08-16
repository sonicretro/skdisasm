@echo off
pushd %~dp0\..
echo Splitting Sonic ^& Knuckles...
"Build Scripts/split.exe" "Build Scripts/sk.bin" "Build Scripts/sk.txt"
echo Splitting Sonic the Hedgehog 3...
"Build Scripts/split.exe" "Build Scripts/s3.bin" "Build Scripts/s3.txt"
popd
pause
