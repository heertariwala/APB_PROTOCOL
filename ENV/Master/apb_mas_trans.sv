//transaction class declaration

`ifndef APB_TRANS
`define APB_TRANS
class apb_mas_trans extends uvm_sequence_item;

	//signal declaration
  randc bit [`ADDR_WIDTH-1:0]   paddr;
  rand bit     		        pwrite;
  bit [`DATA_WIDTH-1:0]         prdata;
  rand bit [`DATA_WIDTH-1:0]    pwdata;
  bit            		pslverr;
  rand bit [5:0]                delay;   //this is added in order to rectify the idle going to access directly when delays are added in between transaction ; when delays are added between transactions

   
  //factory registration  
   `uvm_object_utils_begin(apb_mas_trans)
     `uvm_field_int(paddr, UVM_ALL_ON | UVM_HEX)
     `uvm_field_int(pwrite, UVM_ALL_ON)
     `uvm_field_int(prdata, UVM_ALL_ON | UVM_HEX)
     `uvm_field_int(pwdata, UVM_ALL_ON | UVM_HEX)
     `uvm_field_int(delay, UVM_ALL_ON)
   `uvm_object_utils_end

	//new method	
  function new (string name = "apb_mas_trans");
    super.new(name);
  endfunction

  //declaring constraint for address offset
  constraint addr_offset { soft paddr[1:0] == 0; paddr < 20;}
  constraint delay_zero {soft delay == 0;}
  constraint delay_add {delay%10==0;}
endclass

`endif
