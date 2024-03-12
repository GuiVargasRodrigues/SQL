CREATE DATABASE exercicio3;
USE exercicio3;

CREATE TABLE empregado (
    idemp INT PRIMARY KEY,
    nomeemp VARCHAR(50),
    aniversario DATE,
    enderecoemp VARCHAR(100),
    sexoemp CHAR(1),
    salarioemp DECIMAL(10, 2),
    nrdep INT
);

CREATE TABLE departamento (
    nrdep INT PRIMARY KEY,
    nomedep VARCHAR(50),
    idgerente INT,
    horario VARCHAR(50)
);

CREATE TABLE localizacao (
    localizacao VARCHAR(100),
    nrdep INT,
    FOREIGN KEY (nrdep) REFERENCES departamento(nrdep)
);

CREATE TABLE trabalha_em (
    idemp INT,
    nrprojeto INT,
    horas INT,
    PRIMARY KEY (idemp, nrprojeto),
    FOREIGN KEY (idemp) REFERENCES empregado(idemp),
    FOREIGN KEY (nrprojeto) REFERENCES projeto(nrproj)
);

CREATE TABLE projeto (
    nrproj INT PRIMARY KEY,
    nomeproj VARCHAR(100),
    nrdep INT,
    FOREIGN KEY (nrdep) REFERENCES departamento(nrdep)
);

CREATE TABLE dependente (
    iddepende INT PRIMARY KEY,
    idemp INT,
    nomedep VARCHAR(50),
    sexodep CHAR(1),
    aniversariodep DATE,
    parentesco VARCHAR(50),
    FOREIGN KEY (idemp) REFERENCES empregado(idemp)
);

-- Inserção de alguns dados de exemplo
INSERT INTO empregado VALUES (1, 'João', '1990-05-15', 'Rua A, 123', 'M', 3000.00, 1);
INSERT INTO empregado VALUES (2, 'Maria', '1985-10-20', 'Rua B, 456', 'F', 3500.00, 2);

INSERT INTO departamento VALUES (1, 'Compras', 1, '08:00 - 17:00');
INSERT INTO departamento VALUES (2, 'Vendas', 2, '09:00 - 18:00');

INSERT INTO localizacao VALUES ('Rio de Janeiro', 1);
INSERT INTO localizacao VALUES ('São Paulo', 2);

INSERT INTO trabalha_em VALUES (1, 1, 40);
INSERT INTO trabalha_em VALUES (2, 2, 45);

INSERT INTO projeto VALUES (1, 'Projeto A', 1);
INSERT INTO projeto VALUES (2, 'Projeto B', 2);

INSERT INTO dependente VALUES (1, 1, 'Filho', 'M', '2010-03-10', 'Filho');
INSERT INTO dependente VALUES (2, 2, 'Filha', 'F', '2012-07-15', 'Filha');

-- Consultas solicitadas

-- 1. Recuperar o nome e o endereço de todos os empregados que trabalham para o Departamento de Compras.
SELECT EMPREGADO.nomeemp, EMPREGADO.enderecoemp
FROM EMPREGADO
JOIN TRABALHA_EM ON EMPREGADO.idemp = TRABALHA_EM.idemp
JOIN DEPARTAMENTO ON TRABALHA_EM.nrprojeto = DEPARTAMENTO.nrdep
WHERE DEPARTAMENTO.nomedep = 'Compras';

-- 2. Para cada projeto localizado no 'Rio de Janeiro', exibir o número do projeto, o número do departamento que o controla e a identidade de seu gerente, seu endereço e a data de seu aniversário.
SELECT PROJETO.nrproj, PROJETO.nrdep, DEPARTAMENTO.idgerente, EMPREGADO.enderecoemp, EMPREGADO.aniversario
FROM PROJETO
JOIN DEPARTAMENTO ON PROJETO.nrdep = DEPARTAMENTO.nrdep
JOIN EMPREGADO ON DEPARTAMENTO.idgerente = EMPREGADO.idemp
JOIN LOCALIZACAO ON PROJETO.nrdep = LOCALIZACAO.nrdep
WHERE LOCALIZACAO.localizacao = 'Rio de Janeiro';

-- 3. Descobrir os nomes dos projetos onde trabalham empregados com o nome 'João'.
SELECT DISTINCT PROJETO.nomeproj
FROM PROJETO
JOIN TRABALHA_EM ON PROJETO.nrproj = TRABALHA_EM.nrprojeto
JOIN EMPREGADO ON TRABALHA_EM.idemp = EMPREGADO.idemp
WHERE EMPREGADO.nomeemp = 'João';
