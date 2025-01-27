transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+/home/cccoats2/ece411/sp18/testbench_example {/home/cccoats2/ece411/sp18/testbench_example/xor2.sv}

vlog -sv -work work +incdir+/home/cccoats2/ece411/sp18/testbench_example {/home/cccoats2/ece411/sp18/testbench_example/testbench.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L stratixiii_ver -L rtl_work -L work -voptargs="+acc"  testbench

add wave *
view structure
view signals
run 200 ns
