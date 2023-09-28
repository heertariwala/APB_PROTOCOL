//declaration of sequencer class

class apb_mas_seqr extends uvm_sequencer #(apb_mas_trans);

	//factory registration
	`uvm_component_utils(apb_mas_seqr)

	//new method
	function new(string name = "apb_mas_seqr",uvm_component parent);
		super.new(name,parent);
	endfunction

endclass
