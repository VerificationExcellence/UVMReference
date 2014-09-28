
//Example to illustrate a testbench top example with DUT connections
module top_tb;
  `include "timescale.v"
  import uvm_pkg::*;
  import spi_test_lib_pkg::*;

  // PCLK and PRESETn
  logic PCLK;
  logic PRESETn;

  // Instantiate the interfaces:
  apb_if APB(PCLK, PRESETn); // APB interface
  spi_if SPI(); // SPI Interface
  intr_if INTR(); // Interrupt

  //Instantiate DUT
  spi_top DUT(
  // APB Interface:
  .PCLK(PCLK),
  .PRESETN(PRESETn),
  .PSEL(APB.PSEL[0]),
  .PADDR(APB.PADDR[4:0]),
  .PWDATA(APB.PWDATA),
  .PRDATA(APB.PRDATA),
  .PENABLE(APB.PENABLE),
  .PREADY(APB.PREADY),
  .PSLVERR(),
  .PWRITE(APB.PWRITE),
  // Interrupt output
  .IRQ(INTR.IRQ),
  // SPI signals
  .ss_pad_o(SPI.cs),
  .sclk_pad_o(SPI.clk),
  .mosi_pad_o(SPI.mosi), 
  .miso_pad_i(SPI.miso)
  );

  // UVM initial block:
  // Virtual interface wrapping & run_test()
  initial begin
    uvm_config_db #(virtual apb_if)::set( null , "uvm_test_top" , "APB_vif" , APB);
    uvm_config_db #(virtual spi_if)::set( null , "uvm_test_top" , "SPI_vif" , SPI);
    uvm_config_db #(virtual intr_if)::set( null , "uvm_test_top" , "INTR_vif", INTR);
    run_test();
  end

  // Clock and reset initial block:
  //
  initial begin
    PCLK = 0;
    PRESETn = 0;
    repeat(8) begin
      #10ns PCLK = ~PCLK;
    end
    PRESETn = 1;
    forever begin
      #10ns PCLK = ~PCLK;
    end
  end
  
endmodule: top_tb
