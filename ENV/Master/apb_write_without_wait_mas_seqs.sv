
//write with wait state sequence class

`ifndef WRITE_WITHOUT_WAIT
`define WRITE_WITHOUT_WAIT

class apb_write_without_wait_mas_seqs extends apb_mas_base_seqs;

	//factory registration
	`uvm_object_utils(apb_write_without_wait_mas_seqs)

	//new method
	function new(string name = "apb_write_without_wait_mas_seqs");
		super.new(name);
	endfunction

	//body task for randomization sequence
	task body();
		//`uvm_info(get_name(),"[WRITE WITHOUT WAIT]",UVM_DEBUG);
		repeat(no_of_trans) begin
			trans_h = apb_mas_trans :: type_id :: create("trans_h");
			start_item(trans_h);

			if(!trans_h.randomize() with {pwrite==1;delay==20;})
			  `uvm_error("[WRITE WITHOUT WAIT]", "data not randomize");
			finish_item(trans_h);
                end
        endtask

endclass

`endif
