onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -height 15 /testbench/clk
add wave -noupdate -height 15 /testbench/clk
add wave -noupdate -height 15 -radix hexadecimal -childformat {{{/testbench/processor/c/cpu_d/id_stage/reg_file/data[7]} -radix hexadecimal} {{/testbench/processor/c/cpu_d/id_stage/reg_file/data[6]} -radix hexadecimal} {{/testbench/processor/c/cpu_d/id_stage/reg_file/data[5]} -radix hexadecimal} {{/testbench/processor/c/cpu_d/id_stage/reg_file/data[4]} -radix hexadecimal} {{/testbench/processor/c/cpu_d/id_stage/reg_file/data[3]} -radix hexadecimal} {{/testbench/processor/c/cpu_d/id_stage/reg_file/data[2]} -radix hexadecimal} {{/testbench/processor/c/cpu_d/id_stage/reg_file/data[1]} -radix hexadecimal} {{/testbench/processor/c/cpu_d/id_stage/reg_file/data[0]} -radix hexadecimal}} -expand -subitemconfig {{/testbench/processor/c/cpu_d/id_stage/reg_file/data[7]} {-height 16 -radix hexadecimal} {/testbench/processor/c/cpu_d/id_stage/reg_file/data[6]} {-height 16 -radix hexadecimal} {/testbench/processor/c/cpu_d/id_stage/reg_file/data[5]} {-height 16 -radix hexadecimal} {/testbench/processor/c/cpu_d/id_stage/reg_file/data[4]} {-height 16 -radix hexadecimal} {/testbench/processor/c/cpu_d/id_stage/reg_file/data[3]} {-height 16 -radix hexadecimal} {/testbench/processor/c/cpu_d/id_stage/reg_file/data[2]} {-height 16 -radix hexadecimal} {/testbench/processor/c/cpu_d/id_stage/reg_file/data[1]} {-height 16 -radix hexadecimal} {/testbench/processor/c/cpu_d/id_stage/reg_file/data[0]} {-height 16 -radix hexadecimal}} /testbench/processor/c/cpu_d/id_stage/reg_file/data
add wave -noupdate -height 15 -radix hexadecimal /testbench/pmem/WE
add wave -noupdate -height 15 -radix hexadecimal /testbench/pmem/CYC
add wave -noupdate -height 15 -radix hexadecimal /testbench/pmem/DAT_M
add wave -noupdate -height 15 -radix hexadecimal /testbench/pmem/DAT_S
add wave -noupdate -height 15 /testbench/pmem/ACK
add wave -noupdate -height 15 -radix hexadecimal /testbench/processor/eviction_wb_interconnect/WE
add wave -noupdate -height 15 -radix hexadecimal /testbench/processor/eviction_wb_interconnect/ADR
add wave -noupdate -height 15 -radix hexadecimal /testbench/processor/eviction_wb_interconnect/DAT_S
add wave -noupdate -height 15 -radix hexadecimal /testbench/processor/eviction_wb_interconnect/DAT_M
add wave -noupdate -height 15 -radix hexadecimal /testbench/processor/eviction_wb_interconnect/CYC
add wave -noupdate -height 15 /testbench/processor/eviction_wb_interconnect/ACK
add wave -noupdate -height 15 /testbench/processor/eviction_wb/cache_c/state
add wave -noupdate -height 15 /testbench/processor/eviction_wb/cache_c/hit
add wave -noupdate -height 15 /testbench/processor/eviction_wb/cache_c/valid0_out
add wave -noupdate -height 15 /testbench/processor/eviction_wb/cache_c/valid1_out
add wave -noupdate -height 15 /testbench/processor/eviction_wb/cache_c/valid2_out
add wave -noupdate -height 15 /testbench/processor/eviction_wb/cache_c/valid3_out
add wave -noupdate -height 15 /testbench/processor/eviction_wb/cache_c/data0_write
add wave -noupdate -height 15 /testbench/processor/eviction_wb/cache_c/data1_write
add wave -noupdate -height 15 /testbench/processor/eviction_wb/cache_c/data2_write
add wave -noupdate -height 15 /testbench/processor/eviction_wb/cache_c/data3_write
add wave -noupdate -height 15 /testbench/processor/eviction_wb/cache_c/cpu_action_stb
add wave -noupdate -height 15 /testbench/processor/eviction_wb/cache_c/cpu_action_cyc
add wave -noupdate -height 15 /testbench/processor/eviction_wb/cache_c/cpu_write
add wave -noupdate -height 15 /testbench/processor/eviction_wb/cache_c/valid
add wave -noupdate -height 15 /testbench/processor/l2_interconnect/ACK
add wave -noupdate -height 15 -radix hexadecimal /testbench/processor/l2_interconnect/WE
add wave -noupdate -height 15 -radix hexadecimal /testbench/processor/l2_interconnect/CYC
add wave -noupdate -height 15 -radix hexadecimal /testbench/processor/l2_interconnect/DAT_S
add wave -noupdate -height 15 -radix hexadecimal /testbench/processor/l2_interconnect/DAT_M
add wave -noupdate -height 15 -radix hexadecimal /testbench/processor/l2_interconnect/ADR
add wave -noupdate -height 15 -radix hexadecimal /testbench/processor/l2_cache/cache_d/data0/data
add wave -noupdate -height 15 -radix hexadecimal /testbench/processor/l2_cache/cache_d/data1/data
add wave -noupdate -height 15 -radix hexadecimal /testbench/processor/l2_cache/cache_d/data2/data
add wave -noupdate -height 15 -radix hexadecimal -childformat {{{/testbench/processor/l2_cache/cache_d/data3/data[15]} -radix hexadecimal} {{/testbench/processor/l2_cache/cache_d/data3/data[14]} -radix hexadecimal} {{/testbench/processor/l2_cache/cache_d/data3/data[13]} -radix hexadecimal} {{/testbench/processor/l2_cache/cache_d/data3/data[12]} -radix hexadecimal} {{/testbench/processor/l2_cache/cache_d/data3/data[11]} -radix hexadecimal} {{/testbench/processor/l2_cache/cache_d/data3/data[10]} -radix hexadecimal} {{/testbench/processor/l2_cache/cache_d/data3/data[9]} -radix hexadecimal} {{/testbench/processor/l2_cache/cache_d/data3/data[8]} -radix hexadecimal} {{/testbench/processor/l2_cache/cache_d/data3/data[7]} -radix hexadecimal} {{/testbench/processor/l2_cache/cache_d/data3/data[6]} -radix hexadecimal} {{/testbench/processor/l2_cache/cache_d/data3/data[5]} -radix hexadecimal} {{/testbench/processor/l2_cache/cache_d/data3/data[4]} -radix hexadecimal} {{/testbench/processor/l2_cache/cache_d/data3/data[3]} -radix hexadecimal} {{/testbench/processor/l2_cache/cache_d/data3/data[2]} -radix hexadecimal} {{/testbench/processor/l2_cache/cache_d/data3/data[1]} -radix hexadecimal} {{/testbench/processor/l2_cache/cache_d/data3/data[0]} -radix hexadecimal}} -subitemconfig {{/testbench/processor/l2_cache/cache_d/data3/data[15]} {-height 15 -radix hexadecimal} {/testbench/processor/l2_cache/cache_d/data3/data[14]} {-height 15 -radix hexadecimal} {/testbench/processor/l2_cache/cache_d/data3/data[13]} {-height 15 -radix hexadecimal} {/testbench/processor/l2_cache/cache_d/data3/data[12]} {-height 15 -radix hexadecimal} {/testbench/processor/l2_cache/cache_d/data3/data[11]} {-height 15 -radix hexadecimal} {/testbench/processor/l2_cache/cache_d/data3/data[10]} {-height 15 -radix hexadecimal} {/testbench/processor/l2_cache/cache_d/data3/data[9]} {-height 15 -radix hexadecimal} {/testbench/processor/l2_cache/cache_d/data3/data[8]} {-height 15 -radix hexadecimal} {/testbench/processor/l2_cache/cache_d/data3/data[7]} {-height 15 -radix hexadecimal} {/testbench/processor/l2_cache/cache_d/data3/data[6]} {-height 15 -radix hexadecimal} {/testbench/processor/l2_cache/cache_d/data3/data[5]} {-height 15 -radix hexadecimal} {/testbench/processor/l2_cache/cache_d/data3/data[4]} {-height 15 -radix hexadecimal} {/testbench/processor/l2_cache/cache_d/data3/data[3]} {-height 15 -radix hexadecimal} {/testbench/processor/l2_cache/cache_d/data3/data[2]} {-height 15 -radix hexadecimal} {/testbench/processor/l2_cache/cache_d/data3/data[1]} {-height 15 -radix hexadecimal} {/testbench/processor/l2_cache/cache_d/data3/data[0]} {-height 15 -radix hexadecimal}} /testbench/processor/l2_cache/cache_d/data3/data
add wave -noupdate -height 15 -radix hexadecimal /testbench/processor/eviction_wb/cache_d/data0/data
add wave -noupdate -height 15 -radix hexadecimal /testbench/processor/eviction_wb/cache_d/data1/data
add wave -noupdate -height 15 -radix hexadecimal /testbench/processor/eviction_wb/cache_d/data2/data
add wave -noupdate -height 15 -radix hexadecimal /testbench/processor/eviction_wb/cache_d/data3/data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {25952082 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 365
configure wave -valuecolwidth 209
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {25841483 ps} {26048518 ps}
