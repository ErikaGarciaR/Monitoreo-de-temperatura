package monitoreo_pkg;
    // Parámetros de límites de alerta
    parameter TEMP_BAJO = 180; 
    parameter TEMP_ALTO = 259; 

    // Límites  de operación del sensor
    parameter MIN_SENSOR = -400;
    parameter MAX_SENSOR = 850;

    // --- Clase padre
    class temp_base;
        rand logic signed [10:0] valor;

        // Rango del sensor
        constraint c_fisico { valor inside {[MIN_SENSOR: MAX_SENSOR ]}; }

        function new();
            this.valor = 0;
        endfunction

        // Visualizacion de dato en consola
        virtual function void reportar();
            $display("[monitoreo_pkg] Temperatura Generada: %0d.%0d C", valor/10, valor%10);
        endfunction
    endclass

    // --- Clases Hijas

    class temp_bajo extends temp_base;
        constraint c_rango { valor < TEMP_BAJO; }

        virtual function void reportar();
            $display("[ESTADO: FRIO] registrando temperatura baja: %0d.%0d C", valor/10, valor%10);
        endfunction

    endclass

    class temp_normal extends temp_base;
        constraint c_rango { valor inside {[TEMP_BAJO : TEMP_ALTO]}; }

        virtual function void reportar();
            $display("[ESTADO: NORMAL] registrando temperatura estable: %0d.%0d C", valor/10, valor%10);
        endfunction

    endclass

    class temp_alto extends temp_base;
        constraint c_rango { valor > TEMP_ALTO; }

        virtual function void reportar();
            $display("[ESTADO: ALTO] registrando temperatura alta: %0d.%0d C", valor/10, valor%10);
        endfunction

    endclass

endpackage : monitoreo_pkg