`timescale 1ns / 1ps

module registro_temp (
    input logic clk,                            // reloj del sistema
    input logic arst_n,                         // reset asincrono
    input logic signed [10:0] temp_entrada,     // temperatura digitalizada (-400 a 850)
    input logic fuera_rango,                    // indica que temperatura está fuera del rango normal
    output logic signed [10:0] temp_registrado, // valor almacenado de temperatura
    output logic [2:0] contador_fuera_rango     // contador de persistencia
);

    // Guarda la temperatura y controla el contador
    always_ff @( posedge clk, negedge arst_n) begin
        if (!arst_n) begin
            temp_registrado <= 0;
            contador_fuera_rango <= 0;
        end else begin
            
            temp_registrado <= temp_entrada;  // almacena el valor actual de temperatura

            // contador para checar la persistencia de la temperatura
            if (fuera_rango)     // si fuera_rango=1 indica que la temperatura registrada se encuentra fuera del rango normal
                contador_fuera_rango <= contador_fuera_rango + 1; // se incrementa el contador
            else
                contador_fuera_rango <= 0;  // indica que la temperatura registrada esta dentro del rango normal
        end
    end

endmodule