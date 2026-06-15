
--Œrednia ucznia
CREATE FUNCTION dbo.SredniaUcznia (@Id_Ucznia BIGINT)
RETURNS FLOAT
AS
BEGIN
    DECLARE @Srednia FLOAT

    SELECT @Srednia = ROUND(AVG(Ocena), 2)
    FROM Oceny o
    INNER JOIN Uczestnictwo u ON o.Uczestnictwo_ID = u.Uczestnictwo_ID
    WHERE u.Uczniowie_Id_osoby = @Id_Ucznia

    RETURN (@Srednia)
END

SELECT dbo.SredniaUcznia(350) AS 'Œrednia'

--Procent obecnoœci ucznia
CREATE FUNCTION ObecnoscUcznia(@Uczniowie_Id_osoby BIGINT)
RETURNS FLOAT
AS
BEGIN
    DECLARE @LiczbaObecnosci INT;
    DECLARE @LiczbaZajec INT;
    DECLARE @ProcentObecnosci FLOAT;


    SELECT @LiczbaObecnosci = COUNT(*) 
    FROM Uczestnictwo 
    WHERE Uczniowie_Id_osoby = @Uczniowie_Id_osoby 
    AND Obecny = 1;


    SELECT @LiczbaZajec = COUNT(*) 
    FROM Uczestnictwo 
    WHERE Uczniowie_Id_osoby = @Uczniowie_Id_osoby;


        SET @ProcentObecnosci = ROUND((@LiczbaObecnosci * 100.0) / @LiczbaZajec, 2);

    RETURN @ProcentObecnosci;
END;


SELECT dbo.ObecnoscUcznia(265) AS Procent_Obecnoœci;

--Liczba uczêstników konkursu

CREATE FUNCTION dbo.LiczbaUczestnikowKonkursu
(
    @IdKonkursu BIGINT
)
RETURNS INT
AS
BEGIN
    DECLARE @Liczba INT

    SELECT @Liczba = COUNT(*)
    FROM Konkursy_uczniowie
    WHERE Id_konkursu = @IdKonkursu

    RETURN @Liczba
END


SELECT dbo.LiczbaUczestnikowKonkursu(2) AS Liczba;












