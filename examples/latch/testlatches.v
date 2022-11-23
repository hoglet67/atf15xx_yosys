module testlatches
  (
   input      s,
   input      r,
   input      d,
   input      en,
   output reg q1,
   output reg q2,
   output reg q3
   );

   // Infer a transparent latch
   always @(*)
     if (en == 1)
       q1 <= d;

   // Infer a set-reset latch
   always @(*)
     if (r == 1)
    	 q2 <= 1'b0;
     else if (s == 1)
       q2 <= 1'b1;

   // Infer a Transparent latch with S and R
   always @(*)
     if (r == 1)
    	 q3 <= 1'b0;
     else if (s == 1)
       q3 <= 1'b1;
     else if (en == 1)
       q3 <= d;

endmodule // testlatches
