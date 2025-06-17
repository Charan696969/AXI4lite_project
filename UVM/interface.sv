interface axi4lite_interface(input logic aclk);

  logic[12:0] aw,ar;
  logic[35:0] w;
  logic awvalid, wvalid, bready, arvalid, rready, aresetn, awready, wready, bvalid, arready, rvalid;
  logic[1:0] b;
  logic[33:0] r;
  
endinterface: axi4lite_interface
