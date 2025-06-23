//component class - driver
class axi4lite_driver extends uvm_driver#(axi4lite_seq_item);
  //register to factory
  `uvm_component_utils(axi4lite_driver)
  
  //instantiations
  virtual axi4lite_interface intf;
  axi4lite_seq_item tx;

  //constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("DRIVER_CLASS","Constructor called!", UVM_MEDIUM)
  endfunction

  //build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("DRIVER_CLASS","Build Phase called!", UVM_MEDIUM)
    if (!uvm_config_db#(virtual axi4lite_interface)::get(this, "", "vif", intf))
      `uvm_fatal("NO_VIF", "Virtual interface not found")
  endfunction

  //run phase
  task run_phase(uvm_phase phase);
  `uvm_info("DRIVER_CLASS","Driver Run Phase started!",UVM_MEDIUM)
    forever begin
      `uvm_info("DRIVER_CLASS","Waiting for next sequence item...",UVM_MEDIUM)
      seq_item_port.get_next_item(tx);
      `uvm_info("DRIVER_CLASS", $sformatf("Received new sequence item: %s", tx.sprint()),UVM_MEDIUM) //tx.sprint() prints the details of the current sequence item

      //detailed step by step debugging, to ensure all FSMs of design works correctly
      if (tx.is_write) begin
        `uvm_info("DRIVER_CLASS", $sformatf("Starting AXI4-Lite Write Transaction to addr 0x%0h", tx.addr), UVM_MEDIUM)
        @(posedge intf.ACLK);
        intf.AW<= {tx.prot, tx.addr};
        intf.W<= {tx.wstrb, tx.wdata};
        intf.AWVALID<= 1;
        intf.WVALID<= 1;
        `uvm_info("DRIVER_CLASS", "Waiting for AWREADY && WREADY...", UVM_MEDIUM)
        wait (intf.AWREADY && intf.WREADY);
    `uvm_info("DRIVER_CLASS", "AWREADY && WREADY received!", UVM_MEDIUM)

        @(posedge intf.ACLK);
        intf.AWVALID<= 0;
        intf.WVALID<= 0;
        intf.BREADY<= 1;
        `uvm_info("DRIVER_CLASS", "Waiting for BVALID (Write Response)...", UVM_MEDIUM)
        wait (intf.BVALID);
        `uvm_info("DRIVER_CLASS", $sformatf("BVALID received! Response: %0b", intf.B), UVM_MEDIUM)
        tx.resp = intf.B;
        @(posedge intf.ACLK);
        intf.BREADY <= 0;
        `uvm_info("DRIVER_CLASS", "Write Transaction completed.", UVM_MEDIUM)
      end else begin 
        `uvm_info("DRIVER_CLASS", $sformatf("Starting AXI4-Lite Read Transaction from addr 0x%0h", tx.addr), UVM_MEDIUM)
        @(posedge intf.ACLK);
        intf.AR      <= {tx.prot, tx.addr};
        intf.ARVALID <= 1;
        `uvm_info("DRIVER_CLASS", "Waiting for ARREADY...", UVM_MEDIUM)
        wait (intf.ARREADY);
        `uvm_info("DRIVER_CLASS", "ARREADY received!", UVM_MEDIUM)
        @(posedge intf.ACLK);
        intf.ARVALID <= 0;
        intf.RREADY  <= 1;
        `uvm_info("DRIVER_CLASS", "Waiting for RVALID (Read Data)...", UVM_MEDIUM)
        wait (intf.RVALID);
        `uvm_info("DRIVER_CLASS", $sformatf("RVALID received! Read Data: 0x%0h, Response: %0b", intf.R[31:0], intf.R[33:32]), UVM_MEDIUM)
        tx.rdata = intf.R[31:0];
        tx.resp  = intf.R[33:32];
        @(posedge intf.ACLK);
        intf.RREADY <= 0;
        `uvm_info("DRIVER_CLASS", "Read Transaction completed.", UVM_MEDIUM)
      end

      `uvm_info("DRIVER_CLASS", "Calling item_done()...", UVM_MEDIUM)
      seq_item_port.item_done();
      `uvm_info("DRIVER_CLASS", "item_done() called. Driver ready for next item.", UVM_MEDIUM)
      //Detailed debug messages. Very hectic.
    end
  endtask
endclass
