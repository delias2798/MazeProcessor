library verilog;
use verilog.vl_types.all;
library work;
entity ir is
    port(
        \in\            : in     vl_logic_vector(15 downto 0);
        opcode          : out    work.lc3b_types.lc3b_opcode;
        dest            : out    vl_logic_vector(2 downto 0);
        src1            : out    vl_logic_vector(2 downto 0);
        src2            : out    vl_logic_vector(2 downto 0);
        offset4         : out    vl_logic_vector(3 downto 0);
        offset5         : out    vl_logic_vector(4 downto 0);
        offset6         : out    vl_logic_vector(5 downto 0);
        offset8         : out    vl_logic_vector(7 downto 0);
        offset9         : out    vl_logic_vector(8 downto 0);
        offset11        : out    vl_logic_vector(10 downto 0)
    );
end ir;
