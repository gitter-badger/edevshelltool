#!/bin/bash

fds(){
	rm output.txt
	# File descriptor 0 is the standard input (stdin).
	# File descriptor 1 is the standard output (stdout).
	# File descriptor 2 is the standard error (stderr).
	# - initially, stdout points to your terminal (you read it)-
	# - same applies to stderr, it's connected to your terminal
	# Send stdout(1) and stderr(2) output into the log file, but would also leave you with fd 3 connected to the console.
	# 2>&1 - redirects fd stderr(2) to stdout(1).
	# 3>&1 - create a new file descriptor and redirect it to stdout(1).
	# http://www.tldp.org/LDP/abs/html/io-redirection.html
	# http://wiki.bash-hackers.org/syntax/redirection
	# 1>>filename - Redirect and append stdout(1) to file "filename."
	exec 3>&1 1>>output.txt 2>&1
	printf "\n# timingcustom5 - fork+exec system calls\n"
	cc -Wall -o timingcustom5 timingcustom5.c
	#./timingcustom5
	./timingcustom5.exe | tee /dev/fd/3
	pause
	printf "\n############# mycopy\n"
	cc -Wall -g -o mycopy mycopy.c
	#time ./mycopy
	time ./mycopy.exe
	pause
	# Each system call can take more or less time depending on the actions the kernel must complete internally before returning a reply to the processes making the call.
	# http://stackoverflow.com/questions/5769734/what-are-the-different-versions-of-exec-used-for-in-c
}

# Aircrack-ng is an 802.11 WEP and WPA-PSK keys cracking program that can recover keys once enough data packets have been captured.
# http://www.aircrack-ng.org/
aircrack(){
  printf "\nDownloading pre... "
  sudo apt-get -y install build-essential libssl-dev libnl-3-dev iw
  printf "\nDownloading Aircrack source code from official website...\n"
  cd $DIR_WORK
  wget -O aircrack-ng.tar.gz http://download.aircrack-ng.org/aircrack-ng-1.2-rc2.tar.gz
  printf "\nExtracting and deleteing Aircrack source code...\n"
  tar -zxvf aircrack-ng.tar.gz
  sudo rm aircrack-ng.tar.gz
  cd $DIR_WORKINTALL
  echo "\nGranting privileges and running setup script...\n"
  sudo chmod +x common.mak
  sudo nano common.mak
  sudo make
  sudo make install
}

cmus(){
  sudo vi /etc/apt/sources.list
  # Add this: deb http://www.deb-multimedia.org testing main non-free
  # While Debian’s main repositories didn’t, luckily deb-multimedia did
  sudo apt-get update
  sudo apt-get install deb-multimedia-keyring
  sudo apt-get update

  sudo apt-get install libavcodec-dev libavformat-dev libpulse-dev libopusfile-dev libcue-dev libflac-dev libvorbis-dev libwavpack-dev libfaad-dev libmp4v2-dev libmad0-dev libswresample-dev
  sudo mkdir /home/pi/workspace/programming/bash/demos_bash/cmus
  cd /home/pi/workspace/programming/bash/demos_bash/cmus
  wget https://github.com/cmus/cmus/archive/v2.7.1.tar.gz -O cmus.tar.gz
  tar xvzf cmus.tar.gz
  cd /home/pi/workspace/programming/bash/demos_bash/cmus/cmus-2.7.1
  ./configure CONFIG_ROAR=n && sudo make install

  sudo apt-get install cmus
  sudo cmus /var/lib/mopidy/media
}

