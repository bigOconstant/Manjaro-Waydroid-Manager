#!/bin/bash
echo "checking file system now..."
waydroid=/var/lib/waydroid
if [ -f "$waydroid" ]; then
    echo "Waydroid found in /var/lib/waydroid"
    echo -e "\e[92m Located \e[0m"
else 
    echo "$waydroid Installation not found"
    echo -e "\e[31m Unable to Locate \e[0m"
fi
vendor_img=/var/lib/waydroid/images/vendor.img
if [ -f "$vendor_img" ]; then
    echo "vendor.img found in /var/lib/waydroid/images"
    echo -e "\e[92m Located \e[0m"
else 
    echo "vendor.img wasn't found in /var/lib/waydroid/images"
    echo -e "\e[31m Unable to Locate \e[0m"
fi
system_img=/var/lib/waydroid/images/system.img
if [ -f "$system_img" ]; then
    echo "system.img found in /var/lib/waydroid/images"
    echo -e "\e[92m Located \e[0m"
else 
    echo "system.img wasn't found in /var/lib/waydroid/images"
    echo -e "\e[31m Unable to Locate \e[0m"
fi
echo -e "Press '\e[92m enter \e[0m' to continue"
read -p ""
./MWM.sh
