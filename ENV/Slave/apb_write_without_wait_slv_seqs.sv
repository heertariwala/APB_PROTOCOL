


//write with wait state sequence class

`ifndef WRITE_WITHOUT_SLV_WAIT
`define WRITE_WITHOUT_SLV_WAIT

class apb_write_without_wait_slv_seqs extends apb_slv_base_seqs;

	//factory registration
	`uvm_object_utils(apb_write_without_wait_slv_seqs)
			
	//trans_h = apb_slv_trans::type_id::create("trans_h");

	//new method
	function new(string name = "apb_write_without_wait_slv_seqs");
		super.new(name);
	endfunction

	//body task for randomization sequence
	/*
        task body();
        $display("[WRITE WITHOUT WAIT]");
		forever begin
		  `uvm_send(trans_h)
		end
	endtask
                */
  /*
	virtual task body();
  
	  forever begin
	    p_sequencer.trans_h_fifo.get(trans_h);
		//`uvm_info("[SEQUENCE]","before psel",UVM_MEDIUM); 
      if(trans_h.pselx)
		begin
			//`uvm_info("[SEQUENCE]","after psel",UVM_MEDIUM); 
   	   trans_h.pready = 1;
   	   trans_h.pslverr = 0;
   	   trans_h.randomize();
			
			if(trans_h.paddr[1:0] == 0)
			begin
   	  		 case(trans_h.pwrite)
		  		 	1'b1: begin
		  		 		      mem[trans_h.paddr[`ADDR_WIDTH-1 : 2]] = trans_h.pwdata;
		  		 		      $display("data added to memory ");
		  		 	      end
		  		   1'b0: begin
		  		 	  		if(mem.exists(trans_h.paddr))
		  		 			begin
		  		           	trans_h.prdata = mem[trans_h.paddr[`ADDR_WIDTH-1 : 2]];
		  		 			end
		  		 			else
		  		 				trans_h.prdata = 0;
		  		         end
		  		  endcase
			end

			else
				trans_h.pslverr = 1;
			//`uvm_create(trans_h);
			`uvm_send(trans_h);
	  	end
		end
	endtask
	*/
endclass

`endif
