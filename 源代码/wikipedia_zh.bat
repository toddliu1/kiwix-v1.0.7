@echo off
title 维基百科
color 0A

:: 开启全局变量延迟扩展
setlocal enabledelayedexpansion

:: 遍历当前文件夹下的.zim文件，将zim文件名存入zim变量
for  /F %%a in ('dir /b *.zim') do set zim=!zim! %%a

:: 显示本机IP地址，以便后续通过该地址访问维基百科
for /F "tokens=15 delims=: " %%i in ('ipconfig ^| findstr IPv4') do @echo 你的IP地址是：%%i

echo.
echo 请勿关闭此窗口！！！

echo.
echo 关闭浏览器窗口后，此窗口自动关闭。
echo.

:: 启动默认浏览器
start http://localhost

:: 判断用户浏览器
for %%b in (360chrome,chrome,msedge,360se,firefox,iexplore) do (

:: 检查上一步启动的浏览器进程PID
	for /F "tokens=2" %%p in ('tasklist /FI "imagename  EQ %%b.exe" /NH ^| findstr %%b') do (
		echo %%p | findstr "[0-9]" >nul && set pid=%%p
		goto START
	)
)

:START
:: 启动维基百科服务，绑定到前面获取到的PID
kiwix-serve.exe -a %pid% %zim% > kiwix.log.txt
