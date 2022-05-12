#!/bin/bash
 
# Pinephone/Pro Waydroid Installation Script v 0.09
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
options[4]="Disable video acceleration"
options[5]="Enable video acceleration
       (experimental / Work-In-Progress)"
options[6]="Install local .apk files
       (experimental / Work-In-Progress)"
options[7]="Restart Waydroid"
options[8]="Remove Waydroid"
options[9]="Credits"
options[10]="Exit (ctrl + c)"

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
        ./Pinephone-Pro-Waydroid-Installation-Script.sh
    fi
    if [[ ${choices[1]} ]]; then
        # Install Dependencies
        echo "This will install python-pip, pyclip, git, base-devel, and yay 
             (for the gapps version of Waydroid"
        read -p "Press 'enter' to continue, or ctrl + c to cancel"
        sudo pacman -S base-devel git
        sudo pamac install python-pip
        sudo pip install pyclip
        git clone https://aur.archlinux.org/yay-git.git
        cd yay-git
        makepkg -si
        cd ..
        read -p "Press 'enter' to continue, or ctrl + c to cancel"
        ./Pinephone-Pro-Waydroid-Installation-Script.sh
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
        ./Pinephone-Pro-Waydroid-Installation-Script.sh
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
        ./Pinephone-Pro-Waydroid-Installation-Script.sh
    fi
    if [[ ${choices[4]} ]]; then
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
        ./Pinephone-Pro-Waydroid-Installation-Script.sh
    fi
    if [[ ${choices[5]} ]]; then
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
        ./Pinephone-Pro-Waydroid-Installation-Script.sh
    fi
    if [[ ${choices[6]} ]]; then
        # Enable local .apk files
        echo 'Apk Integration is a WIP'
        echo 'This Option will install all .apk files found in /Downloads, and is not extension-case sensitive'
        sudo mkdir /home/$me/Waydroid-Installer || true
        sudo mkdir /home/$me/Waydroid-Installer/Apk_Files || true
        
        find /home/$me \( -name "*.apk" -o -name "*.APK" \) -exec cp -r {} /home/$me/Waydroid-Installer/Apk_Files \;
        find /home/$me/Waydroid-Installer/Apk_Files \( -name "*.apk" -o -name "*.APK" \) -exec waydroid app install -r
        read "press 'k' to continue"
        
        ./Pinephone-Pro-Waydroid-Installation-Script.sh
    fi
    if [[ ${choices[7]} ]]; then
        # Restart Waydroid 
        echo "Remember to give the container 45 seconds to start"
        waydroid session stop
        sudo systemctl restart waydroid-container.service
        waydroid session start &
        waydroid show-full-ui &
        read -p "Press 'enter' to continue"
        ./Pinephone-Pro-Waydroid-Installation-Script.sh
    fi
    if [[ ${choices[8]} ]]; then
        # Remove Waydroid
        read -p "Press 'enter' to continue, or ctrl + c to cancel"
        yay -R waydroid waydroid-image-gapps
        yay -Syu
        sudo pacman -R waydroid waydroid-image
        sudo pacman -Syu  
        read -p "Press 'enter' to continue"
        ./Pinephone-Pro-Waydroid-Installation-Script.sh   
    fi
    if [[ $choices[9]} ]]; then
        # Credits
        echo "Credits: Cara Oswin, Waydroid Team (Waydroid)"
        read -p "Press 'enter' to continue"
        ./Pinephone-Pro-Waydroid-Installation-Script.sh
    fi
    if [[ ${choices[10]} ]]; then
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
    echo "       Manjaro Pinephone(pro) Waydroid
           Installation Menu v0.09
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
         | Manjaro Waydroid Installer |
         |----------------------------|
         | GPL  3.0, 2022, Cara Oswin |
         ------------------------------"
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
