module axi4lite(
    input  logic [12:0] AW,
    input  logic [35:0] W,
    input  logic [12:0] AR,
    input  logic AWVALID, WVALID, BREADY, ARVALID, RREADY,
    input  logic ARESETN, ACLK,
    output logic AWREADY, WREADY, BVALID, ARREADY, RVALID,
    output logic [1:0]  B,
    output logic [33:0] R
);
  
  logic [9:0] AWADDR, ARADDR;
  logic [2:0] AWPROT, ARPROT;
  logic [31:0] WDATA;
  logic [3:0]  WSTRB;

  assign AWADDR = AW[9:0];
  assign AWPROT = AW[12:10];

  assign ARADDR = AR[9:0];
  assign ARPROT = AR[12:10];

  assign WDATA = W[31:0];
  assign WSTRB = W[35:32];

  //Latches and Memory
  logic [9:0] write_address_latch, read_address_latch;
  logic       write_address_hs, write_data_hs;
  logic [31:0] memory [0:1023];

  //Output registers
  logic [31:0] RDATA;
  logic [1:0]  RRESP, BRESP;
  
  assign R = {RRESP, RDATA};
  assign B = BRESP;

  // Ready signals
  assign AWREADY = !write_address_hs;
  assign WREADY  = !write_data_hs;
  assign ARREADY = !RVALID;

  //Write
  always_ff @(posedge ACLK or negedge ARESETN) begin
    if (!ARESETN) begin
      write_address_hs<= 0;
      write_data_hs <= 0;
      BVALID<= 0;
      BRESP <= 0;
      for (int i = 0; i < 1024; i++)
        memory[i] <= 32'b0;
    end else begin

      if (AWVALID && AWREADY) begin
        write_address_latch <= AWADDR;
        write_address_hs <= 1;
      end


      if (WVALID && WREADY)
        write_data_hs <= 1;


      if (write_address_hs && write_data_hs) begin
        for (int i = 0; i < 4; i++) begin
          if (WSTRB[i])
            memory[write_address_latch][8*i +: 8] <= WDATA[8*i +: 8];
        end

        BVALID<= 1;
        BRESP <= 2'b00; 
        write_address_hs <= 0;
        write_data_hs <= 0;
      end


      if (BVALID && BREADY) begin
        BVALID <= 0;
        BRESP<= 2'b00;
      end
    end
  end

  //Read
  always_ff @(posedge ACLK or negedge ARESETN) begin
    if (!ARESETN) begin
      RVALID <= 0;
      RDATA  <= 0;
      RRESP  <= 0;
    end else begin
      if (ARVALID && ARREADY) begin
        read_address_latch <= ARADDR;
        RDATA <= memory[ARADDR];
        RRESP <= 2'b00;
        RVALID <= 1;
      end else if (RVALID && RREADY) begin
        RVALID <= 0;
        RRESP  <= 2'b00;
      end
    end
  end
endmodule
