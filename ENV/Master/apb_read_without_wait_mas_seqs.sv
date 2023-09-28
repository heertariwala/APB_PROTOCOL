//write with wait state sequence class

`ifndef READ_WITHOUT_WAIT_MAS
`define READ_WITHOUT_WAIT_MAS

class apb_read_without_wait_mas_seqs extends apb_mas_base_seqs;

	//factory registration
	`uvm_object_utils(apb_read_without_wait_mas_seqs)

	//new method
	function new(string name = "apb_read_without_wait_mas_seqs");
		super.new(name);
	endfunction

	//body task for randomization sequence
	task body();
		repeat(no_of_trans) begin
			trans_h = apb_mas_trans :: type_id :: create("trans_h");
			start_item(trans_h);

			if(!trans_h.randomize() with {pwrite==1;})
			  `uvm_error(get_full_name(), "data not randomize");
			finish_item(trans_h);
                end

                repeat(no_of_trans) begin
			trans_h = apb_mas_trans :: type_id :: create("trans_h");
			start_item(trans_h);

			if(!trans_h.randomize() with {pwrite==0;delay == 0;})
			  `uvm_error(get_full_name(), "data not randomize");
			finish_item(trans_h);
                        #trans_h.delay;
                end

        endtask

endclass

`endif
