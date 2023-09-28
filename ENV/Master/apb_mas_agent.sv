//declaration of agent class


class apb_mas_agent extends uvm_agent;

  //factory registration
  `uvm_component_utils(apb_mas_agent)
  
  //new method
  function new(string name = "apb_mas_agent",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  //virtual interface declaration
  virtual apb_inf vif;
  
  //class handle declaration
  apb_mas_drv  drv_h;
  apb_mas_mon  mon_h;
  apb_mas_seqr seqr_h;
  
  //build phase declaration
  function void build_phase(uvm_phase phase);
  	super.build_phase(phase);
  
  	//creating handles
  	drv_h  = apb_mas_drv  :: type_id :: create("drv_h" ,this);
  	mon_h  = apb_mas_mon  :: type_id :: create("mon_h" ,this);
  	seqr_h = apb_mas_seqr :: type_id :: create("seqr_h",this);
  
  	//getting virtual interface through config db
  	if(!(uvm_config_db #(virtual apb_inf)::get(this,"","vif",vif)))
  		`uvm_fatal("[AGENT]","FAILED TO GET VIRTUAL INTERFACE");
  
  endfunction
  
  //connect phase declaration
  function void connect_phase(uvm_phase phase);
  	super.connect_phase(phase);
  
  	//building connection
  	drv_h.seq_item_port.connect(seqr_h.seq_item_export);
  	
  	//virtual interface handle assignment
  	drv_h.vif = vif;
  	mon_h.vif = vif;
  
  endfunction

endclass
