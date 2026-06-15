SELECT 
    u.Id_Osoby AS Id_Ucznia,
    o.Imie,
    o.Nazwisko,
    ROUND(AVG(oc.Ocena), 2) AS SredniaOcena,
    RANK() OVER (ORDER BY ROUND(AVG(oc.Ocena), 2) DESC) AS PozycjaRankingu,
    ROUND(LAG(AVG(oc.Ocena)) OVER (ORDER BY ROUND(AVG(oc.Ocena), 2) DESC), 2) AS SredniaOcenaPoprzedniego

FROM 
    Uczestnictwo ucz
INNER JOIN 
    Oceny oc ON ucz.Uczestnictwo_ID = oc.Uczestnictwo_ID
INNER JOIN 
    Uczniowie u ON ucz.Uczniowie_Id_osoby = u.Id_Osoby
INNER JOIN 
    Osoby o ON u.Id_Osoby = o.Id_osoby
GROUP BY 
    u.Id_Osoby, o.Imie, o.Nazwisko


	SELECT 
    u.Id_Osoby AS Id_Ucznia,
    o.Imie,
    o.Nazwisko,
    ROUND(AVG(oc.Ocena), 2) AS SredniaOcena,
    RANK() OVER (ORDER BY ROUND(AVG(oc.Ocena), 2) DESC) AS Pozycja_w_Rankingu,
    ROUND(LEAD(AVG(oc.Ocena)) OVER (ORDER BY ROUND(AVG(oc.Ocena), 2) DESC), 2) AS SredniaOcenaNastepnego
FROM 
    Uczestnictwo ucz
INNER JOIN 
    Oceny oc ON ucz.Uczestnictwo_ID = oc.Uczestnictwo_ID
INNER JOIN 
    Uczniowie u ON ucz.Uczniowie_Id_osoby = u.Id_Osoby
INNER JOIN 
    Osoby o ON u.Id_Osoby = o.Id_osoby
GROUP BY 
    u.Id_Osoby, o.Imie, o.Nazwisko



	SELECT * FROM (SELECT 
    u.Id_Osoby AS Id_Ucznia,
    o.Imie,
    o.Nazwisko,
    ROUND(AVG(oc.Ocena), 2) AS SredniaOcena,
FROM 
    Uczestnictwo ucz
INNER JOIN 
    Oceny oc ON ucz.Uczestnictwo_ID = oc.Uczestnictwo_ID
INNER JOIN 
    Uczniowie u ON ucz.Uczniowie_Id_osoby = u.Id_Osoby
INNER JOIN 
    Osoby o ON u.Id_Osoby = o.Id_osoby
GROUP BY 
    u.Id_Osoby, o.Imie, o.Nazwisko) tab1
