// Yosys transparent d-type latches
//    $_DLATCH_P_      (E, D, Q)
//    $_DLATCH_N_      (E, D, Q)

// A positive enable D-type latch.
module $_DLATCH_P_ (input E, input D, output Q);
    LATCH _TECHMAP_REPLACE_ (
        .D(D),
        .EN(E),
        .Q(Q),
        );
endmodule

// A negative enable D-type latch.
module $_DLATCH_N_ (input E, input D, output Q);
    LATCH _TECHMAP_REPLACE_ (
        .D(D),
        .EN(!E),
        .Q(Q),
        );
endmodule

// Yosys transparent d-type latches with one set or reset input
//    $_DLATCH_NN0_    (E, R, D, Q)
//    $_DLATCH_NN1_    (E, R, D, Q)
//    $_DLATCH_NP0_    (E, R, D, Q)
//    $_DLATCH_NP1_    (E, R, D, Q)
//    $_DLATCH_PN0_    (E, R, D, Q)
//    $_DLATCH_PN1_    (E, R, D, Q)
//    $_DLATCH_PP0_    (E, R, D, Q)
//    $_DLATCH_PP1_    (E, R, D, Q)

// A negative enable D-type latch with negative polarity reset.
module $_DLATCH_NN0_ (input E, input R, input D, output Q);
    LATCH _TECHMAP_REPLACE_ (
        .D(D),
        .EN(E),
        .AR(!R),
        .Q(Q),
        );
endmodule

// A negative enable D-type latch with negative polarity set.
module $_DLATCH_NN1_ (input E, input R, input D, output Q);
    LATCH _TECHMAP_REPLACE_ (
        .D(D),
        .EN(E),
        .AS(!R),
        .Q(Q),
        );
endmodule

// A negative enable D-type latch with positive polarity reset.
module $_DLATCH_NP0_ (input E, input R, input D, output Q);
    LATCH _TECHMAP_REPLACE_ (
        .D(D),
        .EN(!E),
        .AR(R),
        .Q(Q),
        );
endmodule

// A negative enable D-type latch with positive polarity set.
module $_DLATCH_NP1_ (input E, input R, input D, output Q);
    LATCH _TECHMAP_REPLACE_ (
        .D(D),
        .EN(!E),
        .AS(R),
        .Q(Q),
        );
endmodule

// A positive enable D-type latch with negative polarity reset.
module $_DLATCH_PN0_ (input E, input R, input D, output Q);
    LATCH _TECHMAP_REPLACE_ (
        .D(D),
        .EN(E),
        .AR(!R),
        .Q(Q),
        );
endmodule

//A positive enable D-type latch with negative polarity set.
module $_DLATCH_PN1_ (input E, input R, input D, output Q);
    LATCH _TECHMAP_REPLACE_ (
        .D(D),
        .EN(E),
        .AS(!R),
        .Q(Q),
        );
endmodule

// A positive enable D-type latch with positive polarity reset.
module $_DLATCH_PP0_ (input E, input R, input D, output Q);
    LATCH _TECHMAP_REPLACE_ (
        .D(D),
        .EN(E),
        .AR(R),
        .Q(Q),
        );
endmodule

// A positive enable D-type latch with positive polarity set.
module $_DLATCH_PP1_ (input E, input R, input D, output Q);
    LATCH _TECHMAP_REPLACE_ (
        .D(D),
        .EN(E),
        .AS(R),
        .Q(Q),
        );
endmodule

// Yosys transparent d-type latches with seperate set and resets inputs
//    $_DLATCHSR_NNN_  (E, S, R, D, Q)
//    $_DLATCHSR_NNP_  (E, S, R, D, Q)
//    $_DLATCHSR_NPN_  (E, S, R, D, Q)
//    $_DLATCHSR_NPP_  (E, S, R, D, Q)
//    $_DLATCHSR_PNN_  (E, S, R, D, Q)
//    $_DLATCHSR_PNP_  (E, S, R, D, Q)
//    $_DLATCHSR_PPN_  (E, S, R, D, Q)
//    $_DLATCHSR_PPP_  (E, S, R, D, Q)

