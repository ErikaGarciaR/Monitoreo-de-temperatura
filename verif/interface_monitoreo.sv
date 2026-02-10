interface interface_monitoreo(input logic clk, input logic arst_n);
    logic signed [10:0] temp_entrada;
    logic alerta, calefactor, ventilador;
    logic [1:0] estado_actual;

    // Tarea 1.......
    task enviar_temperatura(input int valor);
        @(negedge clk);
        temp_entrada = valor;
        $display("[INTERFACE] Enviando T = %0d", valor);
    endtask
    
endinterface
