/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`define default_netname none

module tt_um_Counter_1_shivam (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // All output pins must be assigned. If not used, assign to 0.
  assign uio_out = 0;
  assign uio_oe  = 0;
      reg  [7:0] count; // 8-bit counter output
    reg  [7:0] hex;   // Hexadecimal output
    reg  [7:0] dec;   // Decimal output

  assign uo_out[7:0] =count;
  assign uo_out[7:0] = hex;
  assign uo_out[7:0] =dec;
// Internal signals
reg [7:0] next_count;

// Counter logic
    always @(posedge clk or posedge rst_n) begin
        if (rst_n) begin
        count <= 8'b00000000; // Reset counter
        end else if (ui_in [2] && ~ui_in [3]) begin
        count <= count + 1; // Increment counter
        end else if (ui_in [3] && ~ui_in [2]) begin
        count <= count - 1; // Decrement counter
    end
end

// Hold logic
always @(posedge clk) begin
    if (ui_in [4]) begin
        next_count <= count; // Freeze current count
    end else begin
        next_count <= next_count; // Update count normally
    end
end

// Output display logic
always @(*) begin
    hex = count; // Hexadecimal output
    dec = count; // Decimal output
end

endmodule

