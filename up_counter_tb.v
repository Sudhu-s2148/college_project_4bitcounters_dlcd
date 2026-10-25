`timescale 1ns / 1ps

module up_counter_tb;

    reg clk;
    wire [3:0] Q;
    wire [3:0] Q_bar;

    // Instantiate your counter
    module_4_bit_up_counter uut (
        .clk(clk),
        .Q(Q),
        .Q_bar(Q_bar)
    );

    // Clock generator: 10ns period
    always #5 clk = ~clk;

    initial begin
        clk = 0;

        // --- THE FIX FOR 'xxxx' ---
        // Force the flip-flop outputs to 0 at the start so the feedback loop 
        // has a known initial value instead of floating as 'x'.
        force uut.ff0.Q = 1'b0;
        force uut.ff0.Q_bar = 1'b1;
        force uut.ff1.Q = 1'b0;
        force uut.ff1.Q_bar = 1'b1;
        force uut.ff2.Q = 1'b0;
        force uut.ff2.Q_bar = 1'b1;
        force uut.ff3.Q = 1'b0;
        force uut.ff3.Q_bar = 1'b1;
        
        // Release the forced values after 2ns so normal circuit operation takes over
        #2;
        release uut.ff0.Q;
        release uut.ff0.Q_bar;
        release uut.ff1.Q;
        release uut.ff1.Q_bar;
        release uut.ff2.Q;
        release uut.ff2.Q_bar;
        release uut.ff3.Q;
        release uut.ff3.Q_bar;

        // Run simulation long enough to watch it count up
        #250;
        $finish;
    end

    // Monitor output changes in the console
    initial begin
        $monitor("Time = %0t ns | Q = %b (Decimal: %02d) | Q_bar = %b", 
                 $time, Q, Q, Q_bar);
    end

endmodule