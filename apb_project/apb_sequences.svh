
//A few flavours of apb sequences

`ifndef APB_SEQUENCES_SV
`define APB_SEQUENCES_SV

//------------------------
//Base APB sequence derived from uvm_sequence and parameterized with sequence item of type apb_rw
//------------------------
class apb_base_seq extends uvm_sequence#(apb_rw);

  `uvm_object_utils(apb_base_seq)

  function new(string name ="");
    super.new(name);
  endfunction


  //Main Body method that gets executed once sequence is started
  task body();
     apb_rw rw_trans;
     //Create 10 random APB read/write transaction and send to driver
     repeat(10) begin
       rw_trans = apb_rw::type_id::create(.name("rw_trans"),.contxt(get_full_name()));
       start_item(rw_trans);
       assert (rw_trans.randomize());
       finish_item(rw_trans);
     end
  endtask
  
endclass



`endif