// A negative enable D-type latch with negative polarity set and negative polarity reset.
module $_DLATCHSR_NNN_ (input E, input S, input R, input D, output Q);
    LATCH _TECHMAP_REPLACE_ (
        .D(D),
        .EN(!E),
        .AS(!S),
        .AR(!R),
        .Q(Q),
        );
endmodule

// A negative enable D-type latch with negative polarity set and positive polarity reset.
module $_DLATCHSR_NNP_ (input E, input S, input R, input D, output Q);
    LATCH _TECHMAP_REPLACE_ (
        .D(D),
        .EN(!E),
        .AS(!S),
        .AR(R),
        .Q(Q),
        );
endmodule

// A negative enable D-type latch with positive polarity set and negative polarity reset.
module $_DLATCHSR_NPN_ (input E, input S, input R, input D, output Q);
    LATCH _TECHMAP_REPLACE_ (
        .D(D),
        .EN(!E),
        .AS(S),
        .AR(!R),
        .Q(Q),
        );
endmodule

// A negative enable D-type latch with positive polarity set and positive polarity reset.
module $_DLATCHSR_NPP_ (input E, input S, input R, input D, output Q);
    LATCH _TECHMAP_REPLACE_ (
        .D(D),
        .EN(!E),
        .AS(S),
        .AR(R),
        .Q(Q),
        );
endmodule

// A positive enable D-type latch with negative polarity set and negative polarity reset.
module $_DLATCHSR_PNN_ (input E, input S, input R, input D, output Q);
    LATCH _TECHMAP_REPLACE_ (
        .D(D),
        .EN(E),
        .AS(!S),
        .AR(!R),
        .Q(Q),
        );
endmodule

// A positive enable D-type latch with negative polarity set and positive polarity reset.
module $_DLATCHSR_PNP_ (input E, input S, input R, input D, output Q);
    LATCH _TECHMAP_REPLACE_ (
        .D(D),
        .EN(E),
        .AS(!S),
        .AR(R),
        .Q(Q),
        );
endmodule

// A positive enable D-type latch with negative polarity set and positive polarity reset.
module $_DLATCHSR_PPN_ (input E, input S, input R, input D, output Q);
    LATCH _TECHMAP_REPLACE_ (
        .D(D),
        .EN(E),
        .AS(S),
        .AR(!R),
        .Q(Q),
        );
endmodule

// A positive enable D-type latch with positive polarity set and positive polarity reset.
module $_DLATCHSR_PPP_ (input E, input S, input R, input D, output Q);
    LATCH _TECHMAP_REPLACE_ (
        .D(D),
        .EN(E),
        .AS(S),
        .AR(R),
        .Q(Q),
        );
endmodule


// Yosys edge triggered d-type FFs with clock enable
//    $_DFFE_NN_       (D, C, E, Q)
//    $_DFFE_NP_       (D, C, E, Q)
//    $_DFFE_PN_       (D, C, E, Q)
//    $_DFFE_PP_       (D, C, E, Q)

// A negative edge D-type flip-flop with negative polarity enable.
module $_DFFE_NN_ (input D, input C, input E, output Q);
    DFFE _TECHMAP_REPLACE_ (
        .CLK(!C),
        .CE(!E),
        .D(D),
        .Q(Q),
        );
endmodule

// A negative edge D-type flip-flop with positive polarity enable.
module $_DFFE_NP_ (input D, input C, input E, output Q);
    DFFE _TECHMAP_REPLACE_ (
        .CLK(!C),
        .CE(E),
        .D(D),
        .Q(Q),
        );
endmodule

// A positive edge D-type flip-flop with negative polarity enable.
module $_DFFE_PN_ (input D, input C, input E, output Q);
    DFFE _TECHMAP_REPLACE_ (
        .CLK(C),
        .CE(!E),
        .D(D),
        .Q(Q),
        );
endmodule

