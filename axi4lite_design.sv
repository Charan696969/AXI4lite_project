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

  logic [9:0] write_address_latch;
  logic [31:0] memory [0:1023];

  logic write_address_active; //indicates active AW
  logic write_data_active; //indicates active WDATA
  logic write_transfer_complete; //indicates handshake(write)

  logic read_address_active; //indicates active AR
  logic read_data_transfer_complete; //indicates handshake(read)

  logic [31:0] RDATA_reg;
  logic [1:0]  RRESP_reg, BRESP_reg;
  
  assign R = {RRESP_reg, RDATA_reg}; 
  assign B = BRESP_reg;             

  //For a simple memory module - the memory is always ready to accept the incoming inputs - thus helping us simplify the logic to only checking "VALID" inputs.
  assign AWREADY = 1'b1; 
  assign WREADY  = 1'b1;
  assign ARREADY = 1'b1;

//Write Channel LOgic
  always_ff @(posedge ACLK or negedge ARESETN) begin
    if (!ARESETN) begin
      write_address_active <= 0;
      write_data_active <= 0;
      write_transfer_complete <= 0;
      BVALID <= 0;
      BRESP_reg <= 0; 
      for (int i = 0; i < 1024; i++)
        memory[i] <= 32'b0;
    end else begin

      if (AWVALID) begin
        write_address_latch <= AWADDR;
        write_address_active <= 1; 
      end else begin
        write_address_active <= 0;
      end


      if (WVALID) begin 
        write_data_active <= 1; 
      end else begin
        write_data_active <= 0; 
      end

      if (write_address_active && write_data_active) begin
        for (int i = 0; i < 4; i++) begin
          if (WSTRB[i])
            memory[write_address_latch][8*i +: 8] <= WDATA[8*i +: 8];
        end
        write_transfer_complete <= 1;
        BRESP_reg <= 2'b00;
      end else begin
        write_transfer_complete <= 0;
      end


      if (write_transfer_complete) begin
        BVALID <= 1;
      end else if (BVALID && BREADY) begin
        BVALID <= 0;
        BRESP_reg <= 2'b00; 
      end
    end
  end

  // Read Channel Logic
  always_ff @(posedge ACLK or negedge ARESETN) begin
    if (!ARESETN) begin
      read_address_active <= 0;
      read_data_transfer_complete <= 0;
      RVALID <= 0;
      RDATA_reg <= 0;
      RRESP_reg <= 0;
    end else begin
      if (ARVALID) begin 
        read_address_active <= 1; 
        RDATA_reg <= memory[ARADDR]; 
        RRESP_reg <= 2'b00; 
      end else begin
        read_address_active <= 0;
      end


      if (read_address_active) begin 
        read_data_transfer_complete <= 1;
      end else begin
        read_data_transfer_complete <= 0;
      end

      if (read_data_transfer_complete) begin
        RVALID <= 1;
      end else if (RVALID && RREADY) begin
        RVALID <= 0;
        RRESP_reg <= 2'b00; 
      end
    end
  end
endmodule
