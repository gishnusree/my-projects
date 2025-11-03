class mux_driver extends uvm_driver #(mux_transaction);
  virtual mux_if vif;

  `uvm_component_utils(mux_driver)

  function new(string name = "mux_driver", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    if(!uvm_config_db#(virtual mux_if)::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", "Virtual interface not set for driver")
  endfunction

  task run_phase(uvm_phase phase);
    mux_transaction tr;
    forever begin
      seq_item_port.get_next_item(tr);
      vif.a = tr.a;
      vif.b = tr.b;
      vif.sel = tr.sel;
      #1;
      tr.y = vif.y;
      seq_item_port.item_done();
    end
  endtask
endclass
