class mux_scoreboard extends uvm_component;
  uvm_analysis_imp #(mux_transaction, mux_scoreboard) analysis_export;

  `uvm_component_utils(mux_scoreboard)

  function new(string name, uvm_component parent);
    super.new(name, parent);
    analysis_export = new("analysis_export", this);
  endfunction

  function void write(mux_transaction tr);
    bit [7:0] expected = (tr.sel) ? tr.b : tr.a;
    if (tr.y !== expected)
      `uvm_error("MUX_FAIL", $sformatf("Mismatch! a=%0d b=%0d sel=%0b Expected=%0d Got=%0d",
                                       tr.a, tr.b, tr.sel, expected, tr.y))
    else
      `uvm_info("MUX_PASS", $sformatf("PASS: a=%0d b=%0d sel=%0b y=%0d", tr.a, tr.b, tr.sel, tr.y), UVM_LOW)
  endfunction
endclass
