@echo off
setlocal
set BASE=%~dp0
set CONFIG=%BASE%config
set NAME=ha

echo Starting Home Assistant Container ...
echo Container name: %NAME%
echo Configuration folder: %CONFIG%

mkdir %CONFIG% 2>NUL

container run -d ^
  --name %NAME% ^
  -e TZ=Europe/Berlin ^
  -v %CONFIG%:/config ^
  -p 8123:8123 ^
  --rm ^
  ghcr.io/home-assistant/home-assistant:stable


echo.
echo Available containers:
container list

echo.
echo Local Home Assistant website:
echo http://localhost:8123/

echo.
echo Done.
endlocal
