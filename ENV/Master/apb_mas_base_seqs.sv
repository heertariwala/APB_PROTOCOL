
//declaration of base seqsuence class


class apb_mas_base_seqs extends uvm_sequence #(apb_mas_trans);
  
  rand bit [31:0] no_of_trans;

  constraint value{soft no_of_trans == 10 ;}

	//factory registration
  `uvm_object_utils(apb_mas_base_seqs)

  //Tackinh the instance of the Write transection class.
  apb_mas_trans trans_h;  

  //new constructor.
  function new (string name = "apb_mas_base_seqs");
    super.new(name);
  endfunction
 
  // Creating the body task to make the seqsuence.
  virtual task body();
    forever begin
    `uvm_do(trans_h);
    end
 endtask  : body

endclass  : apb_mas_base_seqs

