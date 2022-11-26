#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>


char *output_name(char *name) {
   while (isalpha(*name) || isdigit(*name)) {
      putchar(*name++);
   }
   while (*name == ' ') {
      name++;
   }
   return name;
}

char* make_input2(char *name, char *attribute) {
   printf("        pin(");
   name = output_name(name);
   printf(") {\n");
   printf("            direction: input;\n");
   if (attribute) {
      printf("            %s;\n", attribute);
   }
   printf("        }\n");
   return name;
}

char* make_input(char *name) {
   return make_input2(name, NULL);
}


void make_output(char *name, char *function) {
   printf("        pin(%s) {\n", name);
   printf("            direction: output;\n");
   if (function) {
      printf("            function: \"%s\";\n", function);
   }
   printf("        }\n");
}

void make_inout(char *name, char *function) {
   printf("        pin(%s) {\n", name);
   printf("            direction: inout;\n");
   if (function) {
      printf("            function: \"%s\";\n", function);
   }
   printf("        }\n");
}

void make_gate(char *name, int area, char *inputs, char *output, char *function ) {
   printf("    cell(%s) {\n", name);
   printf("        area: %d;\n", area);
   while (*inputs) {
      inputs = make_input(inputs);
   }
   make_output(output, function);
   printf("    }\n");

}

void make_bibuf() {
   printf("    cell(bibuf) {\n");
   printf("        area: 0;\n");
   make_input("A");
   make_input("EN");
   make_output("Q", NULL);
   make_inout("PAD", NULL);
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
   make_input2("CLK", "clock: true");
   make_input("D");
   if (inc_clken) {
      make_input("CE");
   }
   if (inc_rst) {
      make_input("AR");
   }
   if (inc_set) {
      make_input("AS");
   }
   make_output("Q", "IQ");
   make_output("QN", "IQN");
   printf("        ; // empty statement\n");
   printf("    }\n");
}

void make_latch(char *name, int area) {
   printf("    cell(%s) {\n", name);
   printf("        area: %d;\n", area);
   printf("        latch(\"IQ\", \"IQN\") {\n");
   printf("            data_in: D;\n");
   printf("            enable: EN;\n");
   printf("            preset: AS;\n");
   printf("            clear: AR;\n");
   printf("        }\n");
   make_input("D");
   make_input("EN");
   make_input("AS");
   make_input("AR");
   make_output("Q", "IQ");
   make_output("QN", "IQN");
   printf("        ; // empty statement\n");
   printf("    }\n");
}


