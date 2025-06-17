class axi4lite_driver extends uvm_driver#(axi4lite_sequence_item);
  `uvm_component_utils(axi4lite_driver)
  
  virtual axi4lite_interface vif;
  
  function new(string name = "axi4lite_driver", uvm_component parent);
    super.new(name, parent);
    `uvm_info("DRIVER_CLASS","Inside axi4lite_driver constructor!", UVM_HIGH)
  endfunction: new
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("DRIVER_CLASS","Inside axi4lite_driver build_phase!", UVM_HIGH)
    if(!(uvm_config_db #(virtual axi4lite_interface)::get(this, "*", "vif", vif))) begin
      `uvm_error("DRIVER_CLASS","Failed to get vif from config_db!");
    end
    
  endfunction: build_phase
  
  function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
    `uvm_info("DRIVER_CLASS","Inside axi4lite_driver connect_phase!", UVM_HIGH)
  endfunction: connect_phase
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    
    //Fill with logic later
    
  endtask: run_phase
  
endclass: axi4lite_driver
