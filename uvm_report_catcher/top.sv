//---------------------------------
// Using custom UVM Report Catcher to demote messages.
// Demote using Component ID/ Message string with regex.
//
// - Mayur Kubavat
//--------------------------------

module top;

   import uvm_pkg::*;
   `include "uvm_macros.svh"

   // Custom Report Catcher
   `include "report_catcher.svh"
   
   // Env contains run_phase() to print messages
   `include "env.svh"

   // Test uses callback to register/remove custom report catcher
   `include "test.svh"
   


   initial
   begin
      run_test("test");
   end

endmodule

