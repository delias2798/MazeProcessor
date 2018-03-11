library verilog;
use verilog.vl_types.all;
entity fetch_stage is
    port(
        clk             : in     vl_logic;
        imem_rdata      : in     vl_logic_vector(127 downto 0);
        new_pc          : in     vl_logic_vector(15 downto 0);
        branch_enable   : in     vl_logic;
        imem_address    : out    vl_logic_vector(15 downto 0);
        imem_action_stb : out    vl_logic;
        imem_action_cyc : out    vl_logic;
        pc_plus2_out    : out    vl_logic_vector(15 downto 0);
        imem_rdata_out  : out    vl_logic_vector(15 downto 0)
    );
end fetch_stage;
