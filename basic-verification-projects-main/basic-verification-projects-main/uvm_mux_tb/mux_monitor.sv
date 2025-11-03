class mux_monitor extends uvm_component;
  virtual mux_if vif;
  uvm_analysis_port #(mux_transaction) ap;

  `uvm_component_utils(mux_monitor)

  function new(string name, uvm_component parent);
    super.new(name, parent);
    ap = new("ap", this);
  endfunction

  function void build_phase(uvm_phase phase);
    if(!uvm_config_db#(virtual mux_if)::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", "Virtual interface not set for monitor")
  endfunction

  task run_phase(uvm_phase phase);
    mux_transaction tr;
    forever begin
      @(posedge vif.sel or negedge vif.sel);
      tr = mux_transaction::type_id::create("tr");
      tr.a = vif.a;
      tr.b = vif.b;
      tr.sel = vif.sel;
      tr.y = vif.y;
      ap.write(tr);
    end
  endtask
endclass
