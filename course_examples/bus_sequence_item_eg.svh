 //Example Bus Sequence Item
 class bus_seq_item extends uvm_sequence_item;
 
   // Request data properties are rand
   rand logic[31:0] addr;
   rand logic[31:0] write_data;
   rand bit read_not_write;
   rand int delay;
   
   // Response data properties are NOT rand
   bit error;
   logic[31:0] read_data;
  
   //Factory registeration
   `uvm_object_utils(bus_seq_item)

   function new(string name = "bus_seq_item");
     super.new(name);
   endfunction

   // Delay between bus cycles is in a sensible range
   constraint at_least_1 { delay inside {[1:20]};}
   // 32 bit aligned transfers
   constraint align_32 {addr[1:0] == 0;

   // do_copy method:
   function void do_copy(uvm_object rhs);
     bus_item rhs_;
     if(!$cast(rhs_, rhs)) begin
        uvm_report_error("do_copy:", "Cast failed");
        return;
     end
     super.do_copy(rhs); // Chain the copy with parent classes
     delay = rhs_.delay;
     addr = rhs_.addr;
     op_code = rhs_.op_code;
     slave_name = rhs_.slave_name;
     data = rhs_.data;
     response = rhs_.response;
   endfunction: do_copy

   // do_compare implementation:
   function bit do_compare(uvm_object rhs, uvm_comparer comparer); 
     bus_item rhs_;
     // If the cast fails, comparison has also failed
     // A check for null is not needed because that is done in the compare()
     // function which calls do_compare()
     if(!$cast(rhs_, rhs)) begin
      return 0;
     end 
     return((super.do_compare(rhs, comparer) &&
            (delay == rhs_.delay) &&
            (addr == rhs.addr) &&
            (op_code == rhs_.op_code) &&
            (slave_name == rhs_.slave_name) &&
            (data == rhs_.data) &&
            (response == rhs_.response));
  endfunction: do_compare


  // Implementation example:
  function string convert2string(); 
    string s;
    s = super.convert2string();
    // Note the use of \t (tab) and \n (newline) to format the data in columns
    // The enumerated op_code types .name() method returns a string corresponding to its value
    $sformat(s, "%s\n delay \t%0d\n addr \t%0h\n op_code \t%s\n slave_name \t%s\n",
                s, delay, addr, op_code.name(), slave_name);
    // For an array we need to iterate through the values:
    foreach(data[i]) begin
      $sformat(s, "%s data[%0d] \t%0h\n", s, i, data[i]);
    end
    $sformat(s, "%s response \t%0b\n", s, response);
    return s;
  endfunction: convert2string


 endclass: bus_seq_item

