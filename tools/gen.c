#include <stdio.h>


void make_gate(char *name, int area, int n, char *function ) {
   printf("    cell(%s) {\n", name);
   printf("        area: %d;\n", area);
   for (int i = 0; i < n; i++) {
      printf("        pin(%c) {\n", 'A' + i);
      printf("            direction: input;\n");
      printf("        }\n");
   }
   printf("        pin(Q) {\n");
   printf("            direction: output;\n");
   printf("            function: \"(%s)\";\n", function);
   printf("        }\n");
   printf("    }\n");

}

void make_mux(char *name, int area, int ns, int nm, char *function ) {
   printf("    cell(%s) {\n", name);
   printf("        area: %d;\n", area);
   for (int i = 0; i < ns; i++) {
      printf("        pin(S%d) {\n", i);
      printf("            direction: input;\n");
      printf("        }\n");
   }
   for (int i = 0; i < nm; i++) {
      printf("        pin(M%d) {\n", i);
      printf("            direction: input;\n");
      printf("        }\n");
   }
   printf("        pin(Q) {\n");
   printf("            direction: output;\n");
   printf("            function: \"(%s)\";\n", function);
   printf("        }\n");
   printf("    }\n");
}



void make_dff(char *name, int area, int inc_clken, int inc_rst, int inc_set) {
   printf("    cell(%s) {\n", name);
   printf("        area: %d;\n", area);

   printf("        ff(\"IQ\", \"IQN\") {\n");
   printf("            clocked_on: CLK;\n");
   printf("            next_state: D;\n");
   if (inc_set) {
      printf("            preset: AS;\n");
   }
   if (inc_rst) {
      printf("            clear: AR;\n");
   }
   printf("        }\n");
   printf("        pin(CLK) {\n");
   printf("            direction: input;\n");
   printf("            clock: true;\n");
   printf("        }\n");
   printf("        pin(D) {\n");
   printf("            direction: input;\n");
   printf("        }\n");
   printf("        pin(Q) {\n");
   printf("            direction: output;\n");
   printf("            function: \"IQ\";\n");
   printf("        }\n");
   printf("        pin(QN) {\n");
   printf("            direction: output;\n");
   printf("            function: \"IQN\";\n");
   printf("        }\n");
   if (inc_set) {
      printf("        pin(AS) {\n");
      printf("            direction: input;\n");
      printf("        }\n");
   }
   if (inc_rst) {
      printf("        pin(AR) {\n");
      printf("            direction: input;\n");
      printf("        }\n");
   }
   printf("        ; // empty statement\n");
   printf("    }\n");
}


#if 0
  cell(DFFSR) {
    area: 18;
    ff("IQ", "IQN") { clocked_on: C;
                  next_state: D;
                      preset: S;
                       clear: R; }
    pin(C) { direction: input;
                 clock: true; }
    pin(D) { direction: input; }
    pin(Q) { direction: output;
              function: "IQ"; }
    pin(S) { direction: input; }
    pin(R) { direction: input; }
    ; // empty statement
  }
#endif



