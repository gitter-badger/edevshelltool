#!/bin/bash

pause() {
	read -p "Press [Enter] key to continue..." fackEnterKey
}

# Usage: echo "DATE: $(todaysdate)"
todaysdate(){
	local d=$(date +%d/%m/%Y) # Date of Today
	echo $d
}
