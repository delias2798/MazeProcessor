library verilog;
use verilog.vl_types.all;
entity cc_comp is
    port(
        dest            : in     vl_logic_vector(2 downto 0);
        cc_out          : in     vl_logic_vector(2 downto 0);
        branch_enable   : out    vl_logic
    );
end cc_comp;
