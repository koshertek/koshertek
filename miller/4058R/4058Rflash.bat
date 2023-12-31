@echo off
setlocal

rem Read the contents of %koshertek%\org into the org variable
set "org="
for /f "usebackq delims=" %%a in ("%koshertek%\org") do set "org=%%a"

rem Read the contents of %koshertek%\name into the name variable
set "name="
for /f "usebackq delims=" %%a in ("%koshertek%\name") do set "name=%%a"

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



echo.
echo Organization: %org%
echo.

echo Name: %name%
echo.

echo Selected phone: TCL 4058R
echo.
echo [31mPLEASE NOTE: The installation for this model TCL is different than others.[0m
echo [31mThe phone will enter a few different modes. DO NOT touch the phone until the tool says it is done!![0m
echo [31mDO NOT press[0m[32m "REBOOT SYSTEM" [0m[31mon the phone.[0m
echo.
echo Select a profile to install:
echo.
echo 1. R1- Talk,Text,Waze,Zmanim,Weather,Smartlist,Tefilas Haderech,Talk2Text 
echo.
echo 2. R2- Talk,Text,Camera,Gallery,Talk2Text,No Music
echo.


choice /c 12 /n /m "Enter your choice:"

if errorlevel 2 (
    start /B "" "%koshertek%\adb\autobooter.exe" >nul 2>&1
    echo.
    echo Selected Profile: R2
    echo.
    echo Connect phone while it is powered off.
    echo.
    echo Press volume up when prompted by the phone
    "%koshertek%\adb\fastboot.exe" flashing unlock >nul 2>&1
    TASKKILL /F /IM autobooter.exe >nul 2>&1
    echo.
    echo Flashing phone now. Do not disconnect the phone until told!
    "%koshertek%\adb\fastboot.exe" --disable-verity --disable-verification flash boot "%koshertek%\4058R\R2.img" >nul 2>&1
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
    "%koshertek%\adb\adb.exe" wait-for-recovery
    "%koshertek%\adb\adb.exe" shell "su -c parted /dev/block/mmcblk0 ---pretend-input-tty resizepart 41 2447 y i i i i i"
    "%koshertek%\adb\adb.exe" shell "su -c parted /dev/block/mmcblk0 ---pretend-input-tty resizepart 32 452 y i i i i i"
    "%koshertek%\adb\adb.exe" shell "su -c parted /dev/block/mmcblk0 ---pretend-input-tty resizepart 9 152 y i i i i i"
    start /B "" "%koshertek%\adb\autobooter.exe" >nul 2>&1
    timeout 5 >nul
    "%koshertek%\adb\adb.exe" reboot >nul 2>&1
    "%koshertek%\adb\fastboot.exe" --disable-verity --disable-verification flash recovery "%koshertek%\4058R\recovery3.bin" >nul 2>&1
    "%koshertek%\adb\fastboot.exe" reboot fastboot >nul 2>&1
    TASKKILL /F /IM autobooter.exe >nul 2>&1
    rem Part 3 
    "%koshertek%\4058R\superflash" "%koshertek%\adb\fastboot.exe" flash super "%koshertek%\4058R\4058Rsuper.img"
    start /B "" "%koshertek%\adb\autobooter.exe" >nul 2>&1
    echo.
    echo Do not disconnect phone. One last thing...
    timeout 5 >nul
    "%koshertek%\adb\fastboot.exe" reboot >nul 2>&1
    "%koshertek%\adb\fastboot.exe" --disable-verity --disable-verification flash recovery "%koshertek%\4058R\finalrec.img" >nul 2>&1
	
    curl --insecure "https://docs.google.com/forms/d/1oaMf_beV8LyYhcYeGlE_RuXFtaOVzW4wq8Eepbgpsyo/formResponse" -d "ifq" -d "entry.1941268801=%org% 4058R %name%" -d "submit=Submit" >nul 2>&1
    TASKKILL /F /IM autobooter.exe >nul 2>&1
    "%koshertek%\adb\fastboot.exe" reboot >nul 2>&1
    echo.
    echo Flashing complete. You may now disconnect the phone. Phone will now restart... 
    echo. 
    echo Press enter to exit
    pause >nul 2>&1
    
    
) else (
    start /B "" "%koshertek%\adb\autobooter.exe" >nul 2>&1
    echo.
    echo Selected Profile: R1
    echo.
    echo Connect phone while it is powered off.
    echo.
    echo Press volume up when prompted by the phone
    "%koshertek%\adb\fastboot.exe" flashing unlock >nul 2>&1
    TASKKILL /F /IM autobooter.exe >nul 2>&1
    echo.
    echo Flashing phone now. Do not disconnect the phone until told!
    "%koshertek%\adb\fastboot.exe" --disable-verity --disable-verification flash boot "%koshertek%\4058R\R1.img" >nul 2>&1
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
    "%koshertek%\adb\adb.exe" wait-for-recovery
    "%koshertek%\adb\adb.exe" shell "su -c parted /dev/block/mmcblk0 ---pretend-input-tty resizepart 41 2447 y i i i i i" >nul 2>&1
    "%koshertek%\adb\adb.exe" shell "su -c parted /dev/block/mmcblk0 ---pretend-input-tty resizepart 32 452 y i i i i i" >nul 2>&1
    "%koshertek%\adb\adb.exe" shell "su -c parted /dev/block/mmcblk0 ---pretend-input-tty resizepart 9 152 y i i i i i" >nul 2>&1
    start /B "" "%koshertek%\adb\autobooter.exe" >nul 2>&1
    timeout 5 >nul
    "%koshertek%\adb\adb.exe" reboot >nul 2>&1
    "%koshertek%\adb\fastboot.exe" --disable-verity --disable-verification flash recovery "%koshertek%\4058R\recovery3.bin" >nul 2>&1
    TASKKILL /F /IM autobooter.exe >nul 2>&1
    "%koshertek%\adb\fastboot.exe" reboot fastboot >nul 2>&1
	
    rem Part 3 
    "%koshertek%\4058R\superflash" "%koshertek%\adb\fastboot.exe" flash super "%koshertek%\4058R\4058Rsuper.img"
    start /B "" "%koshertek%\adb\autobooter.exe" >nul 2>&1
    echo.
    echo Do not disconnect phone. One last thing...
    timeout 5 >nul
    "%koshertek%\adb\fastboot.exe" reboot >nul 2>&1
    "%koshertek%\adb\fastboot.exe" --disable-verity --disable-verification flash recovery "%koshertek%\4058R\finalrec.img" >nul 2>&1 
	
    curl --insecure "https://docs.google.com/forms/d/1oaMf_beV8LyYhcYeGlE_RuXFtaOVzW4wq8Eepbgpsyo/formResponse" -d "ifq" -d "entry.1941268801=%org% 4058R %name%" -d "submit=Submit" >nul 2>&1
    TASKKILL /F /IM autobooter.exe >nul 2>&1
    "%koshertek%\adb\fastboot.exe" reboot
    echo.
    echo Flashing complete. You may now disconnect the phone. Phone will now restart... 
    echo.
    echo Press enter to exit
    pause >nul 2>&1
	
)
