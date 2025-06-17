class axi4lite_monitor extends uvm_monitor;
  `uvm_component_utils(axi4lite_monitor)
  
  virtual axi4lite_interface vif;
  
  function new(string name = "axi4lite_monitor", uvm_component parent);
    super.new(name, parent);
    `uvm_info("MONITOR_CLASS","Inside axi4lite_monitor constructor!", UVM_HIGH)
  endfunction: new
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("MONITOR_CLASS","Inside axi4lite_monitor build_phase!", UVM_HIGH)
    if(!(uvm_config_db #(virtual axi4lite_interface)::get(this, "*", "vif", vif))) begin
      `uvm_error("MONITOR_CLASS","Failed to get vif from config_db!");
    end
  endfunction: build_phase
  
  function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
    `uvm_info("TEST_MONITOR","Inside axi4lite_monitor connect_phase!", UVM_HIGH)
  endfunction: connect_phase
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    
    //Fill with logic later
    
  endtask: run_phase
  
endclass: axi4lite_monitor
