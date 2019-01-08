//---------------------------------
// Using custom UVM Report Catcher to demote messages.
// Demote using Component ID/ Message string with regex.
//
// - Mayur Kubavat
//--------------------------------

class env extends uvm_env;
   `uvm_component_utils(env)

   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction


   task run_phase(uvm_phase phase);

      #1;

      `uvm_error("MYENV", "error message 1) from env..")

      #50;

      `uvm_error("MYENV", "error message 2) from env..")

      #50;

      `uvm_error("MYENV", "error message 3) from env..")

   endtask

endclass

