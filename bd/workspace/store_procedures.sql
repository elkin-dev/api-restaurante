-- Esta es una de la forma en la que puedo empezar a crear el sp donde lo puedo ejecutar y probar
DO $$

DECLARE
    MI_VARIABLE RECORD;
BEGIN
    FOR MI_VARIABLE IN (
        SELECT
            *
        FROM
            CLIENTE
    ) LOOP
        RAISE NOTICE 'Un pasajero se llama %', MI_VARIABLE.DES_NOMBRE;
    END LOOP;

    RAISE NOTICE 'El conteo es %', CONTADOR;
END $$;

-- En este punto ya creo la funcion
CREATE OR REPLACE
FUNCTION FIRST_SP_CLIENTE() RETURNS integer AS $CODE$
DECLARE
    MI_VARIABLE RECORD;
    CONTADOR    INTEGER := 0;
BEGIN
    FOR MI_VARIABLE IN (
        SELECT
            *
        FROM
            CLIENTE
    ) LOOP
        RAISE NOTICE 'Un pasajero se llama %', MI_VARIABLE.DES_NOMBRE;
        CONTADOR := CONTADOR + 1;
    END LOOP;

    RAISE NOTICE 'El conteo es %', CONTADOR;
    RETURN CONTADOR;
END $CODE$ LANGUAGE PLPGSQL;

-- llamo la funcion o sp --Create a new Procedure
 -- Procedure definition
SELECT FIRST_SP_CLIENTE();

DROP FUNCTION first_sp_cliente()

