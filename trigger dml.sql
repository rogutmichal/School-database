CREATE TRIGGER Informacja_o_ocenie
ON Oceny
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @Ocena FLOAT,
            @Uczniowie_Id_Osoby BIGINT,
            @Imie VARCHAR(50),
            @Nazwisko VARCHAR(50),
            @Data DATE;

    -- Pobranie danych o ocenie i uczniu
    SELECT @Ocena = i.Ocena,
           @Uczniowie_Id_Osoby = i.Uczestnictwo_ID,
           @Data = i.Data,
           @Imie = o.Imie,
           @Nazwisko = o.Nazwisko
    FROM inserted i
    INNER JOIN Uczestnictwo u ON i.Uczestnictwo_ID = u.Uczestnictwo_ID
    INNER JOIN Uczniowie ucz ON u.Uczniowie_Id_osoby = ucz.Id_Osoby
    INNER JOIN Osoby o ON ucz.Id_Osoby = o.Id_osoby;

    PRINT 'Dodano now¹ ocenê ' + CAST(@Ocena AS VARCHAR) + ' uczniowi ' + @Imie + ' ' + @Nazwisko + ' w dniu ' + CAST(@Data AS VARCHAR);
END;


INSERT INTO Oceny(Ocena, Komentarz, Data, Uczestnictwo_ID) VALUES (4, 'DOBRZE', '2024-05-05', 3);