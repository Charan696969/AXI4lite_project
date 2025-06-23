//object class - sequence
class axi4lite_sequence extends uvm_sequence#(axi4lite_seq_item);
  //register to factory
  `uvm_object_utils(axi4lite_sequence)

  
  //constructor
  function new(string name = "axi4lite_sequence");
    super.new(name);
    `uvm_info("SEQUENCE_CLASS","Constructor called!", UVM_MEDIUM)
  endfunction

  //sequence
  task body();
    `uvm_info("SEQUENCE_CLASS","Initiating seqeunce!", UVM_MEDIUM)
    repeat (10) begin //repeat(n) indicates number of sequence items generated
      axi4lite_seq_item tx;

      tx = axi4lite_seq_item::type_id::create("tx");
      assert(tx.randomize()); //randomizing inputs
      start_item(tx);
      finish_item(tx);
    end
    `uvm_info("SEQUENCE_CLASS","Sequence body done!",UVM_MEDIUM)
  endtask
endclass
