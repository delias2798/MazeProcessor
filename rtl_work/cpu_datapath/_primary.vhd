library verilog;
use verilog.vl_types.all;
entity cpu_datapath is
    port(
        clk             : in     vl_logic;
        imem_rdata      : in     vl_logic_vector(127 downto 0);
        imem_resp       : in     vl_logic;
        imem_retry      : in     vl_logic;
        imem_address    : out    vl_logic_vector(15 downto 0);
        imem_action_stb : out    vl_logic;
        imem_action_cyc : out    vl_logic;
        dmem_rdata      : in     vl_logic_vector(127 downto 0);
        dmem_resp       : in     vl_logic;
        dmem_retry      : in     vl_logic;
        dmem_address    : out    vl_logic_vector(15 downto 0);
        dmem_wdata      : out    vl_logic_vector(15 downto 0);
        dmem_action_stb : out    vl_logic;
        dmem_action_cyc : out    vl_logic;
        dmem_write      : out    vl_logic;
        dmem_byte_enable: out    vl_logic_vector(1 downto 0)
    );
end cpu_datapath;
