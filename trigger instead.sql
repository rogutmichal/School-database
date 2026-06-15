CREATE TRIGGER SprawdzOcene
ON Oceny
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (SELECT * FROM inserted WHERE Ocena < 1 OR Ocena > 6)
    BEGIN
        ROLLBACK;
        
        THROW 50000, 'Ocena musi byæ z zakresu od 1 do 6.', 1;
    END
    ELSE
    BEGIN
        INSERT INTO Oceny (Ocena, Komentarz, Data, Uczestnictwo_ID)
        SELECT Ocena, Komentarz, Data, Uczestnictwo_ID
        FROM inserted;
    END
END


INSERT INTO Oceny (Ocena, Komentarz, Data, Uczestnictwo_ID) VALUES (9, 'abcdeF', '2025-03-04', 1)

