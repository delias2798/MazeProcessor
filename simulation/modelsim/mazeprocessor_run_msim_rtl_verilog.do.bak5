transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/lc3b_types.sv}
vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/register.sv}
vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/wishbone.sv}
vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/mux8.sv}
vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/mux2.sv}
vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/mux4.sv}
vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/plus2.sv}
vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/write_back_stage.sv}
vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/register_control_rom.sv}
vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/gencc.sv}
vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/cc_comp.sv}
vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/cpu_datapath.sv}
vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/control_rom.sv}
vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/regfile.sv}
vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/zext.sv}
vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/sext.sv}
vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/adj.sv}
vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/ir.sv}
vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/fetch_stage.sv}
vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/decode_stage.sv}
vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/execute_stage.sv}
vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/br_add.sv}
vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/alu.sv}
vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/zext_s.sv}
vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/memory_stage.sv}
vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/cpu.sv}
vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/mazeprocessor.sv}

vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/testbench.sv}
vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/magic_memory_dual_port.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L arriaii_hssi_ver -L arriaii_pcie_hip_ver -L arriaii_ver -L rtl_work -L work -voptargs="+acc"  testbench

add wave *
view structure
view signals
run 200 ns
