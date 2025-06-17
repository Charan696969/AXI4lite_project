//Object class - sequence_item

class axi4lite_sequence_item extends uvm_sequence_item;
  `uvm_object_utils(axi4lite_sequence_item)
  
  //Instantiations
  
  rand logic[12:0] aw,ar;
  rand logic[35:0] w;
  rand logic awvalid, wvalid, bready, arvalid, rready, aresetn;
  logic awready, wready, bvalid, arready, rvalid;
  logic[1:0] b;
  logic[33:0] r;
  
  constraint address_aligned{
    aw[1:0] == 2'b00;
  }
  
  constraint strb_valid{
    if(wvalid) begin
      w[35:32] != 4'b0000;
    end
    else begin
      w[35:32] == 4'b0000;
    end
  }
  
  constraint address_range{
    aw[9:0] inside {[0:1023]};
  }
  
  function new(string name = "axi4lite_sequence_item");
    super.new(name);
  endfunction: new
  
endclass: axi4lite_sequence_item