mopidy(){
  #UNNINSTALL
  sudo apt-get remove --purge package														# Will remove and purge the binaries. Purge meaning that any configuration files are deleted too.
	sudo aptitude remove package
	sudo apt-get autoremove																		# autoremove is used to remove packages that were automatically installed to satisfy dependencies for some package and that are no more needed.
  #FIRSTRUN
  printf "\nMaking sure that mpd was stopped...\n"
  sudo /etc/init.d/mpd stop																	# Make sure MPD Server doens't run
  printf "\nMPD Server was stooped.\n"

  sudo service mopidy stop																	# Run Mopidy a service (/etc/init.d/mopidy stop)
  sudo service mopidy start																	# mopidy (/etc/init.d/mopidy start)
  sudo service mopidy stop																	# mopidy (/etc/init.d/mopidy stop)
  #RUN
  printf "\n$TEXT_DEBUG Starting Server...\n"
	sudo service mopidy stop																	# sudo /etc/init.d/mopidy stop
	sudo service mopidy start																	# mopidy # sudo /etc/init.d/mopidy start
	#sudo service mopidy restart																# sudo /etc/init.d/mopidy restart
	#sudo service mopidy force-reload															# sudo /etc/init.d/mopidy force-reload
	#sudo service mopidy run																	# decreapted Debian package version 0.19.4-3 with mopidyctl
	printf "\n$TEXT_DEBUG Server was started.\n"
	pause

	printf "\n$TEXT_DEBUG Scanning for files in Mopidy...\n"
	# sudo mopidy local scan																	# Scan local music collection as regular user
	sudo mopidyctl local scan																	# Scan local music collection as system service
	curl -d '{"jsonrpc": "2.0", "id": 1, "method": "core.library.refresh"}' http://localhost:6680/mopidy/rpc # Refresh the library throw JSON-RPC API, only support by this method.
	printf "\$TEXT_DEBUG Files are scanned...\n"
	pause

	printf "\n$TEXT_DEBUG Starting Client...\n"
	# find /var/lib/mopidy/media/ -name "*.mp3" > /var/lib/mopidy/playlists/alex.m3u			# Create playlist m3u with all .mp3 filepath inside.
	ncmpcpp																						# Run ncmpcpp client.
	printf "\n$TEXT_DEBUG Client was started.\n"
  #FIX PERMISSIONS
  #userdel
	sudo adduser --system mopidy # created the user mopidy as a system user
	sudo adduser mopidy audio # Add mopidy user to audio group

	sudo chown -R pi:nogroup /var/lib/mopidy/media												# Fix 553 FTP Problem. The problem is because your folder is owned by root, instead of pi

	sudo chown -R mopidy:audio /home/pi/Music/mopidy											# Fix "Could not open resource for reading"
	sudo chown -R mopidy:audio /home/pi/Music/mopidy/media 									# Fix "Could not open resource for reading"
	sudo chown -R mopidy:audio /home/pi/Music/mopidy/local 									# Fix "Could not open resource for reading"

	sudo nano /etc/vsftpd.conf																	# Open VSFTPD config file
	sudo /etc/init.d/vsftpd reload																# Reload VSFTP service to config make changes.
  sudo modprobe ipv6																			# Load the IPv6 kernel module.
	echo ipv6 | sudo tee -a /etc/modules														# Add ipv6 to /etc/modules to ensure the IPv6 kernel module is loaded on boot.

  sudo wget -q -O - https://apt.mopidy.com/mopidy.gpg | sudo apt-key add -					# Add the archive’s GPG key
  if [ ! -d "$DIR_SOURCESLIST" ]; then														# If '/etc/apt/sources.list.d/' directory doesn't exists than open editor for 'sudo nano /etc/apt/sources.list' file
    sudo wget -q -O /etc/apt/sources.list https://apt.mopidy.com/jessie.list				# Add a sources list file to /etc/apt/sources.list.d/mopidy.list
  fi
  if [ -d "$DIR_SOURCESLIST" ]; then															# If '/etc/apt/sources.list.d/' directory exists than add sources list from mopidy.com
    sudo wget -q -O /etc/apt/sources.list.d/mopidy.list https://apt.mopidy.com/jessie.list	# Add a sources list file to /etc/apt/sources.list.d/mopidy.list
  fi
  sudo apt-get update																	# Make sure you have all APT packages updated
	sudo apt-get dist-upgrade															# Make sure upgrade versions if APT package and his dependencies
  sudo apt-get install rpi-update													# Install 'rpi-update' from APT package manager.
	sudo rpi-update																	# Update the RaspberryPi firmware.
  printf "\nTEXT_DEBUG Fixing ALSA audio problems...\n"
	cp /home/pi/workspace/programming/bash/demos_bash/mopidy/asoundrc ~/.asoundrc				# (root/.asoundrc)Note that if you have an ~/.asoundrc it will overide any global settings from /etc/asound.conf
	cp /home/pi/workspace/programming/bash/demos_bash/mopidy/asound.conf /etc/asound.conf
	printf "\n$TEXT_DEBUG ALSA audio problems was fixed.\n"
  clear
	echo
	echo "Sound Connector:"
	echo "1. Auto"
	echo "2. Analog"
	echo "3. HDMI"
	echo
	local choice
	read -p "Enter choice [1 - 3]: " choice
	case $choice in																								# Want the sound on analog sound connector. 'sudo amixer cset numid=3 <num>' [1: analog, 0: auto (default), 2: HDMI]-<num>
		1) sudo amixer cset numid=3 0 ;;																		# 1. Change RaspberryPi audio connector to auto.
		2) sudo amixer cset numid=3 1 ;;																		# 2. Change RaspberryPi audio connector to analog.
		3) sudo amixer cset numid=3 2 ;;																		# 3. Change RaspberryPi audio connector to hdmi.
		*) sudo amixer cset numid=3 1 ;;																		# Choice is unexpected, will change connector to analog by default.
	esac
  sudo apt-get update																			# Update the APT Package Manager
	sudo apt-cache show mopidy																	# Show a readable record for the package
	pause
	sudo apt-get install mopidy																# Install 'mopidy' APT packge
	sudo apt-get install mopidy-spotify														# Installation Spotify Mopidy Extensions
	sudo apt-get install mopidy-soundcloud														# Installation Soundcloud Mopidy Extensions
	sudo apt-get install mpc																	# Installation MPC Client
	sudo apt-get install ncmpcpp																# Installation of 'ncmpcpp' APT package
	sudo pip install Mopidy-Mopify																# Installation of Mopidy web client.
	sudo pip install --upgrade Mopidy-Mopify													# Upgrade of Mopify web client.
	sudo pip install Mopidy-Moped																# Instlattion of Moped web client.
	sudo apt-get install mpd-client-rompr														# Installation Rmpr Mopidy Extensions
  # Fix: https://discuss.mopidy.com/t/a-number-of-questions-using-mopidy/842/3 (config_dir = /etc/mopidy)
	cp /home/pi/workspace/programming/bash/demos_bash/mopidy/mopidy.conf /etc/mopidy/mopidy.conf	# When running Mopidy as a system service, this should usually be /etc/mopidy
	cp /home/pi/workspace/programming/bash/demos_bash/mopidy/mopidy.conf ~/.config/mopidy/mopidy.conf # (/root/.config/mopidy/mopidy.conf) When running Mopidy as a regular user, should usually be $XDG_CONFIG_DIR/mopidy (~/.config/mopidy). To run Mopidy as user, use 'mopidy'
	sudo mopidy config																			# See the configuration as regular user
	sudo mopidyctl config																		# See the configuration as system service
  cd $DIR_WORK
	wget https://goo.gl/XJuOUW -O example.mp3 --no-check-certificate							# Download example.mp3
	omxplayer -o local example.mp3																# Test sound ouput: example.mp3 with omxplayer
	aplay example.mp3																			# Test sound ouput: example.mp3 with aplay
	aplay /usr/share/sounds/alsa/Front_Center.wav												# Test sound output: Front_Center.wav with aplay
  printf "\n$TEXT_DEBUG Debugging Mopidy status...\n"
	mopidy --version																			# Show Mopidy version
	curl -d '{"jsonrpc": "2.0", "id": 1, "method": "core.playback.get_state"}' http://localhost:6680/mopidy/rpc # JSON-RPC API .get_state
	sudo service mopidy status																	# mopidy (/etc/init.d/mopidy status)
	printf "\n$TEXT_DEBUG Mopidy status was debugged.\n"
  sudo nano /var/log/mopidy/mopidy.log														# See Mopidy log file.
  sudo nano /etc/mopidy/logging.conf
  printf "\n$TEXT_DEBUG Clearing log file...\n"
  cat /dev/null > /var/log/mopidy/mopidy.log # Clear log
  printf "\n$TEXT_DEBUG Log file was cleared.\n"
  sudo nano /etc/rc.local																		# In order to have a command or program run when the Pi boots
	# sudo sed -i '/^exit 0/icommand to add' /etc/rc.local
	printf "\n$TEXT_DEBUG rc.local is changed.\n"
  # http://mopidy.readthedocs.org/en/latest/running/#init-scripts
	printf "\n$TEXT_DEBUG Updating init.d script...\n"
	cp /home/pi/workspace/programming/bash/demos_bash/mopidy/mopidy /etc/init.d/mopidy
	sudo chmod +x /etc/init.d/mopidy
	sudo chown root:root /etc/init.d/mopidy
	printf "\n$TEXT_DEBUG init.d script updated...\n"

	printf "\n$TEXT_DEBUG Managing systemd system and service manager...\n"
	#sudo update-rc.d mopidy enable																# Install and remove System-V style init script links. SysV and RunLevels decreapted on jessie.
	sudo systemctl enable mopidy																		# Install and remove SystemD style init service script links
	printf "\n$TEXT_DEBUG Systemd service created.\n"

	sudo dpkg-reconfigure mopidy																# Reconfigure an already installed package
}

