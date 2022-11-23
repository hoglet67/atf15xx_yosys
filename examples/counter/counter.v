module counter
  (
   input        clock,
   output reg [1:0] counter
   );

   always @(posedge clock) begin
      counter <= counter + 1;
   end

endmodule
// Pin assignment for the experimental Yosys FLoow
//
//PIN: CHIP "counter" ASSIGNED TO AN PLCC84
//PIN: clock      : 83
//PIN: counter_0  : 37
//PIN: counter_1  : 39
