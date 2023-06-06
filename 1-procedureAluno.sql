CREATE PROCEDURE sp_add_TblAluno
@nome VARCHAR(60),  @endereco VARCHAR(200), @curso INT, @estado VARCHAR(2), @cidade INT, @turma INT
AS
DECLARE @ano as int, @mes as varchar(2), @digito as int, @matricula VARCHAR(8)
BEGIN
SELECT @ano = CONVERT(INT, YEAR(GETDATE()))
SELECT @digito=(LEFT(RIGHT(MAX(CAST(matricula as int)),4),2) + 1) from TblAluno

IF MONTH(GETDATE())>9 AND @digito>9
BEGIN
	SELECT @matricula = CONCAT(@ano,
						@digito,
						CONVERT(VARCHAR(2),MONTH(GETDATE()))
						)
END
ELSE IF @digito>9 AND MONTH(GETDATE())<10
BEGIN
	SELECT @matricula = CONCAT(@ano,
							@digito,
							'0',
							CONVERT(VARCHAR(1),MONTH(GETDATE()))
							)
END
ELSE
BEGIN
	SELECT @matricula = CONCAT(@ano,
						'0',
						@digito,
						'0',
						CONVERT(VARCHAR(1),MONTH(GETDATE()))
						)
END
INSERT INTO TblAluno(matricula,nome,endereco,codigo_curso,sigla_estado,id_cidade,id_turma) 
VALUES
(@matricula, @nome,@endereco,@curso, @estado, @cidade,@turma)
END