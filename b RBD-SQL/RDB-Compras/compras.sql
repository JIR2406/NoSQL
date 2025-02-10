DROP TABLE compras;
DROP TABLE clientes;
DROP TABLE productos;

----------------------------------
-- DDL, Data Definition Language
----------------------------------

CREATE TABLE clientes
(
    id         INTEGER PRIMARY KEY
   ,nombre     VARCHAR(100) NOT NULL
   ,direccion  VARCHAR(200)
);

CREATE TABLE productos
(
    id         INTEGER PRIMARY KEY
   ,nombre     VARCHAR(200) NOT NULL
   ,precio     FLOAT
);

CREATE TABLE compras
(
    id           INTEGER PRIMARY KEY
   ,cliente_id   INTEGER NOT NULL
   ,producto_id  INTEGER NOT NULL
   ,cantidad     INTEGER NOT NULL
   ,FOREIGN KEY (cliente_id)  REFERENCES clientes(id)
   ,FOREIGN KEY (producto_id) REFERENCES productos(id)
);


----------------------------------
-- DML, Data Manipulation Language
----------------------------------

----------------------------------
-- Creando datos con INSERT
INSERT INTO clientes 
VALUES (101, 'José Pérez Méndez', 'Calle A # 100');
INSERT INTO clientes(id, direccion, nombre)
VALUES (102, 'María López', 'Calle B # 200');

----------------------------------
-- Leyendo datos con SELECT
SELECT *
FROM   clientes;

----------------------------------
-- Actualizando datos con UPDATE
UPDATE clientes SET nombre='María López Martínez', direccion='Calle B # 200'
WHERE  id=102

----------------------------------
-- Borrando datos con UPDATE
DELETE FROM clientes 
WHERE  id=103;

----------------------------------
-- Creando datos en la tabla ```productos```

INSERT INTO productos (id, nombre, precio)
VALUES 
    (1001, 'Camiseta', 10.00),
    (1002, 'Pantalón', 20.00),
    (1003, 'Zapatos',  30.00);

SELECT *
FROM   productos;


----------------------------------
-- Creando datos en la tabla ```compras```

INSERT INTO compras (id, cliente_id, producto_id, cantidad)
VALUES 
    (1, 101, 1001, 2),
    (2, 101, 1003, 1),
    (3, 102, 1002, 1);

SELECT *
FROM   compras;


CREATE VIEW compras_vw AS
    SELECT   cl.id,cl.nombre "Cliente"
            ,p.nombre "producto", p.precio
            ,cp.cantidad, p.precio * cp.cantidad "Subtotal" 
    FROM    compras cp, clientes cl, productos p
    WHERE        cp.cliente_id=cl.id
            AND  cp.producto_id=p.id;

CREATE VIEW compras_cliente_vw AS
    SELECT  cliente, SUM(subtotal)  
    FROM    compras_vw
    GROUP BY cliente;

SELECT *
FROM   compras_cliente_vw;













