@ echo off
setlocal
set BASE=%~dp0
set CONFIG=%BASE%config

call %BASE%stop.cmd

if exist "%CONFIG%\." (
  echo Removing Home Assistant configuration ...
  echo Configuration folder: %CONFIG%
  rmdir /S /Q "%CONFIG%"
)

if "%1" == "/all" (
  echo Removing all unused container images ...
  container image prune --all --force
)

echo.
echo Done.
endlocal
