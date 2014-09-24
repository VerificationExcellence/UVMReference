//-------------------------------------------------------------------------
//This is a  pseudo code example for how  build flow works form a test class down to env and to agents and sub components
//This code also demonstrates how to use configuration objects to configure parameters for each component
//and how to build first level of hierarchy.
//
// Before referencing this - it might be also good to refer to the simple case with no configs (simple_build_test.svh)
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
  // Configuration objects
  spi_env_config m_env_cfg;
  apb_agent_config m_apb_cfg;
  spi_agent_config m_spi_cfg;

  // Build the env, create the env configuration
  // including any sub configurations and assigning virtual interfaces
  function void build_phase( uvm_phase phase );
    // Create env configuration object
    m_env_cfg = spi_env_config::type_id::create("m_env_cfg");
    // Call function to configure the env
    configure_env(m_env_cfg);
    // Create apb agent configuration object
    m_apb_cfg = apb_agent_config::type_id::create("m_apb_cfg");
    // Call function to configure the apb_agent
    configure_apb_agent(m_apb_cfg);
    // Adding the apb virtual interface:
    if( !uvm_config_db #( virtual apb3_if )::get(this, "" , "APB_vif",m_apb_cfg.APB) )
         `uvm_error(...)
    // Assign the apb_angent config handle inside the env_config:
    m_env_cfg.m_apb_agent_cfg = m_apb_cfg;
    // Repeated for the spi configuration object
    m_spi_cfg = spi_agent_config::type_id::create("m_spi_cfg");
    configure_spi_agent(m_spi_cfg);
    if( !uvm_config_db #( virtual apb3_if )::get(this, "" , "SPIvif",m_spi_cfg.SPI) )
       `uvm_error(...)
    m_env_cfg.m_spi_agent_cfg = m_spi_cfg;
    // Now env config is complete set it into config space:
    uvm_config_db #( spi_env_config )::set( this , "*m_spi_agent*", "spi_env_config", m_env_cfg) );
    // Now we are ready to build the spi_env:
    m_env = spi_env::type_id::create("m_env", this);
  
  endfunction: build_phase

  //configure env config - can extend in derived tests
  function void configure_env(spi_env_config cfg);
    cfg.has_functional_coverage = 1;
    cfg.has_reg_scoreboard = 0;
    cfg.has_spi_scoreboard = 1;
  endfunction: configure_env


  // Convenience function to configure the apb agent
  // This can also be extended by derived classes
  function void configure_apb_agent(apb_agent_config cfg);
    cfg.active = UVM_ACTIVE;
    cfg.has_functional_coverage = 0;
    cfg.has_scoreboard = 0;
  endfunction: configure_apb_agent
  
endclass: spi_test_base

//---------------------------------------------------
// Env Config  Class
//---------------------------------------------------
class spi_env_config extends uvm_object;
  // UVM Factory Registration Macro
  `uvm_object_utils(spi_env_config)
  //------------------------------------------
  // Data Members
  //------------------------------------------
  // Whether env analysis components are used:
  bit has_functional_coverage = 1;
  bit has_reg_scoreboard = 0;
  bit has_spi_scoreboard = 1;
   
  //Configurations for the sub_components
  //APB Agent Config
  apb_config m_apb_agent_cfg;
  // SPI Agent Config
  spi_agent_config m_spi_agent_cfg;

  function new(string name = "spi_env_config");
    super.new(name);
  endfunction
 
endclass:  spi_env_config 

endclass: spi_env_config
