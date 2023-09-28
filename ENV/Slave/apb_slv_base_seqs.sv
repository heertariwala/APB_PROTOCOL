class apb_slv_base_seqs extends uvm_sequence #(apb_mas_trans);

  apb_mas_trans trans_h;

  bit [`DATA_WIDTH - 1 : 0] mem [int];


  `uvm_object_utils_begin(apb_slv_base_seqs)
    `uvm_field_aa_int_int(mem,UVM_ALL_ON)
  `uvm_object_utils_end

  //apb_slv_seqr p_sequencer;
  `uvm_declare_p_sequencer(apb_slv_seqr);

  function new(string name = "apb_slv_seqs");
    super.new(name);
  endfunction

  virtual task body();
  /*
    if (!$cast(p_sequencer,m_sequencer))
	     `uvm_fatal(get_full_name(),"sequencer up-casting failed")
*/
                $display("----------------------SLV SQS--------------------");
	  forever begin
             //`uvm_info(get_name(),"BEFORE GET IN TRANS_H",UVM_MEDIUM)
             //trans_h.print();
	     p_sequencer.item_collected_fifo.get(trans_h);
	     start_item(trans_h);

                `uvm_info(get_name(),"before psel",UVM_MEDIUM); 
/*      
		if(trans_h.pselx)
		begin
			//`uvm_info("[SEQUENCE]","after psel",UVM_MEDIUM); 
   	   trans_h.pready = 1;
   	   trans_h.pslverr = 0;
*/
   	   //inline constraint to check with wait and without wait
			if(trans_h.paddr[1:0] == 0)
			begin
   	  		 case(trans_h.pwrite)
		  		 	1'b1: begin
		  		 		      mem[trans_h.paddr[`ADDR_WIDTH-1 : 2]] = trans_h.pwdata;
		  		 		      //$display("data added to memory ");
								`uvm_info(get_name(),"**********************added to memory",UVM_MEDIUM)
								foreach(mem[i])
									`uvm_info(get_name(),$sformatf("[%0d]=%h",i,mem[i]),UVM_MEDIUM)
		  		 	      end
		  		        
                                        1'b0: begin
								`uvm_info(get_name(),"******************************* READ ENTERED",UVM_MEDIUM)
		  		 	  		if(mem.exists(trans_h.paddr[`ADDR_WIDTH-1 : 2]))
		  		 			begin
							//	`uvm_info(get_name(),"******************************* PRDATA GETS VALUE",UVM_MEDIUM)
	                	  		           	trans_h.prdata = mem[trans_h.paddr[`ADDR_WIDTH-1 : 2]];
							//	`uvm_info(get_name(),$sformatf("[%0h]",trans_h.paddr),UVM_MEDIUM)
		  		 			end
		  		 			else begin
							//	`uvm_info(get_name()," ******************************* PRDATA GET 0 ",UVM_MEDIUM)
		  		 			// mem[trans_h.paddr[`ADDR_WIDTH-1 : 2]] = 0;
                                                                 trans_h.prdata = 0;
                                                        end
		  		         end
		  		  endcase
			end

			else begin
				trans_h.pslverr = 1;
                                //@()trans_h.pslverr = 0;
                        end
			finish_item(trans_h);
	  	end
	//end
	endtask

endclass
