class apb_slv_mon extends uvm_monitor;

  apb_mas_trans trans_h;

  virtual apb_inf mon_vif;

  bit penable,pselx,pready;

  uvm_analysis_port #(apb_mas_trans) an_slv_port;

  `uvm_component_utils(apb_slv_mon)

  function new(string name = "apb_slv_mon",uvm_component parent = null);
    super.new(name,parent);
    an_slv_port = new("an_slv_port",this);
  endfunction

  function void build_phase(uvm_phase phase);
    trans_h = apb_mas_trans::type_id::create("trans_h");
  endfunction

  task run_phase(uvm_phase phase);
    wait(!mon_vif.prstn);
    wait(mon_vif.prstn);
    forever begin
      fork
        begin
          wait(!mon_vif.prstn);
        end
        forever @(mon_vif.slv_mon_cb) begin
	  if(mon_vif.slv_mon_cb.pselx)
	  begin
              //  `uvm_info(get_name(),"----------------------AFTER PSELX --------------------",UVM_MEDIUM);
               dut_to_mon(trans_h);
               an_slv_port.write(trans_h);
          end
        end
      join_any
      disable fork;
      wait(mon_vif.prstn);
    end
  endtask

  task dut_to_mon(apb_mas_trans trans_h);
    //`uvm_info(get_name(),"-------------------apb_slv_mon--------------",UVM_MEDIUM);
    penable = mon_vif.penable;
    pselx    = mon_vif.pselx;
    pready  = mon_vif.pready;
    trans_h.pwrite  = mon_vif.pwrite;
    trans_h.paddr   = mon_vif.paddr;
    trans_h.pwdata  = mon_vif.pwdata;
    trans_h.prdata  = mon_vif.prdata;
    trans_h.pslverr = mon_vif.pslverr;
    trans_h.prdata  = mon_vif.prdata;
    //trans_h.print();
  endtask

endclass
