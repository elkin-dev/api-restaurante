SELECT *
  FROM mesa;TRUNCATE TABLE mesa CASCADE;TRUNCATE TABLE mesa RESTART IDENTITY CASCADE;SELECT count(*) --

  FROM (
        SELECT a.des_nombre,
               a.des_apellido,
               b.fk_id_cliente,
               b.fk_id_mesa
          FROM cliente AS a
         INNER JOIN reserva AS b
            ON a.pk_id_cliente = b.fk_id_cliente
       )AS dual;SELECT count(*)
  FROM (
        SELECT a.des_nombre,
               a.des_direccion,
               b.num_numero_mesa,
               b.num_capacidad,
               c.pk_id_reserva
          FROM restaurante a
         INNER JOIN mesa b
            ON a.pk_id_restaurante = b.fk_id_restaurante
         INNER JOIN reserva c
            ON c.fk_id_mesa = b.pk_id_mesa
       )AS dual;
       
       -- Aca en este punto se puede ver un claro ejemplo de un left join entre la tabla restaurante y mesa hay 371 registros que no cruzan
SELECT count(*) AS conteo_left
  FROM (
        SELECT a.pk_id_restaurante,
               a.des_nombre,
               a.des_direccion,
               b.pk_id_mesa,
               b.num_numero_mesa,
               b.num_capacidad
          FROM restaurante AS a
          LEFT JOIN mesa AS b
            ON a.pk_id_restaurante = b.fk_id_restaurante
         WHERE b.pk_id_mesa IS NULL
       ) AS dual;
       
-- En este ejemplo vemos el inner join los datos que coinciden entre las dos tablas
SELECT count(*) AS conteo_inner
  FROM (
        SELECT a.pk_id_restaurante,
               a.des_nombre,
               a.des_direccion,
               b.pk_id_mesa,
               b.num_numero_mesa,
               b.num_capacidad
          FROM restaurante AS a
         INNER JOIN mesa AS b
            ON a.pk_id_restaurante = b.fk_id_restaurante
         WHERE b.pk_id_mesa IS NOT NULL
       ) AS dual;
       
-- Aca vemos el el right si lo contamos va a tener los mismos valores del inner 
SELECT a.pk_id_restaurante,
       a.des_nombre,
       a.des_direccion,
       b.pk_id_mesa,
       b.num_numero_mesa,
       b.num_capacidad
  FROM restaurante AS a
 RIGHT JOIN mesa AS b
    ON a.pk_id_restaurante = b.fk_id_restaurante



SELECT count(*)
  FROM (
        SELECT a.pk_id_cliente,
               a.des_nombre,
               b.pk_id_reserva
          FROM cliente a
          left  JOIN reserva b
            ON a.pk_id_cliente = b.fk_id_cliente
         WHERE b.fk_id_cliente IS NULL
       ) AS dual;
       
       
SELECT a.pk_id_cliente,
               a.des_nombre,
               b.pk_id_reserva
          FROM cliente a
          left  JOIN reserva b
            ON a.pk_id_cliente = b.fk_id_cliente
         WHERE b.fk_id_cliente IS NULL