//-------------------------------------------
// Top level Test module
//  Includes all env component and sequences files 
//    (you could ideally create an env package and import that as well instead of including)
//-------------------------------------------

 import uvm_pkg::*;
`include "uvm_macros.svh"

 //Include all files
`include "apb_if.svh"
`include "apb_rw.svh"
`include "apb_driver_seq_mon.svh"
`include "apb_agent_env_config.svh"
`include "apb_sequences.svh"
`include "apb_test.svh"

//--------------------------------------------------------
//Top level module that instantiates  just a physical apb interface
//No real DUT or APB slave as of now
//--------------------------------------------------------
module test;

   logic pclk;
  
   logic [31:0] paddr;
   logic        psel;
   logic        penable;
   logic        pwrite;
   logic [31:0] prdata;
   logic [31:0] pwdata;

   initial begin
      pclk=0;
   end

    //Generate a clock
   always begin
      #10 pclk = ~pclk;
   end
 
   //Instantiate a physical interface for APB interface
  apb_if  apb_if(.pclk(pclk));
  
  initial begin
    //Pass this physical interface to test top (which will further pass it down to env->agent->drv/sqr/mon
    uvm_config_db#(virtual apb_if)::set( null, "uvm_test_top", "vif", apb_if);
    //Call the test - but passing run_test argument as test class name
    //Another option is to not pass any test argument and use +UVM_TEST on command line to sepecify which test to run
    run_test("apb_base_test");
  end
  
  
endmodule


