class mux_test extends uvm_test;
  `uvm_component_utils(mux_test)

  mux_env env;
  mux_sequence seq;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    env = mux_env::type_id::create("env", this);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    seq = mux_sequence::type_id::create("seq");
    seq.start(env.seqr);
    phase.drop_objection(this);
  endtask
endclass
