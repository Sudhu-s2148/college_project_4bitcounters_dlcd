module module_4_bit_up_counter (
    input wire clk,
    output wire [3:0] Q,       // Changed from input to output wire
    output wire [3:0] Q_bar
);

    //D0 = Q0'
    //D1 = Q1 XOR Q0
    //D2 = Q2 XOR (Q0 AND Q1)
    //D3 = Q3 XOR (Q0 AND Q1 AND Q2)
    
    wire d1, d2, d3;
    wire and1, and2;


    xor gate_xor1 (d1, Q[0], Q[1]);
    
    and gate_and1 (and1, Q[0], Q[1]);
    xor gate_xor2 (d2, and1, Q[2]);

    and gate_and2 (and2, Q[1], and1);
    xor gate_xor3 (d3, and2, Q[3]);


    d_flipflop ff0 (
        .d_in(Q_bar[0]),
        .clk(clk),
        .Q(Q[0]),
        .Q_bar(Q_bar[0])
    );

    // Bit 1
    d_flipflop ff1 (
        .d_in(d1),
        .clk(clk),
        .Q(Q[1]),
        .Q_bar(Q_bar[1])
    );

    // Bit 2
    d_flipflop ff2 (
        .d_in(d2),
        .clk(clk),
        .Q(Q[2]),
        .Q_bar(Q_bar[2])
    );

    // Bit 3
    d_flipflop ff3 (
        .d_in(d3),
        .clk(clk),
        .Q(Q[3]),
        .Q_bar(Q_bar[3])
    );

endmodule