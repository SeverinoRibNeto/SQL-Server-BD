/***************************/
/*Criação da Base de Dados*/
/*************************/
USE [master]
GO
DROP DATABASE [ProjetoEscolaBD]
GO
-- COMANDO USADO CASO JÁ EXISTA O BANCO. USADO PARA DELETAR


USE [master]
GO

CREATE DATABASE ProjetoEscolaBD
ON (NAME=ProjetoEscolaBD,
	FILENAME ='C:\Escola\ProjetoEscola.mdf',
	SIZE = 100,
	MAXSIZE = 1024,
	FILEGROWTH=10)
LOG
ON(NAME=log_ProjetoEscolaBD,
	FILENAME='C:\Escola\log_projetoEscolaBD.ldf',
	SIZE = 50,
	MAXSIZE = 1024,
	FILEGROWTH = 10)

/**********************/
/*Criação das Tabelas*/
/********************/

USE [ProjetoEscolaBD]
GO --ESCOLHER A DATABASE PARA SE CRIAR AS TABELAS




--CRIAÇÃO TblTurma

CREATE TABLE TblTurma(
	id INT IDENTITY
	CONSTRAINT PK_TblTurma PRIMARY KEY NOT NULL,
	sala VARCHAR(10) NOT NULL
)
--FIM TblTurma

--CRIAÇÃO TblCurso
CREATE TABLE TblCurso(
	nome VARCHAR(60) NOT NULL,
	codigo INT IDENTITY
	CONSTRAINT PK_TblCurso PRIMARY KEY NOT NULL
)
--FIM TblCurso

--CRIAÇÃO TblCidade
CREATE TABLE TblCidade(
	id INT IDENTITY
	CONSTRAINT PK_TblCidade PRIMARY KEY NOT NULL,
	nome VARCHAR(60) NOT NULL
	
)
--FIM TblCidade

--CRIAÇÃO TblEstado

CREATE TABLE TblEstado(
	nome VARCHAR(60) NOT NULL,
	sigla VARCHAR(2)
	CONSTRAINT PK_TblEstado PRIMARY KEY NOT NULL
)
--FIM TblEstado

--CRIAÇÃO TblProfessor
CREATE TABLE TblProfessor(
	matricula VARCHAR(8) --ANO + MES + INCREMENTO COME�ANDO POR 01
	CONSTRAINT PK_TblProfessor PRIMARY KEY NOT NULL,
	nome VARCHAR(60) NOT NULL,
	telefone VARCHAR(15),
	endereco VARCHAR(200) NOT NULL,
	salario SMALLMONEY NOT NULL,
	sigla_estado VARCHAR(2)
	CONSTRAINT FK_Estado_Professor FOREIGN KEY
	REFERENCES TblEstado(sigla) NOT NULL,
	id_cidade INT 
	CONSTRAINT FK_Cidade_Professor FOREIGN KEY
	REFERENCES TblCidade(id) NOT NULL
)
-- FIM TblProfessor

--CRIAÇÃO TblAluno
CREATE TABLE TblAluno(
	endereco VARCHAR(200) NOT NULL,
	matricula VARCHAR(8) --ANO + INCREMENTO COMEÇANDO POR 01 + MES
	CONSTRAINT PK_TblAluno PRIMARY KEY NOT NULL,
	nome VARCHAR(60) NOT NULL,
	codigo_curso INT
	CONSTRAINT FK_Curso_Aluno FOREIGN KEY
	REFERENCES TblCurso(codigo) NOT NULL,
	sigla_estado VARCHAR(2)
	CONSTRAINT FK_Estado_Aluno FOREIGN KEY
	REFERENCES TblEstado(sigla) NOT NULL,
	id_cidade INT
	CONSTRAINT FK_Cidade_Aluno FOREIGN KEY
	REFERENCES TblCidade(id) NOT NULL,
	id_turma INT
	CONSTRAINT FK_Turma_Aluno FOREIGN KEY
	REFERENCES TblTurma(id) NOT NULL
)

--FIM TblAluno

--CRIAÇÃO TblDisciplina
CREATE TABLE TblDisciplina(
	codigo TINYINT IDENTITY
	CONSTRAINT PK_TblDisciplina PRIMARY KEY NOT NULL,
	nome VARCHAR(60) NOT NULL,
	carga_horaria INT NOT NULL
)
--FIM TblDisciplina


--CRIAÇÃO TblProva
CREATE TABLE TblProva(
	id INT IDENTITY
	CONSTRAINT PK_TblProva PRIMARY KEY NOT NULL,
	nota FLOAT NOT NULL,
	codigo_disciplina TINYINT
	CONSTRAINT FK_Prova_Disciplina FOREIGN KEY
	REFERENCES TblDisciplina(codigo)
)