webiopi(){
  # Default Username: webiopi
  # Default Password: raspberry
  # http://webiopi.trouch.com/INSTALL.html

  #CONFIG
  printf "\nCreating boot script for WebIOPi...\n"
  sudo update-rc.d webiopi defaults
  sudo cp $FILE_CONFIG /etc/webiopi/config
  sudo webiopi -d -c /etc/webiopi/config
  #sudo /etc/init.d/webiopi start

  #INSTALL
  printf "\nDownloading WebIOPi source code from official website...\n"
  cd $DIR_WORK
  wget -O webiopi.tar.gz http://sourceforge.net/projects/webiopi/files/WebIOPi-0.7.1.tar.gz/download
  printf "\nExtracting WebIOPi...\n"
  tar xvzf webiopi.tar.gz
  sudo rm webiopi.tar.gz
  cd $DIR_WORKINTALL
  echo "\nGranting privileges and running setup script...\n"
  sudo chmod +x setup.sh
  sudo ./setup.sh
}

# web2py - Free open source full-stack framework for rapid development of fast, scalable, secure and portable database-driven web-based applications.
web2py(){
  #CONFIG
  printf "\nGenerating RSA Private Key 2048 bit\n"
  cd $DIR_WORKINTALL
  openssl genrsa -out server.key 2048
  openssl req -new -key server.key -out server.csr
  openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt
  python web2py.py -a 'raspberry123' -c server.crt -k server.key -i 0.0.0.0 -p 8001
  #INSTALL
  printf "\nDownloading and installing 'unzip' package from APT...\n"
	sudo apt-get install unzip
	printf "\nDownloading web2py source code from official website...\n"
	cd $DIR_WORK
	wget http://www.web2py.com/examples/static/web2py_src.zip
	unzip web2py_src.zip
	cd $DIR_WORKINTALL
	python web2py.py
}

