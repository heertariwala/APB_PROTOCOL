//declaration of driver class

class apb_mas_drv extends uvm_driver #(apb_mas_trans);

	//factory registration
  `uvm_component_utils(apb_mas_drv);
  
  //virtual interface declaration
  virtual apb_inf vif;
  
  //new method
  function new(string name = "apb_mas_drv",uvm_component parent);
  	super.new(name,parent);
  endfunction
  
  //build phase declaration
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    //getting virtual interface through config db
    if(!(uvm_config_db #(virtual apb_inf)::get(this,"","vif",vif)))
      `uvm_fatal(get_name(),"FAILED TO GET VIRTUAL INTERFACE")
  endfunction
  
  //run phase declaration
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    wait(!vif.prstn);           //if we want to drive presetn according to clock then (vif.drv_vif.prstn) should be used and
                                //prstn should be inside clocking block (for getting posedge reset)
    drive_reset();
    wait(vif.prstn);
    forever@(vif.mas_drv_cb) begin
    //`uvm_info(get_name(),"[INSIDE DRIVER]",UVM_DEBUG);
      fork 
      	begin
      	  wait(!vif.prstn);
          drive_reset();
      	end
      
        forever	begin
          vif.pselx <=0;
      	  seq_item_port.get_next_item(req);
          //vif.mas_drv_cb.pselx <=1;
          //$display()
          if(req.delay>0) begin
            `uvm_info(get_name(),"-----------------delay happening",UVM_MEDIUM)
            @(vif.mas_drv_cb);
          end
      	  send_to_dut(req);
          //vif.pselx<=0;    //getting glitch
          seq_item_port.item_done();
      	end
      join_any
      disable fork;
      wait(vif.prstn);
    end
  
  endtask
  
  //send to dut task
  task send_to_dut(apb_mas_trans trans_h);
         `uvm_info(get_name(),"MAS DRIVER",UVM_HIGH) 
  
    //wait(vif.pready);
    vif.mas_drv_cb.paddr <= trans_h.paddr;
    vif.mas_drv_cb.pwrite <= trans_h.pwrite;
    vif.mas_drv_cb.pwdata <= trans_h.pwdata;
    vif.mas_drv_cb.pselx <=1;
    
    //if(vif.mas_drv_cb.pselx) begin
    @(vif.mas_drv_cb);
    vif.mas_drv_cb.penable <= 1;
  
    begin
      while(!vif.pready) begin
        @(vif.mas_drv_cb);
      end
      vif.mas_drv_cb.penable <= 0;
    end
    
        trans_h.print();
  endtask

/*
  //reset task -> called in top
  task reset(int delay = 5);
    vif.prstn = 0;
    #delay;
    vif.prstn = 1;
  endtask
*/

  //drive reset task -> makes all signals 0
  task drive_reset();
    $display("--------------------------------------drive reset---------------------------------------");
    //@(vif.mas_drv_cb);
    vif.prstn <=0;
    vif.prdata <=0;
    vif.pslverr <=0;
    vif.pready <=0;
    vif.paddr <=0;
    vif.pwdata <=0;
    vif.pselx <=0;
    vif.pwrite <=0;
    vif.penable <=0;
    //wait(vif.prstn == 1);
  endtask

endclass
