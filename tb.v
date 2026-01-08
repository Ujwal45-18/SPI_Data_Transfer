`timescale 1ns / 1ps

module tb_spi_top;

    // Testbench signals
    reg clk;
    reg rst;

    wire sclk;
    wire cs;
    wire mosi;
    wire miso;
    wire pass;
    wire fail;

    // Instantiate the TOP module
    spi_top uut (
        .clk(clk),
        .rst(rst),
        .sclk(sclk),
        .cs(cs),
        .mosi(mosi),
        .miso(miso),
        .pass(pass),
        .fail(fail)
    );

    // Clock generation: 100 MHz (10 ns period)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Reset and simulation control
    initial begin
        // Initialize
        rst = 1'b1;

        // Hold reset for some time
        #50;
        rst = 1'b0;

        // Run simulation long enough to finish SPI
        #2000;

        // Display result
        if (pass)
            $display("SPI TRANSFER PASS");
        else
            $display("SPI TRANSFER FAIL");

        $stop;
    end