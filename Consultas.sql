
--CONSULTAS

-- 1- Consulta mostra todas as diciplinas e seus cursos.
SELECT c.nome Curso, d.nome NomeDisciplina
FROM
TblDisciplina d
INNER JOIN
TblDisciplinaCurso dc
ON
dc.codigo_disciplina=d.codigo --Junção com a tabela Disciplina
INNER JOIN
TblCurso c
ON
dc.codigo_curso=c.codigo --Junção com a tabela Curso
ORDER BY Curso 

-- 2- Consulta mostra o aluno e a média nas matérias
SELECT a.nome as Aluno, d.nome as Disciplina,m.media
FROM
TblMedia m
INNER JOIN TblAluno a
ON m.matricula_aluno=a.matricula
INNER JOIN TblDisciplina d
ON m.codigo_disciplina = d.codigo
ORDER BY a.nome, d.nome

--3- Consulta mostra o nome, nota e disciplina de todos os alunos;
SELECT a.nome AS Aluno, p.nota AS Nota, d.nome AS Disciplina
FROM
TblProva p
INNER JOIN
TblDisciplina d
ON p.codigo_disciplina=d.codigo--Junção da tabela disciplina com prova
INNER JOIN
TblProvaAluno pa
ON pa.id_prova=p.id--junção da tabela prova com aluno
INNER JOIN
TblAluno a
ON pa.matricula_aluno= a.matricula --Junção da tabela aluno, para se pegar o nome
ORDER BY a.nome, p.nota

-- 4- Consulta os professores que ensinam as matérias e o curso da materia

SELECT p.nome AS Professor, d.nome AS Disciplina, c.nome as Curso
FROM
TblProfessor p
INNER JOIN
TblProfessorMinistra pm
ON
pm.matricula_professor=p.matricula
INNER JOIN
TblDisciplina d
ON
pm.codigo_disciplina=d.codigo
INNER JOIN
TblDisciplinaCurso dp
ON
dp.codigo_curso=d.codigo
INNER JOIN
TblCurso c
ON
dp.codigo_curso=c.codigo
GROUP BY p.nome,d.nome,c.nome,p.matricula
ORDER BY p.matricula

-- 5- Consulta mostra nome do aluno, valor da mensalidade e o dia do vencimento delas
SELECT a.nome AS Aluno, m.valor AS Valor, m.data_vencimento
FROM
TblMensalidade m
INNER JOIN
TblAluno a
ON
m.matricula_aluno=a.matricula



-- 6- Consulta mostra nome dos alunos, disciplinas e o dia que eles faltaram
SELECT al.nome AS Aluno, d.nome AS Disciplina, a.data_aula AS Dia, a.presenca
FROM
TblAula a
INNER JOIN
TblAluno al
ON
a.matricula_aluno=al.matricula
INNER JOIN
TblDisciplina d
ON
a.codigo_disciplina=d.codigo
WHERE a.presenca='f'

-- 7- Consulta mostra o nome do professor, cidade e estado que ele vive
SELECT p.nome AS Professor, c.nome AS Cidade, e.nome AS Estado
FROM
TblProfessor p
INNER JOIN
TblCidade c
ON
p.id_cidade=c.id
INNER JOIN
TblEstado e
ON
p.sigla_estado=e.sigla


-- 8-Mostra o nome, nome da cidade e do estado em que os alunos residem
SELECT a.nome AS Aluno, c.nome AS Cidade, e.nome AS Estado
FROM
TblAluno a
INNER JOIN
TblCidade c
ON
a.id_cidade=c.id
INNER JOIN
TblEstado e
ON
a.sigla_estado=e.sigla


-- 9-Mostra o total de faltas dos alunos em nas disciplinas
SELECT al.nome AS Aluno, d.nome AS Disciplina, COUNT(a.presenca) AS FaltasTotais
FROM
TblAula a
INNER JOIN
TblAluno al
ON
a.matricula_aluno=al.matricula
INNER JOIN
TblDisciplina d
ON
a.codigo_disciplina=d.codigo
WHERE a.presenca='f'
GROUP BY al.nome, d.nome

-- 10- Mostra nome do aluno, curso e sala que ele pertence
SELECT a.nome AS Aluno, c.nome AS Curso, t.sala AS Sala
FROM
TblAluno a
INNER JOIN
TblCurso c
ON
a.codigo_curso=c.codigo
INNER JOIN
TblTurma t
ON
a.id_turma=t.id