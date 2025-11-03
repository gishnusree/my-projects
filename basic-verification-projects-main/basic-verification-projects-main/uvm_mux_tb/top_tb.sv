`timescale 1ns/1ps

module top_tb;
  mux_if mux_if_inst();

  mux dut (
    .a(mux_if_inst.a),
    .b(mux_if_inst.b),
    .sel(mux_if_inst.sel),
    .y(mux_if_inst.y)
  );

  initial begin
    uvm_config_db#(virtual mux_if)::set(null, "*", "vif", mux_if_inst);
    run_test("mux_test");
  end
endmodule
