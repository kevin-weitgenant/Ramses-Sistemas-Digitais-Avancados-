library verilog;
use verilog.vl_types.all;
entity UAL is
    port(
        controle        : in     vl_logic_vector(2 downto 0);
        A               : in     vl_logic_vector(15 downto 0);
        B               : in     vl_logic_vector(15 downto 0);
        cout_teste      : out    vl_logic;
        ov_teste        : out    vl_logic;
        D               : out    vl_logic_vector(15 downto 0)
    );
end UAL;
