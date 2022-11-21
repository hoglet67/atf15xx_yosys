//PIN: A8X        : 76
//PIN: ADDR_0     : 34
//PIN: ADDR_1     : 35
//PIN: ADDR_2     : 45
//PIN: ADDR_3     : 44
//PIN: ADDR_4     : 5
//PIN: ADDR_5     : 41
//PIN: ADDR_6     : 40
//PIN: ADDR_7     : 58
//PIN: ADDR_8     : 36
//PIN: ADDR_9     : 37
//PIN: ADDR_10    : 39
//PIN: ADDR_11    : 80
//PIN: ADDR_12    : 84
//PIN: ADDR_13    : 64
//PIN: ADDR_14    : 63
//PIN: ADDR_15    : 60
//PIN: BA         : 46
//PIN: BS         : 48
//PIN: BUFDIR     : 73
//PIN: CLKX4      : 2
//PIN: DATA_0     : 4
//PIN: DATA_1     : 6
//PIN: DATA_2     : 24
//PIN: DATA_3     : 25
//PIN: DATA_4     : 9
//PIN: DATA_5     : 29
//PIN: DATA_6     : 28
//PIN: DATA_7     : 27
//PIN: EX         : 68
//PIN: E          : 83
//PIN: MMU_ADDR_0 : 15
//PIN: MMU_ADDR_1 : 12
//PIN: MMU_ADDR_2 : 16
//PIN: MMU_ADDR_3 : 18
//PIN: MMU_ADDR_4 : 11
//PIN: MMU_ADDR_5 : 30
//PIN: MMU_ADDR_6 : 31
//PIN: MMU_ADDR_7 : 17
//PIN: MMU_DATA_0 : 55
//PIN: MMU_DATA_1 : 56
//PIN: MMU_DATA_2 : 57
//PIN: MMU_DATA_3 : 52
//PIN: MMU_DATA_4 : 54
//PIN: MMU_DATA_5 : 75
//PIN: MMU_DATA_6 : 74
//PIN: MMU_DATA_7 : 69
//PIN: MMU_nRD    : 10
//PIN: MMU_nWR    : 20
//PIN: MRDY       : 49
//PIN: QA13       : 70
//PIN: QX         : 67
//PIN: RESET      : 1
//PIN: RnW        : 65
//PIN: nBUFEN     : 61
//PIN: nCSEXT     : 81
//PIN: nCSRAM     : 51
//PIN: nCSROM0    : 77
//PIN: nCSROM1    : 50
//PIN: nCSUART    : 21
//PIN: nRD        : 22
//PIN: nWR        : 33

module mmu
  (
   // CPU
   input        E,
   input [15:0] ADDR,
   input        BA,
   input        BS,
   input        RnW,
   input        nRESET,
   inout [7:0]  DATA,

   // MMU RAM

   output [7:0] MMU_ADDR,
   output       MMU_nRD,
   output       MMU_nWR,
   inout [7:0]  MMU_DATA,

   // Memory / Device Selects
   output       A8X,
   output       QA13,
   output       nRD,
   output       nWR,
   output       nCSEXT,
   output       nCSROM0,
   output       nCSROM1,
   output       nCSRAM,
   output       nCSUART,

   // External Bus Control
   output       BUFDIR,
   output       nBUFEN,

   // Clock Generator (for the E Parts)
   input        CLKX4,
   input        MRDY,
   output reg   QX,
   output reg   EX

   );

   parameter IO_PAGE = 16'hFE00;
   wire io_access  = {ADDR[15:8], 8'h00} == IO_PAGE;
   wire io_access_int = io_access & (ADDR[7:0] < 8'h30);
   wire mmu_access = {ADDR[15:3], 3'b000} == IO_PAGE + 16'h0020;
   wire mmu_access_rd = mmu_access & RnW;
   wire mmu_access_wr = mmu_access & !RnW;

   // Internal Registers
   reg            enmmu;
   reg            mode8k;
   reg [4:0]      access_key;
   reg [4:0]      task_key;

   always @(negedge E, negedge nRESET) begin
      if (!nRESET) begin
         mode8k     <= 1'b1;
         {mode8k, enmmu} <= 2'b0;
         access_key <= 5'b0;
         task_key <= 5'b0;
      end else begin
         if (!RnW && ADDR == IO_PAGE + 16'h0010) begin
            {mode8k, enmmu} <= DATA[1:0];
         end
         if (!RnW && ADDR == IO_PAGE + 16'h0011) begin
            access_key <= DATA[4:0];
         end
         if (!RnW && ADDR == IO_PAGE + 16'h0012) begin
            task_key <= DATA[4:0];
         end
      end
   end


   wire [7:0] data_out = ADDR == IO_PAGE + 16'h0010 ? {6'b0, mode8k, enmmu} :
                         ADDR == IO_PAGE + 16'h0011 ? {3'b0, access_key} :
                         ADDR == IO_PAGE + 16'h0012 ? {3'b0, task_key} :
                         {ADDR[15:4], 4'b0} == IO_PAGE + 16'h0010 ? 8'hAA : // unused registers
                         MMU_DATA;

   wire       data_en = E & (mmu_access_rd | (RnW & {ADDR[15:4], 4'b0} == IO_PAGE + 16'h0010));

   assign DATA = data_en ? data_out : 8'hZZ;

   assign MMU_ADDR = mmu_access ? {access_key, ADDR[2:0]} : {task_key, ADDR[15:13]};
// assign MMU_nCS  = 1'b0;
   assign MMU_nRD  = !(enmmu & !mmu_access_wr);
   assign MMU_nWR  = !(E     &  mmu_access_wr);

   wire [7:0] mmu_data_out = mmu_access_wr ? DATA : {5'b00000, ADDR[15:13]};
   wire       mmu_data_en = (mmu_access_wr & E) | !enmmu;

   assign MMU_DATA = mmu_data_en ? mmu_data_out : 8'hZZ;

   assign QA13 = mode8k ? MMU_DATA[5] : ADDR[13];

   always @(posedge CLKX4) begin
      // Q leads E
      case ({QX, EX})
        2'b00: QX <= 1'b1;
        2'b10: EX <= 1'b1;
        2'b11: QX <= 1'b0;
        2'b01: if (MRDY) EX <= 0;
      endcase
   end

   assign A8X = ADDR[8] ^ (!BA & BS & RnW);
   assign nRD = !(E & RnW);
   assign nWR = !(E & !RnW);
   assign nCSUART = !(E & {ADDR[15:4], 4'b0000} == IO_PAGE);

   assign nCSROM0 = !(((enmmu & MMU_DATA[7:6] == 2'b00) | (!enmmu &  ADDR[15])) & !io_access);
   assign nCSROM1 = !(  enmmu & MMU_DATA[7:6] == 2'b01                          & !io_access);
   assign nCSRAM  = !(((enmmu & MMU_DATA[7:6] == 2'b10) | (!enmmu & !ADDR[15])) & !io_access);
   assign nCSEXT  = !(BA ^ (enmmu & ((MMU_DATA[7:6] == 2'b11) | io_access) & !io_access_int));
   assign nBUFEN  = !(BA ^ (enmmu & ((MMU_DATA[7:6] == 2'b11) | io_access) & !io_access_int));
   assign BUFDIR  =   BA ^ RnW;

endmodule
