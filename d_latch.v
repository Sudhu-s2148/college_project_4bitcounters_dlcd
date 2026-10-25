module d_latch (
    input wire d_in,
    input wire en,
    output wire Q,
    output wire Q_bar
);

    wire d_not;
    wire set,reset;

    not gate_not (d_not, d_in);

    nand gate_nand1 (set, en, d_in);
    nand gate_nand2 (reset, en, d_not);

    nand gate_q (Q,Q_bar,set);
    nand gate_qbar (Q_bar,Q,reset);

endmodule