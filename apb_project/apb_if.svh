//------------------------------------
//APB (Advanced peripheral Bus) Interface 
//
//------------------------------------
`ifndef APB_IF_SV
`define APB_IF_SV

interface apb_if(input bit pclk);
   wire [31:0] paddr;
   wire        psel;
   wire        penable;
   wire        pwrite;
   wire [31:0] prdata;
   wire [31:0] pwdata;


   //Master Clocking block - used for Drivers
   clocking master_cb @(posedge pclk);
      output paddr, psel, penable, pwrite, pwdata;
      input  prdata;
   endclocking: master_cb

   //Slave Clocking Block - used for any Slave BFMs
   clocking slave_cb @(posedge pclk);
      input  paddr, psel, penable, pwrite, pwdata;
      output prdata;
   endclocking: slave_cb

   //Monitor Clocking block - For sampling by monitor components
   clocking monitor_cb @(posedge pclk);
      input paddr, psel, penable, pwrite, prdata, pwdata;
   endclocking: monitor_cb

  modport master(clocking master_cb);
  modport slave(clocking slave_cb);
  modport passive(clocking monitor_cb);

endinterface: apb_if

`endif
