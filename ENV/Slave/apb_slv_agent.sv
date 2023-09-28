class apb_slv_agent extends uvm_agent;

  //factory registration
  `uvm_component_utils(apb_slv_agent)

  //new method
  function new(string name = "apb_slv_agent",uvm_component parent);
    super.new(name,parent);
  endfunction

  //virtual interface declaration
  virtual apb_inf vif;

  //handles declaration
  apb_slv_drv drv_h;
  apb_slv_mon mon_h;
  apb_slv_seqr seqr_h;

  //build phase
  function void build_phase(uvm_phase phase);
    drv_h = apb_slv_drv   :: type_id :: create("drv_h",this);
    mon_h = apb_slv_mon   :: type_id :: create("mon_h",this);
    seqr_h = apb_slv_seqr :: type_id :: create("seqr_h",this);

    //getting virtual interface from config DB
    if(!(uvm_config_db #(virtual apb_inf)::get(this,"","vif",vif)))
      `uvm_fatal("[AGENT]","failed to get virtual interface")
  endfunction

  //connect phase declaration
  function void connect_phase(uvm_phase phase);
    drv_h.seq_item_port.connect(seqr_h.seq_item_export);
    mon_h.an_slv_port.connect(seqr_h.item_export);

    drv_h.drv_vif = vif;
    mon_h.mon_vif = vif;
  endfunction
  
endclass
