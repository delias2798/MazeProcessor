library verilog;
use verilog.vl_types.all;
library work;
entity memory_stage is
    port(
        clk             : in     vl_logic;
        alu_out         : in     vl_logic_vector(15 downto 0);
        pc_br_out       : in     vl_logic_vector(15 downto 0);
        pc_j_out        : in     vl_logic_vector(15 downto 0);
        dmem_rdata      : in     vl_logic_vector(127 downto 0);
        dest_out        : in     vl_logic_vector(15 downto 0);
        dmem_resp       : in     vl_logic;
        mem_addr_mux_sel: in     vl_logic;
        newpcmux_sel    : in     vl_logic_vector(1 downto 0);
        opcode          : in     work.lc3b_types.lc3b_opcode;
        pc_out          : out    vl_logic_vector(15 downto 0);
        dmem_address    : out    vl_logic_vector(15 downto 0);
        dmem_wdata      : out    vl_logic_vector(15 downto 0);
        dmem_action_stb : out    vl_logic;
        dmem_action_cyc : out    vl_logic;
        dmem_write      : out    vl_logic;
        dmem_rdata_out  : out    vl_logic_vector(15 downto 0);
        dmem_byte_enable: out    vl_logic_vector(1 downto 0)
    );
end memory_stage;
