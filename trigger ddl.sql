CREATE TRIGGER NieUsuwaj
ON DATABASE
FOR DROP_TABLE
AS
	PRINT 'Nie mo¿esz usun¹æ tabeli'
	ROLLBACK;

DROP TABLE dbo.Konkursy_uczniowie