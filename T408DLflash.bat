@echo off
echo Selected phone: TCL T408DL
echo Select a profile to install:
echo 1. Talk, Text, Waze, Smartlist, Voice2Text, No Email
echo 2. Talk, Text, Waze, Smartlist, Voice2Text, Yes Email

choice /c 12 /n /m "Enter your choice:"

if errorlevel 2 (
    start /B "%koshertek%\T408DL\autobooter.exe" >nul 2>&1
    echo.
    echo Selected Profile: Yes Email
    echo.
    echo Please inform the customer that the phone will be reset!
    echo.
    echo Connect phone while it is powered off.
    "%koshertek%\T408DL\dontmixmeup.exe" flashing unlock >nul 2>&1
    echo.
    echo Press volume up when prompted by the phone
    echo.
    echo Flashing phone now. Do not disconnect the phone until done!
    "%koshertek%\T408DL\dontmixmeup.exe" --disable-verity --disable-verification flash boot "%koshertek%\T408DL\yesemail.img" >nul 2>&1
    "%koshertek%\T408DL\dontmixmeup.exe" --disable-verity --disable-verification flash recovery "%koshertek%\T408DL\stockrecovery.img" >nul 2>&1
    "%koshertek%\T408DL\dontmixmeup.exe" --disable-verity --disable-verification flash vbmeta "%koshertek%\T408DL\emptyvbmeta" >nul 2>&1
    "%koshertek%\T408DL\dontmixmeup.exe" --disable-verity --disable-verification flash vbmeta_system "%koshertek%\T408DL\emptyvbmeta" >nul 2>&1
    "%koshertek%\T408DL\dontmixmeup.exe" --disable-verity --disable-verification flash vbmeta_vendor "%koshertek%\T408DL\emptyvbmeta" >nul 2>&1
    "%koshertek%\T408DL\dontmixmeup.exe" flash lk "%koshertek%\T408DL\7546" >nul 2>&1
    "%koshertek%\T408DL\dontmixmeup.exe" flash lk2 "%koshertek%\T408DL\7546" >nul 2>&1
    "%koshertek%\T408DL\dontmixmeup.exe" erase super >nul 2>&1
    "%koshertek%\T408DL\dontmixmeup.exe" reboot fastboot >nul 2>&1
    echo.
    echo Almost done!
    "%koshertek%\T408DL\dontmixmeup.exe" flash super "%koshertek%\T408DL\T408DLsuper.img" >nul 2>&1
    curl --insecure https://docs.google.com/forms/d/1-fV3lPmyRjqOPMIwWHYiRP_xycHZdBAza7Cx93p0Vq0/formResponse -d ifq -d entry.546571740=T408DLflash -d submit=Submit >nul 2>&1
    "%koshertek%\T408DL\dontmixmeup.exe" reboot
    echo.
    echo Flashing complete. Phone will now restart... 
    echo.
    echo Please give customer instructions paper.
    echo. 
    echo Press enter to exit
    pause >nul 2>&1
    
    
) else (
    start /B "%koshertek%\T408DL\autobooter.exe" >nul 2>&1
    echo.
    echo Selected Profile: Yes Email
    echo.
    echo Please inform the customer that the phone will be reset!
    echo.
    echo Connect phone while it is powered off.
    "%koshertek%\T408DL\dontmixmeup.exe" flashing unlock >nul 2>&1
    echo.
    echo Press volume up when prompted by the phone
    echo.
    echo Flashing phone now. Do not disconnect the phone until done!
    "%koshertek%\T408DL\dontmixmeup.exe" --disable-verity --disable-verification flash boot "%koshertek%\T408DL\noemail.img" >nul 2>&1
    "%koshertek%\T408DL\dontmixmeup.exe" --disable-verity --disable-verification flash recovery "%koshertek%\T408DL\stockrecovery.img" >nul 2>&1
    "%koshertek%\T408DL\dontmixmeup.exe" --disable-verity --disable-verification flash vbmeta "%koshertek%\T408DL\emptyvbmeta" >nul 2>&1
    "%koshertek%\T408DL\dontmixmeup.exe" --disable-verity --disable-verification flash vbmeta_system "%koshertek%\T408DL\emptyvbmeta" >nul 2>&1
    "%koshertek%\T408DL\dontmixmeup.exe" --disable-verity --disable-verification flash vbmeta_vendor "%koshertek%\T408DL\emptyvbmeta" >nul 2>&1
    "%koshertek%\T408DL\dontmixmeup.exe" flash lk "%koshertek%\T408DL\7546" >nul 2>&1
    "%koshertek%\T408DL\dontmixmeup.exe" flash lk2 "%koshertek%\T408DL\7546" >nul 2>&1
    "%koshertek%\T408DL\dontmixmeup.exe" erase super >nul 2>&1
    "%koshertek%\T408DL\dontmixmeup.exe" reboot fastboot >nul 2>&1
    echo.
    echo Almost done!
    "%koshertek%\T408DL\dontmixmeup.exe" flash super "%koshertek%\T408DL\T408DLsuper.img" >nul 2>&1
    curl --insecure https://docs.google.com/forms/d/1-fV3lPmyRjqOPMIwWHYiRP_xycHZdBAza7Cx93p0Vq0/formResponse -d ifq -d entry.546571740=T408DLflash -d submit=Submit
    "%koshertek%\T408DL\dontmixmeup.exe" reboot
    echo.
    echo Flashing complete. Phone will now restart... 
    echo.
    echo Please give customer instructions paper.
    echo. 
    echo Press enter to exit
    pause >nul 2>&1
)

