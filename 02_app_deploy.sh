#!/bin/bash

echo "Deployment script started..."

# printer
# network
# mariadb install, apache2, php8.4

# copying and restarting related service.
# Test Print 

sudo apt install xinput


c/X11/xorg.conf.d$ sudo nano /etc/X11/xorg.conf.d/90-disable-cursor.conf
sudo: nano: command not found
linaro@linaro-alip:/etc/X11/xorg.conf.d$ sudo vim 90-disable-crusor.conf

Section "InputClass"
    Identifier "Disable Mouse"
    MatchIsPointer "on"
    Option "PointerDisable" "true"
EndSection


root@linaro-alip:/home/linaro# xinput list
⎡ Virtual core pointer                    	id=2	[master pointer  (3)]
⎜   ↳ Virtual core XTEST pointer              	id=4	[slave  pointer  (2)]
⎜   ↳ Instant USB Optical Mouse               	id=7	[slave  pointer  (2)]
⎜   ↳ SONiX USB Keyboard Consumer Control     	id=9	[slave  pointer  (2)]
⎜   ↳ goodix-ts                               	id=13	[slave  pointer  (2)]
⎣ Virtual core keyboard                   	id=3	[master keyboard (2)]
    ↳ Virtual core XTEST keyboard             	id=5	[slave  keyboard (3)]
    ↳ adc-keys                                	id=6	[slave  keyboard (3)]
    ↳ SONiX USB Keyboard                      	id=8	[slave  keyboard (3)]
    ↳ SONiX USB Keyboard System Control       	id=10	[slave  keyboard (3)]
    ↳ rk805 pwrkey                            	id=11	[slave  keyboard (3)]
    ↳ hdmi_cec_key                            	id=12	[slave  keyboard (3)]
    ↳ SONiX USB Keyboard Consumer Control     	id=14	[slave  keyboard (3)]
root@linaro-alip:/home/linaro#     