void main() {

   printf("/*\n");
   printf(" delay model :       typ\n");
   printf(" check model :       typ\n");
   printf(" power model :       typ\n");
   printf(" capacitance model : typ\n");
   printf(" other model :       typ\n");
   printf("*/\n");
   printf("library(atf15xx) {\n");

   make_gate("GND",       0,  0, "0");
   make_gate("VCC",       0,  0, "1");
   make_gate("BUF",       0,  1, "A");
   make_gate("OUTBUF",  100,  1, "A");
   make_gate("INBUF",   100,  1, "A");
   make_gate("IBUF",    100,  1, "A");
   make_gate("INV",     100,  1, "!A");
   make_gate("XOR",     300,  2, "A !B + !A B");
   make_gate("XOR2",    300,  2, "A !B + !A B");
   make_gate("AND2",    200,  2, "(A B)");
   make_gate("AND3",    300,  3, "(A B C)");
   make_gate("AND4",    400,  4, "(A B C D)");
   make_gate("AND5",    500,  5, "(A B C D E)");
   make_gate("AND6",    600,  6, "(A B C D E F)");
   make_gate("AND7",    700,  7, "(A B C D E F G)");
   make_gate("AND8",    800,  8, "(A B C D E F G H)");
   make_gate("AND9",    800,  9, "(A B C D E F G H I)");
   make_gate("AND10",   800, 10, "(A B C D E F G H I J)");
   make_gate("AND11",   800, 11, "(A B C D E F G H I J K)");
   make_gate("AND12",   800, 12, "(A B C D E F G H I J K L)");
   make_gate("AND2I1",  200,  2, "(A !B)");
   make_gate("AND2I2",  200,  2, "(!A !B)");
   make_gate("AND3I1",  300,  3, "(A B !C)");
   make_gate("AND3I2",  300,  3, "(A !B !C)");
   make_gate("AND3I3",  300,  3, "(!A !B !C)");
   make_gate("AND4I1",  400,  4, "(A B C !D)");
   make_gate("AND4I2",  400,  4, "(A B !C !D)");
   make_gate("AND4I3",  400,  4, "(A !B !C !D)");
   make_gate("AND4I4",  400,  4, "(!A !B !C !D)");
   make_gate("NAND2",   200,  2, "!(A B)");
   make_gate("NAND3",   300,  3, "!(A B C)");
   make_gate("NAND4",   400,  4, "!(A B C D)");
   make_gate("NAND5",   500,  5, "!(A B C D E)");
   make_gate("NAND6",   600,  6, "!(A B C D E F)");
   make_gate("NAND7",   700,  7, "!(A B C D E F G)");
   make_gate("NAND8",   800,  8, "!(A B C D E F G H)");
   make_gate("NAND9",   800,  9, "!(A B C D E F G H I)");
   make_gate("NAND10",  800, 10, "!(A B C D E F G H I J)");
   make_gate("NAND11",  800, 11, "!(A B C D E F G H I J K)");
   make_gate("NAND12",  800, 12, "!(A B C D E F G H I J K L)");
   make_gate("NAND2I1", 200,  2, "!(A !B)");
   make_gate("NAND2I2", 200,  2, "!(!A !B)");
   make_gate("NAND3I1", 300,  3, "!(A B !C)");
   make_gate("NAND3I2", 300,  3, "!(A !B !C)");
   make_gate("NAND3I3", 300,  3, "!(!A !B !C)");
   make_gate("NAND4I1", 400,  4, "!(A B C !D)");
   make_gate("NAND4I2", 400,  4, "!(A B !C !D)");
   make_gate("NAND4I3", 400,  4, "!(A !B !C !D)");
   make_gate("NAND4I4", 400,  4, "!(!A !B !C !D)");
   make_gate("OR2",     200,  2, "(A+B)");
   make_gate("OR3",     300,  3, "(A+B+C)");
   make_gate("OR4",     400,  4, "(A+B+C+D)");
   make_gate("OR5",     500,  5, "(A+B+C+D+E)");
   make_gate("OR6",     600,  6, "(A+B+C+D+E+F)");
   make_gate("OR7",     700,  7, "(A+B+C+D+E+F+G)");
   make_gate("OR8",     800,  8, "(A+B+C+D+E+F+G+H)");
   make_gate("OR9",     800,  9, "(A+B+C+D+E+F+G+H+I)");
   make_gate("OR10",    800, 10, "(A+B+C+D+E+F+G+H+I+J)");
   make_gate("OR11",    800, 11, "(A+B+C+D+E+F+G+H+I+J+K)");
   make_gate("OR12",    800, 12, "(A+B+C+D+E+F+G+H+I+J+K+L)");
   make_gate("OR2I1",   200,  2, "(A+!B)");
   make_gate("OR2I2",   200,  2, "(!A+!B)");
   make_gate("OR3I1",   300,  3, "(A+B+!C)");
   make_gate("OR3I2",   300,  3, "(A+!B+!C)");
   make_gate("OR3I3",   300,  3, "(!A+!B+!C)");
   make_gate("OR4I1",   400,  4, "(A+B+C+!D)");
   make_gate("OR4I2",   400,  4, "(A+B+!C+!D)");
   make_gate("OR4I3",   400,  4, "(A+!B+!C+!D)");
   make_gate("OR4I4",   400,  4, "(!A+!B+!C+!D)");
   make_gate("NOR2",    200,  2, "!(A+B)");
   make_gate("NOR3",    300,  3, "!(A+B+C)");
   make_gate("NOR4",    400,  4, "!(A+B+C+D)");
   make_gate("NOR5",    500,  5, "!(A+B+C+D+E)");
   make_gate("NOR6",    600,  6, "!(A+B+C+D+E+F)");
   make_gate("NOR7",    700,  7, "!(A+B+C+D+E+F+G)");
   make_gate("NOR8",    800,  8, "!(A+B+C+D+E+F+G+H)");
   make_gate("NOR9",    800,  9, "!(A+B+C+D+E+F+G+H+I)");
   make_gate("NOR10",   800, 10, "!(A+B+C+D+E+F+G+H+I+J)");
   make_gate("NOR11",   800, 11, "!(A+B+C+D+E+F+G+H+I+J+K)");
   make_gate("NOR12",   800, 12, "!(A+B+C+D+E+F+G+H+I+J+K+L)");
   make_gate("NOR2I1",  200,  2, "!(A+!B)");
   make_gate("NOR2I2",  200,  2, "!(!A+!B)");
   make_gate("NOR3I1",  300,  3, "!(A+B+!C)");
   make_gate("NOR3I2",  300,  3, "!(A+!B+!C)");
   make_gate("NOR3I3",  300,  3, "!(!A+!B+!C)");
   make_gate("NOR4I1",  400,  4, "!(A+B+C+!D)");
   make_gate("NOR4I2",  400,  4, "!(A+B+!C+!D)");
   make_gate("NOR4I3",  400,  4, "!(A+!B+!C+!D)");
   make_gate("NOR4I4",  400,  4, "!(!A+!B+!C+!D)");

   make_gate("XNOR2",   100,  2, "!((A+B) !(A B))"); // Change function?

   make_mux("MUX2",    800,  1, 2, "(!S0 M0)+(S0 M1)");
   make_mux("MUX4",    800,  2, 4, "(!S1 !S0 M0)+(!S1 S0 M1)+(S1 !S0 M2)+(S1 S0 M3)");
   make_mux("MUX8",    800,  3, 8, "(!S2 !S1 !S0 M0)+(!S2 !S1 S0 M1)+(!S2 S1 !S0 M2)+(!S2 S1 S0 M3)+(S2 !S1 !S0 M4)+(S2 !S1 S0 M5)+(S2 S1 !S0 M6)+(S2 S1 S0 M7)");

   // PGATE  0 0	DG	DFFEARS 6.00		CLK RECK AR AS CE * D Q QN *
   // PGATE  0 0	DG	DFF     6.00		CLK RECK * * * * D Q QN *
   // PGATE  0 0	DG	DFFE    6.00		CLK RECK * * CE * D Q QN *
   // PGATE  0 0	DG	DFFAR   6.00		CLK RECK AR * * * D Q QN *
   // PGATE  0 0	DG	DFFAS 6.00		CLK RECK * AS * * D Q QN *
   // PGATE  0 0	DG	DFFARS 6.00		CLK RECK AR AS * * D Q QN *

   //   make_dff("DFFEARS", 600, 1, 1, 1);
   make_dff("DFF",     600, 0, 0, 0);
   //   make_dff("DFFE",    600, 1, 0, 0);
   make_dff("DFFAR",   600, 0, 1, 0);
   make_dff("DFFAS",   600, 0, 0, 1);
   make_dff("DFFARS",  600, 0, 1, 1);


   // PGATE  0 0 	LG 	LATCH  5.00		EN L1 AR AS CE * D Q QN *
   // PGATE  0 0	JKG	JKFFEARS 12.00		CLK RECK !AR !AS CE * J K Q QN *
   // PGATE  0 0	TG	TFF     12.00		CLK RECK * * * * T Q QN *
   // PGATE  0 0	TG	TFFE    12.00		CLK RECK * * CE * T Q QN *
   // PGATE  0 0	TG	TFFAR   12.00		CLK RECK AR * * * T Q QN *
   // PGATE  0 0	TG	TFFAS   12.00		CLK RECK * AS * * T Q QN *
   // PGATE  0 0	TG	TFFARS  12.00		CLK RECK AR AS * * T Q QN *
   // PGATE  0 0	TG	TFFEARS 12.00		CLK RECK AR AS CE * T Q QN *
   // PGATE  0 0      THG	BUFTH  2.00        A     ENA        Q
   // PGATE  0 0      THG	TRI  2.00        A     ENA        Q
   // PGATE  0 0      BUF     BI_BUF  BIBUF	0.00     A       Q       PAD    EN

   printf("}\n");
}
