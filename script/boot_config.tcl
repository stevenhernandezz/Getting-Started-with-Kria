# Setting Bootmodes
# Once applications and custom HW designs are generated, developers need to move
# them to target. If using the Kria Starter Kit, developers can use various 
# boot-modes to test monolithic boot to application software using the following
# TCL scripts to set the preferred development boot process. Developers will 
# first put the functions in a <boot>.tcl script. Then, with the host machine 
# connected with their SOM kit, they use the following commands in XSDB or XSCT:
# source:
# https://xilinx.github.io/kria-apps-docs/creating_applications/2022.1/build/html/docs/bootmodes.html

# To set K26 to JTAG bootmode using XSDB/XSCT, add the following TCL scripts and call the function:
proc boot_jtag { } {
############################
# Switch to JTAG boot mode #
############################
targets -set -filter {name =~ "PSU"}
# update multiboot to ZERO
mwr 0xffca0010 0x0
# change boot mode to JTAG
mwr 0xff5e0200 0x0100
# reset
rst -system
}

# To set K26 to SD bootmode using XSDB/XSCT, add the following TCL scripts and call the function:
proc boot_sd { } {
############################
# Switch to SD boot mode #
############################
targets -set -filter {name =~ "PSU"}
# update multiboot to ZERO
mwr 0xffca0010 0x0
# change boot mode to SD
mwr 0xff5e0200 0xE100
# reset
rst -system
#A53 may be held in reset catch, start it with "con"
after 2000
con
}

# To set K26 to QSPI bootmode using XSDB/XSCT, add the following TCL scripts and call the function:
proc boot_qspi { } {
############################
# Switch to QSPI boot mode #
############################
targets -set -filter {name =~ "PSU"}
# update multiboot to ZERO
mwr 0xffca0010 0x0
# change boot mode to QSPI
mwr 0xff5e0200 0x2100
# reset
rst -system
#A53 may be held in reset catch, start it with "con"
after 2000
con
}

# To set K26 to eMMC bootmode using XSDB/XSCT, add the following TCL scripts and call the function:
proc boot_emmc { } {
############################
# Switch to emmc boot mode #
############################
targets -set -nocase -filter {name =~ "PSU"}
stop
# update multiboot to ZERO
mwr 0xffca0010 0x0
# change boot mode to EMMC
mwr 0xff5e0200 0x6100
# reset
rst -system
#A53 may be held in reset catch, start it with "con"
after 2000
con
}

# To set K26 to USB bootmode using XSDB/XSCT, add the following TCL scripts and call the function:
proc boot_usb { } {
############################
# Switch to usb0 boot mode #
############################
targets -set -nocase -filter {name =~ "PSU"}
stop
# update multiboot to ZERO
mwr 0xffca0010 0x0
# change boot mode to EMMC
mwr 0xff5e0200 0x7100
# reset
rst -system
#A53 may be held in reset catch, start it with "con"
after 2000
con
} 