// A positive edge D-type flip-flop with positive polarity enable.
module $_DFFE_PP_ (input D, input C, input E, output Q);
    DFFE _TECHMAP_REPLACE_ (
        .CLK(C),
        .CE(E),
        .D(D),
        .Q(Q),
        );
endmodule


// Yosys edge triggered d-type FFs with clock enable and one set or reset input
//    $_DFFE_NN0N_     (D, C, R, E, Q)
//    $_DFFE_NN0P_     (D, C, R, E, Q)
//    $_DFFE_NN1N_     (D, C, R, E, Q)
//    $_DFFE_NN1P_     (D, C, R, E, Q)
//    $_DFFE_NP0N_     (D, C, R, E, Q)
//    $_DFFE_NP0P_     (D, C, R, E, Q)
//    $_DFFE_NP1N_     (D, C, R, E, Q)
//    $_DFFE_NP1P_     (D, C, R, E, Q)
//    $_DFFE_PN0N_     (D, C, R, E, Q)
//    $_DFFE_PN0P_     (D, C, R, E, Q)
//    $_DFFE_PN1N_     (D, C, R, E, Q)
//    $_DFFE_PN1P_     (D, C, R, E, Q)
//    $_DFFE_PP0N_     (D, C, R, E, Q)
//    $_DFFE_PP0P_     (D, C, R, E, Q)
//    $_DFFE_PP1N_     (D, C, R, E, Q)
//    $_DFFE_PP1P_     (D, C, R, E, Q)

// A negative edge D-type flip-flop with negative polarity reset and
// positive polarity clock enable.
module $_DFFE_NN0P_ (input D, input C, input R, input E, output Q);
    DFFEARS _TECHMAP_REPLACE_ (
        .CLK(!C),
        .CE(E),
        .AR(!R),
        .D(D),
        .Q(Q),
        );
endmodule


// A positive edge D-type flip-flop with positive polarity set and
// positive polarity clock enable.
module $_DFFE_PP1P_ (input D, input C, input R, input E, output Q);
    DFFEARS _TECHMAP_REPLACE_ (
        .CLK(C),
        .CE(E),
        .AS(R),
        .D(D),
        .Q(Q),
        );
endmodule

// TODO: Add the other 14 flavours by inverting the control inputs

// Yosys edge triggered d-type FFs with clock enable and seperate set and resets inputs
//    $_DFFSRE_NNNN_   (C, S, R, E, D, Q)
//    $_DFFSRE_NNNP_   (C, S, R, E, D, Q)
//    $_DFFSRE_NNPN_   (C, S, R, E, D, Q)
//    $_DFFSRE_NNPP_   (C, S, R, E, D, Q)
//    $_DFFSRE_NPNN_   (C, S, R, E, D, Q)
//    $_DFFSRE_NPNP_   (C, S, R, E, D, Q)
//    $_DFFSRE_NPPN_   (C, S, R, E, D, Q)
//    $_DFFSRE_NPPP_   (C, S, R, E, D, Q)
//    $_DFFSRE_PNNN_   (C, S, R, E, D, Q)
//    $_DFFSRE_PNNP_   (C, S, R, E, D, Q)
//    $_DFFSRE_PNPN_   (C, S, R, E, D, Q)
//    $_DFFSRE_PNPP_   (C, S, R, E, D, Q)
//    $_DFFSRE_PPNN_   (C, S, R, E, D, Q)
//    $_DFFSRE_PPNP_   (C, S, R, E, D, Q)
//    $_DFFSRE_PPPN_   (C, S, R, E, D, Q)
//    $_DFFSRE_PPPP_   (C, S, R, E, D, Q)

// A positive edge D-type flip-flop with positive polarity set,
// positive polarity reset and positive polarity clock enable.
module $_DFFSRE_PPPP_ (input C, input S, input R, input E, input D, output Q);
    DFFEARS _TECHMAP_REPLACE_ (
        .CLK(C),
        .CE(E),
        .AR(R),
        .AS(S),
        .D(D),
        .Q(Q),
        );
endmodule

// TODO: Add the other 15 flavours by inverting the control inputs
