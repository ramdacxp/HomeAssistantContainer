@echo off
setlocal
set BASE=%~dp0
set NETWORK=hanet
set HA_NAME=ha
set HA_CONFIG=%BASE%config\ha
set EH_NAME=esphome
set EH_CONFIG=%BASE%config\esphome

rem NETWORK
echo Creating network %NETWORK% ...
container network create %NETWORK%

rem HOME ASSISTANT
echo Starting Home Assistant ...
echo - Name: %HA_NAME%
echo - Config: %HA_CONFIG%

mkdir %HA_CONFIG% 2>NUL

container run -d ^
  --name %HA_NAME% ^
  -e TZ=Europe/Berlin ^
  -v %HA_CONFIG%:/config ^
  -p 8123:8123 ^
  --network %NETWORK% ^
  --rm ^
  ghcr.io/home-assistant/home-assistant:stable

REM ESPHOME
echo Starting ESP Home ...
echo - Name: %EH_NAME%
echo - Config: %EH_CONFIG%

mkdir %EH_CONFIG% 2>NUL

container run -d ^
  --name %EH_NAME% ^
  -v %EH_CONFIG%:/config ^
  -p 6052:6052 ^
  --network %NETWORK% ^
  --rm ^
  ghcr.io/esphome/esphome

echo.
echo Available containers:
container list

echo.
echo Home Assistant: http://localhost:8123/
echo ESP Home:       http://localhost:6052/
endlocal
