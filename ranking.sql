SELECT 
        u.Id_Osoby AS Id_Ucznia,
        o.Imie AS imie,
        o.Nazwisko AS nazwisko,
		uk.Klasy_Id_klasy,
        ROUND(AVG(oc.Ocena), 2) AS SredniaOcena,
        ROUND(AVG(AVG(oc.Ocena)) OVER (PARTITION BY uk.Klasy_Id_klasy), 2) AS SredniaKlasy,
		DENSE_RANK() OVER (ORDER BY ROUND(AVG(oc.Ocena), 2) DESC) AS PozycjaRankingu 

    FROM 
        Uczestnictwo ucz
    INNER JOIN 
        Oceny oc ON ucz.Uczestnictwo_ID = oc.Uczestnictwo_ID
    INNER JOIN 
        Uczniowie u ON ucz.Uczniowie_Id_osoby = u.Id_Osoby
    INNER JOIN 
        Osoby o ON u.Id_Osoby = o.Id_osoby
    INNER JOIN 
        Uczen_klasa uk ON u.Id_Osoby = uk.Uczniowie_Id_osoby
	GROUP BY
	u.Id_Osoby, o.Imie, o.Nazwisko, uk.Klasy_Id_klasy
