-- Criar o banco de dados para o exercício 2
CREATE DATABASE exercicio2;
USE exercicio2;

-- Criar tabela ALUNO
CREATE TABLE ALUNO (
    aluno_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    curso VARCHAR(50) NOT NULL,
    nivel VARCHAR(50) NOT NULL,
    idade INT NOT NULL
);

-- Criar tabela TURMA
CREATE TABLE TURMA (
    turma_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nometurma VARCHAR(50) NOT NULL,
    sala VARCHAR(20) NOT NULL,
    horario VARCHAR(20) NOT NULL
);

-- Criar tabela MATRÍCULA
CREATE TABLE MATRICULA (
    matricula_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    aluno_id INT NOT NULL,
    turma_id INT NOT NULL,
    nota1 FLOAT,
    nota2 FLOAT,
    nota3 FLOAT,
    nota_final FLOAT,
    nr_faltas INT,
    FOREIGN KEY (aluno_id) REFERENCES ALUNO(aluno_id),
    FOREIGN KEY (turma_id) REFERENCES TURMA(turma_id)
);

-- Inserir dados nas tabelas

-- Inserir dados na tabela ALUNO
INSERT INTO ALUNO (nome, curso, nivel, idade) 
VALUES ('João', 'Engenharia', 'Graduação', 22),
       ('Maria', 'Medicina', 'Graduação', 25),
       ('Pedro', 'Administração', 'Pós-graduação', 30),
       ('Ana', 'Direito', 'Graduação', 23);

-- Inserir dados na tabela TURMA
INSERT INTO TURMA (nometurma, sala, horario)
VALUES ('Matemática', '101', 'Segunda-feira, 14:00'),
       ('História', '202', 'Terça-feira, 10:00'),
       ('Física', '303', 'Quarta-feira, 16:00'),
       ('Química', '404', 'Quinta-feira, 08:00');

-- Inserir dados na tabela MATRÍCULA
INSERT INTO MATRICULA (aluno_id, turma_id, nota1, nota2, nota3, nota_final, nr_faltas)
VALUES (1, 1, 8.5, 7.5, 9.0, 8.0, 2),
       (2, 2, 7.0, 6.5, 8.0, 7.5, 3),
       (3, 3, 9.0, 8.5, 9.5, 9.0, 1),
       (4, 4, 6.0, 7.0, 6.5, 6.5, 4);

-- Consultas

-- 1. Quais os nomes de todos os alunos?
SELECT nome FROM ALUNO;

-- 2. Quais os números das matrículas dos alunos?
SELECT matricula_id FROM MATRICULA;

-- 3. Quais os números das matrículas dos alunos que não estão matriculados em uma turma?
SELECT matricula_id FROM MATRICULA WHERE turma_id IS NULL;

-- 4. Quais os números dos alunos matriculados em uma turma de número '30'?
SELECT aluno_id FROM MATRICULA WHERE turma_id = 30;

-- 5. Qual o horário da turma do aluno MEDINHO?
SELECT TURMA.horario
FROM ALUNO
JOIN MATRICULA ON ALUNO.aluno_id = MATRICULA.aluno_id
JOIN TURMA ON MATRICULA.turma_id = TURMA.turma_id
WHERE ALUNO.nome = 'JOAO';

-- 6. Quais os nomes dos alunos matriculados em uma turma de número 30?
SELECT ALUNO.nome
FROM ALUNO
JOIN MATRICULA ON ALUNO.aluno_id = MATRICULA.aluno_id
WHERE MATRICULA.turma_id = 30;

-- 7. Quais os nomes dos alunos que não estão matriculados na turma de número 30?
SELECT ALUNO.nome
FROM ALUNO
LEFT JOIN MATRICULA ON ALUNO.aluno_id = MATRICULA.aluno_id AND MATRICULA.turma_id = 30
WHERE MATRICULA.matricula_id IS NULL;

-- 8. Quais os nomes das turmas com alunos com nota final maior que 8?
SELECT TURMA.nometurma
FROM TURMA
JOIN MATRICULA ON TURMA.turma_id = MATRICULA.turma_id
WHERE MATRICULA.nota_final > 8;
