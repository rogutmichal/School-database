CREATE SEQUENCE [dbo].[Seq_Id_osoby] 
 AS [bigint]
 START WITH 1
 INCREMENT BY 1
 MINVALUE -9223372036854775808
 MAXVALUE 9223372036854775807
 CACHE 
GO

---przedmioty

INSERT INTO Przedmioty (Nazwa) VALUES 
('biologia'),
('chemia'),
('fizyka'),
('geografia'),
('historia'),
('informatyka'),
('jêzyk angielski'),
('jêzyk niemiecki'),
('jêzyk francuski'),
('jêzyk polski'),
('matematyka'),
('muzyka'),
('plastyka'),
('technika'),
('wiedza o spo³eczeñstwie'),
('wychowanie fizyczne');

---stanowiska

INSERT INTO Stanowisko (Nazwa) VALUES 
('Nauczyciel'),
('Dyrektor szko³y'),
('Wicedyrektor'),
('Sekretarz szko³y'),
('Pedagog szkolny'),
('Psycholog szkolny'),
('Bibliotekarz szkolny'),
('Nauczyciel wspomagaj¹cy'),
('WoŸny'),
('Kucharz szkolny');


---pracownicy

CREATE SEQUENCE [dbo].[Seq_Pracownik] 
 AS [bigint]
 START WITH 1
 INCREMENT BY 1
 MINVALUE -9223372036854775808
 MAXVALUE 9223372036854775807
 CACHE 
GO


DECLARE @Counter INT = 1;

WHILE @Counter <= 40
BEGIN
    DECLARE @Numer NUMERIC(28);
    SELECT @Numer = NEXT VALUE FOR Seq_Pracownik;
	  DECLARE @IdOsoby BIGINT;
	  SELECT @IdOsoby = NEXT VALUE FOR Seq_Id_osoby;

    DECLARE @Imie VARCHAR(50);
    DECLARE @Nazwisko VARCHAR(50);
    DECLARE @Plec VARCHAR(50);
    DECLARE @DataUrodzenia DATE;
    DECLARE @Email VARCHAR(50);
    DECLARE @Pensja BIGINT;
    DECLARE @Etat BIGINT;
    DECLARE @NumerTelefonu VARCHAR(15);
    DECLARE @StanowiskoId NUMERIC(28);

    SET @Imie = CONCAT('ImiePrac', CAST(@Numer AS VARCHAR(10)));
    SET @Nazwisko = CONCAT('NazwPrac', CAST(@Numer AS VARCHAR(10)));
    SET @Plec = CASE WHEN RAND() > 0.5 THEN 'Mê¿czyzna' ELSE 'Kobieta' END;
    SET @DataUrodzenia = DATEADD(YEAR, -CAST(RAND() * 60 + 20 AS INT), GETDATE());
    SET @Email = LOWER(@Imie + '.' + @Nazwisko + '@example.com');
    SET @Pensja = CAST(ROUND(RAND() * 2000 + 3000, 0) AS BIGINT); 
    SET @Etat = CAST(ROUND(RAND(), 0) AS BIT); 
    SET @NumerTelefonu = CAST(ROUND(RAND() * 900000000 + 100000000, 0) AS BIGINT);

    SELECT TOP 1 @StanowiskoId = Stanowisko_ID FROM Stanowisko ORDER BY NEWID(); 

    INSERT INTO Osoby (Id_osoby, Imie, Nazwisko, Plec, Data_urodzenia, Email)
    VALUES (@IdOsoby, @Imie, @Nazwisko, @Plec, @DataUrodzenia, @Email);

    INSERT INTO Pracownicy (Pensja, Etat, Numer_telefonu, Id_Osoby, Stanowisko_ID)
    VALUES (@Pensja, @Etat, @NumerTelefonu, @IdOsoby, @StanowiskoId);

    SET @Counter = @Counter + 1;
END;



--------Uczen

CREATE SEQUENCE [dbo].[Seq_Uczen] 
 AS [bigint]
 START WITH 1
 INCREMENT BY 1
 MINVALUE -9223372036854775808
 MAXVALUE 9223372036854775807
 CACHE 
GO
DECLARE @Counter2 INT = 1;

