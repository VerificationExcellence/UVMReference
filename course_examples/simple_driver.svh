class simple_driver extends uvm_driver #(simple_item);
  simple_item s_item;
  virtual dut_if vif;
  
   // UVM automation macros for general components
  `uvm_component_utils(simple_driver)
   // Constructor
   function new (string name = "simple_driver", uvm_component parent);
     super.new(name, parent);
   endfunction : new

   function void build_phase(uvm_phase phase);
     string inst_name;
     super.build_phase(phase);
      if(!uvm_config_db#(virtual dut_if)::get(this,"","vif",vif)) begin
        `uvm_fatal("NOVIF", {"virtual interface must be set for: ", get_full_name(),".vif"});
      end 
   endfunction : build_phase 
   
   task run_phase(uvm_phase phase);
     forever begin
       // Get the next data item from sequencer (may block).
       seq_item_port.get_next_item(s_item);
       // Execute the item. 
       drive_item(s_item);
       seq_item_port.item_done(); // Consume the request.
     end
   endtask : run

   task drive_item (input simple_item item);
      // Add your logic here.
   endtask : drive_item
  
endclass : simple_driver
