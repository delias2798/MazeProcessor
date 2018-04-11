## Generated SDC file "mazeprocessor.out.sdc"

## Copyright (C) 1991-2014 Altera Corporation
## Your use of Altera Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Altera Program License 
## Subscription Agreement, Altera MegaCore Function License 
## Agreement, or other applicable license agreement, including, 
## without limitation, that your use is for the sole purpose of 
## programming logic devices manufactured by Altera and sold by 
## Altera or its authorized distributors.  Please refer to the 
## applicable agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus II"
## VERSION "Version 13.1.4 Build 182 03/12/2014 SJ Full Version"

## DATE    "Wed Apr 11 15:19:39 2018"

##
## DEVICE  "EP3SL50F780C2"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {pmem_wb.CLK} -period 10.000 -waveform { 0.000 5.000 } [get_ports {pmem_wb.CLK}]


#**************************************************************
# Create Generated Clock
#**************************************************************



#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************

set_clock_uncertainty -rise_from [get_clocks {pmem_wb.CLK}] -rise_to [get_clocks {pmem_wb.CLK}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {pmem_wb.CLK}] -fall_to [get_clocks {pmem_wb.CLK}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {pmem_wb.CLK}] -rise_to [get_clocks {pmem_wb.CLK}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {pmem_wb.CLK}] -fall_to [get_clocks {pmem_wb.CLK}]  0.020  


#**************************************************************
# Set Input Delay
#**************************************************************

set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.ACK}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.CLK}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[0]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[1]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[2]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[3]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[4]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[5]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[6]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[7]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[8]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[9]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[10]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[11]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[12]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[13]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[14]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[15]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[16]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[17]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[18]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[19]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[20]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[21]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[22]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[23]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[24]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[25]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[26]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[27]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[28]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[29]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[30]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[31]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[32]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[33]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[34]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[35]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[36]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[37]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[38]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[39]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[40]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[41]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[42]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[43]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[44]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[45]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[46]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[47]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[48]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[49]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[50]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[51]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[52]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[53]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[54]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[55]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[56]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[57]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[58]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[59]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[60]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[61]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[62]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[63]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[64]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[65]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[66]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[67]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[68]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[69]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[70]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[71]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[72]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[73]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[74]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[75]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[76]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[77]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[78]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[79]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[80]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[81]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[82]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[83]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[84]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[85]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[86]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[87]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[88]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[89]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[90]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[91]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[92]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[93]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[94]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[95]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[96]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[97]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[98]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[99]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[100]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[101]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[102]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[103]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[104]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[105]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[106]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[107]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[108]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[109]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[110]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[111]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[112]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[113]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[114]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[115]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[116]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[117]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[118]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[119]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[120]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[121]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[122]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[123]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[124]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[125]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[126]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.DAT_S[127]}]
set_input_delay -add_delay  -clock [get_clocks {pmem_wb.CLK}]  0.000 [get_ports {pmem_wb.RTY}]


#**************************************************************
# Set Output Delay
#**************************************************************



#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************



#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************

