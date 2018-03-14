library verilog;
use verilog.vl_types.all;
library work;
entity execute_stage is
    port(
        clk             : in     vl_logic;
        offset9         : in     vl_logic_vector(8 downto 0);
        offset11        : in     vl_logic_vector(10 downto 0);
        pc              : in     vl_logic_vector(15 downto 0);
        sr1             : in     vl_logic_vector(15 downto 0);
        sr2             : in     vl_logic_vector(15 downto 0);
        offset8         : in     vl_logic_vector(7 downto 0);
        dest_out        : in     vl_logic_vector(15 downto 0);
        bradd2mux_sel   : in     vl_logic;
        aluop           : in     work.lc3b_types.lc3b_aluop;
        alumux_sel      : in     vl_logic;
        br_add_out      : out    vl_logic_vector(15 downto 0);
        bradd2mux_out   : out    vl_logic_vector(15 downto 0);
        alumux_out      : out    vl_logic_vector(15 downto 0);
        destmux_out     : out    vl_logic_vector(15 downto 0)
    );
end execute_stage;
