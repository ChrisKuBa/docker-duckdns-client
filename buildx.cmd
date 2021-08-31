@echo off

git log -1 --format=%%H > tmpFile
set /p REVISION= < tmpFile
del tmpFile 
FOR /F "tokens=*" %%g IN ('git describe --tags') do (SET TAG=%%g)

docker buildx build ^
  --platform linux/amd64,linux/arm64,linux/arm/v7 ^
  --no-cache=true ^
  --build-arg BUILD_DATE="%date:~6,4%-%date:~3,2%-%date:~0,2%T%time:~0,2%:%time:~3,2%:%time:~6,2%+01:00" ^
  --build-arg BUILD_VERSION=%TAG% ^
  --build-arg BUILD_REVISION=%REVISION% ^
  -t chriskuba/dynv6-client:%TAG% ^
  -t chriskuba/dynv6-client:latest ^
  --push ^
  .
  