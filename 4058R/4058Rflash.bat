@echo off

setlocal


rem Read the contents of %koshertek%\location into the location variable
set "location="
for /f "usebackq delims=" %%a in ("%koshertek%\location") do set "location=%%a"

rem Read the contents of %koshertek%\username into the username variable
set "username="
for /f "usebackq delims=" %%a in ("%koshertek%\username") do set "username=%%a"
echo Selected phone: TCL 4058R
echo.
echo Tag Location: %location%
echo.
echo Username: %username%
echo.

:choices:


echo Select a profile to install:
echo.
echo 1. Talk, Text, Waze, Voice2Text
echo.
echo 2. Talk, Text, Waze, Voice2Text, Smartlist
echo.
echo 3. Talk, Text, Waze, Voice2Text, Email
echo.
echo 4. Talk, Text, Waze, Voice2Text, Smartlist, Email
echo.
set /p choice=Enter the profile number and press enter: 

if "%choice%"=="1" (
    set "boot=%koshertek%\4058R\noenos.img"
	set "prof=Talk, Text, Waze, Voice2Text"
) else if "%choice%"=="2" (
    set "boot=%koshertek%\4058R\noemail.img"
	set "prof=Talk, Text, Waze, Voice2Text, Smartlist"
) else if "%choice%"=="3" (
    set "boot=%koshertek%\4058R\yesemailnos.img"
	set "prof=Talk, Text, Waze, Voice2Text, Email"
) else if "%choice%"=="4" (
    set "boot=%koshertek%\4058R\yesemail.img"
	set "prof=Talk, Text, Waze, Voice2Text, Smartlist, Email"
) else (
	cls
	echo ##############################################
	echo              KosherTek Flash Tool             
	echo ##############################################
	echo.
    echo [31mInvalid Choice. Please try again.[0m
	echo.
    goto choices
)





rem Check if the fileschecked flag exists
if not exist "%koshertek%\4058R\fileschecked" (
    "%koshertek%\4058R\checksize.exe"

    rem Check the errorlevel and act accordingly
    if errorlevel 1 (
        echo Files did not download correctly! Contact KosherTek for help.
        pause >nul 2>&1
        exit /b 1
    ) else (
        echo. > "%koshertek%\4058R\fileschecked"
    )
)

cls
echo ##############################################
echo              KosherTek Flash Tool             
echo ##############################################

echo.
echo Tag Location: %location%
echo.

echo Username: %username%
echo.

echo.
echo Selected phone: TCL 4058R
echo.
echo.
echo Selected Profile: %prof%
echo.
echo.
echo [31mPLEASE NOTE: The installation for this model TCL is different than others.[0m
echo [31mThe phone will enter a few different modes. DO NOT touch the phone until the tool says it is done!![0m
echo [31mDO NOT press[0m[32m "REBOOT SYSTEM" [0m[31mon the phone.[0m
echo.






start /B "" "%koshertek%\adb\autobooter.exe" >nul 2>&1
echo.
echo Please inform the customer that the phone will be reset!
echo.
echo Connect phone while it is powered off. If the phone goes to charging mode just disconnect and reconnect it.
echo.
echo Press volume up when prompted by the phone
"%koshertek%\adb\fastboot.exe" flashing unlock >nul 2>&1
TASKKILL /F /IM autobooter.exe >nul 2>&1
echo.
echo Flashing phone now. Do not disconnect the phone until told!
"%koshertek%\adb\fastboot.exe" --disable-verity --disable-verification flash boot "%boot%" >nul 2>&1
"%koshertek%\adb\fastboot.exe" --disable-verity --disable-verification flash vbmeta "%koshertek%\4058R\emptyvbmeta" >nul 2>&1
"%koshertek%\adb\fastboot.exe" --disable-verity --disable-verification flash vbmeta_system "%koshertek%\4058R\emptyvbmeta" >nul 2>&1
"%koshertek%\adb\fastboot.exe" --disable-verity --disable-verification flash vbmeta_vendor "%koshertek%\4058R\emptyvbmeta" >nul 2>&1
"%koshertek%\adb\fastboot.exe" flash lk "%koshertek%\4058R\lk.img" >nul 2>&1
"%koshertek%\adb\fastboot.exe" flash md1img "%koshertek%\4058R\md1img.img" >nul 2>&1
"%koshertek%\adb\fastboot.exe" flash tee1 "%koshertek%\4058R\tee.img" >nul 2>&1
"%koshertek%\adb\fastboot.exe" flash dtbo "%koshertek%\4058R\dtbo.img" >nul 2>&1
"%koshertek%\adb\fastboot.exe" flash loader_ext1 "%koshertek%\4058R\loader_ext.img" >nul 2>&1
"%koshertek%\adb\fastboot.exe" flash mcupmfw "%koshertek%\4058R\mcupmfw.img" >nul 2>&1
"%koshertek%\adb\fastboot.exe" flash spmfw "%koshertek%\4058R\spmfw.img" >nul 2>&1
"%koshertek%\adb\fastboot.exe" flash logo "%koshertek%\4058R\logo.bin" >nul 2>&1
"%koshertek%\adb\fastboot.exe" flash preloader "%koshertek%\4058R\preloader_raw.img" >nul 2>&1
"%koshertek%\adb\fastboot.exe" flash md1dsp "%koshertek%\4058R\md1dsp.img" >nul 2>&1
"%koshertek%\adb\fastboot.exe" --disable-verity --disable-verification flash recovery "%koshertek%\4058R\recovery3.bin" >nul 2>&1
rem Part 2
"%koshertek%\adb\fastboot.exe" reboot fastboot >nul 2>&1
"%koshertek%\adb\fastboot.exe" reboot recovery >nul 2>&1
timeout 10 >nul
"%koshertek%\adb\adb.exe" wait-for-recovery >nul 2>&1
"%koshertek%\adb\adb.exe" shell "su -c parted /dev/block/mmcblk0 ---pretend-input-tty resizepart 41 2447 y i i i i i" >nul 2>&1
"%koshertek%\adb\adb.exe" shell "su -c parted /dev/block/mmcblk0 ---pretend-input-tty resizepart 32 452 y i i i i i" >nul 2>&1
"%koshertek%\adb\adb.exe" shell "su -c parted /dev/block/mmcblk0 ---pretend-input-tty resizepart 9 152 y i i i i i" >nul 2>&1
start /B "" "%koshertek%\adb\autobooter.exe" >nul 2>&1
timeout 15 >nul
"%koshertek%\adb\adb.exe" reboot >nul 2>&1
"%koshertek%\adb\fastboot.exe" --disable-verity --disable-verification flash recovery "%koshertek%\4058R\recovery3.bin" >nul 2>&1
"%koshertek%\adb\fastboot.exe" reboot fastboot >nul 2>&1
TASKKILL /F /IM autobooter.exe >nul 2>&1
rem Part 3 
"%koshertek%\4058R\superflash" "%koshertek%\adb\fastboot.exe" flash super "%koshertek%\4058R\4058Rsuper.img"
start /B "" "%koshertek%\adb\autobooter.exe" >nul 2>&1
echo.
echo Do not disconnect phone. One last thing...
timeout 15 >nul 2>&1
"%koshertek%\adb\fastboot.exe" reboot >nul 2>&1
"%koshertek%\adb\fastboot.exe" --disable-verity --disable-verification flash recovery "%koshertek%\4058R\finalrec.img" >nul 2>&1
	
curl --insecure "https://docs.google.com/forms/d/1-fV3lPmyRjqOPMIwWHYiRP_xycHZdBAza7Cx93p0Vq0/formResponse" -d "ifq" -d "entry.546571740=%location% 4058R %username%" -d "submit=Submit" >nul 2>&1
TASKKILL /F /IM autobooter.exe >nul 2>&1
"%koshertek%\adb\fastboot.exe" reboot >nul 2>&1
echo.
echo Flashing complete. You may now disconnect the phone. Phone will now restart... 
echo.
echo Please give customer instructions paper.
echo. 
echo Press enter to exit
pause >nul 2>&1
endlocal
    
    
