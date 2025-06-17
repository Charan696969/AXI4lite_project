class axi4lite_sequencer extends uvm_sequencer#(axi4lite_sequence_item);
  `uvm_component_utils(axi4lite_sequencer)
  
  
  function new(string name = "axi4lite_sequencer", uvm_component parent);
    super.new(name, parent);
    `uvm_info("SEQUENCER_CLASS","Inside axi4lite_sequencer constructor!", UVM_HIGH)
  endfunction: new
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("SEQUENCER_CLASS","Inside axi4lite_sequencer build_phase!", UVM_HIGH)
  endfunction: build_phase
  
  function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
    `uvm_info("SEQUENCER_CLASS","Inside axi4lite_sequencer connect_phase!", UVM_HIGH)
  endfunction: connect_phase
  
endclass: axi4lite_sequencer
