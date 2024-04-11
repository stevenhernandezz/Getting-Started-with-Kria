proc boot_jtag { } {
  # Switch to JTAG boot mode #
  targets -set -filter {name =~ "PSU"}
  # update multiboot to ZERO
  mwr 0xffca0010 0x0
  # change boot mode to JTAG
  mwr 0xff5e0200 0x0100
  # reset
  rst -system
}
puts "Connect"
connect
puts "set boot mode to jtag"
boot_jtag
puts "List targets"
targets
puts "set targetr to PSU"
targets -set -filter {name =~ "PSU"}
puts "Configure the FPGA"
# When the active target is not a FPGA device, the first FPGA device is configured
fpga ./proj_platform/hw/system_wrapper.bit
puts "Source the psu_init.tcl script and run psu_init command to initialize PS"
source ./proj_platform/hw/psu_init.tcl
psu_init
puts "PS-PL power isolation must be removed and PL reset must be toggled, before the PL address space can be accessed"
# Some delay is needed between these steps
after 1000
psu_ps_pl_isolation_removal
after 1000
psu_ps_pl_reset_config
puts "Select A53 #0 and clear its reset"
targets -set -filter {name =~ "Cortex-A53 #0"}
puts "reset processor"
rst -processor
puts "Download the application program"
dow ./proj_app/Debug/proj_app.elf
puts "Run the application"
con
