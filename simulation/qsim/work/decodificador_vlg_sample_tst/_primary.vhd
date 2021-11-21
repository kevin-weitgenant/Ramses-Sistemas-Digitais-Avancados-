library verilog;
use verilog.vl_types.all;
entity decodificador_vlg_sample_tst is
    port(
        entrada         : in     vl_logic_vector(3 downto 0);
        sampler_tx      : out    vl_logic
    );
end decodificador_vlg_sample_tst;
