#!/bin/bash
 
# MWM v0.0.9
# Previously: Pinephone/Pro Waydroid Installation Script
# License: GPL v3.0
# Author: Cara Oswin
# Copyright: 2022, GPL v3.0
	
	# Notes: This is a script to help Pinephone Pro owners running Manjaro (tested with Phosh) install and manage Waydroid on their phone. It's possible it's also compatible with OG pinephones on manjaro, i've not tested it.
	
# Additional notes: 
		# The gapps image is not play-protect certified, meaning no working google play still. The likely fix to this is the same fix for full video acceleration, a custom waydroid image (i'll ellaborate in the note about Video Acceleration, bellow.)
# Working options:
	# Install Waydroid, Disable video acceleration, Restart Waydroid, Remove Waydroid, Credits, Exit.
# Partially-Working options:
	# Enable Video Acceleration
	# Enable Video Acceleration doesn't fully work yet, I say it works partially, because it's set to load mesa for egl and does so, however it's not actually doing it correctly. I think a custom waydroid android image made from the rk3399's factory image would likely fix this, once gralloc is set to gbm.
	
# Broken options:
        # Install Local apk files automatically
me="$(whoami)"

options[0]="Help!"
options[1]="Install Dependencies"
options[2]="Install Waydroid (gapps)"
options[3]="Install Waydroid (non-gapps)"
options[4]="Extra Options and Video Mode
       Settings. (alt + 1,2)"
options[5]="Credits (alt + 1,1)" 
options[6]="Exit (ctrl + c)"

#Actions to take based on selection
function ACTIONS {
    if [[ ${choices[0]} ]]; then
        # Help Me!
        echo "Help:
        
        Common Questions:
        
        Q: Waydroid init is taking forever!
        A: Waydroid may take up to 46 seconds 
        to initialize the container, 
        have patience
        
        Q: Phosh crashed / touch isn't 
        registering!
        A: Phosh did *not* crash, that's 
        waydroids default (incorrect, currently) 
        settings. Ignore the artifacts, and swipe 
        waydroid closed as you normally would, 
        the screen will go back to normal.
        After installing Waydroid with the script,
        run the 'disable video acceleration option' 
        this should be the very first thing you do. 
        You can toggle it back on after, but 
        waydroids default, unmodified settings
        will not currently work.
        
        Q: Is this full video acceleration?
        A: No, not yet, more work is required 
        to get there.
        
        Q: *something not listed here*
        A: Reach out on github, or read through the 
        script, the developer notes may 
        be illuminating."
        read -p "Press 'enter' to continue"
        ./MWM.sh
    fi
    if [[ ${choices[1]} ]]; then
        # Install Dependencies
        echo "This will install python-pip, pyclip, git, base-devel, and yay 
             (for the gapps version of Waydroid"
        read -p "Press 'enter' to continue, or ctrl + c to cancel"
        sudo pacman -S base-devel git
        sudo pamac install python-pip
        git clone https://aur.archlinux.org/yay-git.git
        cd yay-git
        makepkg -si
        cd ..
        yay -S python-pip
        sudo pip install pyclip
        read -p "Press 'enter' to continue, or ctrl + c to cancel"
        ./MWM.sh
    fi
    if [[ ${choices[2]} ]]; then
        # Install Waydroid (gapps)
        read -p "Press 'enter' to continue, or ctrl + c to cancel"
        echo "Remember to give the container 45 seconds to start"
        yay -S waydroid waydroid-image-gapps
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
        read -p "Press 'enter' to continue"
        ./MWM.sh
    fi
    if [[ ${choices[4]} ]]; then
        # Extra Developer Options
        
        #!/bin/bash
#Extra Options and Video Mode Settings sub-menu
options[0]="Enable video acceleration
       (experimental / Work-In-Progress)"
options[1]="Disable video acceleration"
options[2]="Install microg
       (coming in future release)"
options[3]="Init non-gapps image w/ -GAPPS tag"
options[4]="Install local .apk files
       (experimental / Work-In-Progress)"
options[5]="Restart Waydroid"
options[6]="Remove Waydroid (alt + 1,0)"
options[7]="Back"

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
        # Install microg
        echo 'placeholder'
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
        echo 'This Option will install all .apk files found in /Downloads, and is not extension-case sensitive'
        sudo mkdir /home/$me/MWM || true
        sudo mkdir /home/$me/MWM/Apk_Files || true
        
        find /home/$me \( -name "*.apk" -o -name "*.APK" \) -exec cp -r {} /home/$me/MWM/Apk_Files \;
        find /home/$me/MWM/Apk_Files \( -name "*.apk" -o -name "*.APK" \) -exec waydroid app install -r
        read "press 'k' to continue"
    fi
    if [[ ${choices[5]} ]]; then
        # Restart Waydroid 
        echo "Remember to give the container 45 seconds to start"
        waydroid session stop
        sudo systemctl restart waydroid-container.service
        waydroid session start &
        waydroid show-full-ui &
        read -p "Press 'enter' to continue"
    fi
    if [[ ${choices[6]} ]]; then
        # Remove Waydroid
        read -p "Press 'enter' to continue, or ctrl + c to cancel"
        yay -R waydroid waydroid-image-gapps
        yay -Syu
        sudo pacman -R waydroid waydroid-image
        sudo pacman -Syu  
        read -p "Press 'enter' to continue"
    fi
    if [[ ${choices[7]} ]]; then
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

    echo -e "         Manjaro Waydroid Manager v0.09
      Extra Options and Video Mode Settings
                    sub-menu
    \e[34m
          ____________________________
         |       __          __       |
         |       \ \        / /       |
         |        \ \------/ /        |
         | ____   /          \   ____ |
         | \   \ |  ()    ()  | /   / |
         |  \   \|     /\     |/   /  |
         |   \   \    /  \    /   /   |
         |    \   \  /    \  /   /    |
         |     \   \/      \/   /     |
         |      \      /\      /      |
         |       \    /  \    /       |
         |        \__/    \__/        |
         |____________________________|
         |  Manjaro Waydroid Manager  |
         |----------------------------|
         | GPL  3.0, 2022, Cara Oswin |
         ------------------------------\e[0m"
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

    echo -e "       Manjaro Waydroid Manager v0.09
    \e[92m
          ____________________________
         |       __          __       |
         |       \ \        / /       |
         |        \ \------/ /        |
         | ____   /          \   ____ |
         | \   \ |  ()    ()  | /   / |
         |  \   \|     /\     |/   /  |
         |   \   \    /  \    /   /   |
         |    \   \  /    \  /   /    |
         |     \   \/      \/   /     |
         |      \      /\      /      |
         |       \    /  \    /       |
         |        \__/    \__/        |
         |____________________________|
         |  Manjaro Waydroid Manager  |
         |----------------------------|
         | GPL  3.0, 2022, Cara Oswin |
         ------------------------------\e[0m"
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
