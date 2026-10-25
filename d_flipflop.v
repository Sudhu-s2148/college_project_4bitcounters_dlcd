module d_flipflop (
    input wire clk,
    input wire d_in,       // Changed semicolon to comma
    output wire Q,
    output wire Q_bar
);

    wire master_Q, master_Q_bar;
    wire clk_not;

    not gate_clk_not (clk_not, clk);

    d_latch master (
        .d_in(d_in),
        .en(clk_not),
        .Q(master_Q),
        .Q_bar(master_Q_bar)  // Fixed to match Q_bar and master_Q_bar
    );

    d_latch slave (
        .d_in(master_Q),
        .en(clk),
        .Q(Q),
        .Q_bar(Q_bar)
    );

endmodule