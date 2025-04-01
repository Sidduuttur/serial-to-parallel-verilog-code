module tb_serial_to_parallel;
    reg clk;
    reg reset;
    reg serial_in;
    reg load;
    wire [31:0] parallel_out;

    // Instantiate the design under test (DUT)
    serial_to_parallel dut (
        .clk(clk),
        .reset(reset),
        .serial_in(serial_in),
        .load(load),
        .parallel_out(parallel_out)
    );

    // Clock generation
    always #5 clk = ~clk; // Toggle clock every 5 time units

    // Stimulus
    initial begin
        $dumpfile("dump.vcd"); // Specifies the VCD file name
        $dumpvars(0, tb_serial_to_parallel); // Dumps all variables in testbench

        // Initialize signals
        clk = 0;
        reset = 0;
        serial_in = 0;
        load = 0;

        // Apply reset
        reset = 1;
        #10 reset = 0;

        // Send serial data (example: 1101 in binary)
        serial_in = 1; #10;
        serial_in = 1; #10;
        serial_in = 1; #10;
        serial_in = 0; #10;

        // Continue sending remaining 28 bits
        repeat (28) begin
            serial_in = $random % 2; // Random 0 or 1
            #10;
        end

        // Load the shifted data into the parallel output
        load = 1;
        #10 load = 0;

        // Monitor parallel output
        $monitor("Time=%0t | parallel_out=%b", $time, parallel_out);

        // Wait for some time before finishing simulation
        #50; $finish;
    end
endmodule