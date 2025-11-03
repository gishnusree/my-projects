class mux_transaction extends uvm_sequence_item;
  rand bit [7:0] a, b;
  rand bit sel;
  bit [7:0] y;

  `uvm_object_utils_begin(mux_transaction)
    `uvm_field_int(a, UVM_ALL_ON)
    `uvm_field_int(b, UVM_ALL_ON)
    `uvm_field_int(sel, UVM_ALL_ON)
    `uvm_field_int(y, UVM_ALL_ON)
  `uvm_object_utils_end

  function new(string name = "mux_transaction");
    super.new(name);
  endfunction
endclass
