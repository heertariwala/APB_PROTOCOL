
//write with wait state sequence class

`ifndef DEDICATED_WITHOUT_WAIT
`define DEDICATED_WITHOUT_WAIT

class apb_mas_dedicated_without_wait_seqs extends apb_mas_base_seqs;

	//factory registration
	`uvm_object_utils(apb_mas_dedicated_without_wait_seqs)

	//new method
	function new(string name = "apb_mas_dedicated_without_wait_seqs");
		super.new(name);
	endfunction

	//body task for randomization sequence
	task body();
		`uvm_info(get_name(),"[WRITE WITHOUT WAIT]",UVM_DEBUG);
		repeat(5) begin
			trans_h = apb_mas_trans :: type_id :: create("trans_h");
			start_item(trans_h);
                        
                        //dedicated 5 cycles write 
			if(!trans_h.randomize() with {pwrite==1;})
			  `uvm_error(get_full_name(), "data not randomize");
			finish_item(trans_h);
                end
               
                repeat(5) begin
			trans_h = apb_mas_trans :: type_id :: create("trans_h");
			start_item(trans_h);

                        //dedicated 5 cycles read 
			if(!trans_h.randomize() with {pwrite==0;})
			  `uvm_error(get_full_name(), "data not randomize");
			finish_item(trans_h);
	        end
               
	endtask

endclass

`endif
