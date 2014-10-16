APB Project
============
This is a complete APB interface project build in UVM and using only basic concepts as the motivation is to help beginners get started on understanding basic coding

apb_if.sv  ->  Is the APB interface protocol signal interface

apb_rw.svh ->  Is the basic apb read/write transaction class (sequence item)

apb_driver_seq_mon.svh -> Contatins the basic apb driver, sequencer and monitor component class

apb_agent_env_config.svh -> Contatins the basic  apb agent env and configuration class definitions

apb_test.svh ->  is the top level uvm_test for apb interface

apb_sequences.svh -> contatins the basic sequences for testing apb_interface

testbench.sv -> is the top level module that instantiates the apb physical interface and starts the top level test



Since there is no real APB SLAVE DUT - once you simulate this you should be only observing  apb transactions send from driver to interface and the monitor being able to see the interface toggling and reporting out those as transactions

As a future enhancement  - students can also extend this to include a slave bfm, score board etc  but not planned for the basic level course
