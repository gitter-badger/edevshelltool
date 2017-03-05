#!/bin/bash

adblist() {
	adb devices
}

fastbootlist() {
	fastboot devices
}

fastbootflashrecovery(){
	fastboot flash recovery $1
}

fastbootflashboot(){
	fastboot flash boot $1
}

fastbootbootimage(){
	fastboot boot $1
}

fastbootoemlock(){
	fastboot oem lock
}

fastbootreboot(){
	fastboot reboot
}

#@param $1(local)
#@param $2(remote)
# copy files/dirs to device
adbpush(){
	adb push $1 $2
}

#@param $1(local)
#@param $2(remote)
# copy files/dirs from device
adbpull(){
	adb pull $1 $2
}

adbsideload(){
	adb sideload $1
}

adbrebootbootloader(){
	adb reboot bootloader
	#adb reboot-bootloader
}
