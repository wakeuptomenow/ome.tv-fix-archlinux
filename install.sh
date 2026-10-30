#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "🐱 error: please run this script with sudo (sudo ./install.sh)"
  exit 1
fi

echo "cleaning up older v4l2loopback configurations"
rm -f /etc/modprobe.d/v4l2loopback.conf
rm -f /etc/modules-load.d/v4l2loopback.conf

echo "resetting kernel active modules"
rmmod v4l2loopback 2>/dev/null

echo "verifying system packages"
pacman -Sy --needed --noconfirm v4l2loopback-dkms linux-headers v4l-utils iriunwebcam-bin

echo "generating permanent hardware mapping rules"
cat << 'EOF' > /etc/modprobe.d/v4l2loopback.conf
options v4l2loopback devices=2 video_nr=0,1 card_label="Iriun Webcam","Logitech HD Pro Webcam C920" exclusive_caps=1,1
EOF

echo "enabling camera loopback activation on boot"
echo "v4l2loopback" > /etc/modules-load.d/v4l2loopback.conf

echo "activating camera"
modprobe v4l2loopback


echo "mapped drivers:"
echo " /dev/video0 -> Iriun Webcam"
echo " /dev/video1 -> Logitech HD Pro Webcam C920"
echo "since iriun wants to be video0 to actually be able to connect we made it that, thats why if ur asking"
echo "--------------------------------------------------------"
echo "INSTRUCTIONS TO RUN :"
echo "1. start iriun client on pc and phone (it will grab /dev/video0)."
echo "2. open obs -> add video capture device (V4L2) -> choose 'Iriun Webcam'."
echo "3. start virtual camera (it will root to video1)"
echo "4. open ometv and pick 'Logitech HD Pro Webcam C920'."
