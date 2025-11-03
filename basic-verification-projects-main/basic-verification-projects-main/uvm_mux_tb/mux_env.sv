class mux_env extends uvm_env;
  mux_driver drv;
  mux_monitor mon;
  mux_scoreboard sb;
  uvm_sequencer #(mux_transaction) seqr;

  `uvm_component_utils(mux_env)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    drv  = mux_driver::type_id::create("drv", this);
    mon  = mux_monitor::type_id::create("mon", this);
    sb   = mux_scoreboard::type_id::create("sb", this);
    seqr = uvm_sequencer#(mux_transaction)::type_id::create("seqr", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    drv.seq_item_port.connect(seqr.seq_item_export);
    mon.ap.connect(sb.analysis_export);
  endfunction
endclass
