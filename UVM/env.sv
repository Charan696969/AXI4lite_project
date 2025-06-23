//component class - env
class axi4lite_env extends uvm_env;
  //register to factory
  `uvm_component_utils(axi4lite_env)
  //instantaitions
  axi4lite_agent agent;
  axi4lite_scoreboard sb;

  //constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("ENV_CLASS","Constructor called!", UVM_MEDIUM)
  endfunction

  //build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent = axi4lite_agent::type_id::create("agent", this);
    sb = axi4lite_scoreboard::type_id::create("sb", this);
    `uvm_info("ENV_CLASS","Build Phase called!", UVM_MEDIUM)
  endfunction

  //connect phase
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agent.mon.item_collected_port.connect(sb.item_collected_export);
    `uvm_info("ENV_CLASS","Connect Phase called!",UVM_MEDIUM);
  endfunction
endclass
