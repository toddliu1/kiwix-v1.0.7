@echo off
title Wikipedia
color 0A

setlocal enabledelayedexpansion

for  /F %%a in ('dir /b *.zim') do set zim=!zim! %%a

for /F "tokens=15 delims=: " %%i in ('ipconfig ^| findstr IPv4') do @echo Kiwix Server: %%i

start /b kiwix-serve.exe %zim% > kiwix.log.txt && start http://localhost