library verilog;
use verilog.vl_types.all;
entity br_add is
    port(
        offset9         : in     vl_logic_vector(15 downto 0);
        pc              : in     vl_logic_vector(15 downto 0);
        \out\           : out    vl_logic_vector(15 downto 0)
    );
end br_add;
