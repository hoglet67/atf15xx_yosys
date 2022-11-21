module counter
  (
   // Clock Generator (for the E Parts)
   input        CLKX4,
   input        MRDY,
   output reg   QX,
   output reg   EX

   );

   always @(posedge CLKX4) begin
      // Q leads E
      case ({QX, EX})
        2'b00: QX <= 1'b1;
        2'b10: EX <= 1'b1;
        2'b11: QX <= 1'b0;
        2'b01: if (MRDY) EX <= 0;
      endcase
   end

endmodule
