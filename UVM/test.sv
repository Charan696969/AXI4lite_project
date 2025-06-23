//component class - test
class axi4lite_test extends uvm_test;
  //register to factory
  `uvm_component_utils(axi4lite_test)
  //instantiation
  axi4lite_env env;
  axi4lite_sequence seq;
  
  //constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("TEST_CLASS","Constructor called!", UVM_MEDIUM)
  endfunction

  //build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = axi4lite_env::type_id::create("env", this);
    seq = axi4lite_sequence::type_id::create("seq", this);
    `uvm_info("TEST_CLASS","Build Phase called!", UVM_MEDIUM)
  endfunction

  //connect phase
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("TEST_CLASS","COnnect Phase called!", UVM_MEDIUM)
  endfunction
 
  //end of elaboration phase
  virtual function void end_of_elaboration();
    `uvm_info("TEST_CLASS","Elob Phase!",UVM_MEDIUM)
    print();
  endfunction
  
  //run phase
  task run_phase(uvm_phase phase);
    `uvm_info("TEST_CLASS","Run Phase!",UVM_MEDIUM)
    phase.raise_objection(this);
    seq.start(env.agent.seqr);
    phase.drop_objection(this);
  endtask
  
endclass
