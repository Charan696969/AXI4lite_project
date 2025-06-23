//component class - agent
class axi4lite_agent extends uvm_agent;
  //register to factory
  `uvm_component_utils(axi4lite_agent)
  
  //instantiations
  axi4lite_driver drv;
  axi4lite_monitor mon;
  axi4lite_sequencer seqr;

  //constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("AGENT_CLASS","Constructor called!", UVM_MEDIUM)
  endfunction

  //build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    drv  = axi4lite_driver::type_id::create("drv", this);
    mon  = axi4lite_monitor::type_id::create("mon", this);
    seqr = axi4lite_sequencer::type_id::create("seqr", this);
    `uvm_info("AGENT_CLASS","Build Phase called!", UVM_MEDIUM)
  endfunction

  //connect phase
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    drv.seq_item_port.connect(seqr.seq_item_export);
    `uvm_info("AGENT_CLASS","Connect Phase called!", UVM_MEDIUM)
  endfunction
endclass
