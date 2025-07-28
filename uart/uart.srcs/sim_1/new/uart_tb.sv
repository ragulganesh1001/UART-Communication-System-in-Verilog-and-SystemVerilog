`timescale 1ns / 1ps

module uart_tb;

  // Parameters
  parameter clk_freq = 1000000;     // 1 MHz clock
  parameter baud_rate = 9600;

  // Clock & Reset
  reg clk;
  reg rst;

  // UART signals
  reg rx;
  reg [7:0] dintx;
  reg newd;
  wire tx;
  wire [7:0] doutrx;
  wire donetx;
  wire donerx;

  // Clock generation (1 MHz)
  always #500 clk = ~clk;

  // DUT instantiation
  uart_top #(
    .clk_freq(clk_freq),
    .baud_rate(baud_rate)
  ) dut (
    .clk(clk),
    .rst(rst),
    .rx(rx),
    .dintx(dintx),
    .newd(newd),
    .tx(tx),
    .doutrx(doutrx),
    .donetx(donetx),
    .donerx(donerx)
  );

  // Test logic
  initial begin
    $display("Starting UART Testbench...");
    
    // Initialize
    clk = 0;
    rst = 1;
    rx = 1;
    dintx = 8'h00;
    newd = 0;

    #2000;
    rst = 0;

    // Send data
    dintx = 8'hA5;      // Example data = 10100101
    newd = 1;
    #1000;
    newd = 0;

    // Wait for TX complete
    wait (donetx == 1);
    $display("TX done at time %t", $time);

    // Simulate loopback: connect TX to RX with delay
    fork
      begin
        // Bit delay = 1e9 / baud_rate ≈ 104166 ns per bit
        int i;
        rx = 1'b1;
        #(104166); rx = 1'b0;  // Start bit
        for (i = 0; i < 8; i++) begin
          #(104166); rx = dintx[i];
        end
        #(104166); rx = 1'b1;  // Stop bit
      end
    join_none

    // Wait for RX complete
    wait (donerx == 1);
    $display("RX done at time %t", $time);
    $display("Received byte = 0x%0h", doutrx);

    if (doutrx == 8'hA5)
      $display("UART Transmission successful!");
    else
      $display("UART Transmission failed!");

    #1000;
    $finish;
  end

endmodule
