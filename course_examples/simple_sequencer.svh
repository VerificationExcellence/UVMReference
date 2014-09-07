class simple_sequencer extends uvm_sequencer #(simple_item, simple_rsp);
 
 `uvm_component_utils(simple_sequencer);

  function new (input string name, uvm_component parent=null)'
    super.new(name, parent);
  endfunction

endclass : simple_sequencer
