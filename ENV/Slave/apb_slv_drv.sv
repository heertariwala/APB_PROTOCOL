class apb_slv_drv extends uvm_driver #(apb_mas_trans);

  rand bit [`WAIT_READY - 1 : 0] no_of_cycle; //-|after how much cycle pready should drive

  `uvm_component_utils_begin(apb_slv_drv)
     `uvm_field_int(no_of_cycle, UVM_ALL_ON | UVM_HEX)
   `uvm_component_utils_end

  virtual apb_inf drv_vif;

  bit pready;

  function new(string name = "apb_slv_drv",uvm_component parent = null);
    super.new(name,parent);
  endfunction

  task run_phase(uvm_phase phase);
    wait(!drv_vif.prstn);
    forever begin
      fork
        begin
          wait(!drv_vif.prstn);
        end

        forever @(drv_vif.slv_drv_cb) begin
          std::randomize(no_of_cycle) with {no_of_cycle == 5;};
	  if(drv_vif.pselx) begin
            if(no_of_cycle > 0 ) begin
	      repeat(no_of_cycle) begin
	        @(drv_vif.slv_drv_cb);
                $display("no_of_cycles %D",$time,no_of_cycle);
              end
	    end
                $display("no_of_cycles out of loop %D",$time,no_of_cycle);
          drv_vif.slv_drv_cb.pready  <= 1;
                $display("pready 1",$time);
          //end
          //if(drv_vif.pselx) begin
            seq_item_port.get_next_item(req);
            
            /*
            if(req.no_of_cycle > 0 ) 
            begin
              repeat(req.no_of_cycle)
              @(drv_vif.slv_drv_cb);
            end
            */
            
            drv_to_inf(req);
              @(drv_vif.slv_drv_cb);
              drv_vif.slv_drv_cb.pready <= 0;
            seq_item_port.item_done();
	  end
        end
      join_any
      disable fork;
      wait(drv_vif.prstn);
    end
    
  endtask

  task drv_to_inf(apb_mas_trans req);
    //repeat(req.no_of_cycle)
      //@(drv_vif.slv_drv_cb)
    //drv_vif.slv_drv_cb.pready  <= 1; //In order to get Pready before monitor get the data 
    //from interface Pready must be driver before starting the transaction

    drv_vif.pslverr <= req.pslverr;
    if(req.pwrite == 0)
      drv_vif.prdata <= req.prdata;
    fork 
      begin
        @(drv_vif.slv_drv_cb);
        drv_vif.pslverr <= 0;
      end
    join_none
    //req.print();
  endtask

endclass
