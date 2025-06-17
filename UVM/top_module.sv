`timescale 1ns/1ns

import uvm_pkg::*;
`include "uvm_macros.svh"


`include "interface.sv"
`include "sequence_item.sv"
`include "sequence.sv"
`include "sequencer.sv"
`include "driver.sv"
`include "monitor.sv"
`include "agent.sv"
`include "scoreboard.sv"
`include "environment.sv"
`include "test.sv"


module top;
  
  logic clock;
  
  axi4lite_interface intf(.aclk(clock));
  
  axi4lite dut (
    .AW(intg.aw),
    .W(intf.w),
    .AR(intf.ar),
    .AWVALID(intf.awvalid),
    .WVALID(intf.wvalid),
    .BREADY(intf.bready),
    .ARVALID(intf.arvalid),
    .RREADY(intf.rready),
    .ARESETN(intf.aresetn),
    .ACLK(intf.aclk),
    .AWREADY(intf.awready),
    .WREADY(intf.wready),
    .BVALID(intf.bvalid),
    .ARREADY(intf.arready),
    .RVALID(intf.rvalid),
    .B(intf.b),
    .R(intf.r)
  );
  
  initial begin
    uvm_config_db #(virtual axi4lite_interface)::set(null, "*", "vif", intf);
  end
  
  initial begin
    run_test();
  end
  
  initial begin
    clock = 0;
    forever #5 clock = ~clock;
  end
  
  initial begin
    #10000;
    $display("End of clock cycles!");
    $finish;
  end
  
  initial begin
    $dumpfile("output.vcd");
    $dumpvars(0,top);
  end
  
endmodule: top
