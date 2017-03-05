#!/bin/bash

issue='unknown'
DEBIANVERSION='unknown'
RELEASE='unknown'
LSBRELEASE='unknown'
HOSTNAMECTL='unknown'
KERNELNAME='unknown'
VCGENCMD='unknown'
OSRELEASE='unknown'
IFCONFIG='unknown'
ostypelong='unknown'
platform='unknown'

#@return stdout
#@param $1(variable): variable to print
# Usage: echo "$(getvar variable)"
getvar(){
  if [ -z "$1" ]
  then
    echo "Parameter #1 is zero length"  # Or no parameter passed.
  else
    local d=$(printenv $1)
    echo $d
  fi
}

#@return stdout
# Usage: echo "$(getallvar)"
getallvar(){
  # not POSIX
  printenv --version
  echo
  printenv
  # POSIX - http://pubs.opengroup.org/onlinepubs/9699919799/utilities/env.html
  #env
}

detectSysInfo(){
	if [[ "$OSTYPE" == "linux-gnu" ]]; then
		ostypelong=""
	elif [[ "$OSTYPE" == "darwin"* ]]; then
		ostypelong="Mac OSX"
	elif [[ "$OSTYPE" == "cygwin" ]]; then
		ostypelong="POSIX compatibility layer and Linux environment emulation for Windows"
	elif [[ "$OSTYPE" == "msys" ]]; then
		ostypelong="Lightweight shell and GNU utilities compiled for Windows, part of MinGW"
	elif [[ "$OSTYPE" == "win32" ]]; then
		ostypelong="I'm not sure this can happen."
	elif [[ "$OSTYPE" == "freebsd"* ]]; then
		ostypelong="freebsd"
	fi
	if [[ "$KERNELNAME" == 'Linux' ]]; then
		platform='linux'
	elif [[ "$KERNELNAME" == 'FreeBSD' ]]; then
		platform='freebsd'
	elif [[ "$KERNELNAME" == 'CYGWIN_NT-10.0' ]]; then
		platform='win10'
	fi
}

tempsysinfo(){
  printf "\n/etc/issue: $ISSUE\n"
  printf "\n/etc/debian_version: $DEBIANVERSION\n"
  printf "\n/etc/*-release: $RELEASE\n"
  printf "\nlsb_release -da: $LSBRELEASE\n"
  printf "\nhostnamectl: $HOSTNAMECTL\n"
  printf "\nKERNEL: $KERNELNAME\n"
  printf "\n/opt/vc/bin/vcgencmd version: $VCGENCMD\n"
  printf "\n/etc/os-release: $OSRELEASE\n"
  printf "\nifconfig: $IFCONFIG\n\n"
  echo "PLATFORM: $platform"
  echo "OSTYPE: $OSTYPE ($ostypelong)"
}

main(){
  issue=`cat /etc/issue`
  DEBIANVERSION=`cat /etc/debian_version`
  RELEASE=`cat /etc/*-release`
  LSBRELEASE=`lsb_release -da`
  HOSTNAMECTL=`hostnamectl`
  KERNELNAME=`uname -s`
  VCGENCMD=`/opt/vc/bin/vcgencmd version`
  OSRELEASE=`cat /etc/os-release`
  IFCONFIG=`ifconfig eth0 | grep inet | awk '{ print $2 }'`
  detectSysInfo
}
main "$@"
