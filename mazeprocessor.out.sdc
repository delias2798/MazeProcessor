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

## DATE    "Sun Apr 15 02:14:22 2018"

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

