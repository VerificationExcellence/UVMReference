
//This is a  pseudo code example for how  build flow works form a test class down to env and to agents and sub components
//while configuring same as well
///////////////////////////////////////////

class spi_test_base extends uvm_test;
// UVM Factory Registration Macro
//
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
function void spi_test_base::build_phase( uvm_phase phase );
// Create env configuration object
m_env_cfg = spi_env_config::type_id::create("m_env_cfg");
// Call function to configure the env
configure_env(m_env_cfg);
// Create apb agent configuration object
m_apb_cfg = apb_agent_config::type_id::create("m_apb_cfg");
// Call function to configure the apb_agent
configure_apb_agent(m_apb_cfg);
// More to follow
endfunction: build_phase
