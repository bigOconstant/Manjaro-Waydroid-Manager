#!/bin/bash
 
# MWM v0.1.1
# Previously: Pinephone/Pro Waydroid Installation Script
# License: GPL v3.0
# Author: Cara Oswin
# Copyright: 2022, GPL v3.0

# Notes: This is a script to help Pinephone Pro owners running Manjaro (tested with Phosh) install and manage Waydroid on their phone. It's possible it's also compatible with OG pinephones on manjaro, i've not tested it.
	
# Additional notes: 

# The gapps images are not play-protect certified, meaning no working google play still. The likely fix to this is the same fix for full video acceleration, a custom waydroid image (i'll ellaborate in the note about Video Acceleration, bellow.)

# Working options:

# Install Waydroid, Disable video acceleration, Restart Waydroid, Remove Waydroid, install all apk's, install images from sourceforge (needs sources updated occasionally.), init w/ -gapps, Credits, Exit.

# Partially-Working options:

# Enable Video Acceleration
# Enable Video Acceleration doesn't fully work yet, I say it works partially, because it's set to load mesa for egl and does so, however it's not actually doing it correctly. I think a custom waydroid android image made from the rk3399's factory image would likely fix this, once gralloc is set to gbm.

me="$(whoami)"

options[0]="|| Help!                  ||
       ||------------------------||"
options[1]="|| Install Dependencies   ||
       ||------------------------||"
options[2]="||Install Waydroid(gapps) ||
       ||------------------------||"
options[3]="||Install Waydroid Xgapps ||
       ||------------------------||"
options[4]="|| Extra Options, Install ||
       ||options, video Settings ||
       ||------------------------||"
options[5]="|| Credits                ||
       ||------------------------||" 
options[6]="|| Exit                   ||
       ||________________________||"

