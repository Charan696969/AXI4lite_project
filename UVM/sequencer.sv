//compoennt class - sequencer
class axi4lite_sequencer extends uvm_sequencer#(axi4lite_seq_item);
  //register to factory
  `uvm_component_utils(axi4lite_sequencer)

  //constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("SEQUENCER_CLASS","Constructor called!", UVM_MEDIUM)
  endfunction
endclass
