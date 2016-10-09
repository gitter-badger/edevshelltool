#!/bin/bash

#variables
workingdir="" # working path
includesdir="" # includes path
scriptdir="" # external scripts path
separator='~~~~~~~~~~~~~~~~~~~~~~~~~'
options_menu=("Scripts" "Git" "SysInfo" "Env Variables" "Android")
options_menuscripts=("Bash Script Header Maker" "Bash Portability Test Suite")
options_menugit=("Status (Show changed files in working dir)" "Log (Show history of changes)" "Diff (Show changes between code)" "Blame (Show who changed what and when in a file)" "Show (Show a commit identified by a id)" "Branch (Show all local branches)" "Fetch (Fetch latest changes from origin but doesnt merge them)" "Pull (Fetch and Merge)" "Commit" "Push (Push changes to origin)" "Tag" "Add all files" "Config Help")
options_menusysinfo=("Kernel Name" "Temp")
options_menuenvvar=("Print a specific variable" "Print all environment variables")
options_menuandroid=("ADB Print Devices" "ADB Push ROM" "ADB Sideload Default ROM" "ADB Reboot Bootloader" "Fastboot Print Devices" "Fastboot Flash Default Recovery" "Fastboot Flash Default Boot" "Fastboot Reboot" "Fastboot Boot TWRP" "Fastboot OEM Lock")

#functions - Will give an error message if variables not yet defined.
_init(){
	# init paths
	workingdir="$(dirname "$0")"
	includesdir="$workingdir/includes"
	scriptdir="$workingdir/scripts"
	etcdir="$workingdir/etc"
	includefiles=("$includesdir/android.sh" "$includesdir/apps.sh" "$includesdir/common.sh" "$includesdir/menu.sh" "$includesdir/sysinfo.sh")
	scriptfiles=("$scriptdir/mkscript.sh" "$scriptdir/test-suite.sh")
	bootandroidfile=("$etcdir/android/boot")
	recoveryandroidfile=("$etcdir/android/recovery" "$etcdir/android/recovery-twrp.img")
	romandroidfile=("$etcdir/android/rom.zip")
	allfiles=("${includefiles[@]}" "${scriptfiles[@]}")
	local inc=0
	for i in "${!allfiles[@]}";	do
		# fix permissions for /includes
		printf "File #%d: ${allfiles[$i]}\n" $((i+1))
		chmod u+x ${allfiles[$i]}
		chmod 775 ${allfiles[$i]}
		sed -i 's/\r$//' ${allfiles[$i]}
	done
	for f in ${!includefiles[@]}
	do
		printf "Include File #%d: ${includefiles[$f]}\n" $((f+1))
		# includes - includesdir need to be defined
		source ${includefiles[$f]} # same as > . "$dir/filename.sh"
	done
}
menu() {
	if [ -z "$1" ] # falta verificar se é inteiro e maior que 0
		then
			clear
			echo "Parameter #1 is zero length"  # Or no parameter passed.
		else
			clear
			echo $separator
			echo "    ENTHDEV BASH TOOL"
			echo $separator
			echo "USER: $(getvar USER)"
			echo "HOME: $(getvar HOME)"
			echo "Today's Date: $(todaysdate)"
			echo $separator
			if [ "$1" -eq 0 ]
				then
					showmenu "${options_menu[@]}"
					local c=$(readoption)
					case $c in
						1) menu 1;;
						2) menu 2;;
						3) menu 3;;
						4) menu 4;;
						5) menu 5;;
						6) exit 0;;
						*) optionerror;;
					esac
			elif [ "$1" -eq 1 ]
				then
					showmenu "${options_menuscripts[@]}"
					local c=$(readoption)
					case $c in
						1) sh ./"$scriptdir/mkscript.sh";;
						2) sh ./"$scriptdir/test-suite.sh";;
						3) ;;
						*) optionerror;;
					esac
			elif [ "$1" -eq 2 ]
				then
					showmenu "${options_menugit[@]}"
					local c=$(readoption)
					case $c in
						1) git status ;;
						2) git log ;;
						3) git diff ;;
						4) git blame ;;
						5) git show ;;
						6) git branch ;;
						7) git fetch ;;
						8) git pull ;;
						9) git commit -a -m "edevbashtool" ;; # Committ all your local changes
						10) git push ;;
						11) git tag ;;
						12) git add -A ;;
						13) git config --help ;;
						14) ;;
						*) optionerror;;
					esac
			elif [ "$1" -eq 3 ]
				then
					showmenu "${options_menusysinfo[@]}"
					local c=$(readoption)
					case $c in
						1) uname -s ;;
						2) tempsysinfo ;;
						3) ;;
						*) optionerror;;
					esac
			elif [ "$1" -eq 4 ]
				then
					showmenu "${options_menuenvvar[@]}"
					local c=$(readoption)
					case $c in
						1) echo "USER: $(getvar USER)" ;;
						2) echo "$(getallvar)" ;;
						3) ;;
						*) optionerror;;
					esac
			elif [ "$1" -eq 5 ]
				then
					showmenu "${options_menuandroid[@]}"
					local c=$(readoption)
					case $c in
						1) adblist ;;
						2) adbpush ${romandroidfile[0]} "/sdcard/alu";;
						3) adbsideload ${romandroidfile[0]} ;;
						4) adbrebootbootloader ;;
						5) fastbootlist ;;
						6) fastbootflashrecovery ${recoveryandroidfile[0]} ;;
						7) fastbootflashboot ${bootandroidfile[0]} ;;
						8) fastbootreboot ;;
						9) fastbootbootimage ${recoveryandroidfile[1]} ;;
						10) fastbootoemlock ;;
						11) ;;
						*) optionerror;;
					esac
		fi
	fi
}

#mainlogic - Will give an error message if functions not yet defined.
main() {
	#trap '' SIGINT SIGQUIT SIGTSTP # Trap CTRL+C, CTRL+Z and quit singles
	#trap 'echo "Control-C disabled."' SIGINT # Capture CTRL+C single using the trap
	#trap 'echo "Cannot terminate this script."'  SIGQUIT # Capture Quit single using the trap
	#trap 'echo "Control-Z disabled."' SIGTSTP # Capture CTRL+Z single using the trap
	echo
	echo "> Initializing script..."
	_init
	echo "Initialization completed."
	while true
	do
	pause
	menu 0
	done
}
main "$@"