# vsftpd is used to start a FTP server. Provides a lightweight, efficient FTP server written for security.
vsftpd(){
  # Fix the 553 FTP Problem.
  # The problem is because your folder is owned by root, instead of pi
  sudo chown -R pi:nogroup /var/lib/mopidy/media
  sudo /etc/init.d/vsftpd reload
  sudo /etc/init.d/vsftpd start
  sudo /etc/init.d/vsftpd stop
  sudo /etc/init.d/vsftpd status
  sudo /etc/init.d/vsftpd restart
  #UNNINSTALL
  printf "\nRemoving the Very Secure FTPD binaries...\n"
  # Will remove and purge the binaries. Purge meaning that any configuration files are deleted too.
  sudo apt-get remove --purge vsftpd
  sudo aptitude remove vsftpd
  # autoremove is used to remove packages that were automatically installed to satisfy dependencies for some package and that are no more needed
  sudo apt-get autoremove
  #INSTALL
  printf "\nDownloading and installing 'vsftpd' package from APT...\n"
  sudo apt-get install vsftpd
  printf "\nRestarting FTP server\n\n"
	sudo /etc/init.d/vsftpd stop
	sudo /etc/init.d/vsftpd start
	printf "\nStopping FTP server\n\n"
	sudo /etc/init.d/vsftpd stop
	pause
	printf "\nCopying and Backing up new config to VSFTPD folder...\n"
	sudo cp $FILE_LOCAL $FILE_CONF # cp Source Dest
	sudo cp $FILE_LOCALBAK $FILE_CONFBAK # cp Source Dest
	# Showing Very Secure FTPD 'pam.d/vsftpd' file.
	echo
  cat /etc/pam.d/vsftpd
	# Showing Very Secure FTPD '/etc/ftpusers' file.
	echo
  cat /etc/ftpusers
	# Showing Very Secure FTPD '/etc/vsftpd.conf' file.
	echo
  sudo nano $FILE_CONF
	# Showing Very Secure FTPD '/etc/init.d/vsftpd' file.
	echo
  sudo nano /etc/init.d/vsftpd
	# cat /etc/vsftpd/ftpworkers # workers settings config
}

