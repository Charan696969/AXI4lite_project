//component class - scoreboard
class axi4lite_scoreboard extends uvm_scoreboard;
  //register to factory
  `uvm_component_utils(axi4lite_scoreboard)
  //declare port
  uvm_analysis_imp #(axi4lite_seq_item, axi4lite_scoreboard) item_collected_export;

  //mirror the memory here, so we can pluck out expected values :>
  bit [31:0] model_mem[0:1023];
  
  //constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("SCOREBOARD_CLASS","Constructor called!", UVM_MEDIUM)
  endfunction

  //build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    item_collected_export = new("item_collected_export",this);
    `uvm_info("SCOREBOARD_CLASS","Build Phase called!", UVM_MEDIUM)
  endfunction
  
  
  
  //checking exp with actual
  function void write(axi4lite_seq_item tx);
    `uvm_info("SCOREBOARD_CLASS","Checking expected with actual!", UVM_MEDIUM)
    if (tx.is_write) begin //writing to our mirrored memory to set expected values
      for (int i = 0; i < 4; i++) begin
        if (tx.wstrb[i])
          model_mem[tx.addr][8*i +: 8] = tx.wdata[8*i +: 8];
      end
    end else begin
      bit [31:0] expected = model_mem[tx.addr];
      if (tx.rdata !== expected)
        `uvm_error("SCOREBOARD", $sformatf("Read data mismatch at 0x%0h: Got 0x%0h, Expected 0x%0h", tx.addr, tx.rdata, expected))
    end
  endfunction
endclass
