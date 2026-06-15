
 SELECT TOP 10 O.Imie, O.Nazwisko, COUNT(UC.Obecny) AS LiczbaNieobecnosci
    FROM Uczniowie U
    INNER JOIN Uczestnictwo UC ON U.Id_Osoby = UC.Uczniowie_Id_osoby
	INNER JOIN Osoby O On O.Id_osoby = U.Id_Osoby
    WHERE UC.Obecny = 0 
    GROUP BY O.Imie, O.Nazwisko
    ORDER BY LiczbaNieobecnosci DESC
	------

	SELECT  
    O.Imie, 
    O.Nazwisko, 
	K.Kod as Kod_klasy,
    ROUND(AVG(Oc.Ocena),2) AS Srednia_ocena 
FROM 
    Klasy K
JOIN 
    Uczen_klasa UK ON K.Id_klasy = UK.Klasy_Id_klasy
JOIN 
    Uczniowie U ON UK.Uczniowie_Id_osoby = U.Id_Osoby
JOIN 
    Osoby O ON U.Id_Osoby = O.Id_osoby
JOIN 
    Uczestnictwo Ucz ON U.Id_Osoby = Ucz.Uczniowie_Id_osoby
JOIN 
    Oceny Oc ON Ucz.Uczestnictwo_ID = Oc.Uczestnictwo_ID
GROUP BY 
    O.Imie, O.Nazwisko, k.Kod
HAVING 
    ROUND(AVG(Oc.Ocena),2) > 4.75
ORDER BY 
    Srednia_ocena DESC;

---

