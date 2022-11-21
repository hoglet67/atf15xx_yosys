module register
  (
   input clock,
   input en,
   input RnW,
   inout data
   );

   reg   dreg;


always @(posedge clock)
  begin
     if (en & !RnW) begin
        dreg <= data;
     end
  end

  assign data = (en & RnW) ? dreg : 1'bZ;

endmodule // register
