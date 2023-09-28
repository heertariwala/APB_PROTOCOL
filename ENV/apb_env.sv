//declaration of ENV class


class apb_env extends uvm_env;

	//factory registration
	`uvm_component_utils(apb_env)

	//class handle declaration
	apb_sb sb_h;
	apb_mas_agent mas_agent_h;
	apb_slv_agent slv_agent_h;

	//function new
	function new(string name = "apb_env",uvm_component parent);
		super.new(name,parent);
	endfunction

	//build phase
	function void build_phase(uvm_phase phase);
		mas_agent_h = apb_mas_agent :: type_id :: create("mas_agent_h",this);
		slv_agent_h = apb_slv_agent :: type_id :: create("slv_agent_h",this);
		sb_h = apb_sb :: type_id :: create("sb_h",this);
	endfunction

	//connect phase
	function void connect_phase(uvm_phase phase);
		mas_agent_h.mon_h.an_mas_port.connect(sb_h.an_imp_mas);
		slv_agent_h.mon_h.an_slv_port.connect(sb_h.an_imp_mas);
	endfunction

endclass
