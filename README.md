# XRDP-for-ubuntu
Automatically installs and configures XFCE, XRDP and variables for a one-script setup

Before you begin, please read through this code - it will make changes to your environment that may or may not result in a positive change for your system. It is using standard and upkept repositories for installation setup and with a little bit of shell magic puts things where they need to go. 

#THIS SCRIPT WILL MAKE THE FOLLOWING CHANGES, SO READ THEM FIRST - SERIOUSLY
1. This script WILL INSTALL XFCE DESKTOP environment - so, y'know - think about whether you want that.
You PROBABLY can adjust the .xsession file to target a different environment, but when I ran it with gnome-session --replace to get a gnome shell up it seemed a tad unhappy. So ye be warned.

2. This script will install xrdp and a few other xrdp dependencies and make changes to your /etc/ directory
3. This script will place two hidden files in your home folder at: ~/.xsession and ~/.Xresources
4. This script will open port 3389 (RDP default port) for ALL TRAFFIC!!!

(you can ammend this with a different port or only allow from specific IP addresses - I have this as a generalized script hold and work in an environment where all our traffic is protected by our global firewall- YOU MAY NOT - PLEASE BE CAREFUL WITH ACCESS.)

 > if you need help setting up your ubuntu firewall I recommend downloading and using 'gufw' which is a nice graphical User interface for the built in ubuntu firewall (ufw). 
 5. This script will enable the xrdp service to start up on boot automatically.

# To install and use this script:

clone this repository with: 
'sudo git clone https://github.com/scotchman0/XRDP-for-ubuntu' to your home folder or install directory

make the script executable with: 'sudo chmod a+x xrdp_install.sh'

run the script with sudo permissions: 'sudo ./xrdp_install.sh'


TO ENABLE RDP SESSIONS FOR MULTIPLE USERS:
simply copy the ~/.xsession and ~/.Xresources files into their home directories and grant them ownership over the files.
