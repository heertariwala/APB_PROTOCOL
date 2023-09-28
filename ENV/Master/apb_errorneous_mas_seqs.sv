//write with errorneous sequence class

`ifndef ERRORNEOUS
`define ERRORNEOUS

class apb_errorneous_mas_seqs extends apb_mas_base_seqs;

	//factory registration
	`uvm_object_utils(apb_errorneous_mas_seqs)

	//new method
	function new(string name = "apb_errorneous_mas_seqs");
		super.new(name);
	endfunction

	//body task for randomization sequence
        task body();
		`uvm_info(get_name(),"[ERRORNEOUS]",UVM_MEDIUM);
		repeat(no_of_trans) begin
			trans_h = apb_mas_trans :: type_id :: create("trans_h");
			start_item(trans_h);

			if(!trans_h.randomize()with {pwrite == 1;})
			  `uvm_error(get_full_name(), "data not randomize");
			finish_item(trans_h);
                end

                repeat(no_of_trans) begin
			trans_h = apb_mas_trans :: type_id :: create("trans_h");
			start_item(trans_h);

			if(!trans_h.randomize()with {paddr[0] == 1;})
			  `uvm_error(get_full_name(), "data not randomize");
			finish_item(trans_h);
                end
        
                repeat(no_of_trans) begin
			trans_h = apb_mas_trans :: type_id :: create("trans_h");
			start_item(trans_h);

			if(!trans_h.randomize()with {pwrite == 0;})
			  `uvm_error(get_full_name(), "data not randomize");
			finish_item(trans_h);
                end

        endtask

endclass

`endif
