-- COALESCE permite comparar dos valores y retornar cual de los dos valores es nulo
-- NULLIF permite conparar dos valores y devuelve nullif si los dos valores son iguales
-- GREATEST permite comparar un arreglo de valores y retorna el valor mayor
-- LEAST permite comparar un arreglo de valores y retorna el valor menor
-- BLOQUES ANONIMOS permite ingresar condicionales a traves de una consulta de base de datos
 UPDATE cliente
   SET des_apellido = NULL
 WHERE pk_id_cliente = 2 ;
 
 SELECT coalesce(des_apellido, 'No aplica') AS des_apellido,
       a.des_telefono,
       a.des_email
  FROM cliente a
 WHERE pk_id_cliente = 2;
 
 SELECT NULLIF (0, 0);
 
 SELECT greatest(1, 39, 9, 453, 3);
 
 SELECT least(1, 39, 9, 453, 3);
 
 
SELECT *,
       CASE WHEN des_nombre = 'Elkin' THEN 'Hola ELkin como estas?'
            ELSE 'No eres el(:'
             END
  FROM cliente
 WHERE pk_id_cliente BETWEEN 1 AND 10;
 
SELECT des_nombre,
       des_apellido,
       des_telefono,
       CASE WHEN des_nombre ilike 'r%'                            THEN 'Nombre empieza con R'
            WHEN fec_actualizacion = '2024-01-05 08:05:41.537583' THEN 'Actualizado el 5 enero 2024'
            ELSE 'No clumple'
             END AS condicion
  FROM cliente 
  -- where (des_nombre ILIKE 'r%' OR fec_actualizacion = '2024-01-05 08:05:41.537583')
 WHERE pk_id_cliente BETWEEN 1 AND 10;
 
 
 
 SELECT *
  FROM cliente UPDATE cliente
   SET fec_actualizacion = CURRENT_TIMESTAMP
 WHERE pk_id_cliente = 2 SELECT *
  FROM cliente
 WHERE pk_id_cliente BETWEEN 1 AND 10;