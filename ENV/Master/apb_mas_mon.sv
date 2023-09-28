//declaratin of monitor class

class apb_mas_mon extends uvm_monitor;

  //factory registration
  `uvm_component_utils(apb_mas_mon);
  
  //signal description which are needed to be monitored
  bit psel,penb;
  bit pready;	
  
  
  //virtual interface declaration
  virtual apb_inf vif;
  
  //class handle declaratin
  apb_mas_trans trans_h;
  
  //analysis port declaration
  uvm_analysis_port #(apb_mas_trans) an_mas_port;
  
  //new method
  function new(string name = "apb_mas_mon",uvm_component parent);
    super.new(name,parent);
    an_mas_port = new("an_mas_port",this);
  endfunction
  
  //build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    //getting virtual interface through config db
    if(!(uvm_config_db #(virtual apb_inf)::get(this,"","vif",vif)))
    	`uvm_fatal(get_name(),"FAILED TO GET VIRTUAL INTERFACE");
  endfunction
  
  //run phase 
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    
    forever @(vif.mas_mon_cb) begin
    trans_h = new();
      if(vif.mas_mon_cb.pselx || vif.mas_mon_cb.penable || vif.mas_mon_cb.pready) begin
        monitor();
      end
            
      if(vif.mas_mon_cb.pselx && vif.mas_mon_cb.penable && vif.mas_mon_cb.pready) begin
        an_mas_port.write(trans_h);      
      end
    end
  
  endtask
  
  //monitor task declaration
  task monitor();
  
    if(vif.pready)
    begin
    	trans_h.paddr = vif.mas_mon_cb.paddr;
    	trans_h.pwdata = vif.mas_mon_cb.pwdata;
    	psel = vif.mas_mon_cb.pselx;
    	penb = vif.mas_mon_cb.penable;
    	trans_h.prdata = vif.mas_mon_cb.prdata;
    	trans_h.pslverr = vif.mas_mon_cb.pslverr;
    	pready = vif.mas_mon_cb.pready;
    	trans_h.pwrite = vif.mas_mon_cb.pwrite;
    end
    `uvm_info(get_name(),$sformatf("psel = %p, penb = %p, pwrite = %p, pwdata = %h, paddr = %h, pready = %p, prdata = %h", psel,penb,trans_h.pwrite,trans_h.pwdata,trans_h.paddr,pready,trans_h.prdata),UVM_MEDIUM)
  
endtask

endclass