htop(){
  sudo apt-get install htop
}

midori(){
  sudo apt-get install midori
}

#VNC enables you to remotely access and control your devices wherever you are in the world, whenever you need to.
realvnc(){
  #INSTALL
  ############# Download VNC #############
	# Download and unpack the latest VNC on a Raspbian system:
	printf "\nDownloading RealVNC for RPi from official source website... "
	cd $DIR_WORK
	curl -L -o VNC.tar.gz https://www.realvnc.com/download/binary/latest/debian/arm/
	printf "\nExtracting and deleting RealVNC source code...\n"
	tar xvf VNC.tar.gz
	sudo rm VNC.tar.gz
	############# Daemons Installation Fix #############
	# https://support.realvnc.com/knowledgebase/article/View/511/2/vnc-installer-fails-to-install-daemons-on-certain-linux-distributions
	sudo mkdir /usr/lib/systemd/system/
	############# Install VNC Server and VNC Viewer #############
	# Install VNC Server and VNC Viewer on a Debian-compatible system (package names need editing):
	sudo dpkg -i VNC-Server-5.2.3-Linux-ARM.deb VNC-Viewer-5.2.3-Linux-ARM.deb
	############# License VNC Server #############
	# Mandatory. More information:
	# man vnclicense
	# Apply a license key (received via email):
	sudo vnclicense -add F2B3B-RBA7P-ZMAQH-74C5C-QA6JA
	############# Specify a VNC password for VNC Server #############
	# Mandatory for Free licenses. More information:
	# man vncpasswd
	# Specify a VNC password for VNC Server in Service Mode:
	sudo vncpasswd /root/.vnc/config.d/vncserver-x11
	# Specify a VNC password for VNC Server in Virtual Mode:
	vncpasswd ~/.vnc/config.d/Xvnc

	sudo vncinitconfig -install-defaults -service-daemon
	sudo vncinitconfig -install-defaults -service-daemon

	sudo systemctl disable vncserver-virtuald.service
	sudo systemctl disable vncserver-x11-serviced.service

	# sudo systemctl enable vncserver-virtuald.service
	sudo systemctl enable vncserver-x11-serviced.service

	sudo systemctl stop vncserver-x11-serviced.service
	sudo systemctl start vncserver-x11-serviced.service

	# sudo systemctl stop vncserver-virtuald.service
	# sudo systemctl start vncserver-virtuald.service

	sudo vncserver-virtual -kill :1
	sudo vncserver-virtual :1 -geometry 1920x1080
	sudo vncserver-virtual -kill :1

	cd $DIR_WORKINTALL
	echo "\nGranting privileges and running setup script...\n"
	sudo chmod +x common.mak
	sudo nano common.mak
	sudo make
	sudo make install

  #UNNINSTALL
  sudo rm -r /usr/lib/systemd/system/
}

