`include "apb_defines.sv"

class apb_slv_trans extends uvm_sequence_item;

  bit [`DATA_WIDTH - 1 : 0]  prdata; //-|read data
  bit                       pslverr; //-|error signal
  bit                        pready; //-|slave use this signal to extends the transfer
  bit [`ADDR_WIDTH - 1 : 0]   paddr; //-|address
  bit [`DATA_WIDTH - 1 : 0]  pwdata; //-|write data
  bit                         pselx; //-|slave select
  bit                        pwrite; //-|1 - write || 0 - read
  bit                       penable; //-|enable the transfer

  rand bit [`WAIT_READY - 1 : 0] no_of_cycle; //-|after how much cycle pready should drive

  //bit [`DATA_WIDTH - 1 : 0] mem [`DEPTH];

  `uvm_object_utils_begin(apb_slv_trans)
    `uvm_field_int(penable,UVM_ALL_ON)
    `uvm_field_int(pselx  ,UVM_ALL_ON)
    `uvm_field_int(pready ,UVM_ALL_ON)
    `uvm_field_int(pwrite ,UVM_ALL_ON)
    `uvm_field_int(paddr  ,UVM_ALL_ON)
    `uvm_field_int(pwdata ,UVM_ALL_ON)
    `uvm_field_int(prdata ,UVM_ALL_ON)
    `uvm_field_int(pslverr,UVM_ALL_ON)
    `uvm_field_int(no_of_cycle,UVM_ALL_ON)
  `uvm_object_utils_end

  function new(string name = "apb_slv_trans");
    super.new(name);
  endfunction

  constraint waiting {soft no_of_cycle == 0 ;}

endclass
