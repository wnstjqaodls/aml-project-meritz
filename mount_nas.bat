@echo off
chcp 65001 > nul
echo Testing NAS connection...
net use Z: \\192.168.40.2\private /user:KJS "dnjsvudwnd@SY14" /TRANSPORT:TCP /persistent:yes
echo Exit code: %ERRORLEVEL%
if %ERRORLEVEL% == 0 (
    echo SUCCESS - Z drive mapped
) else (
    echo FAILED - trying programing share...
    net use Y: \\192.168.40.2\programing /user:KJS "dnjsvudwnd@SY14" /TRANSPORT:TCP /persistent:yes
    echo Exit code: %ERRORLEVEL%
)
net use
