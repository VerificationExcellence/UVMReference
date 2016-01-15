class simple_agent extends uvm_agent;

  uvm_active_passive_enum is_active;
  // Constructor and UVM automation macros
  simple_sequencer sequencer;
  simple_driver driver;
  simple_monitor monitor;
 
  // Use build() phase to create agents's subcomponents.
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase)
    monitor = simple_monitor::type_id::create("monitor",this);
    if (is_active == UVM_ACTIVE) begin
      // Build the sequencer and driver.
      sequencer = simple_sequencer::type_id::create("sequencer",this);
      driver = simple_driver::type_id::create("driver",this);
    end
  endfunction : build_phase

  //Use connect phase to connect components together
  virtual function void connect_phase(uvm_phase phase);
    if(is_active == UVM_ACTIVE) begin
      driver.seq_item_port.connect(sequencer.seq_item_export);
    end
 endfunction : connect_phase

endclass : simple_agent