--FIM TblProva

--CRIAÇÃO TblProfessorMinistra
CREATE TABLE TblProfessorMinistra(
	matricula_professor VARCHAR(8)
	CONSTRAINT FK_ProfessorMinistra_Professor FOREIGN KEY
	REFERENCES TblProfessor(matricula) NOT NULL,
	codigo_disciplina TINYINT
	CONSTRAINT FK_ProfessorMinistra_Disciplina FOREIGN KEY
	REFERENCES TblDisciplina(codigo) NOT NULL,
	CONSTRAINT PK_TblProfessorMinistra PRIMARY KEY(matricula_professor, codigo_disciplina)
)
--FIM TblProfessorMinistra



--CRIAÇÃO TblEnsina
CREATE TABLE TblEnsina(
	id_turma INT
	CONSTRAINT FK_Ensina_Turma FOREIGN KEY
	REFERENCES TblTurma(id) NOT NULL,
	matricula_professor VARCHAR(8)
	CONSTRAINT FK_Ensina_Professor FOREIGN KEY
	REFERENCES TblProfessor(matricula) NOT NULL,
	CONSTRAINT PK_TblEnsina PRIMARY KEY(id_turma, matricula_professor)
)
--FIM TblEnsina


--CRIAÇÃO TblMedia
CREATE TABLE TblMedia(
	matricula_aluno VARCHAR(8)
	CONSTRAINT FK_Media_Aluno FOREIGN KEY
	REFERENCES TblAluno(matricula) NOT NULL,
	codigo_disciplina TINYINT
	CONSTRAINT FK_Media_Disciplina FOREIGN KEY
	REFERENCES TblDisciplina(codigo) NOT NULL,
	media FLOAT,
	CONSTRAINT PK_TblMedia PRIMARY KEY(matricula_aluno,codigo_disciplina)
)
--FIM TblMedia

--CRIAÇÃO TblDisciplinaCurso
CREATE TABLE TblDisciplinaCurso(
	codigo_disciplina TINYINT
	CONSTRAINT FK_DisciplinaCurso_Disciplina FOREIGN KEY
	REFERENCES TblDisciplina(codigo) NOT NULL,
	codigo_curso INT
	CONSTRAINT FK_DisciplinaCurso_Curso FOREIGN KEY
	REFERENCES TblCurso(codigo) NOT NULL,
	CONSTRAINT PK_TblDisciplinaCurso PRIMARY KEY(codigo_disciplina, codigo_curso)
)
--FIM TblDisciplinaCurso

--CRIAÇÃO TblAula
CREATE TABLE TblAula(
	data_aula SMALLDATETIME NOT NULL,
	presenca VARCHAR(1) NOT NULL,
	matricula_aluno VARCHAR(8)
	CONSTRAINT FK_Aluno_Aula FOREIGN KEY
	REFERENCES TblAluno(matricula) NOT NULL,
	codigo_disciplina TINYINT
	CONSTRAINT FK_Disciplina_Aula FOREIGN KEY
	REFERENCES TblDisciplina(codigo) NOT NULL,
	CONSTRAINT PK_TblAula PRIMARY KEY(matricula_aluno, codigo_disciplina, data_aula) 
)

--FIM TblAula

--CRIAÇÃO TblMensalidade
CREATE TABLE TblMensalidade(
	id int IDENTITY
	CONSTRAINT PK_TblMensalidade PRIMARY KEY NOT NULL,
	valor SMALLMONEY NOT NULL,
	data_vencimento SMALLDATETIME NOT NULL,
	valor_pago SMALLMONEY,
	data_pagamento SMALLDATETIME,
	matricula_aluno varchar(8)
	CONSTRAINT FK_Mensalidade_Aluno FOREIGN KEY
	REFERENCES TblAluno(matricula) NOT NULL
)
--FIM TblMensalidade

--CRIAÇÃO TblProvaAluno
CREATE TABLE TblProvaAluno(
	matricula_aluno VARCHAR(8)
	CONSTRAINT FK_ProvaAluno_Aluno FOREIGN KEY
	REFERENCES TblAluno(matricula) NOT NULL,
	id_prova INT
	CONSTRAINT FK_ProvaAluno_Prova FOREIGN KEY
	REFERENCES TblProva(id) NOT NULL,
	CONSTRAINT PK_TblProvaAluno PRIMARY KEY(matricula_aluno, id_prova)
)
--FIM TblProvaAluno

--Alteração TblCidade
USE [ProjetoEscolaBD]
GO	
