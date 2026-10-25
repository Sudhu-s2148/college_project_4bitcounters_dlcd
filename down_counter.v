module down_counter_4bit (
    input wire clk,
    output wire [3:0] Q,
    output wire [3:0] Q_bar
);

    wire d1, d2, d3;
    wire and1, and2;

    //D0 = Q0'
    //D1 = Q1 XOR Q0'
    //D2 = Q2 XOR (Q0' AND Q1')
    //D3 = Q3 XOR (Q0' AND Q1' AND Q2')

    xor u_xor1 (d1, Q[1], Q_bar[0]);
    and u_and1 (and1, Q_bar[0], Q_bar[1]);
    xor u_xor2 (d2, Q[2], and1);
    and u_and2 (and2, Q_bar[2], and1);
    xor u_xor3 (d3, Q[3], and2);

    d_flipflop ff0 (
        .d_in(Q_bar[0]), 
        .clk(clk),
        .Q(Q[0]),
        .Q_bar(Q_bar[0])
    );

    d_flipflop ff1 (
        .d_in(d1),
        .clk(clk),
        .Q(Q[1]),
        .Q_bar(Q_bar[1])
    );

    d_flipflop ff2 ( 
        .d_in(d2),
        .clk(clk),
        .Q(Q[2]),
        .Q_bar(Q_bar[2])
    );

    d_flipflop ff3 (
        .d_in(d3),
        .clk(clk),
        .Q(Q[3]),
        .Q_bar(Q_bar[3])
    );

endmodule