--PROCEDURE CRIAR PROFESSOR
CREATE PROCEDURE sp_add_TblProfessor
@nome VARCHAR(60), @telefone VARCHAR(15), @endereco VARCHAR(200), @salario smallmoney, @estado VARCHAR(2), @cidade INT
AS
DECLARE @ano as int, @mes as varchar(2), @digito as int, @matricula VARCHAR(8)
BEGIN
SELECT @ano = CONVERT(INT, YEAR(GETDATE()))
SELECT @digito=(RIGHT(MAX(CAST(matricula as int)),2) + 1) from TblProfessor

IF MONTH(GETDATE())>9 AND @digito>9
BEGIN
	SELECT @matricula = CONCAT(@ano,
						CONVERT(VARCHAR(2),MONTH(GETDATE())),
						@digito)
END
ELSE IF @digito>9 AND MONTH(GETDATE())<10
BEGIN
	SELECT @matricula = CONCAT(@ano,
							'0',
							CONVERT(VARCHAR(1),MONTH(GETDATE())),
							@digito)
END
ELSE
BEGIN
	SELECT @matricula = CONCAT(@ano,
						'0',
						CONVERT(VARCHAR(1),MONTH(GETDATE())),
						'0',
						@digito)
END
INSERT INTO TblProfessor(matricula,nome,telefone,endereco,salario,sigla_estado,id_cidade) 
VALUES
(@matricula, @nome, @telefone, @endereco, @salario, @estado, @cidade)
END


