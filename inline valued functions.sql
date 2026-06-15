CREATE FUNCTION dbo.UczniowieWybranejKlasy
(
    @ClassId BIGINT
)
RETURNS TABLE
AS
RETURN
(
    SELECT Osoby.Imie, Osoby.Nazwisko
    FROM Uczen_klasa
    INNER JOIN Osoby ON Uczen_klasa.Uczniowie_Id_osoby = Osoby.Id_osoby
    WHERE Uczen_klasa.Klasy_Id_klasy = @ClassId
)
SELECT *FROM dbo.UczniowieWybranejKlasy(13)

CREATE FUNCTION dbo.PracownicyWgStanowiska
(
    @NazwaStanowiska VARCHAR(50)
)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        Osoby.Imie AS Imie,
        Osoby.Nazwisko AS Nazwisko,
        Osoby.Email AS Email,
        Pracownicy.Pensja AS Pensja,
        Pracownicy.Numer_telefonu AS NumerTelefonu
    FROM 
        Pracownicy
    INNER JOIN 
        Osoby ON Pracownicy.Id_Osoby = Osoby.Id_osoby
    INNER JOIN 
        Stanowisko ON Pracownicy.Stanowisko_ID = Stanowisko.Stanowisko_ID
    WHERE 
        Stanowisko.Nazwa = @NazwaStanowiska
);

SELECT * FROM dbo.PracownicyWgStanowiska('Nauczyciel');