noip(){
  #CONFIG
  printf "\nCreating boot script for NOIPDynamicUpdateClient...\n"
  sudo nano /etc/rc.local # Add this: sudo noip2
  sudo noip2 -S # To show noip configuration
  sudo noip2 -U 15 # To change update interval
  sudo noip2 --help # To Display Help
  #INSTALL
  printf "\nDownloading NOIPDynamicUpdateClient source code from official website...\n"
	cd $WORKDIR
	wget http://www.no-ip.com/client/linux/noip-duc-linux.tar.gz
	printf "\nExtracting NOIPDynamicUpdateClient...\n"
	tar xf noip-duc-linux.tar.gz
	sudo rm noip-duc-linux.tar.gz
	cd $DIR_WORKINTALL
	sudo make install
}

mpc(){
  mpc --host=127.0.0.1 --port=6600 help														# Run Console Client MPC: help
  mpc --host=127.0.0.1 --port=6600 stats														# Run Console Client MPC: statistics
  mpc --host=127.0.0.1 --port=6600 version													# Run Console Client MPC: version
  mpc --host=127.0.0.1 --port=6600 update													# Run Console Client MPC:
  mpc --host=127.0.0.1 --port=6600 lsplaylists												# Run Console Client MPC:
  mpc --host=127.0.0.1 --port=6600 ls /Files/media/											# Run Console Client MPC:
  mpc --host=127.0.0.1 --port=6600 load /Files/playlists/alex.								# Run Console Client MPC:
  # mpc --host=127.0.0.1 --port=6600 load /var/lib/mopidy/playlists/alex.m3u					# Run Console Client MPC:
  # mpc --host=127.0.0.1 --port=6600 save /Files/playlists/alex.m3u							# Not implemented
  mpc --host=127.0.0.1 --port=6600 volume 100												# Run Console Client MPC: Change volume to value
  mpc --host=127.0.0.1 --port=6600 playlist													# Run Console Client MPC: Print current playlist
  mpc --host=127.0.0.1 --port=6600 play 1													# Run Console Client MPC: Play track number of playlist
  mpc --host=127.0.0.1 --port=6600 clear														# Run Console Client MPC: Clear playlist
  mpc --host=127.0.0.1 --port=6600 findadd any melodrama										# Run Console Client MPC: Find track and add it to playlist
}

