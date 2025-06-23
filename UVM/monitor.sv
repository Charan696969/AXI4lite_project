//component class - monitor
class axi4lite_monitor extends uvm_monitor;
  //register to factory
  `uvm_component_utils(axi4lite_monitor)
  
  //instantiations
  virtual axi4lite_interface intf;
  uvm_analysis_port #(axi4lite_seq_item) item_collected_port;

  //constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
    item_collected_port = new("item_collected_port", this);
    `uvm_info("MONITOR_CLASS","Constructor called!", UVM_MEDIUM)
  endfunction

  //build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("MONITOR_CLASS","Build Phase called!", UVM_MEDIUM)
    if (!uvm_config_db#(virtual axi4lite_interface)::get(this, "", "vif", intf))
      `uvm_fatal("NO_VIF", "Virtual interface not found")
  endfunction

  //run phase
  task run_phase(uvm_phase phase);
    `uvm_info("MONITOR_CLASS","Run Phase called!", UVM_MEDIUM)
    forever begin //used to read data from the virtual interface, and drive the transcation output
      axi4lite_seq_item tx = axi4lite_seq_item::type_id::create("tx");
      @(posedge intf.ACLK);

      if (intf.AWVALID && intf.AWREADY && intf.WVALID && intf.WREADY) begin
        tx.is_write = 1;
        tx.addr     = intf.AW[9:0];
        tx.prot     = intf.AW[12:10];
        tx.wdata    = intf.W[31:0];
        tx.wstrb    = intf.W[35:32];
        wait (intf.BVALID);
        tx.resp = intf.B;
        item_collected_port.write(tx);
      end else if (intf.ARVALID && intf.ARREADY) begin
        tx.is_write = 0;
        tx.addr     = intf.AR[9:0];
        tx.prot     = intf.AR[12:10];
        wait (intf.RVALID);
        tx.rdata = intf.R[31:0];
        tx.resp  = intf.R[33:32];
        item_collected_port.write(tx);
      end
    end
  endtask
endclass
