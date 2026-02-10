// property_defines.svh
`define AST(block=mon, name=no_name, precond=1'b1 |->, consq=1'b0) \
    ``block``_ast_``name``: assert property (@(posedge clk) disable iff(!arst_n) ``precond`` ``consq``);