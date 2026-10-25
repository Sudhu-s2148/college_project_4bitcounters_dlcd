`timescale 1ns / 1ps

module down_counter_tb;

    // Inputs
    reg clk;

    // Outputs
    wire [3:0] Q;
    wire [3:0] Q_bar;

    // Instantiate the Down Counter Unit Under Test (UUT)
    down_counter_4bit uut (
        .clk(clk),
        .Q(Q),
        .Q_bar(Q_bar)
    );

    // Generate a clock with a 10ns period (5ns high, 5ns low)
    always #5 clk = ~clk;

    initial begin
        // Initialize clock
        clk = 0;

        // Force initial values at t = 0 to break the 'x' state in the latches
        force uut.ff0.Q = 1'b0;
        force uut.ff0.Q_bar = 1'b1;
        force uut.ff1.Q = 1'b0;
        force uut.ff1.Q_bar = 1'b1;
        force uut.ff2.Q = 1'b0;
        force uut.ff2.Q_bar = 1'b1;
        force uut.ff3.Q = 1'b0;
        force uut.ff3.Q_bar = 1'b1;
        
        // Release the forces after 2ns so normal counting logic takes over
        #2;
        release uut.ff0.Q;
        release uut.ff0.Q_bar;
        release uut.ff1.Q;
        release uut.ff1.Q_bar;
        release uut.ff2.Q;
        release uut.ff2.Q_bar;
        release uut.ff3.Q;
        release uut.ff3.Q_bar;

        // Run simulation long enough to see a full downward cycle (16 * 10ns = 160ns)
        #200;
        
        $finish;
    end

    // Monitor changes in the console
    initial begin
        $monitor("Time = %0t ns | Q = %b (Decimal: %02d) | Q_bar = %b", 
                 $time, Q, Q, Q_bar);
    end

endmodule