library verilog;
use verilog.vl_types.all;
library work;
entity write_back_stage is
    port(
        clk             : in     vl_logic;
        pc_br           : in     vl_logic_vector(15 downto 0);
        pc              : in     vl_logic_vector(15 downto 0);
        dmem_address    : in     vl_logic_vector(15 downto 0);
        dmem_wdata      : in     vl_logic_vector(15 downto 0);
        alu_out         : in     vl_logic_vector(15 downto 0);
        dest_register   : in     vl_logic_vector(2 downto 0);
        opcode          : in     work.lc3b_types.lc3b_opcode;
        load_cc         : in     vl_logic;
        regfilemux_sel  : in     vl_logic_vector(2 downto 0);
        write_data      : out    vl_logic_vector(15 downto 0);
        branch_enable   : out    vl_logic
    );
end write_back_stage;
