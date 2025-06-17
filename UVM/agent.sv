class axi4lite_agent extends uvm_agent;
  `uvm_component_utils(axi4lite_agent)
  
  axi4lite_driver drv;
  axi4lite_monitor mon;
  axi4lite_sequencer seqr;
  
  function new(string name = "axi4lite_agent", uvm_component parent);
    super.new(name, parent);
    `uvm_info("AGENT_CLASS","Inside axi4lite_agent constructor!", UVM_HIGH)
  endfunction: new
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("AGENT_CLASS","Inside axi4lite_agent build_phase!", UVM_HIGH)
  endfunction: build_phase
  
  function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
    `uvm_info("AGENT_CLASS","Inside axi4lite_agent connect_phase!", UVM_HIGH)
  endfunction: connect_phase 
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    
    //Fill with logic later
    
  endtask: run_phase
  
endclass: axi4lite_agent
