//-------------------------------------------------------------------------
//This is a  pseudo code example for how  build flow works form a test class down to env and to agents and sub components
//This is a simplest example with no config objects to start with
//
//Once you get this concept and understand config object - it might be also good to refer to the 
//similar example with  config objects as well (simple_build_config.svh)
//------------------------------------------------------------------------------

class spi_test_base extends uvm_test;
  // UVM Factory Registration Macro
  `uvm_component_utils(spi_test_base)
  //------------------------------------------
  // Data Members
  //------------------------------------------
  //------------------------------------------
  // Component Members
  //------------------------------------------
  
  // The environment class
  spi_env m_env;
 
  // Build the env, 
  function void build_phase( uvm_phase phase );
    // Now we are ready to build the spi_env:
    m_env = spi_env::type_id::create("m_env", this);
  endfunction: build_phase

endclass: spi_test_base

