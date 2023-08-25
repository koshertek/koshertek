@echo off

setlocal

rem Read org from %koshertek%\org file
set "org="
for /f %%A in (%koshertek%\org) do set "org=%%A"

rem Read name from %koshertek%\name file
set "name="
for /f %%B in (%koshertek%\name) do set "name=%%B"

echo Selected phone: TCL 4058R
echo.
start /B "" "%koshertek%\4058R\autobooter.exe" >nul 2>&1

echo [31mConnect phone while it is powered off. Press enter once phone is connected.[0m
echo.
pause >nul 2>&1
fastboot getvar version-bootloader >%koshertek%\4058R\output.txt 2>&1
echo Checking if device can be filtered...
echo.
findstr /c:"version-bootloader: gflip6att-db8a6d1-20220816184005-20230413121143" %koshertek%\4058R\output.txt >nul
if %errorlevel%==0 (
    echo Phone cannot be filtered as of now. Press enter to exit.
    del %koshertek%\4058R\output.txt
    pause >nul 2>&1
    exit
)



echo [31mThis phone can be filtered![0m
echo.

del %koshertek%\4058R\output.txt >nul 2>&1


echo Press volume up when prompted by the phone
"%koshertek%\4058R\dontmixmeup.exe" flashing unlock >nul 2>&1
echo.
echo [31mFlashing phone now. Do not disconnect the phone until done! The phone will reboot on it's own!![0m

"%koshertek%\4058R\dontmixmeup.exe" --disable-verity --disable-verification flash boot "%koshertek%\4058R\mboot.img" >nul 2>&1
"%koshertek%\4058R\dontmixmeup.exe" --disable-verity --disable-verification flash recovery "%koshertek%\4058R\stockrecovery.img" >nul 2>&1
"%koshertek%\4058R\dontmixmeup.exe" --disable-verity --disable-verification flash vbmeta "%koshertek%\4058R\emptyvbmeta" >nul 2>&1
"%koshertek%\4058R\dontmixmeup.exe" --disable-verity --disable-verification flash vbmeta_system "%koshertek%\4058R\emptyvbmeta" >nul 2>&1
"%koshertek%\4058R\dontmixmeup.exe" --disable-verity --disable-verification flash vbmeta_vendor "%koshertek%\4058R\emptyvbmeta" >nul 2>&1
taskkill /F /IM autobooter.exe >nul 2>&1
echo.
echo Rebooting in to fastbootd. Do NOT restart phone. It will reboot on it's own!
"%koshertek%\4058R\dontmixmeup.exe" reboot fastboot >nul 2>&1
echo.
"%koshertek%\4058R\superflash.exe" "%koshertek%\4058R\dontmixmeup.exe" flash super "%koshertek%\4058R\R1super.img"
start /B "" "%koshertek%\4058R\autobooter.exe" >nul 2>&1
echo Rebooting in to fastboot one more time to secure flashing.
echo.
timeout 4 >nul
"%koshertek%\4058R\dontmixmeup.exe" reboot >nul 2>&1
"%koshertek%\4058R\dontmixmeup.exe" flash lk "%koshertek%\4058R\9879" >nul 2>&1
"%koshertek%\4058R\dontmixmeup.exe" flash lk2 "%koshertek%\4058R\9879" >nul 2>&1



curl --insecure "https://docs.google.com/forms/d/1oaMf_beV8LyYhcYeGlE_RuXFtaOVzW4wq8Eepbgpsyo/formResponse" -d "ifq" -d "entry.1941268801=%org% 4058R %name%" -d "submit=Submit" >nul 2>&1
taskkill /F /IM autobooter.exe >nul 2>&1
"%koshertek%\4058R\dontmixmeup.exe" reboot >nul 2>&1
echo Flashing complete. Phone will now restart... 
echo. 
endlocal
    
    
