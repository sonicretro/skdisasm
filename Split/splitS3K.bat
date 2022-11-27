@echo off
pushd %~dp0\..
echo Splitting Sonic ^& Knuckles...
"Split/split.exe" "Split/sk.bin" "Split/sk.txt"
echo Splitting Sonic the Hedgehog 3...
"Split/split.exe" "Split/s3.bin" "Split/s3.txt"
popd
pause
