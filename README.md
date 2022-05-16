# Manjaro Waydroid Manager   
# (  Compatible with Pinephone Pro / Manjaro Arm  )
Manjaro Waydroid Manager is a CLI program for installing and managing Waydroid on Manjaro Arm on the Pinephone Pro.

How to download and use:

With git clone:

git clone https://github.com/MadameMalady/Manjaro-Waydroid-Manager

cd Manjaro-Waydroid-Manager

chmod +x MWM.sh

./MWM.sh
    

From the 'Releases' page:

Download the latest release from the 'Releases'page (  The MWM.sh file  )

cd in terminal to where you downloaded MWM.sh , this will typically be in /Downloads

chmod +x MWM.sh

./MWM.sh




The current implemented features are:

-Automated dependencies installation

-Installation options for both waydroid-gapps and standard waydroid

-Grab the system.img vendor.img from Sourceforge (optional)

-Video Mode toggles for software or gpu-based rendering

-Uninstall Waydroid

-Restart Waydroid

-Install all .apk files in /Downloads automatically

-Restart the 'non-gapps'image with the -s --gapps tag (helpful for getting past google play warnings in some games



WIP features include:

-Automation of custom rom creation for waydroid

-toggle .desktop view on / off for individual apps (You can currently do this manuely with 'Desktopius' from the elementary os flatpak repo.

-Check Installation statuses for Waydroid, Waydroid-img, and system and vendor.img's.
(This is what waydroid_checker.sh is for).
