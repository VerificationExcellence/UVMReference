//-----------------------------
// This file contains apb config, apb_agent and apb_env class components
//-----------------------------
`ifndef APB_AGENT_ENV_CFG__SV
`define APB_AGENT_ENV_CFG__SV

//---------------------------------------
// APB Config class
//   -Not really done anything as of now
//---------------------------------------
class apb_config extends uvm_object;

   `uvm_object_utils(apb_config)
   virtual apb_if vif;

  function new(string name="apb_config");
     super.new(name);
  endfunction

endclass

//---------------------------------------
// APB Agent class
//---------------------------------------
class apb_agent extends uvm_agent;

   //Agent will have the sequencer, driver and monitor components for the APB interface
   apb_sequencer sqr;
   apb_master_drv drv;
   apb_monitor mon;

   virtual apb_if  vif;

   `uvm_component_utils_begin(apb_agent)
      `uvm_field_object(sqr, UVM_ALL_ON)
      `uvm_field_object(drv, UVM_ALL_ON)
      `uvm_field_object(mon, UVM_ALL_ON)
   `uvm_component_utils_end
   
   function new(string name, uvm_component parent = null);
      super.new(name, parent);
   endfunction

   //Build phase of agent - construct sequencer, driver and monitor
   //get handle to virtual interface from env (parent) config_db
   //and pass handle down to srq/driver/monitor
   virtual function void build_phase(uvm_phase phase);
      sqr = apb_sequencer::type_id::create("sqr", this);
      drv = apb_master_drv::type_id::create("drv", this);
      mon = apb_monitor::type_id::create("mon", this);
      
      if (!uvm_config_db#(virtual apb_if)::get(this, "", "vif", vif)) begin
         `uvm_fatal("APB/AGT/NOVIF", "No virtual interface specified for this agent instance")
      end
     uvm_config_db#(virtual apb_if)::set( this, "sqr", "vif", vif);
     uvm_config_db#(virtual apb_if)::set( this, "drv", "vif", vif);
     uvm_config_db#(virtual apb_if)::set( this, "mon", "vif", vif);
   endfunction: build_phase

   //Connect - driver and sequencer port to export
   virtual function void connect_phase(uvm_phase phase);
      drv.seq_item_port.connect(sqr.seq_item_export);
      uvm_report_info("apb_agent::", "connect_phase, Connected driver to sequencer");
   endfunction
endclass: apb_agent

//----------------------------------------------
// APB Env class
//----------------------------------------------
class apb_env  extends uvm_env;
 
   `uvm_component_utils(apb_env);

   //ENV class will have agent as its sub component
   apb_agent  agt;
   //virtual interface for APB interface
   virtual apb_if  vif;

   function new(string name, uvm_component parent = null);
      super.new(name, parent);
   endfunction

   //Build phase - Construct agent and get virtual interface handle from test  and pass it down to agent
   function void build_phase(uvm_phase phase);
     agt = apb_agent::type_id::create("agt", this);
     if (!uvm_config_db#(virtual apb_if)::get(this, "", "vif", vif)) begin
         `uvm_fatal("APB/AGT/NOVIF", "No virtual interface specified for this env instance")
     end
     uvm_config_db#(virtual apb_if)::set( this, "agt", "vif", vif);
   endfunction: build_phase
  
endclass : apb_env  
  
  
`endif
