#!/bin/bash
#Install XRDP for Ubuntu script
#Written and configured by Will Russell (scotchman0) for public use
#compiled from many other smarter users than I - I'm just automating it.

#WARNING: THIS SOFTWARE WILL INSTALL AND CONFIGURE AN XFCE ENVIRONMENT AS PART OF THE INSTALL
#PROCEED WITH CAUTION


#check for and perform updates:
apt update && apt upgrade -y

#install baseline software and XFCE
apt-get install xrdp -y
apt-get install xorgxrdp -y
apt-get install xfce4 -y

sleep 3

#set XFCE as default RDP session:
echo xfce4-session > ~/.xsession

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

#enable firewall rule for the default port:
ufw allow 3389

#restart the service for baseline updates
service xrdp restart

#create local session files for your resources to pull from:
echo 'Xcursor.core: 1' > ~/.Xresources

#check session's online:
service status xrdp

echo 'services available!'
exit 0