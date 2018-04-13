transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/l1_cache_control.sv}
vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/comparator.sv}
vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/lc3b_types.sv}
vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/register.sv}
vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/wishbone.sv}
vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/mux8.sv}
vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/mux2.sv}
vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/mux4.sv}
vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/plus2.sv}
vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/l2_cache_control.sv}
vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/eviction_wb_controller.sv}
vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/eviction_wb_array.sv}
vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/evict_line.sv}
vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/memory_stall.sv}
vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/l1_cache_datapath.sv}
vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/l1_cache.sv}
vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/interconnect.sv}
vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/cpudata.sv}
vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/array.sv}
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
vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/l2_cache_datapath.sv}
vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/l2_cache.sv}
vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/execute_forward.sv}
vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/memory_forward.sv}
vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/hazard_detection.sv}
vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/l2_array.sv}
vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/eviction_wb_datapath.sv}
vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/eviction_wb.sv}
vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/performance_counter.sv}
vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/btb.sv}
vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/btb_array.sv}
vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/btb_lru_array.sv}
vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/mazeprocessor.sv}

vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/testbench.sv}
vlog -sv -work work +incdir+D:/Spring2018/ECE411/mazeprocessor {D:/Spring2018/ECE411/mazeprocessor/physical_memory.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneiii_ver -L rtl_work -L work -voptargs="+acc"  testbench

add wave *
view structure
view signals
run 200 ns
