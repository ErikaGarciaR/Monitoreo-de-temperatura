`timescale 1ns / 1ps



module monitoreo_top(
    input  logic clk,                        // Reloj del sistema
    input  logic arst_n,                     // Reset asíncrono (activo en bajo)
    input  logic signed [10:0] temp_entrada, // Temperatura cruda del sensor
    output logic alerta,                     // Indicador general de falla
    output logic calefactor,                 // Señal  para frío
    output logic ventilador,                 // Señal para calor
    output logic estado_actual               // Monitoreo del estado
    
 );
    logic signed [10:0] temp_registrada_int;
    logic [2:0]         contador_int;
    logic               fuera_rango_int;


    // Almacena la temperatura y gestiona el contador de persistencia
    registro_temp registra1(
        .clk                 (clk),
        .arst_n              (arst_n),
        .temp_entrada        (temp_entrada),
        .fuera_rango         (fuera_rango_int),
        .temp_registrado     (temp_registrada_int),
        .contador_fuera_rango(contador_int)
    );


    // Compara la temperatura registrada contra los límites
    comparador_temp compara1 (
        .temp_reg            (temp_registrada_int),
        .fuera_rango         (fuera_rango_int)
    );


    // Decide el estado y activa los actuadores si persiste el error
    estado_temp fsm1 (
        .clk                 (clk),
        .arst_n              (arst_n),
        .temp_registrado     (temp_registrada_int),
        .contador_fuera_rango(contador_int),
        .alerta              (alerta),
        .calefactor          (calefactor),
        .ventilador          (ventilador),
        .estado_actual       (estado_actual)
    );

  
    
endmodule
