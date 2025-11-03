class mux_sequence extends uvm_sequence #(mux_transaction);
  `uvm_object_utils(mux_sequence)

  function new(string name = "mux_sequence");
    super.new(name);
  endfunction

  task body();
    mux_transaction tr;
    repeat (10) begin
      tr = mux_transaction::type_id::create("tr");
      assert(tr.randomize());
      start_item(tr);
      finish_item(tr);
    end
  endtask
endclass
