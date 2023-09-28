
//write with wait state sequence class

`ifndef B2B
`define B2B

class apb_b2b_mas_seqs extends apb_mas_base_seqs;

  //factory registration
  `uvm_object_utils(apb_b2b_mas_seqs)
  
  //new method
  function new(string name = "apb_b2b_mas_seqs");
  	super.new(name);
  endfunction
  
  //body task for randomization sequence
  task body();
    //`uvm_info(get_name(),"[WRITE WITHOUT WAIT]",UVM_DEBUG);
    repeat(no_of_trans) begin
      
      //write transfer
      trans_h = apb_mas_trans :: type_id :: create("trans_h");
      start_item(trans_h);
      if(!trans_h.randomize() with {pwrite==1;})
        `uvm_error(get_full_name(), "data not randomize");
      finish_item(trans_h);
      

      //read transfer
      trans_h = apb_mas_trans :: type_id :: create("trans_h");
      start_item(trans_h);
      if(!trans_h.randomize() with {pwrite==0; delay == 20;})
        `uvm_error(get_full_name(), "data not randomize");
      finish_item(trans_h);
      
      #trans_h.delay;
    end
  endtask

endclass

`endif