WHILE @Counter2 <= 500
BEGIN
    DECLARE @Numer2 NUMERIC(28);
    SELECT @Numer2 = NEXT VALUE FOR Seq_Uczen;

	DECLARE @IdOsoby2 BIGINT;
	  SELECT @IdOsoby2 = NEXT VALUE FOR Seq_Id_osoby;

    DECLARE @Imie2 VARCHAR(50);
    DECLARE @Nazwisko2 VARCHAR(50);
    DECLARE @Plec2 VARCHAR(50);
    DECLARE @DataUrodzenia2 DATE;
    DECLARE @Email2 VARCHAR(50);
    DECLARE @NumerTelefonuOpiekuna VARCHAR(15);

    SET @Imie2 = CONCAT('ImieUczen', CAST(@Numer2 AS VARCHAR(10)));
    SET @Nazwisko2 = CONCAT('NazwUczen', CAST(@Numer2 AS VARCHAR(10)));
    SET @Plec2 = CASE WHEN RAND() > 0.5 THEN 'Mê¿czyzna' ELSE 'Kobieta' END;
    SET @DataUrodzenia2 = DATEADD(YEAR, -CAST(RAND() * 7 + 8 AS INT), GETDATE());
    SET @Email2 = LOWER(@Imie2 + '.' + @Nazwisko2 + '@example.com');
  SET @NumerTelefonuOpiekuna = CAST(ROUND(RAND() * 900000000 + 100000000, 0) AS BIGINT);
    INSERT INTO Osoby (Id_osoby,Imie, Nazwisko, Plec, Data_urodzenia, Email)
    VALUES (@IdOsoby2, @Imie2, @Nazwisko2, @Plec2, @DataUrodzenia2, @Email2);

    INSERT INTO Uczniowie (Numer_telefonu_opiekuna, Id_Osoby)
    VALUES (@NumerTelefonuOpiekuna, @IdOsoby2);

    SET @Counter2 = @Counter2 + 1;
END;

---Klasy

DECLARE @Rok DATE = '2023-09-01'; 
DECLARE @KodyKlas TABLE (Kod VARCHAR(30)); 

INSERT INTO @KodyKlas (Kod) VALUES 
('1a'), ('1b'), ('1c'), ('1d'), 
('2a'), ('2b'), ('2c'), ('2d'), 
('3a'), ('3b'), ('3c'), ('3d'), 
('4a'), ('4b'), ('4c'), ('4d');

INSERT INTO Klasy (Rok, Kod, Nazwa_klasy)
SELECT 
    @Rok AS Rok,
    Kod,
    CASE 
        WHEN RIGHT(Kod, 1) = 'a' THEN 'Humanistyczna'
        WHEN RIGHT(Kod, 1) = 'b' THEN 'Matematyczno-Fizyczna'
        WHEN RIGHT(Kod, 1) = 'c' THEN 'Biologiczno-Chemiczna'
        WHEN RIGHT(Kod, 1) = 'd' THEN 'Geograficzna'
    END AS Nazwa_klasy
FROM @KodyKlas;

--Uczen - Klasa

DECLARE @RokSzkolnyStart DATE = '2023-09-01';
DECLARE @RokSzkolnyEnd DATE = '2024-06-30'; 

DECLARE @UczniowieCount INT;
SELECT @UczniowieCount = COUNT(*) FROM Uczniowie;

DECLARE @CounterKlasy INT = 1;

WHILE @CounterKlasy <= @UczniowieCount
BEGIN
    DECLARE @KlasaId BIGINT;
    SELECT TOP 1 @KlasaId = Id_klasy FROM Klasy ORDER BY NEWID();

    INSERT INTO Uczen_klasa (Uczniowie_Id_osoby, Klasy_Id_klasy, Data_start, Data_end)
    VALUES (@CounterKlasy, @KlasaId, @RokSzkolnyStart, @RokSzkolnyEnd);

    SET @CounterKlasy = @CounterKlasy + 1;
END;

--Zajêcia

DECLARE @DataPoczatkowa DATETIME = '2023-09-01'; 
DECLARE @DataKoncowa DATETIME = '2024-06-30'; 

DECLARE @PracownikId BIGINT;

DECLARE @CounterZajecia INT = 1;

