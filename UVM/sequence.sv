//Object class - sequence

class axi4lite_base_sequence extends uvm_sequence;
  `uvm_object_utils(axi4lite_base_sequence)
  
  axi4lite_sequence_item reset_pkt;
  
  function new(string name = "axi4lite_base_sequence");
    super.new(name);
    `uvm_info("BASE_SEQUENCE", "Inside axi4lite_base_sequence constructor!",UVM_HIGH);
    
  endfunction: new
  
  task body();
    `uvm_info("BASE_SEQUENCE", "Inside body task!",UVM_HIGH)
    
    reset_pkt = axi4lite_sequence_item::type_id::create("reset_pkt");
    start_item(reset_pkt);
    reset_pkt(randomize() with aresetn = 0);
    finish_item(reset_pkt);
    
    
  endtask: body
  
  
endclass: axi4lite_base_sequence


class axi4lite_test_sequence extends axi4lite_base_sequence;
  `uvm_object_utils(axi4lite_test_sequence)
  
  axi4lite_sequence_item item;
  
  function new(string name = "axi4lite_test_sequence");
    super.new(name);
    `uvm_info("TEST_SEQUENCE", "Inside axi4lite_test_sequence constructor!",UVM_HIGH);
    
  endfunction: new
  
  task body();
    `uvm_info("TEST_SEQUENCE", "Inside body task!",UVM_HIGH)
    
    item = axi4lite_sequence_item::type_id::create("item");
    start_item(item);
    item(randomize() with aresetn = 1);
    finish_item(item);

  endtask: body
  
endclass: axi4lite_test_sequence
