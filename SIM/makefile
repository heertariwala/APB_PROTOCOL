comp :
	vlog ..\TEST\apb_pkg.sv ..\TOP\apb_top.sv +incdir+..\TOP +incdir+..\ENV +incdir+..\ENV\Master +incdir+..\ENV\Slave +incdir+..\TEST 
run :
	vsim -novopt apb_top -c -do "run -all; exit"
qrun :
	vsim -novopt apb_top 

regression:
	vlog ..\TEST\apb_pkg.sv ..\TOP\apb_top.sv +incdir+..\TOP +incdir+..\ENV +incdir+..\ENV\Master +incdir+..\ENV\Slave +incdir+..\TEST 
	vsim -novopt apb_top +UVM_TESTNAME=apb_write_with_wait_test
	vsim -novopt apb_top +UVM_TESTNAME=apb_write_without_wait_test
	vsim -novopt apb_top +UVM_TESTNAME=apb_read_with_wait_test
	vsim -novopt apb_top +UVM_TESTNAME=apb_read_without_wait_test
	vsim -novopt apb_top +UVM_TESTNAME=apb_b2b_test
	vsim -novopt apb_top +UVM_TESTNAME=apb_errorneous_test
