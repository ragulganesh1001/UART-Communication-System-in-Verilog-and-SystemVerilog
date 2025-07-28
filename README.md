# UART-Communication-System-in-Verilog-and-SystemVerilog
A complete UART communication system built using Verilog and SystemVerilog. Supports 8-bit serial data transmission with configurable baud rate and clock. Includes transmitter, receiver, and testbench with loopback verification.


# UART Communication System in Verilog and SystemVerilog

## Overview
This project implements a complete **UART (Universal Asynchronous Receiver Transmitter)** system using Verilog and SystemVerilog. It supports 8-bit serial communication with customizable clock frequency and baud rate. The system includes both a **transmitter**, a **receiver**, and a **top-level module**, along with a **SystemVerilog testbench** for simulation and verification.

## Modules Included
- `uarttx`: UART transmitter (8-bit, LSB-first, 1 start bit, 1 stop bit)
- `uartrx`: UART receiver (synchronous with baud rate)
- `uart_top`: Top-level wrapper that connects transmitter and receiver
- `uart_tb.sv`: SystemVerilog testbench that stimulates the system and verifies output using loopback

## Parameters
- `clk_freq`: System clock frequency (default: 1 MHz)
- `baud_rate`: Communication speed (default: 9600)

## Testbench Features
- Clock and reset generation
- Serial data transmission and reception using `tx` and `rx`
- Loopback mechanism to verify full UART cycle
- Console output to confirm correct reception

## How to Run
1. Make sure your simulator supports **SystemVerilog** (e.g., ModelSim, Vivado, VCS)
2. Compile and simulate the design:
   ```sh
   vlog -sv uart_top.sv uart_tb.sv
   vsim uart_tb

