-- Vistas VOLATIL (siempre va ha hacer la  consulta en la base de datos teniendo siempre información reciente)
 CREATE VIEW public.vw_rango AS SELECT *,
       CASE WHEN des_nombre = 'Elkin' THEN 'Hola ELkin como estas?'
            ELSE 'No eres el(:'
             END
  FROM cliente
 WHERE pk_id_cliente BETWEEN 1 AND 10;SELECT *
  FROM vw_rango;-- Vista MATERIALIZADA (Solamente hace la consulta una vez y esa información queda almacenada en memoria la siguiente vez que se consulte va a traer la info de memoria)
 SELECT *
  FROM vw_rango;
  
  SELECT *
  FROM restaurante;
  
CREATE materialized VIEW vw_des_nombres_start_e AS SELECT des_nombre,
       des_direccion
  FROM restaurante
 WHERE des_nombre ilike 'e%' WITH NO DATA;
 
 
 
 SELECT * FROM vw_des_nombres_start_e;
 
 REFRESH MATERIALIZED VIEW vw_des_nombres_start_e;
 
 
 DELETE FROM restaurante 
 
 
 select * from restaurante
 where des_nombre = 'Eire';
 
DELETE
  FROM restaurante
 WHERE pk_id_restaurante = 14
   AND pk_id_restaurante = 22;
   
INSERT INTO cliente (
    pk_id_cliente,
    des_nombre,
    des_apellido,
    des_telefono,
    des_email,
    fec_creacion,
    fec_actualizacion
  )
VALUES (
    pk_id_cliente:integer,
    'des_nombre:character varying',
    'des_apellido:character varying',
    'des_telefono:character varying',
    'des_email:character varying',
    'fec_creacion:timestamp without time zone',
    'fec_actualizacion:timestamp without time zone'
  );select *
FROM restaurante
 WHERE pk_id_restaurante = 14
   AND pk_id_restaurante = 22;


select * from cliente;