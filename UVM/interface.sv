//defining interface for usage
interface axi4lite_interface(input logic ACLK, input logic ARESETN);
  logic [12:0] AW, AR;
  logic [35:0] W;
  logic AWVALID, WVALID, BREADY, ARVALID, RREADY;
  logic AWREADY, WREADY, BVALID, ARREADY, RVALID;
  logic [1:0]  B;
  logic [33:0] R;
endinterface
