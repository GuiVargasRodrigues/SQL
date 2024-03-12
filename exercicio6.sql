CREATE DATABASE exercicio6;
USE exercicio6;


CREATE TABLE Curso (
  id_curso INT PRIMARY KEY,
  nome_curso VARCHAR(100) NOT NULL,
  descricao TEXT
);

CREATE TABLE Professor (
  cpf VARCHAR(11) PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  data_nascimento DATE,
  titulacao VARCHAR(100)
);

CREATE TABLE Aluno (
  id_aluno INT PRIMARY KEY,
  codigo_matricula INT UNIQUE,
  data_matricula DATE,
  nome VARCHAR(100) NOT NULL,
  endereco VARCHAR(255),
  telefone VARCHAR(20),
  data_nascimento DATE,
  altura DECIMAL(5,2),
  peso DECIMAL(5,2)
);

CREATE TABLE Turma (
  id_turma INT PRIMARY KEY,
  id_curso INT,
  cpf_professor VARCHAR(11),
  id_aluno_monitor INT,
  quantidade_alunos INT,
  horario_aula TIME,
  duracao_aula INT, 
  data_inicial DATE,
  data_final DATE,
  FOREIGN KEY (id_curso) REFERENCES Curso(id_curso),
  FOREIGN KEY (cpf_professor) REFERENCES Professor(cpf),
  FOREIGN KEY (id_aluno_monitor) REFERENCES Aluno(id_aluno)
);

CREATE TABLE Ausencia (
  id_ausencia INT PRIMARY KEY,
  id_aluno INT,
  id_turma INT,
  data_ausencia DATE,
  FOREIGN KEY (id_aluno) REFERENCES Aluno(id_aluno),
  FOREIGN KEY (id_turma) REFERENCES Turma(id_turma)
);

SELECT *
FROM Aluno;

SELECT Aluno.*, Turma.*
FROM Aluno
INNER JOIN Turma ON Aluno.id_aluno = Turma.id_aluno_monitor;

SELECT Aluno.*
FROM Aluno
WHERE Aluno.id_aluno NOT IN (SELECT id_aluno FROM Ausencia);

SELECT Professor.nome, COUNT(Turma.id_turma) AS quantidade_turmas
FROM Professor
LEFT JOIN Turma ON Professor.cpf = Turma.cpf_professor
GROUP BY Professor.nome;

SELECT 
    Professor.nome,
    (SELECT telefone FROM Professor WHERE Professor.cpf = p.cpf) AS telefone,
    t.id_turma, t.data_inicial, t.data_final, t.horario_aula, c.nome_curso, a.nome AS nome_aluno
FROM 
    Turma t
INNER JOIN 
    Professor p ON t.cpf_professor = p.cpf
INNER JOIN 
    Curso c ON t.id_curso = c.id_curso
INNER JOIN 
    Aluno a ON t.id_aluno_monitor = a.id_aluno
ORDER BY 
    Professor.nome, t.id_turma, a.nome;

SELECT 
    Professor.nome,
    Turma.id_turma
FROM 
    Professor
INNER JOIN 
    Turma ON Professor.cpf = Turma.cpf_professor
WHERE 
    Turma.quantidade_alunos = (
        SELECT MAX(quantidade_alunos) FROM Turma WHERE cpf_professor = Professor.cpf
    );

SELECT 
    A.nome AS nome_aluno,
    T.id_turma
FROM 
    Ausencia AS Aus
JOIN 
    Aluno AS A ON Aus.id_aluno = A.id_aluno
JOIN 
    (
        SELECT 
            id_turma,
            id_aluno,
            ROW_NUMBER() OVER(PARTITION BY id_aluno ORDER BY COUNT(id_ausencia) DESC) AS rn
        FROM 
            Ausencia
        GROUP BY 
            id_turma, id_aluno
    ) AS T ON Aus.id_turma = T.id_turma AND Aus.id_aluno = T.id_aluno
WHERE 
    T.rn = 1;

SELECT 
    c.nome_curso,
    AVG(t.quantidade_alunos) AS media_alunos
FROM 
    Curso c
JOIN 
    Turma t ON c.id_curso = t.id_curso
GROUP BY 
    c.nome_curso;

UPDATE Professor
SET nome = UPPER(nome);

UPDATE Aluno
SET nome = UPPER(nome)
WHERE id_aluno IN (
    SELECT id_aluno_monitor 
    FROM Turma 
    WHERE quantidade_alunos = (
        SELECT MAX(quantidade_alunos) FROM Turma
    )
);

DELETE FROM Ausencia
WHERE id_aluno IN (
    SELECT id_aluno_monitor
    FROM Turma
);

-- Inserts for Curso table
INSERT INTO Curso (id_curso, nome_curso, descricao) VALUES
(1, 'Engenharia de Software', 'Curso de graduação em Engenharia de Software'),
(2, 'Ciência da Computação', 'Curso de graduação em Ciência da Computação');

-- Inserts for Professor table
INSERT INTO Professor (cpf, nome, data_nascimento, titulacao) VALUES
('12345678901', 'João Silva', '1980-05-15', 'Doutorado'),
('23456789012', 'Maria Santos', '1975-10-20', 'Mestrado');

-- Inserts for Aluno table
INSERT INTO Aluno (id_aluno, codigo_matricula, data_matricula, nome, endereco, telefone, data_nascimento, altura, peso) VALUES
(1, 1001, '2022-01-10', 'Pedro Oliveira', 'Rua A, 123', '111-1111', '2000-03-20', 1.75, 70.5),
(2, 1002, '2022-01-12', 'Ana Souza', 'Rua B, 456', '222-2222', '2001-05-15', 1.68, 65.2),
(3, 1003, '2022-01-15', 'Carlos Pereira', 'Rua C, 789', '333-3333', '2000-08-25', 1.80, 80.0);

-- Inserts for Turma table
INSERT INTO Turma (id_turma, id_curso, cpf_professor, id_aluno_monitor, quantidade_alunos, horario_aula, duracao_aula, data_inicial, data_final) VALUES
(1, 1, '12345678901', 1, 30, '08:00:00', 60, '2022-02-01', '2022-06-30'),
(2, 2, '23456789012', 2, 25, '10:00:00', 90, '2022-02-05', '2022-07-31');

-- Inserts for Ausencia table
INSERT INTO Ausencia (id_ausencia, id_aluno, id_turma, data_ausencia) VALUES
(1, 2, 1, '2022-03-15'),
(2, 3, 1, '2022-04-20'),
(3, 1, 2, '2022-05-10'),
(4, 2, 2, '2022-06-25');

