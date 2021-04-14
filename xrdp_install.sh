#!/bin/bash
#Install XRDP for Ubuntu script
#Written and configured by Will Russell (scotchman0) for public use
#compiled from many other smarter users than I - I'm just automating it.

#WARNING: THIS SOFTWARE WILL INSTALL AND CONFIGURE AN XFCE ENVIRONMENT AS PART OF THE INSTALL
#WARNING: THIS SOFTWARE WILL OPEN TO ALL TRAFFIC PORT 3389 ON YOUR NETWORK - CHANGE THIS IF THAT'S A PROBLEM
#PROCEED WITH CAUTION

echo "did you read the readme?"
echo "press return to continue - otherwise press ctrl+c to cancel the script"
sleep 1
read input1

#check for and perform updates:
#apt update && apt upgrade -y

#install baseline software and XFCE
apt-get install xrdp -y
apt-get install xorgxrdp -y
apt-get install xfce4 -y
apt-get install xfce4-terminal -y


sleep 3

#set XFCE as default RDP session:
echo xfce4-session > ~/.xsession

#create local session files for your resources to pull from:
echo 'Xcursor.core: 1' > ~/.Xresources

#set XRDP to start at linux boot:
systemctl enable xrdp

#Clear the existing details captured in startwm.sh after copy
cp /etc/xrdp/startwm.sh /etc/xrdp/startwm.sh.original
sh -c 'cat /dev/null > /etc/xrdp/startwm.sh'

#copy in the base lines for the file:
#NOTE lines 2-4 are there to kill the existing session if locally active on your login - so that xrdp can create the session

echo '#!/bin/sh' > /etc/xrdp/startwm.sh
echo unset DBUS_SESSION_BUS_ADDRESS >> /etc/xrdp/startwm.sh
echo unset XDG_RUNTIME_DIR >> /etc/xrdp/startwm.sh
echo . $HOME/.profile >> /etc/xrdp/startwm.sh
echo '' >> /etc/xrdp/startwm.sh
echo 'if [ -r /etc/default/locale ]; then' >> /etc/xrdp/startwm.sh
echo ' . /etc/default/locale' >> /etc/xrdp/startwm.sh
echo ' export LANG LANGUAGE' >> /etc/xrdp/startwm.sh
echo fi >> /etc/xrdp/startwm.sh
echo startxfce4 >> /etc/xrdp/startwm.sh
echo '' >> /etc/xrdp/startwm.sh

sleep 2

echo "Please be advised, port 3389 will be open to incoming connections on your system"
sleep 2

#enable firewall rule for the default port:
ufw allow 3389
#comment out the above and uncomment below if you want to just allow port access on your home net:
#ufw allow from 192.168.1.0/24 to any port 3389

#restart the service for baseline updates
#service xrdp restart
systemctl restart xrdp

#if service restart hangs above - (sometimes it does after XORGRDP is installed) - kill the task manually with htop
#or restart your workstation - that works too)

#check session's online:
if service --status-all | grep xrdp
  then echo "services available!"
else 
  echo "xrdp service not running, check wiki or restart service manually (or reboot)"
fi
exit 0
