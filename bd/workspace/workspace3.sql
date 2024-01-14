INSERT INTO public.cliente(pk_id_cliente, des_nombre, des_apellido, des_telefono, des_email)
VALUES (1, 'Elkin', 'Jaramillo', '3233217865', 'elkin@mail.com')
    ON
CONFLICT (pk_id_cliente) DO UPDATE
   SET des_nombre = 'Elkin',
       des_apellido = 'Jaramillo',
       des_telefono = '3233217865',
       des_email = 'elkin@mail.com' ;
       
       
INSERT INTO public.cliente(des_nombre, des_apellido, des_telefono, des_email)
VALUES ('RET', 'TESTs', '89584357', 'RET@mail.com') RETURNING *;

SELECT *
  FROM cliente;
  
SELECT
    * 
FROM cliente
WHERE pk_id_cliente between 1000 and 1010;

SELECT des_nombre
  FROM cliente
 WHERE des_nombre ilike 'e%'
   and des_nombre like '%n';
