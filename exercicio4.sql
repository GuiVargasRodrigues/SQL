-- Criação do banco de dados
CREATE DATABASE exercicio4;
USE exercicio4;

-- Criação da tabela Turmas
CREATE TABLE Turmas (
    codigo_turma INT AUTO_INCREMENT PRIMARY KEY,
    codigo_disciplina INT,
    sigla_turma VARCHAR(10),
    ano_semestre INT
);

-- Criação da tabela Alunos
CREATE TABLE Alunos (
    codigo_aluno INT AUTO_INCREMENT PRIMARY KEY,
    nome_aluno VARCHAR(100)
);

-- Criação da tabela Provas
CREATE TABLE Provas (
    codigo_turma INT,
    numero_prova INT,
    data_prova DATE,
    PRIMARY KEY (codigo_turma, numero_prova),
    FOREIGN KEY (codigo_turma) REFERENCES Turmas(codigo_turma)
);

-- Criação da tabela Notas
CREATE TABLE Notas (
    codigo_turma INT,
    codigo_aluno INT,
    numero_prova INT,
    nota DECIMAL(5,2),
    PRIMARY KEY (codigo_turma, codigo_aluno, numero_prova),
    FOREIGN KEY (codigo_turma, numero_prova) REFERENCES Provas(codigo_turma, numero_prova),
    FOREIGN KEY (codigo_aluno) REFERENCES Alunos(codigo_aluno)
);

-- Inserts para a tabela Turmas
INSERT INTO Turmas (codigo_turma, codigo_disciplina, sigla_turma, ano_semestre)
VALUES (1, 101, 'A', 2023),
       (2, 102, 'B', 2023),
       (3, 103, 'C', 2024);

-- Inserts para a tabela Alunos
INSERT INTO Alunos (codigo_aluno, nome_aluno)
VALUES (1, 'João Silva'),
       (2, 'Maria Oliveira'),
       (3, 'Pedro Santos');

-- Inserts para a tabela Provas
INSERT INTO Provas (codigo_turma, numero_prova, data_prova)
VALUES (1, 1, '2023-03-15'),
       (1, 2, '2023-04-20'),
       (2, 1, '2023-03-18'),
       (2, 2, '2023-04-22'),
       (3, 1, '2024-03-10'),
       (3, 2, '2024-04-15');

-- Inserts para a tabela Notas
INSERT INTO Notas (codigo_turma, codigo_aluno, numero_prova, nota)
VALUES (1, 1, 1, 8.5),
       (1, 1, 2, 7.0),
       (1, 2, 1, 6.0),
       (1, 2, 2, 8.0),
       (1, 3, 1, 9.0),
       (1, 3, 2, 9.5),
       (2, 1, 1, 7.5),
       (2, 1, 2, 8.0),
       (2, 2, 1, 6.5),
       (2, 2, 2, 7.5),
       (2, 3, 1, 8.0),
       (2, 3, 2, 9.0),
       (3, 1, 1, 9.0),
       (3, 1, 2, 8.5),
       (3, 2, 1, 8.0),
       (3, 2, 2, 7.0),
       (3, 3, 1, 7.5),
       (3, 3, 2, 6.5);

-- Consulta: Selecionar todas as turmas e suas informações
SELECT * FROM Turmas;

-- Consulta: Selecionar todos os alunos e seus códigos
SELECT * FROM Alunos;

-- Consulta: Selecionar todas as provas e suas datas
SELECT * FROM Provas;

-- Consulta: Selecionar todas as notas dos alunos em todas as turmas e provas
SELECT * FROM Notas;

-- Consulta: Selecionar o nome do aluno e a nota obtida em cada prova por turma
SELECT Alunos.nome_aluno, Turmas.sigla_turma, Provas.numero_prova, Notas.nota
FROM Notas
JOIN Alunos ON Notas.codigo_aluno = Alunos.codigo_aluno
JOIN Turmas ON Notas.codigo_turma = Turmas.codigo_turma
JOIN Provas ON Notas.codigo_turma = Provas.codigo_turma AND Notas.numero_prova = Provas.numero_prova;

-- Consulta: Selecionar a média das notas de cada aluno em cada turma
SELECT Alunos.nome_aluno, Turmas.sigla_turma, AVG(Notas.nota) AS media_notas
FROM Notas
JOIN Alunos ON Notas.codigo_aluno = Alunos.codigo_aluno
JOIN Turmas ON Notas.codigo_turma = Turmas.codigo_turma
GROUP BY Alunos.nome_aluno, Turmas.sigla_turma;