# TightVNCServer is used to start a VNC (Virtual Network  Computing) desktop. TightVNCServer is a Perl script which simplifies the process of starting an Xvnc server.
tightvncserver(){
  #INSTALL
  sudo apt-get install tightvncserver
  #UNNINSTALL
  printf "\n# Removing the TightVNCServer binaries...\n"
  # Will remove and purge the binaries. Purge meaning that any configuration files are deleted too.
  sudo apt-get remove --purge tightvncserver
  sudo aptitude remove tightvncserver
  # autoremove is used to remove packages that were automatically installed to satisfy dependencies for some package and that are no more needed.
  sudo apt-get autoremove
  sudo rm -r /root/.vnc
  sudo rm -r /home/pi/.vnc
  sudo rm /etc/init.d/tightvncserver
  sudo rm /etc/init.d/vncboot
  sudo rm /tmp/.X0-lock
  sudo rm /tmp/.X11-unix/X0
  printf "\n# Binaries, dependencies and configuration files are deleted.\n"
  #CONFIG
  printf "\n# TightVNCServer was going to configured with the following settings:\nDisplay:0\nGeometry:1920x1080\nDepth:24\n"
	printf "\n# Restarting TightVNCServer...\n"
	sudo /usr/bin/tightvncserver -kill :0
	su $USER -c '/usr/bin/tightvncserver -kill :0'
	pkill Xtightvnc
	su $USER -c '/usr/bin/tightvncserver :0 -geometry 1920x1080 -depth 24 -pixelformat rgb565'
	printf "\n# Creating a custom xstartup script for TightVNCServer...\n# Copying '$FILE_XSTARTUP' file to '$DIR_VNCROOT' folder"
	cp $FILE_XSTARTUP $FILE_VNCXSTARTUP # Copy xstartup file to /root/.vnc (cp Source Destination)
	printf "\n# The '$FILE_XSTARTUP' file was copied to '$FILE_VNCXSTARTUP'\n# Grating permissions to '$FILE_VNCXSTARTUP' file\n\n"
	chmod +x $FILE_VNCXSTARTUP
	nano $FILE_VNCXSTARTUP
	pause
	# Showing all files in TightVNCServer root folder
	printf "\n# Showing all files in TightVNCServer root folder...\n"
	for entry in "$DIR_VNCROOT"/*
	do
	  echo "$entry"
	done
  cat ~/.vnc/*.pid
  cat ~/.vnc/*.log
  #BOOTSCRIPT
  printf "\n# Creating a boot script for TightVNCServer...\n# Copying '$FILE_BOOT' file to '$DIR_INITBOOT' folder\n"
  cp $FILE_BOOT $FILE_INITBOOT # Copy vncboot file to /etc/init.d/vncboot (cp Source Destination)
  printf "\n# The '$FILE_BOOT' file was copied to '$FILE_INITBOOT'\n# Grating permissions to '$FILE_INITBOOT' file\n"
  chmod +x $FILE_INITBOOT
  # update-rc.d: using dependency based boot sequencing
  update-rc.d $FILE_INITBOOT defaults
  # update-rc.d: error: unable to read /etc/init.d//etc/init.d/vncboot
  update-rc.d vncboot defaults
  # If file does not exist in bash
  if [ ! -f "$FILE_INITBOOT" ]
  then
    echo "${RED}# File $FILE_INITBOOT does not exists"
  fi
  nano $FILE_INITBOOT
  printf "\n# Boot script created.\n\n"
  #CONFIG
  sudo /etc/init.d/vncboot start
  sudo /etc/init.d/vncboot stop
}

transmission(){
  sudo apt-get install transmission-daemon
  sudo service transmission-daemon reload
  sudo nano /etc/transmission-daemon/settings.json
  #"rpc-whitelist-enabled": false,
}

phpmyadmin(){
  sudo apt-get install phpmyadmin
  sudo nano /etc/apache2/apache2.conf
  # Add: Include /etc/phpmyadmin/apache.conf
}

apache(){
  # http://elinux.org/RPi_Apache2

  # The default Debian install of Apache will be configured to run in the "www-data" user space, and use the "www-data" group. Create the www-data group
  sudo addgroup www-data
  sudo adduser www-data www-data
  # Create the /var/www folder and reassign ownership of the folder (and any files/subfolders)
  sudo mkdir /var/www
  sudo chown -R www-data:www-data /var/www
  # Update repository information
  sudo apt-get update
  # Install Apache
  sudo apt-get install apache2
  # Display the contents of our site's home page
  cat /var/www/html/index.html

  # http://elinux.org/RPi_A_Simple_Wheezy_LAMP_install

  apt-get install apache2 php5 mysql-client mysql-server tomcat6 vsftpd
  sudo apt-get install libapache2-mod-auth-mysql php5-mysql

  # https://www.digitalocean.com/community/tutorials/how-to-install-linux-apache-mysql-php-lamp-stack-on-ubuntu

  sudo apt-get install apache2
  sudo apt-get install mysql-server libapache2-mod-auth-mysql php5-mysql
  sudo mysql_install_db
  sudo /usr/bin/mysql_secure_installation

  sudo apt-get install php5 libapache2-mod-php5 php5-mcrypt
  sudo nano /etc/apache2/mods-enabled/dir.conf
  #<IfModule mod_dir.c>
  #DirectoryIndex index.php index.html index.cgi index.pl index.php index.xhtml index.htm
  #</IfModule>
  apt-cache search php5- # Terminal will then display the list of possible php modules
  sudo service apache2 restart # /etc/init.d/apache2 restart

  # http://raspipress.com/2012/09/tutorial-install-phpmyadmin-on-your-raspberry-pi/

  apt-get install phpmyadmin

  nano /etc/apache2/apache2.conf
  #Add new line : Include /etc/phpmyadmin/apache.conf



  # https://www.digitalocean.com/community/tutorials/how-to-install-linux-nginx-mysql-php-lemp-stack-on-debian-7
  # https://www.raspberrypi.org/learning/lamp-web-server-with-wordpress/worksheet/
  sudo apt-get install apache2 -y


  # Install Apache + PHP5
  sudo apt-get install apache2 php5 libapache2-mod-php5

  sudo nano /etc/apache2/sites-enabled/000-default
  # change "AllowOverride None" to "AllowOverride ALL".

  # Restart Apache
  sudo service apache2 restart
  cd /var/
  # Privilegies
  sudo chmod 777 /var/www

  # Install Apache saying Yes automatically.
  sudo apt-get install apache2 -y

  # List a long listing format and don't ignore entrie starting with. hidden files are liste as well
  cd /var/www
  ls -al
  # Use the chown command to change file owner and group information.
  # pi to own the /var/www directory.
  sudo chown pi /var/www
  # Add a new group called www-data
  sudo groupadd www-data
  # Change the primary group for a User. usermod -g <group> <user>
  sudo usermod -g www-data www-data
  # Install 'MySQL Server'(mysql-server) and 'MySQL module for PHP5'(php5-mysql)
  sudo apt-get install mysql-server php5-mysql -y
  # Restart Aapache
  sudo service apache2 restart

}

multiselectmenu(){
	options=("AAA" "BBB" "CCC" "DDD")
	mulimenu() {
	    echo "Avaliable options:"
	    for i in ${!options[@]}; do
	        printf "%3d%s) %s\n" $((i+1)) "${choices[i]:- }" "${options[i]}"
	    done
	    [[ "$msg" ]] && echo "$msg"; :
	}
	prompt="Check an option (again to uncheck, ENTER when done): "
	while mulimenu && read -rp "$prompt" num && [[ "$num" ]]; do
	    [[ "$num" != *[![:digit:]]* ]] &&
	    (( num > 0 && num <= ${#options[@]} )) ||
	    { msg="Invalid option: $num"; continue; }
	    ((num--)); msg="${options[num]} was ${choices[num]:+un}checked"
	    [[ "${choices[num]}" ]] && choices[num]="" || choices[num]="+"
	done
	printf "You selected"; msg=" nothing"
	for i in ${!options[@]}; do
	    [[ "${choices[i]}" ]] && { printf " %s" "${options[i]}"; msg=""; }
	done
	echo "$msg"
}
