CREATE VIEW dbo.LiczbaZajecNauczycieli WITH SCHEMABINDING
AS
SELECT 
o.Id_osoby, o.Imie, o.Nazwisko, COUNT_BIG(*) AS Liczba_zajec

FROM
dbo.Zajecia z
INNER JOIN dbo.Pracownicy p ON p.Id_Osoby = z.Pracownicy_Id_osoby
INNER JOIN dbo.Osoby o ON o.Id_osoby = p.Id_Osoby
GROUP BY
o.Id_osoby, o.Imie, o.Nazwisko



CREATE UNIQUE CLUSTERED INDEX 
    ucidx_zajecia_id
	ON dbo.LiczbaZajecNauczycieli(Id_osoby);



SELECT * FROM dbo.LiczbaZajecNauczycieli 