class master_monitor extends uvm_monitor;
  virtual bus_if xmi; // SystemVerilog virtual interface
  bit checks_enable = 1; // Control checking in monitor and interface.
  
  bit coverage_enable = 1; // Control coverage in monitor and interface.
  
  uvm_analysis_port #(simple_item) item_collected_port;
  
  event cov_transaction; // Events needed to trigger covergroups

  protected simple_item trans_collected;
  
  uvm_component_utils_begin(master_monitor)
    `uvm_field_int(checks_enable, UVM_ALL_ON)
    `uvm_field_int(coverage_enable, UVM_ALL_ON)
  uvm_component_utils_end
 
  covergroup cov_trans @cov_transaction;
    option.per_instance = 1;
    // Coverage bins definition
  endgroup : cov_trans

  function new (string name, uvm_component parent);
     super.new(name, parent);
     cov_trans = new();
     cov_trans.set_inst_name({get_full_name(), ".cov_trans"});
     trans_collected = new();
     item_collected_port = new("item_collected_port", this);
  endfunction : new

  virtual task run_phase(uvm_phase phase);
     fork
       collect_transactions(); // Spawn collector task.
    join
  endtask : run

  virtual protected task collect_transactions();
    forever begin  @(posedge xmi.sig_clock);
      // Collect the data from the bus into trans_collected.
      if (checks_enable)
         perform_transfer_checks();
      if (coverage_enable)
         perform_transfer_coverage();
      item_collected_port.write(trans_collected);
    end
  endtask : collect_transactions

  virtual protected function void perform_transfer_coverage();
     -> cov_transaction;
  endfunction : perform_transfer_coverage

  virtual protected function void perform_transfer_checks();
      // Perform data checks on trans_collected.
  endfunction : perform_transfer_checks

endclass : master_monitor
