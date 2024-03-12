CREATE DATABASE exercicio1;
USE exercicio1;

-- Criar tabela vendedores
-- Criar tabela vendedores
CREATE TABLE vendedores (
    id_vendedor INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    numero INT NOT NULL,
    nome VARCHAR(30) NOT NULL,
    idade_vendedor INT NOT NULL,
    salario DECIMAL(5,2) NOT NULL
);

-- Criar tabela clientes
CREATE TABLE clientes (
    id_cliente TINYINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    numero TINYINT NOT NULL,
    cidade VARCHAR(30) NOT NULL,
    tipo VARCHAR(30) NOT NULL
);

-- Criar tabela pedidos
CREATE TABLE pedidos (
    id_pedido TINYINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    numero_pedido TINYINT NOT NULL,
    numero_vendedor INT NOT NULL,
    numero_cliente TINYINT NOT NULL,
    qtd_itens SMALLINT NOT NULL,
    valor_total DECIMAL(8,2) NOT NULL,
    FOREIGN KEY (numero_vendedor) REFERENCES vendedores(id_vendedor),
    FOREIGN KEY (numero_cliente) REFERENCES clientes(id_cliente)
);


-- Inserir dados nas tabelas
INSERT INTO vendedores (numero, nome, idade_vendedor, salario) 
VALUES (1, 'João', 35, 3000.00),
       (2, 'Maria', 28, 2500.00),
       (3, 'José', 40, 3500.00);

INSERT INTO clientes (numero, cidade, tipo) 
VALUES (1, 'São Paulo', 'Pessoa Física'),
       (2, 'Rio de Janeiro', 'Pessoa Jurídica'),
       (3, 'Belo Horizonte', 'Pessoa Física');

INSERT INTO pedidos (numero_pedido, numero_vendedor, numero_cliente, qtd_itens, valor_total) 
VALUES (101, 1, 1, 5, 150.00),
       (102, 2, 2, 3, 200.00),
       (103, 3, 3, 7, 300.00);

-- Consultas utilizando INNER JOIN

-- 4. Nomes dos vendedores que realizaram pedido para clientes do tipo "INDUSTRIA"
SELECT DISTINCT v.nome
FROM vendedores v
INNER JOIN pedidos p ON v.numero = p.numero_vendedor
INNER JOIN clientes c ON p.numero_cliente = c.numero AND c.tipo = 'INDUSTRIA';

-- 5. Tipo do cliente que foi atendido (realizou pedido) pelo vendedor "JOÃO"
SELECT c.tipo
FROM clientes c
INNER JOIN pedidos p ON c.numero = p.numero_cliente
INNER JOIN vendedores v ON p.numero_vendedor = v.numero
WHERE v.nome = 'João';

-- 6. Nomes e tipos dos clientes com pedidos acima de 5000 reais
SELECT c.nome, c.tipo
FROM clientes c
INNER JOIN pedidos p ON c.numero = p.numero_cliente
WHERE p.valor_total > 5000;

-- Consultas utilizando LEFT JOIN

-- 4. Nomes dos vendedores que realizaram pedido para clientes do tipo "INDUSTRIA"
SELECT DISTINCT v.nome
FROM vendedores v
LEFT JOIN pedidos p ON v.numero = p.numero_vendedor
LEFT JOIN clientes c ON p.numero_cliente = c.numero AND c.tipo = 'INDUSTRIA'
WHERE c.tipo IS NOT NULL;

-- 5. Tipo do cliente que foi atendido (realizou pedido) pelo vendedor "JOÃO"
SELECT c.tipo
FROM clientes c
LEFT JOIN pedidos p ON c.numero = p.numero_cliente
LEFT JOIN vendedores v ON p.numero_vendedor = v.numero
WHERE v.nome = 'João';

-- 6. Nomes e tipos dos clientes com pedidos acima de 5000 reais
SELECT c.nome, c.tipo
FROM clientes c
LEFT JOIN pedidos p ON c.numero = p.numero_cliente
WHERE p.valor_total > 5000;
