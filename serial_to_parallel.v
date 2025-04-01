module serial_to_parallel (
    input clk,
    input reset,
    input serial_in,
    input load,
    output reg [31:0] parallel_out
);
    reg [31:0] shift_reg; // Shift register to store serial data

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_reg <= 32'b0; // Reset the shift register
            parallel_out <= 32'b0; // Reset the parallel output
        end else if (load) begin
            parallel_out <= shift_reg; // Load the shift register into parallel_out
        end else begin
            shift_reg <= {shift_reg[30:0], serial_in}; // Shift in serial data
        end
    end
endmodule