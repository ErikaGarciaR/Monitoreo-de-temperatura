`timescale 1ns / 1ps
import monitoreo_pkg::*;

module monitoreo_tb();
    bit clk;
    bit arst_n;
    always #5 clk = ~clk;

    // Instancia de la interfaz
    interface_monitoreo intf(clk, arst_n);

    // Instancia del dut
    monitoreo_top dut (
        .clk(intf.clk),
        .arst_n(intf.arst_n),
        .temp_entrada(intf.temp_entrada),
        .alerta(intf.alerta),
        .calefactor(intf.calefactor),
        .ventilador(intf.ventilador),
        .estado_actual(intf.estado_actual)
    );

    // Instancia de aserciones
    aserciones_monitoreo asercion_1(intf);

    // instanciar objetos de la clase
    temp_bajo    t_frio;
    temp_alto    t_calor;
    temp_normal  t_normal;

    initial begin

        t_frio = new();
        t_calor =new();
        t_normal = new();

        $display("--- Iniciando simulacion ---");
        arst_n = 0;           
        intf.temp_entrada = 0;
        #20 arst_n = 1;   

        $display("\n[TEST] Probando temperaturas normales...");
        repeat(3) begin
            void'(t_normal.randomize()); // Genera valor entre 180 y 450
            t_normal.reportar(); // Muestra el valor en consola
            intf.enviar_temperatura(t_normal.valor);
            $display("--- Dato ingresado al DUT exitosamente ---");
        end
        repeat(5) @(posedge clk);
        
        $display("--- Simulación terminada ---");
        $finish;
    end
endmodule


