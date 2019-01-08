//---------------------------------
// Using custom UVM Report Catcher to demote messages.
// Demote using Component ID/ Message string with regex.
//
// - Mayur Kubavat
//--------------------------------

class test extends uvm_test;
   `uvm_component_utils(test)


   env m_env;
   report_catcher m_report_catcher;

   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction


   function void build_phase(uvm_phase phase);
      m_env = env::type_id::create("m_env", this);
   endfunction


   task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      
      m_report_catcher = new("m_report_catcher");
      m_report_catcher.demote_message("error message 2) from e.*");

      // Register our report catcher for ENV component
      uvm_report_cb::add(m_env, m_report_catcher);
      
      #100;

      uvm_report_cb::delete(m_env, m_report_catcher);
      //void'(m_report_catcher.callback_mode(0));
      
      #100;
      phase.drop_objection(this);
   endtask

endclass

