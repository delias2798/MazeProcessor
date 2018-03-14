library verilog;
use verilog.vl_types.all;
library work;
entity memory_stall is
    port(
        clk             : in     vl_logic;
        load_ex_mem     : in     vl_logic;
        mem_ack_counter : in     vl_logic_vector(1 downto 0);
        dmem_resp       : in     vl_logic;
        opcode          : in     work.lc3b_types.lc3b_opcode;
        dest_out        : in     vl_logic_vector(15 downto 0);
        dmem_address    : in     vl_logic_vector(15 downto 0);
        dmem_action_stb : out    vl_logic;
        dmem_action_cyc : out    vl_logic;
        dmem_write      : out    vl_logic;
        dmem_byte_enable: out    vl_logic_vector(1 downto 0);
        dmem_wdata      : out    vl_logic_vector(15 downto 0);
        mem_stall       : out    vl_logic;
        mem_addr_mux_sel: out    vl_logic
    );
end memory_stall;
