//declaration of scoreboard class

`uvm_analysis_imp_decl(_mas);
`uvm_analysis_imp_decl(_slv);
`ifndef APB_SCOREBOARD
`define APB_SCOREBOARD

class apb_sb extends uvm_scoreboard;

  //factory registration
  `uvm_component_utils(apb_sb);
  
  //class handle declaration
  apb_mas_trans exp_trans_h, act_trans_h;
  apb_mas_trans exp_data[$],act_data[$];

  //reference memory
  bit [`DATA_WIDTH-1 : 0] ref_mem[int];
  
  //imp port declaration
  uvm_analysis_imp_mas #(apb_mas_trans,apb_sb) an_imp_mas;
  uvm_analysis_imp_slv #(apb_mas_trans,apb_sb) an_imp_slv;
  
  //new method
  function new(string name = "apb_sb",uvm_component parent);
    super.new(name,parent);
    an_imp_mas = new("an_imp_mas",this);
    an_imp_slv = new("an_imp_slv",this);
  endfunction
   
  //write method - called from master 
  function void write_mas(apb_mas_trans exp_trans_h);
    `uvm_info(get_type_name(),"EXP DATA - WRITE MAS",UVM_MEDIUM) 
    exp_trans_h.print();
    exp_data.push_back(exp_trans_h);
  endfunction
  
  //write method - called from slave 
  function void write_slv(apb_mas_trans slv_trans_h);
    `uvm_info(get_type_name(),"ACT DATA - WRITE SLV",UVM_MEDIUM) 
    slv_trans_h.print();
    act_data.push_back(slv_trans_h);
  endfunction
  
  //run phase
  task run_phase(uvm_phase phase);
    apb_mas_trans act_mem, exp_mem;

    forever begin
      wait(act_data.size()>0);
      act_mem = act_data.pop_front();
      exp_mem = exp_data.pop_front();

      if(exp_mem.pwrite) begin
        ref_mem[exp_trans_h.paddr] = exp_trans_h.pwdata;
        `uvm_info(get_type_name(),$sformatf("------ :: WRITE DATA :: ------"),UVM_MEDIUM)
        `uvm_info(get_type_name(),$sformatf("Addr: %0d",exp_mem.paddr),UVM_MEDIUM)
        `uvm_info(get_type_name(),$sformatf("Data: %0d",exp_mem.pwdata),UVM_MEDIUM)
        `uvm_info(get_type_name(),"------------------------------------",UVM_MEDIUM)   
      end
      
      else if(!act_mem.pwrite) begin
        if(ref_mem[act_mem.paddr] == act_mem.prdata) begin
          `uvm_info(get_type_name(),$sformatf("------ :: READ DATA MATCH:: ------"),UVM_MEDIUM)
          `uvm_info(get_type_name(),$sformatf("Addr: %0d",act_mem.paddr),UVM_MEDIUM)
          `uvm_info(get_type_name(),$sformatf("Expected Data: %0d Actual Data: %0h",ref_mem[act_mem.paddr],act_mem.prdata), UVM_MEDIUM)
          `uvm_info(get_type_name(),"------------------------------------",UVM_MEDIUM) 
        end
      end

    end
  endtask
  
endclass

`endif
