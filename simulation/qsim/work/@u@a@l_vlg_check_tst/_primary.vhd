library verilog;
use verilog.vl_types.all;
entity UAL_vlg_check_tst is
    port(
        cout_teste      : in     vl_logic;
        D               : in     vl_logic_vector(15 downto 0);
        ov_teste        : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end UAL_vlg_check_tst;
