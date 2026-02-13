interface interface_monitoreo(input logic clk, input logic arst_n);
    logic signed [10:0] temp_entrada;
    logic alerta;
    logic calefactor; 
    logic ventilador;
    logic [1:0] estado_actual;
    //
    task automatic aplicar_reset();
        $display("[INTERFACE] Aplicando Reset...");
        temp_entrada <= 11'b0;
        @(posedge clk);
        $display("[INTERFACE] Reset completado...");
    endtask
    //
    task automatic enviar_temperatura(input logic signed [10:0] valor);
        @(negedge clk);
        temp_entrada = valor;
        $display("[INTERFACE] Enviando T = %0d", valor);
        @(posedge clk);
    endtask
    //
    task automatic reporte_estado();
        $display("[INTERFACE] STATUS @%t | Alerta: %b | Vent: %b | Cal: %b | Estado: %b", 
                 $time, alerta, ventilador, calefactor, estado_actual);
    endtask

endinterface
