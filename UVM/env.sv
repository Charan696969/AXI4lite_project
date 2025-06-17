class axi4lite_env extends uvm_env;
  `uvm_component_utils(axi4lite_env)
  
  axi4lite_agent agnt;
  
  function new(string name = "axi4lite_env", uvm_component parent);
    super.new(name, parent);
    `uvm_info("ENV_CLASS","Inside axi4lite_env constructor!", UVM_HIGH)
  endfunction: new
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("ENV_CLASS","Inside axi4lite_env build_phase!", UVM_HIGH)
    
    agnt = axi4lite_agent::type_id::create("agnt", this);
    
  endfunction: build_phase
  
  function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
    `uvm_info("ENV_CLASS","Inside axi4lite_env connect_phase!", UVM_HIGH)
  endfunction: connect_phase
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    
    //Fill with logic later
    
  endtask: run_phase
  
endclass: axi4lite_env
