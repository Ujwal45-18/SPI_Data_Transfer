module spi_top (
    input  wire clk,
    input  wire rst,
    output wire sclk,
    output wire cs,
    output wire mosi,
    output wire miso,
    output reg  pass,
    output reg  fail
);

    wire done;
    wire [7:0] rx_data;
    reg start;

    // SPI Master
    spi_master master (
        .clk(clk),
        .rst(rst),
        .start(start),
        .miso(miso),
        .sclk(sclk),
        .cs(cs),
        .mosi(mosi),
        .done(done),
        .rx_data(rx_data)
    );

    // Dummy SPI Slave
    spi_slave_dummy slave (
        .sclk(sclk),
        .cs(cs),
        .mosi(mosi),
        .miso(miso)
    );

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            start <= 1'b1;
            pass  <= 1'b0;
            fail  <= 1'b0;
        end else begin
            start <= 1'b0;

            if (done) begin
                if (rx_data == 8'h3C) begin
                    pass <= 1'b1;
                    fail <= 1'b0;
                end else begin
                    pass <= 1'b0;
                    fail <= 1'b1;
                end
            end
        end
    end
endmodule