//`include "property_defines.svh"

module aserciones_monitoreo(interface_monitoreo intf);
    logic clk;
    logic arst_n;
    assign clk = intf.clk;
    assign arst_n = intf.arst_n;

    //  Si reset está activo (0), la alerta DEBE ser 0.
    `AST(mon, alerta_en_reset, (!arst_n) |->, (intf.alerta == 0))
endmodule
