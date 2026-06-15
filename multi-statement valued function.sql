CREATE FUNCTION dbo.ZagrozeniUczniowie
(
@IdKlasy BIGINT
)
RETURNS @Tabela TABLE
(
Imie VARCHAR(50), Nazwisko VARCHAR(50), Œrednia FLOAT, Zagrozony VARCHAR(10)
)
AS BEGIN
	INSERT INTO @Tabela
		SELECT o.Imie, o.Nazwisko, ROUND(AVG(oc.Ocena),2), NULL
		

		FROM Osoby o
			INNER JOIN Uczniowie u ON u.Id_Osoby=o.Id_osoby
			INNER JOIN Uczestnictwo ucz ON ucz.Uczniowie_Id_osoby = u.Id_Osoby
			INNER JOIN Oceny oc ON oc.Uczestnictwo_ID = ucz.Uczestnictwo_ID
			INNER JOIN Uczen_klasa uk ON uk.Uczniowie_Id_osoby = u.Id_Osoby
		WHERE uk.Klasy_Id_klasy=@IdKlasy
   
	GROUP BY o.Imie, o.Nazwisko

	

UPDATE @Tabela
	SET Zagrozony =
	CASE WHEN Œrednia< 1.75 THEN 'TAK'
	ELSE 'NIE'
	
	END
RETURN 
END

SELECT * FROM dbo.ZagrozeniUczniowie(5) ORDER BY Œrednia DESC
