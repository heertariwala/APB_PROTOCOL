class apb_slv_seqr extends uvm_sequencer #(apb_mas_trans);

  `uvm_component_utils(apb_slv_seqr)

  uvm_analysis_export #(apb_mas_trans) item_export;
  uvm_tlm_analysis_fifo #(apb_mas_trans) item_collected_fifo;

  function new(string name = "apb_slv_seqr",uvm_component parent = null);
    super.new(name,parent);
    item_export = new("item_export",this);
    item_collected_fifo = new("item_collected_fifo",this);
  endfunction

  function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
	    item_export.connect(item_collected_fifo.analysis_export);
	endfunction

  task run_phase(uvm_phase phase);
                $display("----------------------SLV SQR--------------------");
  endtask
endclass
