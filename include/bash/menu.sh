#!/bin/bash

red='\033[0;41;30m' # ANSI Escape Sequence
std='\033[0;0;39m' # ANSI Escape Sequence

# @param array: array to print as menu
# Usage: showmenu "${array[@]}"
showmenu() {
	local arr=("$@")
	for i in ${!arr[@]}; do
			printf "%3d) %s\n" $((i+1)) "${arr[i]}"
	done
	printf "%3d< Exit\n" "$((${#arr[@]}+1))"
	printf "Enter choice [1 - %d]" "$((${#arr[@]}+1))"
}

readoption(){
	local choice
	read -p "" choice
	#@return
	echo $choice
}

optionerror(){
	echo -e "${red}Error...${std}" && sleep 1 # -e: enable interpretation of backslash escapes
}
