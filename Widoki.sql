---WIDOKI

CREATE VIEW SredniaKlas AS
SELECT
	k.Kod,
    k.Nazwa_klasy,
    ROUND(AVG(o.Ocena), 2) AS Srednia_ocena
FROM
    Klasy k
    INNER JOIN Uczen_klasa uk ON k.Id_klasy = uk.Klasy_Id_klasy
    INNER JOIN Uczestnictwo ucz ON uk.Uczniowie_Id_osoby = ucz.Uczniowie_Id_osoby
    INNER JOIN Oceny o ON ucz.Uczestnictwo_ID = o.Uczestnictwo_ID
GROUP BY
    k.Id_klasy,
	k.Kod,
    k.Nazwa_klasy


	SELECT * FROM SredniaKlas ORDER BY Kod
	----------

	CREATE VIEW SredniaPensjaStanowisk AS
SELECT 
    S.Nazwa AS Stanowisko, 
    AVG(P.Pensja) AS Srednia_Pensja
FROM 
    Pracownicy P
JOIN 
    Stanowisko S ON P.Stanowisko_ID = S.Stanowisko_ID
GROUP BY 
    S.Nazwa;

	SELECT * FROM SredniaPensjaStanowisk;

	----

	CREATE VIEW ZwyciêzcyKonkurs AS
SELECT O.Imie, O.Nazwisko, KL.Kod Kod_Klasy, KON.Nazwa_konkursu

FROM
Uczniowie U
INNER JOIN Osoby O ON O.Id_osoby=U.Id_Osoby
INNER JOIN Konkursy_uczniowie KU ON KU.Uczniowie_Id_Osoby=U.Id_Osoby
INNER JOIN Konkursy KON ON KON.Id_konkursu=KU.Id_konkursu
INNER JOIN Uczen_klasa UK ON UK.Uczniowie_Id_osoby=U.Id_Osoby
INNER JOIN Klasy KL ON KL.Id_klasy=UK.Klasy_Id_klasy
WHERE KU.Wynik='Pierwsze Miejsce'

SELECT * FROM ZwyciêzcyKonkurs