void main() {

   printf("/*\n");
   printf(" delay model :       typ\n");
   printf(" check model :       typ\n");
   printf(" power model :       typ\n");
   printf(" capacitance model : typ\n");
   printf(" other model :       typ\n");
   printf("*/\n");
   printf("library(atf15xx) {\n");

   make_gate("GND",       0,  "",                          "Q", "(0)");
   make_gate("VCC",       0,  "",                          "Q", "(1)");

   make_gate("BUF",       0, "A",                          "Q",  "(A)");
   make_gate("OUTBUF",  100, "A",                          "Q",  "(A)");
   make_gate("INBUF",   100, "A",                          "Q",  "(A)");
   make_gate("IBUF",    100, "A",                          "Q",  "(A)");
   make_bibuf();

   make_gate("INV",     100, "A",                          "QN", "(!A)");
   make_gate("XOR",     300, "A B",                        "Q",  "(A ^ B)");
   make_gate("XOR2",    300, "A B",                        "Q",  "(A ^ B)");

   make_gate("AND2",    200, "A B",                        "Q",  "((A B))");
   make_gate("AND3",    300, "A B C",                      "Q",  "((A B C))");
   make_gate("AND4",    400, "A B C D",                    "Q",  "((A B C D))");
   make_gate("AND5",    500, "A B C D E",                  "Q",  "((A B C D E))");
   make_gate("AND6",    600, "A B C D E F",                "Q",  "((A B C D E F))");
   make_gate("AND7",    700, "A B C D E F G",              "Q",  "((A B C D E F G))");
   make_gate("AND8",    800, "A B C D E F G H",            "Q",  "((A B C D E F G H))");
   make_gate("AND9",    800, "A B C D E F G H I",          "Q",  "((A B C D E F G H I))");
   make_gate("AND10",   800, "A B C D E F G H I J",        "Q",  "((A B C D E F G H I J))");
   make_gate("AND11",   800, "A B C D E F G H I J K",      "Q",  "((A B C D E F G H I J K))");
   make_gate("AND12",   800, "A B C D E F G H I J K L",    "Q",  "((A B C D E F G H I J K L))");
   make_gate("AND2I1",  200, "A BN",                       "Q",  "((A !BN))");
   make_gate("AND2I2",  200, "AN BN",                      "Q",  "((!AN !BN))");
   make_gate("AND3I1",  300, "A B CN",                     "Q",  "((A B !CN))");
   make_gate("AND3I2",  300, "A BN CN",                    "Q",  "((A !BN !CN))");
   make_gate("AND3I3",  300, "AN BN CN",                   "Q",  "((!AN !BN !CN))");
   make_gate("AND4I1",  400, "A B C DN",                   "Q",  "((A B C !DN))");
   make_gate("AND4I2",  400, "A B CN DN",                  "Q",  "((A B !CN !DN))");
   make_gate("AND4I3",  400, "A BN CN DN",                 "Q",  "((A !BN !CN !DN))");
   make_gate("AND4I4",  400, "AN BN CN DN",                "Q",  "(!AN !BN !CN !DN)");


   make_gate("NAND2",   200, "A B",                        "QN",  "(!(A B))");
   make_gate("NAND3",   300, "A B C",                      "QN",  "(!(A B C))");
   make_gate("NAND4",   400, "A B C D",                    "QN",  "(!(A B C D))");
   make_gate("NAND5",   500, "A B C D E",                  "QN",  "(!(A B C D E))");
   make_gate("NAND6",   600, "A B C D E F",                "QN",  "(!(A B C D E F))");
   make_gate("NAND7",   700, "A B C D E F G",              "QN",  "(!(A B C D E F G))");
   make_gate("NAND8",   800, "A B C D E F G H",            "QN",  "(!(A B C D E F G H))");
   make_gate("NAND9",   800, "A B C D E F G H I",          "QN",  "(!(A B C D E F G H I))");
   make_gate("NAND10",  800, "A B C D E F G H I J",        "QN",  "(!(A B C D E F G H I J))");
   make_gate("NAND11",  800, "A B C D E F G H I J K",      "QN",  "(!(A B C D E F G H I J K))");
   make_gate("NAND12",  800, "A B C D E F G H I J K L",    "QN",  "(!(A B C D E F G H I J K L))");
   make_gate("NAND2I1", 200, "A BN",                       "QN",  "(!(A !BN))");
   make_gate("NAND2I2", 200, "AN BN",                      "QN",  "(!(!AN !BN))");
   make_gate("NAND3I1", 300, "A B CN",                     "QN",  "(!(A B !CN))");
   make_gate("NAND3I2", 300, "A BN CN",                    "QN",  "(!(A !BN !CN))");
   make_gate("NAND3I3", 300, "AN BN CN",                   "QN",  "(!(!AN !BN !CN))");
   make_gate("NAND4I1", 400, "A B C DN",                   "QN",  "(!(A B C !DN))");
   make_gate("NAND4I2", 400, "A B CN DN",                  "QN",  "(!(A B !CN !DN))");
   make_gate("NAND4I3", 400, "A BN CN DN",                 "QN",  "(!(A !BN !CN !DN))");
   make_gate("NAND4I4", 400, "AN BN CN DN",                "QN",  "!(!AN !BN !CN !DN)");

   make_gate("OR2",     200, "A B",                        "Q",  "((A+B))");
   make_gate("OR3",     300, "A B C",                      "Q",  "((A+B+C))");
   make_gate("OR4",     400, "A B C D",                    "Q",  "((A+B+C+D))");
   make_gate("OR5",     500, "A B C D E",                  "Q",  "((A+B+C+D+E))");
   make_gate("OR6",     600, "A B C D E F",                "Q",  "((A+B+C+D+E+F))");
   make_gate("OR7",     700, "A B C D E F G",              "Q",  "((A+B+C+D+E+F+G))");
   make_gate("OR8",     800, "A B C D E F G H",            "Q",  "((A+B+C+D+E+F+G+H))");
   make_gate("OR9",     800, "A B C D E F G H I",          "Q",  "((A+B+C+D+E+F+G+H+I))");
   make_gate("OR10",    800, "A B C D E F G H I J",        "Q",  "((A+B+C+D+E+F+G+H+I+J))");
   make_gate("OR11",    800, "A B C D E F G H I J K",      "Q",  "((A+B+C+D+E+F+G+H+I+J+K))");
   make_gate("OR12",    800, "A B C D E F G H I J K L",    "Q",  "((A+B+C+D+E+F+G+H+I+J+K+L))");
   make_gate("OR2I1",   200, "A BN",                       "Q",  "((A+!BN))");
   make_gate("OR2I2",   200, "AN BN",                      "Q",  "((!AN+!BN))");
   make_gate("OR3I1",   300, "A B CN",                     "Q",  "((A+B+!CN))");
   make_gate("OR3I2",   300, "A BN CN",                    "Q",  "((A+!BN+!CN))");
   make_gate("OR3I3",   300, "AN BN CN",                   "Q",  "((!AN+!BN+!CN))");
   make_gate("OR4I1",   400, "A B C DN",                   "Q",  "((A+B+C+!DN))");
   make_gate("OR4I2",   400, "A B CN DN",                  "Q",  "((A+B+!CN+!DN))");
   make_gate("OR4I3",   400, "A BN CN DN",                 "Q",  "((A+!BN+!CN+!DN))");
   make_gate("OR4I4",   400, "AN BN CN DN",                "Q",  "(!AN+!BN+!CN+!DN)");

   make_gate("NOR2",    200, "A B",                        "QN", "(!(A+B))");
   make_gate("NOR3",    300, "A B C",                      "QN", "(!(A+B+C))");
   make_gate("NOR4",    400, "A B C D",                    "QN", "(!(A+B+C+D))");
   make_gate("NOR5",    500, "A B C D E",                  "QN", "(!(A+B+C+D+E))");
   make_gate("NOR6",    600, "A B C D E F",                "QN", "(!(A+B+C+D+E+F))");
   make_gate("NOR7",    700, "A B C D E F G",              "QN", "(!(A+B+C+D+E+F+G))");
   make_gate("NOR8",    800, "A B C D E F G H",            "QN", "(!(A+B+C+D+E+F+G+H))");
   make_gate("NOR9",    800, "A B C D E F G H I",          "QN", "(!(A+B+C+D+E+F+G+H+I))");
   make_gate("NOR10",   800, "A B C D E F G H I J",        "QN", "(!(A+B+C+D+E+F+G+H+I+J))");
   make_gate("NOR11",   800, "A B C D E F G H I J K",      "QN", "(!(A+B+C+D+E+F+G+H+I+J+K))");
   make_gate("NOR12",   800, "A B C D E F G H I J K L",    "QN", "(!(A+B+C+D+E+F+G+H+I+J+K+L))");
   make_gate("NOR2I1",  200, "A BN",                       "QN", "(!(A+!BN))");
   make_gate("NOR2I2",  200, "AN BN",                      "QN", "(!(!AN+!BN))");
   make_gate("NOR3I1",  300, "A B CN",                     "QN", "(!(A+B+!CN))");
   make_gate("NOR3I2",  300, "A BN CN",                    "QN", "(!(A+!BN+!CN))");
   make_gate("NOR3I3",  300, "AN BN CN",                   "QN", "(!(!AN+!BN+!CN))");
   make_gate("NOR4I1",  400, "A B C DN",                   "QN", "(!(A+B+C+!DN))");
   make_gate("NOR4I2",  400, "A B CN DN",                  "QN", "(!(A+B+!CN+!DN))");
   make_gate("NOR4I3",  400, "A BN CN DN",                 "QN", "(!(A+!BN+!CN+!DN))");
   make_gate("NOR4I4",  400, "AN BN CN DN",                "QN", "(!(!AN+!BN+!CN+!DN))");

   make_gate("XNOR2",   100, "A B ",                       "QN",  "(!(A ^ B))");

   make_gate("MUX2",    800, "S0 M0 M1",                   "Q",   "((!S0 M0)+(S0 M1))");
   make_gate("MUX4",    800, "S0 S1 M0 M1 M2 M3",          "Q",   "((!S1 !S0 M0)+(!S1 S0 M1)+(S1 !S0 M2)+(S1 S0 M3))");
   make_gate("MUX8",    800, "S0 S1 S2 M0 M1 M2 M3 M4 M5 M6 M7", "Q", "((!S2 !S1 !S0 M0)+(!S2 !S1 S0 M1)+(!S2 S1 !S0 M2)+(!S2 S1 S0 M3)+(S2 !S1 !S0 M4)+(S2 !S1 S0 M5)+(S2 S1 !S0 M6)+(S2 S1 S0 M7))");

   // PGATE  0 0	DG	DFFEARS 6.00		CLK RECK AR AS CE * D Q QN *
   // PGATE  0 0	DG	DFF     6.00		CLK RECK * * * * D Q QN *
   // PGATE  0 0	DG	DFFE    6.00		CLK RECK * * CE * D Q QN *
   // PGATE  0 0	DG	DFFAR   6.00		CLK RECK AR * * * D Q QN *
   // PGATE  0 0	DG	DFFAS 6.00		CLK RECK * AS * * D Q QN *
   // PGATE  0 0	DG	DFFARS 6.00		CLK RECK AR AS * * D Q QN *

   make_dff("DFFEARS", 600, 1, 1, 1);
   make_dff("DFF",     600, 0, 0, 0);
   make_dff("DFFE",    600, 1, 0, 0);
   make_dff("DFFAR",   600, 0, 1, 0);
   make_dff("DFFAS",   600, 0, 0, 1);
   make_dff("DFFARS",  600, 0, 1, 1);


   // PGATE  0 0 	LG 	LATCH  5.00		EN L1 AR AS CE * D Q QN *

   make_latch("LATCH", 500);

   // PGATE  0 0	JKG	JKFFEARS 12.00		CLK RECK !ANR !ANS CE * J K Q QN *
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
