library verilog;
use verilog.vl_types.all;
library work;
entity decode_stage is
    port(
        clk             : in     vl_logic;
        instruction     : in     vl_logic_vector(15 downto 0);
        write_register  : in     vl_logic_vector(2 downto 0);
        write_data      : in     vl_logic_vector(15 downto 0);
        load_regfile    : in     vl_logic;
        offset8         : out    vl_logic_vector(7 downto 0);
        offset9         : out    vl_logic_vector(8 downto 0);
        offset11        : out    vl_logic_vector(10 downto 0);
        ctrl            : out    work.lc3b_types.lc3b_control_word;
        sr1_out         : out    vl_logic_vector(15 downto 0);
        sr2mux2_out     : out    vl_logic_vector(15 downto 0);
        dest_out        : out    vl_logic_vector(15 downto 0);
        dest_register   : out    vl_logic_vector(2 downto 0)
    );
end decode_stage;
