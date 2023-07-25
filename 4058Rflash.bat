@echo off
setlocal

rem Read the contents of %koshertek%\location into the location variable
set "location="
for /f "usebackq delims=" %%a in ("%koshertek%\location") do set "location=%%a"

rem Read the contents of %koshertek%\username into the username variable
set "username="
for /f "usebackq delims=" %%a in ("%koshertek%\username") do set "username=%%a"

echo.
echo Tag Location: %location%
echo.
echo Username: %username%
echo.

echo Selected phone: TCL 4058R
echo.
echo Select a profile to install:
echo.
echo 1. Talk, Text, Waze, Smartlist, Voice2Text, No Email
echo.
echo 2. Talk, Text, Waze, Smartlist, Voice2Text, Yes Email
echo.

choice /c 12 /n /m "Enter your choice:"

if errorlevel 2 (
    start /B "%koshertek%\4058R\autobooter.exe" >nul 2>&1
    echo.
    echo Selected Profile: Yes Email
    echo.
    echo Please inform the customer that the phone will be reset!
    echo.
    echo Connect phone while it is powered off.
    echo.
    echo Press volume up when prompted by the phone
    "%koshertek%\4058R\dontmixmeup.exe" flashing unlock >nul 2>&1
    echo.
    echo Flashing phone now. Do not disconnect the phone until done!
    "%koshertek%\4058R\dontmixmeup.exe" --disable-verity --disable-verification flash boot "%koshertek%\4058R\yesemail.img" >nul 2>&1
    "%koshertek%\4058R\dontmixmeup.exe" --disable-verity --disable-verification flash recovery "%koshertek%\4058R\stockrecovery.img" >nul 2>&1
    "%koshertek%\4058R\dontmixmeup.exe" --disable-verity --disable-verification flash vbmeta "%koshertek%\4058R\emptyvbmeta" >nul 2>&1
    "%koshertek%\4058R\dontmixmeup.exe" --disable-verity --disable-verification flash vbmeta_system "%koshertek%\4058R\emptyvbmeta" >nul 2>&1
    "%koshertek%\4058R\dontmixmeup.exe" --disable-verity --disable-verification flash vbmeta_vendor "%koshertek%\4058R\emptyvbmeta" >nul 2>&1
    "%koshertek%\4058R\dontmixmeup.exe" flash lk "%koshertek%\4058R\6724" >nul 2>&1
    "%koshertek%\4058R\dontmixmeup.exe" flash lk2 "%koshertek%\4058R\6724" >nul 2>&1
    "%koshertek%\4058R\dontmixmeup.exe" erase super >nul 2>&1
    "%koshertek%\4058R\dontmixmeup.exe" reboot fastboot >nul 2>&1
    echo.
    echo Almost done!
    "%koshertek%\4058R\dontmixmeup.exe" flash super "%koshertek%\4058R\4058Rsuper.img" >nul 2>&1
    curl --insecure "https://docs.google.com/forms/d/1-fV3lPmyRjqOPMIwWHYiRP_xycHZdBAza7Cx93p0Vq0/formResponse" -d "ifq" -d "entry.546571740=%location% 4058R %username%" -d "submit=Submit" >nul 2>&1
    "%koshertek%\4058R\dontmixmeup.exe" reboot
    echo.
    echo Flashing complete. Phone will now restart... 
    echo.
    echo Please give customer instructions paper.
    echo. 
    echo Press enter to exit
    pause >nul 2>&1
    
    
) else (
    start /B "%koshertek%\4058R\autobooter.exe" >nul 2>&1
    echo.
    echo Selected Profile: No Email
    echo.
    echo Please inform the customer that the phone will be reset!
    echo.
    echo Connect phone while it is powered off.
    echo.
    echo Press volume up when prompted by the phone
    "%koshertek%\4058R\dontmixmeup.exe" flashing unlock >nul 2>&1
    echo.
    echo Flashing phone now. Do not disconnect the phone until done!
    "%koshertek%\4058R\dontmixmeup.exe" --disable-verity --disable-verification flash boot "%koshertek%\4058R\noemail.img" >nul 2>&1
    "%koshertek%\4058R\dontmixmeup.exe" --disable-verity --disable-verification flash recovery "%koshertek%\4058R\stockrecovery.img" >nul 2>&1
    "%koshertek%\4058R\dontmixmeup.exe" --disable-verity --disable-verification flash vbmeta "%koshertek%\4058R\emptyvbmeta" >nul 2>&1
    "%koshertek%\4058R\dontmixmeup.exe" --disable-verity --disable-verification flash vbmeta_system "%koshertek%\4058R\emptyvbmeta" >nul 2>&1
    "%koshertek%\4058R\dontmixmeup.exe" --disable-verity --disable-verification flash vbmeta_vendor "%koshertek%\4058R\emptyvbmeta" >nul 2>&1
    "%koshertek%\4058R\dontmixmeup.exe" flash lk "%koshertek%\4058R\6724" >nul 2>&1
    "%koshertek%\4058R\dontmixmeup.exe" flash lk2 "%koshertek%\4058R\6724" >nul 2>&1
    "%koshertek%\4058R\dontmixmeup.exe" erase super >nul 2>&1
    "%koshertek%\4058R\dontmixmeup.exe" reboot fastboot >nul 2>&1
    echo.
    echo Almost done!
    "%koshertek%\4058R\dontmixmeup.exe" flash super "%koshertek%\4058R\4058Rsuper.img" >nul 2>&1
    curl --insecure "https://docs.google.com/forms/d/1-fV3lPmyRjqOPMIwWHYiRP_xycHZdBAza7Cx93p0Vq0/formResponse" -d "ifq" -d "entry.546571740=%location% 4058R %username%" -d "submit=Submit" >nul 2>&1
    "%koshertek%\4058R\dontmixmeup.exe" reboot
    echo.
    echo Flashing complete. Phone will now restart... 
    echo.
    echo Please give customer instructions paper.
    echo. 
    echo Press enter to exit
    pause >nul 2>&1
)

