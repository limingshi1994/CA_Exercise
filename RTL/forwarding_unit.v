module forwarding_unit 
  #(
   parameter integer DATA_W = 16
   )(
      input  wire [DATA_W-1:0] IDEX_regRs,
      input  wire [DATA_W-1:0] IDEX_regRt,
      input  wire [DATA_W-1:0] EXMEM_regRd,
      input  wire [DATA_W-1:0] MEMWB_regRd,
      input  wire              EXMEM_regW,
      input  wire              MEMWB_regW,
      output reg  [1:0]        forward_A,
      output reg  [1:0]        forward_B
   );

   always@(*)begin
      // Forward A signal
      // EX hazard
      if((EXMEM_regW) && (EXMEM_regRd != 0) && (EXMEM_regRd == IDEX_regRs)) begin
         forward_A <= 2'b10; 
      end 
      // MEM hazard
      else if((MEMWB_regW) && (MEMWB_regRd) && !((EXMEM_regW) && (EXMEM_regRd != 0)) && (EXMEM_regRd != IDEX_regRs) && (MEMWB_regRd == IDEX_regRs)) begin
         forward_A <= 2'b01;
      end 
      // No hazard
      else begin
         forward_A <= 2'b00;
      end
      
      //Forward B signal
      // EX hazard
      if((EXMEM_regW) && (EXMEM_regRd != 0) && (EXMEM_regRd == IDEX_regRt)) begin
         forward_B <= 2'b10;
      end
      // MEM hazard
      else if((MEMWB_regW) && (MEMWB_regRd) && !((EXMEM_regW) && (EXMEM_regRd != 0)) && (EXMEM_regRd != IDEX_regRt) && (MEMWB_regRd == IDEX_regRt)) begin
         forward_B <= 2'b01;
      end
      // No hazard
      else begin
         forward_B <= 2'b00;
      end
   end
endmodule

