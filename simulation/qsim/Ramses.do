onerror {quit -f}
vlib work
vlog -work work Ramses.vo
vlog -work work Ramses.vt
vsim -novopt -c -t 1ps -L cycloneiv_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.decodificador_vlg_vec_tst
vcd file -direction Ramses.msim.vcd
vcd add -internal decodificador_vlg_vec_tst/*
vcd add -internal decodificador_vlg_vec_tst/i1/*
add wave /*
run -all
