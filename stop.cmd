@ echo off

echo Stopping containers ...
container stop ha
container stop esphome

echo Removing network ...
container network remove hanet
