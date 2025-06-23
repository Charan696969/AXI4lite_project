//object class - sequence_item
class axi4lite_seq_item extends uvm_sequence_item;
  //register to factory
  `uvm_object_utils(axi4lite_seq_item)

  //randomisable variables
  rand bit is_write;
  rand logic [9:0] addr;
  rand logic [2:0] prot;
  rand logic [31:0] wdata;
  rand logic [3:0] wstrb;

  logic [31:0] rdata;
  logic [1:0]  resp;

  //constructor
  function new(string name = "axi4lite_seq_item");
    super.new(name);
  endfunction
endclass
