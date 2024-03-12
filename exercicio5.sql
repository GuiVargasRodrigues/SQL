CREATE DATABASE exercicio5;
USE exercicio5;


CREATE TABLE Curso (
    id_curso INT PRIMARY KEY,
    nome_curso VARCHAR(100)
);

CREATE TABLE Turma (
    id_turma INT PRIMARY KEY,
    id_curso INT,
    quantidade_alunos INT,
    horario_aula VARCHAR(50),
    data_inicial DATE,
    data_final DATE,
    FOREIGN KEY (id_curso) REFERENCES Curso(id_curso)
);

CREATE TABLE Professor (
    cpf VARCHAR(11) PRIMARY KEY,
    nome VARCHAR(100),
    data_nascimento DATE,
    titulacao VARCHAR(50)
);

CREATE TABLE TelefoneProfessor (
    cpf VARCHAR(11),
    telefone VARCHAR(20),
    FOREIGN KEY (cpf) REFERENCES Professor(cpf)
);

CREATE TABLE Aluno (
    codigo_matricula INT PRIMARY KEY,
    data_matricula DATE,
    nome VARCHAR(100),
    endereco VARCHAR(200),
    telefone VARCHAR(20),
    data_nascimento DATE,
    altura DECIMAL(5,2),
    peso DECIMAL(5,2)
);

CREATE TABLE Turma_Aluno (
    id_turma INT,
    codigo_matricula INT,
    monitor BOOLEAN,
    FOREIGN KEY (id_turma) REFERENCES Turma(id_turma),
    FOREIGN KEY (codigo_matricula) REFERENCES Aluno(codigo_matricula),
    PRIMARY KEY (id_turma, codigo_matricula)
);

CREATE TABLE Registro_Ausencias (
     id_registro INT PRIMARY KEY,
    codigo_matricula INT,
    data_ausencia DATE,
    FOREIGN KEY (codigo_matricula) REFERENCES Aluno(codigo_matricula)
);

-- Inserção de dados de exemplo

INSERT INTO Curso (id_curso, nome_curso) VALUES
(1, 'Curso de Programação em Java'),
(2, 'Curso de Desenvolvimento Web'),
(3, 'Curso de Banco de Dados');

INSERT INTO Turma (id_turma, id_curso, quantidade_alunos, horario_aula, data_inicial, data_final) VALUES
(1, 1, 20, 'Segunda-feira 18:00-20:00', '2024-03-01', '2024-06-01'),
(2, 2, 15, 'Terça-feira 14:00-16:00', '2024-03-05', '2024-06-05'),
(3, 3, 10, 'Quarta-feira 19:00-21:00', '2024-03-10', '2024-06-10');

INSERT INTO Professor (cpf, nome, data_nascimento, titulacao) VALUES
('12345678901', 'João Silva', '1980-05-15', 'Mestre'),
('23456789012', 'Maria Souza', '1975-10-20', 'Doutor');

INSERT INTO TelefoneProfessor (cpf, telefone) VALUES
('12345678901', '9999-8888'),
('23456789012', '7777-6666');

INSERT INTO Aluno (codigo_matricula, data_matricula, nome, endereco, telefone, data_nascimento, altura, peso) VALUES
(1001, '2024-02-15', 'Pedro Oliveira', 'Rua A, 123', '1111-2222', '2000-01-10', 1.75, 70.5),
(1002, '2024-02-17', 'Ana Santos', 'Rua B, 456', '3333-4444', '2001-03-20', 1.65, 55.0),
(1003, '2024-02-20', 'Carlos Mendes', 'Rua C, 789', '5555-6666', '1999-07-05', 1.80, 80.0);

INSERT INTO Turma_Aluno (id_turma, codigo_matricula, monitor) VALUES
(1, 1001, TRUE),
(1, 1002, FALSE),
(2, 1002, TRUE),
(3, 1003, TRUE);

INSERT INTO Registro_Ausencias (id_registro, codigo_matricula, data_ausencia) VALUES
(1, 1001, '2024-03-08'),
(2, 1002, '2024-03-10'),
(3, 1003, '2024-03-15');