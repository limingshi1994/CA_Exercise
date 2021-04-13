module hazard_detection 
  #(
   parameter integer DATA_W = 16
   )(
      input  wire              IDEX_mem_read,
      input  wire [DATA_W-1:0] IDEX_regRt,
      input  wire [DATA_W-1:0] IFID_regRs,
      input  wire [DATA_W-1:0] IFID_regRt,
      output reg               IFID_write,
      output reg               pc_write,
      output reg               mux_sel
   );

   always@(*)begin
      if((IDEX_mem_read) && ((IDEX_regRt == IFID_regRs) || (IDEX_regRt == IFID_regRt))) begin
         pc_write <= 1'b1;
         IFID_write <= 1'b1;
         mux_sel <= 1'b0;
      end
      else begin
         pc_write <= 1'b0;
         IFID_write <= 1'b0;
         mux_sel <= 1'b1;
      end
   end
endmodule