#Actions to take based on selection
function ACTIONS {
    if [[ ${choices[0]} ]]; then
        # Help Me!
        echo "Help:
        
   Common Questions:
        
   Q: Waydroid init is taking 
      forever!
   A: Waydroid may take up to
      46 seconds to initialize 
      the container, be patient.
        
   Q: Phosh crashed / touch isn't 
      registering!
   A: Phosh did *not* crash, that's 
      waydroids default (incorrect, 
      currently) settings. Ignore 
      the artifacts, and swipe 
      waydroid closed as you 
      normally would, the screen 
      will go back to normal.
      After installing Waydroid 
      with the script, run the 
      'Software-Based Rendering option' 
      this should be the very first 
      thing you do. 
      You can toggle it back on after, 
      but waydroids default, unmodified 
      settings will not currently work.
        
   Q: Is this full video acceleration?
   A: No, not yet, more work is required 
      to get there.
      
   Q: Waydroid shows up, but it's rendered
      Incorrectly. 
      (ie: in a corner, or half the screen.)
   A: If waydroid trys to show the full ui, 
      And the on-screen keyboard is showing,
      It will not render the window correctly.
      Restart waydroid. 
      (option in ectra options.)
      
   Q: I ran one option in the program 
      and it did something else!
   A: Make sure when navigating menus to
      un-check the number you hit last.
      
   Q: The Sourceforge images say they're 
      from xx/xx/xx. Why that date?
   A: The sources for wget will have to 
      be updated periodically as new 
      releases are made available.
        
   Q: *something not listed here*
   A: Open an Issue on github, 
      or read through the script, the 
      developer notes may be 
      illuminating."
        echo -e "Press '\e[92m enter \e[0m' to continue"
        read -p ""
        ./MWM.sh
    fi
    if [[ ${choices[1]} ]]; then
        # Install Dependencies
        echo "This will install python-pip,
pyclip, git, wget, base-devel, and yay 
(for the gapps version of Waydroid"
        echo -e "Press '\e[92m enter \e[0m' to continue
or \e[31mcrtl + c\e[0m to Cancel."
        read -p ""
        sudo pacman -S base-devel git wget
        sudo pamac install python-pip
        git clone https://aur.archlinux.org/yay-git.git
        cd yay-git
        makepkg -si
        cd ..
        yay -S python-pip
        sudo pip install pyclip
        echo -e "Press '\e[92m enter \e[0m' to continue."
        read -p ""
        ./MWM.sh
    fi
    if [[ ${choices[2]} ]]; then
        # Install Waydroid (gapps)
        read -p "This will install the 'waydroid' and 'waydroid-image-gapps'
packages from the aur.
Press '\e[92m enter \e[0m' to continue or \e[31mcrtl + c\e[0m to Cancel."
        yay -S waydroid waydroid-image-gapps
        echo -e "Now to Start the container.
Remember to give the container 45 seconds to start
Press '\e[92m enter \e[0m' to continue or \e[31mcrtl + c\e[0m to Cancel."
        read -p ""
        sudo waydroid init -s GAPPS -f
        sudo pkexec setup-waydroid
        sudo systemctl enable waydroid-container.service
        sudo systemctl restart waydroid-container.service
        read -p "Press 'enter' to continue"
        ./MWM.sh
    fi
    if [[ ${choices[3]} ]]; then
        # Install Waydroid (non-gapps)
        echo "Remember to give the container 45 seconds to start"
        sudo rm -rf /usr/share/bash-completion/completions/lxc
        sudo pacman -S waydroid-image waydroid
        sudo pacman -Syyu
        sudo waydroid init -s VANILLA -f
        sudo pkexec setup-waydroid
        sudo systemctl enable waydroid-container.service
        sudo systemctl restart waydroid-container.service
        echo -e "Press '\e[92m enter \e[0m' to continue"
        read -p ""
        ./MWM.sh
    fi
    if [[ ${choices[4]} ]]; then
        # Extra Developer Options
        
        #!/bin/bash
#Extra Options and Video Mode Settings sub-menu
options[0]="|| GPU-Based Rendering    ||
       || Experimental (Partial- ||
       || implementation/W.I.P.) ||
       ||------------------------||"
options[1]="||Software-Based Rendering||
       ||------------------------||"
options[2]="|| Download waydroid only ||
       || And download the images||
       || From Sourceforge W.I.P ||
       ||------------------------||"
options[3]="|| init waydroid as -gapps||
       ||------------------------||"
options[4]="|| Install all .apk's in  ||
       ||/Downloads (host system)||
       ||------------------------||"
options[5]="||Check Waydroid Install  ||
       || and img Status (W.I.P) ||
       ||------------------------||"
options[6]="||  Restart Waydroid      ||
       ||------------------------||"
options[7]="||  Remove Waydroid       ||
       ||------------------------||"
options[8]="||  Back                  ||
       ||________________________||"

#Actions to take based on selection
function ACTIONS {
    if [[ ${choices[0]} ]]; then
        # Disable Video Acceleration
	#!/bin/bash
	echo "Remember to give the container 45 seconds to start"
	waydroid session stop
        ( sudo echo "ro.hardware.gralloc=default" ; sudo echo "ro.hardware.egl=swiftshader" ) >>/var/lib/waydroid/waydroid_base.prop
        sudo systemctl enable waydroid-container.service
        sudo systemctl restart waydroid-container.service
        waydroid session start &
        waydroid show-full-ui &
        read -p "Press 'enter' to continue"
        ./MWM.sh
    fi

    if [[ ${choices[1]} ]]; then
       # Enable Video Acceleration
       # The opengles.version line is a modification, which should reflect gl es version 3.1, which is the mali panfrost drivers currently provided version.
       # For "ro.hardware.gralloc=____" , I've tested egl (nothing) gbm (glitchy screen) rpi (nothing) and default (current setting, however I belive 'gbm' is the correct setting, in conjunction with a newer android image for waydroid.)
       #!/bin/bash
       echo "Remember to give the container 45 seconds to start"
       waydroid session stop
       ( sudo echo "ro.hardware.gralloc=default" ; sudo echo "ro.hardware.egl=mesa" ; sudo echo "ro.opengles.version=196609" ) >>/var/lib/waydroid/waydroid_base.prop
       sudo systemctl enable waydroid-container.service
       sudo systemctl restart waydroid-container.service
       waydroid session start &
       waydroid show-full-ui &
       read -p "Press 'enter' to continue"
       ./MWM.sh
    fi
    if [[ ${choices[2]} ]]; then
        # Install microg system.img and vender.img from sourceforge (source last updated 5/13/22)
        echo "This will download a gapps 
vender and system image from sourceforge
and install it or you.
(source last updated 5/13/22)"
        echo -e "Press '\e[92m enter \e[0m' to continue 
or \e[31mcrtl + c\e[0m to Cancel."
        read -p ""
        sudo pacman -S waydroid
        sudo pacman -Syu
        sudo rm -rf /home/$me/lineage-gapps-image
        images_present= false
        sudo cd /
        cd var
        cd lib
        cd waydroid
        sudo rm images
        mkdir images
        cd ~
        mkdir /home/$me/lineage-gapps-image
        cd /home/$me/lineage-gapps-image
        wget -O  lineage-17.1-20220316-GAPPS-waydroid_arm64-system.zip  https://sourceforge.net/projects/waydroid/files/images/system/lineage/waydroid_arm64/lineage-17.1-20220316-GAPPS-waydroid_arm64-system.zip
        wget -O lineage-17.1-20220419-MAINLINE-waydroid_arm64-vendor.zip https://sourceforge.net/projects/waydroid/files/images/vendor/waydroid_arm64/lineage-17.1-20220419-MAINLINE-waydroid_arm64-vendor.zip
        unzip lineage-17.1-20220419-MAINLINE-waydroid_arm64-vendor.zip
        unzip lineage-17.1-20220316-GAPPS-waydroid_arm64-system.zip
        sudo find /home/$me/lineage-gapps-image \( -name "*.img" -o -name "*.IMG" \) -exec cp -r {} /var/lib/waydroid/images/ \;
        waydroid session stop
        sudo waydroid init -s GAPPS -f
        sudo pkexec setup-waydroid
        ( sudo echo "ro.hardware.gralloc=default" ; sudo echo "ro.hardware.egl=mesa" ; sudo echo "ro.opengles.version=196609" ) >>/var/lib/waydroid/waydroid_base.prop
        sudo systemctl enable waydroid-container.service
        sudo systemctl restart waydroid-container.service
        waydroid session start &
        waydroid show-full-ui &
        read -p "Press '\e[92m enter \e[0m' to continue"
    fi
    if [[ ${choices[3]} ]]; then
        # Init non-gapps image w/ -GAPPS tag
        echo "Remember to give the container 45 seconds to start"
        waydroid session stop
        sudo waydroid init -s GAPPS -f
        sudo systemctl restart waydroid-container.service
        waydroid session start &
        waydroid show-full-ui &
        read -p "Press 'enter' to continue"
    fi
    if [[ ${choices[4]} ]]; then
        #Install local .apk files (experimental / Work-In-Progress)
        echo 'Apk Integration is a WIP'
        echo "This Option will install all .apk files 
found in /Downloads, and is not extension-case sensitive.
Hit enter to continue."
        read -p ""
        sudo mkdir /home/$me/MWM || true
        sudo mkdir /home/$me/MWM/Apk_Files || true
        
        find /home/$me \( -name "*.apk" -o -name "*.APK" \) -exec cp -r {} /home/$me/MWM/Apk_Files \;
        find /home/$me/MWM/Apk_Files \( -name "*.apk" -o -name "*.APK" \) -exec waydroid app install -r
        read "press 'k' to continue"
    if [[ ${choices[5]} ]]; then
        # Check waydroid and images installation status.
        echo -e "This will check the installation status of Waydroid.
This will scan for installs of 'waydroid' , 'waydroid-img' 
, and for system.img and vendor.img files.
Press '\e[92m enter \e[0m' to continue 
or \e[31mcrtl + c\e[0m to Cancel."
        chmod +x waydroid_checker.sh
        ./waydroid_checker.sh
    fi
    fi
    if [[ ${choices[6]} ]]; then
        # Restart Waydroid 
        echo "Remember to give the container 45 seconds to start"
        waydroid session stop
        sudo systemctl restart waydroid-container.service
        waydroid session start &
        waydroid show-full-ui &
        echo -e "Press '\e[92m enter \e[0m' to continue."
        read -p ""
    fi
    if [[ ${choices[7]} ]]; then
        # Remove Waydroid
        echo "This will unistall waydroid and 
waydroid-image from aur and/or 
manjaro repositories"
        echo -e "Press '\e[92m enter \e[0m' to continue 
or \e[31mcrtl + c\e[0m to Cancel."
        read -p ""
        yay -R waydroid waydroid-image-gapps
        sudo pacman -R waydroid waydroid-image
        echo -e "Press '\e[92m enter \e[0m' to continue"
        read -p ""
    fi
    if [[ ${choices[8]} ]]; then
        # Back to previous menu
        ./MWM.sh
    fi   
}

#Variables 
ERROR= ""

#Clear screen for menu
clear

#Menu function
function MENU {

    echo -e "    \e[92m   ||Manjaro Waydroid Manager||
       ||________________________||
       ||  ____________________  ||
       || |   __          __   | ||
       || |   \ \ ______ / /   | ||
       || |    \ /      \ /    | ||
       || |    /  O    O  \    | ||
       || |    |   ||||   |    | ||
       || |   / /        \ \   | ||
       || |  / /   W  D   \ \  | ||
       || |  \/|__________|\/  | ||
       || |      |_|  |_|      | ||
       || |--------------------| ||
       || |___GPL__3.0,_2022___| ||
       ||________________________||\e[0m"
    for NUM in ${!options[@]}; do
        echo "[""${choices[NUM]:- }""]" $(( NUM+1 ))") ${options[NUM]}"
    done
    echo "$ERROR"
}

#Menu loop
while MENU && read -e -p "Please make a choice.. " -n1 SELECTION && [[ -n "$SELECTION" ]]; do
    clear
    if [[ "$SELECTION" == *[[:digit:]]* && $SELECTION -ge 1 && $SELECTION -le ${#options[@]} ]]; then
        (( SELECTION-- ))
        if [[ "${choices[SELECTION]}" == "+" ]]; then
            choices[SELECTION]=""
        else
            choices[SELECTION]="+"
        fi
            ERROR=" "
    else
        ERROR="Invalid option: $SELECTION"
    fi
done

ACTIONS
    
    fi
    if [[ $choices[5]} ]]; then
        # Credits
        echo "Credits: Cara Oswin, Waydroid Team (Waydroid)"
        read -p "Press 'enter' to continue"
    fi
    if [[ ${choices[6]} ]]; then
        # Exit
        exit
    fi
}

#Variables 
ERROR= ""

#Clear screen for menu
clear

#Menu function
function MENU {
    echo -e "    \e[92m   ||Manjaro Waydroid Manager||
       ||________________________||
       ||  ____________________  ||
       || |   __          __   | ||
       || |   \ \ ______ / /   | ||
       || |    \ /      \ /    | ||
       || |    /  O    O  \    | ||
       || |    |   ||||   |    | ||
       || |   / /        \ \   | ||
       || |  / /   W  D   \ \  | ||
       || |  \/|__________|\/  | ||
       || |      |_|  |_|      | ||
       || |--------------------| ||
       || |___GPL__3.0,_2022___| ||
       ||________________________||\e[0m"
    for NUM in ${!options[@]}; do
        echo "[""${choices[NUM]:- }""]" $(( NUM+1 ))") ${options[NUM]}"
    done
    echo "$ERROR"
}

#Menu loop
while MENU && read -e -p "Please make a choice.. " -n1 SELECTION && [[ -n "$SELECTION" ]]; do
    clear
    if [[ "$SELECTION" == *[[:digit:]]* && $SELECTION -ge 1 && $SELECTION -le ${#options[@]} ]]; then
        (( SELECTION-- ))
        if [[ "${choices[SELECTION]}" == "+" ]]; then
            choices[SELECTION]=""
        else
            choices[SELECTION]="+"
        fi
            ERROR=" "
    else
        ERROR="Invalid option: $SELECTION"
    fi
done

ACTIONS