WHILE @CounterZajecia <= 1000
BEGIN
    DECLARE @Sala BIGINT = CAST(RAND() * 21 + 10 AS BIGINT); 
    DECLARE @Przedmiot VARCHAR(50); 
    SELECT TOP 1 @Przedmiot = Nazwa FROM Przedmioty ORDER BY NEWID(); 

 DECLARE @DataGodzina DATETIME = DATEADD(DAY, RAND() * DATEDIFF(DAY, @DataPoczatkowa, @DataKoncowa), @DataPoczatkowa); 
 SELECT TOP 1 @PracownikId = Id_osoby FROM Pracownicy ORDER BY NEWID(); 

    
    SET @DataGodzina = DATEADD(HOUR, CAST(RAND() * 9 AS INT) + 8, @DataGodzina);
    DECLARE @KlasaId2 BIGINT;
    SELECT TOP 1 @KlasaId2 = Id_klasy FROM Klasy ORDER BY NEWID(); 

    INSERT INTO Zajecia (Numer_sali, Przedmioty_Nazwa, "Data/Godzina", Klasy_Id_klasy, Pracownicy_Id_osoby)
    VALUES (@Sala, @Przedmiot, @DataGodzina, @KlasaId2, @PracownikId);

    SET @CounterZajecia = @CounterZajecia + 1;
END;


--Uczestnictwo

;DECLARE @CounterUczes INT = 1;

WHILE @CounterUczes <= 10000
BEGIN
    DECLARE @ZajecieId BIGINT;
    SELECT TOP 1 @ZajecieId = Id_zajec FROM Zajecia ORDER BY NEWID(); -- Losowe zajêcie

    DECLARE @KlasaId3 BIGINT;
    SELECT @KlasaId3 = Klasy_Id_klasy FROM Zajecia WHERE Id_zajec = @ZajecieId; -- Id klasy na podstawie zajêcia

    DECLARE @UczenId BIGINT;
    SELECT TOP 1 @UczenId = Uczniowie_Id_osoby FROM Uczen_klasa WHERE Klasy_Id_klasy = @KlasaId3 ORDER BY NEWID(); -- Losowy uczeñ z odpowiedniej klasy

    DECLARE @Obecny BIT = CAST(RAND() * 2 AS INT);

    INSERT INTO Uczestnictwo (Uczniowie_Id_osoby, Zajecia_Id_zajec, Obecny, Text)
    VALUES (@UczenId, @ZajecieId, @Obecny, 'Przyk³adowy Tekst');

    SET @CounterUczes = @CounterUczes + 1;
END

---Oceny

DECLARE @CounterOceny INT = 1;

WHILE @CounterOceny <= 2000
BEGIN
    DECLARE @UczestnictwoId NUMERIC(28);
    SELECT TOP 1 @UczestnictwoId = Uczestnictwo_ID FROM Uczestnictwo ORDER BY NEWID(); 

    DECLARE @Ocena BIGINT = CAST(RAND() * 6 + 1 AS BIGINT); 

    INSERT INTO Oceny (Ocena, Komentarz, Data, Uczestnictwo_ID)
    SELECT @Ocena, 'komentarz', [Data/Godzina], @UczestnictwoId
    FROM Zajecia
    WHERE Id_zajec = (SELECT TOP 1 Zajecia_Id_zajec FROM Uczestnictwo WHERE Uczestnictwo_ID = @UczestnictwoId);

    SET @CounterOceny = @CounterOceny + 1;
END;


---Konkursy

DECLARE @CounterKonkursy INT = 65; 

WHILE @CounterKonkursy <= 65 + 14 
BEGIN
    DECLARE @NazwaKonkursu VARCHAR(50) = 'Konkurs' + CHAR(@CounterKonkursy); 

    INSERT INTO Konkursy (Nazwa_konkursu)
    VALUES (@NazwaKonkursu);

    SET @CounterKonkursy = @CounterKonkursy + 1;
END;

---Konkurs Uczniowie

DECLARE @CounterKonUczen INT = 1;

WHILE @CounterKonUczen <= 100
BEGIN
    DECLARE @KonkursId BIGINT;
    SELECT TOP 1 @KonkursId = Id_konkursu FROM Konkursy ORDER BY NEWID();

    DECLARE @UczenIdKon BIGINT;
    SELECT TOP 1 @UczenIdKon = Id_Osoby FROM Uczniowie ORDER BY NEWID(); 

    DECLARE @Miejsce VARCHAR(50);
    SET @Miejsce = CASE CAST(RAND() * 4 AS INT)
                    WHEN 0 THEN 'Pierwsze Miejsce'
                    WHEN 1 THEN 'Drugie Miejsce'
                    WHEN 2 THEN 'Trzecie Miejsce'
                    ELSE 'Wyró¿nienie' END;

    INSERT INTO Konkursy_uczniowie (Wynik, Id_konkursu, Uczniowie_Id_Osoby)
    VALUES (@Miejsce, @KonkursId, @UczenIdKon);

    SET @CounterKonUczen = @CounterKonUczen + 1;
END;
