`timescale 1ns/1ns
//include the required packages
`include "uvm_macros.svh"
import uvm_pkg::*;
//include files
`include "interface.sv"
`include "sequence_item.sv"
`include "sequence.sv"
`include "sequencer.sv"
`include "driver.sv"
`include "monitor.sv"
`include "agent.sv"
`include "scoreboard.sv"
`include "env.sv"
`include "test.sv"
//top module
module top;
  logic ACLK,ARESETN;
  //instantiate interface
  axi4lite_interface intf(.ACLK(ACLK), .ARESETN(ARESETN));
  //instantiate dut
  axi4lite DUT (
    .AW(intf.AW), .W(intf.W), .AR(intf.AR),
    .AWVALID(intf.AWVALID), .WVALID(intf.WVALID), .BREADY(intf.BREADY),
    .ARVALID(intf.ARVALID), .RREADY(intf.RREADY),
    .ARESETN(intf.ARESETN), .ACLK(intf.ACLK),
    .AWREADY(intf.AWREADY), .WREADY(intf.WREADY), .BVALID(intf.BVALID),
    .ARREADY(intf.ARREADY), .RVALID(intf.RVALID), .B(intf.B), .R(intf.R)
  );

  //clocking and reset
  initial begin
    ACLK = 0;
    ARESETN = 1'b0; 

    fork
      forever #5 ACLK = ~ACLK; 
      #50ns; 
      ARESETN = 1'b1;
    join_none 
    uvm_config_db#(virtual axi4lite_interface)::set(null,"*","vif",intf);
    run_test("axi4lite_test");
  end
  
endmodule
