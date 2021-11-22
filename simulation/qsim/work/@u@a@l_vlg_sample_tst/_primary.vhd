library verilog;
use verilog.vl_types.all;
entity UAL_vlg_sample_tst is
    port(
        A               : in     vl_logic_vector(15 downto 0);
        B               : in     vl_logic_vector(15 downto 0);
        controle        : in     vl_logic_vector(2 downto 0);
        sampler_tx      : out    vl_logic
    );
end UAL_vlg_sample_tst;
