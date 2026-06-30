Tworzenie tabel
CREATE TABLE Klasy 
    (
     Id_klasy BIGINT NOT NULL IDENTITY , 
     Rok DATE NOT NULL , 
     Kod VARCHAR (30) , 
     Nazwa_klasy VARCHAR (50) 
    )
GO

ALTER TABLE Klasy ADD CONSTRAINT Klasy_PK PRIMARY KEY NONCLUSTERED (Id_klasy)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Konkursy 
    (
     Id_konkursu BIGINT  NOT NULL IDENTITY, 
     Nazwa_konkursu VARCHAR (50) 
	
    )
GO

ALTER TABLE Konkursy ADD CONSTRAINT Konkursy_PK PRIMARY KEY CLUSTERED (Id_konkursu)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Konkursy_uczniowie 
    (
     Wynik VARCHAR (100) NOT NULL  , 
     Id_konkursu BIGINT NOT NULL , 
     Uczniowie_Id_Osoby BIGINT NOT NULL 
    )
GO

CREATE TABLE Oceny 
    (
     Id_oceny BIGINT NOT NULL IDENTITY, 
     Ocena FLOAT NOT NULL , 
     Komentarz VARCHAR (255) , 
     Data DATE , 
     Uczestnictwo_ID NUMERIC (28) NOT NULL 
    )
GO

ALTER TABLE Oceny ADD CONSTRAINT Oceny_PK PRIMARY KEY NONCLUSTERED (Id_oceny)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO


CREATE TABLE Osoby 
    (
     Id_osoby BIGINT NOT NULL , 
     Imie VARCHAR (50) NOT NULL , 
     Nazwisko VARCHAR (50)  NOT NULL , 
     Plec VARCHAR (50) NOT NULL , 
     Data_urodzenia DATE NOT NULL, 
	 Email VARCHAR (50) NOT NULL UNIQUE CLUSTERED
	 
    )
GO

ALTER TABLE Osoby ADD CONSTRAINT Osoby_PK PRIMARY KEY NONCLUSTERED (Id_osoby)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Pracownicy 
    (
     Pensja BIGINT  , 
     Etat BIGINT , 
     Numer_telefonu VARCHAR (15) , 
     Id_Osoby BIGINT NOT NULL , 
     Stanowisko_ID NUMERIC (28) NOT NULL 
    )
GO

ALTER TABLE Pracownicy ADD CONSTRAINT Pracownicy_PK PRIMARY KEY NONCLUSTERED (Id_Osoby)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Przedmioty 
    (
         
     Nazwa VARCHAR (50) NOT NULL 
    )
GO

ALTER TABLE Przedmioty ADD CONSTRAINT Przedmioty_PK PRIMARY KEY NONCLUSTERED (Nazwa)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Stanowisko 
    (
     Nazwa VARCHAR (50) NOT NULL , 
     Stanowisko_ID NUMERIC (28) NOT NULL IDENTITY NOT FOR REPLICATION 
    )
GO

ALTER TABLE Stanowisko ADD CONSTRAINT Stanowisko_PK PRIMARY KEY NONCLUSTERED (Stanowisko_ID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Uczen_klasa 
    (
     Uczniowie_Id_osoby BIGINT NOT NULL , 
     Klasy_Id_klasy BIGINT NOT NULL , 
     Data_start DATE , 
     Data_end DATE 
    )
GO

ALTER TABLE Uczen_klasa ADD CONSTRAINT Uczen_klasa_PK PRIMARY KEY NONCLUSTERED (Klasy_Id_klasy, Uczniowie_Id_osoby)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Uczestnictwo 
    (
     Uczniowie_Id_osoby BIGINT NOT NULL , 
     Zajecia_Id_zajec BIGINT NOT NULL , 
     Obecny BIT NOT NULL , 
	 Text char(400),
     Uczestnictwo_ID NUMERIC (28) NOT NULL IDENTITY NOT FOR REPLICATION 
    )
GO

ALTER TABLE Uczestnictwo ADD CONSTRAINT Uczestnictwo_PK PRIMARY KEY NONCLUSTERED (Uczestnictwo_ID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Uczniowie 
    (
     Numer_telefonu_opiekuna VARCHAR (15) NOT NULL , 
     Id_Osoby BIGINT NOT NULL 
    )
GO

ALTER TABLE Uczniowie ADD CONSTRAINT Uczniowie_PK PRIMARY KEY NONCLUSTERED (Id_Osoby)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Zajecia 
    (
     Id_zajec BIGINT NOT NULL IDENTITY , 
     Numer_sali BIGINT , 
     Przedmioty_Nazwa VARCHAR (50) NOT NULL , 
     "Data/Godzina" DATETIME , 
     Klasy_Id_klasy BIGINT NOT NULL , 
     Pracownicy_Id_osoby BIGINT NOT NULL 
    )
GO

ALTER TABLE Zajecia ADD CONSTRAINT Zajecia_PK PRIMARY KEY NONCLUSTERED (Id_zajec)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

ALTER TABLE Konkursy_uczniowie 
    ADD CONSTRAINT Konkursy_uczniowie_Konkursy_FK FOREIGN KEY 
    ( 
     Id_konkursu
    ) 
    REFERENCES Konkursy 
    ( 
     Id_konkursu 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Konkursy_uczniowie 
    ADD CONSTRAINT Konkursy_uczniowie_Uczniowie_FK FOREIGN KEY 
    ( 
     Uczniowie_Id_Osoby
    ) 
    REFERENCES Uczniowie 
    ( 
     Id_Osoby 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Oceny 
    ADD CONSTRAINT Oceny_Uczestnictwo_FK FOREIGN KEY 
    ( 
     Uczestnictwo_ID
    ) 
    REFERENCES Uczestnictwo 
    ( 
     Uczestnictwo_ID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Pracownicy 
    ADD CONSTRAINT Pracownicy_Osoby_FK FOREIGN KEY 
    ( 
     Id_Osoby
    ) 
    REFERENCES Osoby 
    ( 
     Id_osoby 
    ) 
    ON DELETE CASCADE 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Pracownicy 
    ADD CONSTRAINT Pracownicy_Stanowisko_FK FOREIGN KEY 
    ( 
     Stanowisko_ID
    ) 
    REFERENCES Stanowisko 
    ( 
     Stanowisko_ID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Uczen_klasa 
    ADD CONSTRAINT Uczen_klasa_Klasy_FK FOREIGN KEY 
    ( 
     Klasy_Id_klasy
    ) 
    REFERENCES Klasy 
    ( 
     Id_klasy 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Uczen_klasa 
    ADD CONSTRAINT Uczen_klasa_Uczniowie_FK FOREIGN KEY 
    ( 
     Uczniowie_Id_osoby
    ) 
    REFERENCES Uczniowie 
    ( 
     Id_Osoby 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Uczestnictwo 
    ADD CONSTRAINT Uczestnictwo_Uczniowie_FK FOREIGN KEY 
    ( 
     Uczniowie_Id_osoby
    ) 
    REFERENCES Uczniowie 
    ( 
     Id_Osoby 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Uczestnictwo 
    ADD CONSTRAINT Uczestnictwo_Zajecia_FK FOREIGN KEY 
    ( 
     Zajecia_Id_zajec
    ) 
    REFERENCES Zajecia 
    ( 
     Id_zajec 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Uczniowie 
    ADD CONSTRAINT Uczniowie_Osoby_FK FOREIGN KEY 
    ( 
     Id_Osoby
    ) 
    REFERENCES Osoby 
    ( 
     Id_osoby 
    ) 
    ON DELETE CASCADE 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Zajecia 
    ADD CONSTRAINT Zajecia_Klasy_FK FOREIGN KEY 
    ( 
     Klasy_Id_klasy
    ) 
    REFERENCES Klasy 
    ( 
     Id_klasy 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Zajecia 
    ADD CONSTRAINT Zajecia_Pracownicy_FK FOREIGN KEY 
    ( 
     Pracownicy_Id_osoby
    ) 
    REFERENCES Pracownicy 
    ( 
     Id_Osoby 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Zajecia 
    ADD CONSTRAINT Zajecia_Przedmioty_FK FOREIGN KEY 
    ( 
     Przedmioty_Nazwa
    ) 
    REFERENCES Przedmioty 
    ( 
     Nazwa 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

Uzupełnianie bazy danymi
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
('język angielski'),
('język niemiecki'),
('język francuski'),
('język polski'),
('matematyka'),
('muzyka'),
('plastyka'),
('technika'),
('wiedza o społeczeństwie'),
('wychowanie fizyczne');

---stanowiska

INSERT INTO Stanowisko (Nazwa) VALUES 
('Nauczyciel'),
('Dyrektor szkoły'),
('Wicedyrektor'),
('Sekretarz szkoły'),
('Pedagog szkolny'),
('Psycholog szkolny'),
('Bibliotekarz szkolny'),
('Nauczyciel wspomagający'),
('Woźny'),
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
    SET @Plec = CASE WHEN RAND() > 0.5 THEN 'Mężczyzna' ELSE 'Kobieta' END;
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
    SET @Plec2 = CASE WHEN RAND() > 0.5 THEN 'Mężczyzna' ELSE 'Kobieta' END;
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

--Zajęcia

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
    SELECT TOP 1 @ZajecieId = Id_zajec FROM Zajecia ORDER BY NEWID(); -- Losowe zajęcie

    DECLARE @KlasaId3 BIGINT;
    SELECT @KlasaId3 = Klasy_Id_klasy FROM Zajecia WHERE Id_zajec = @ZajecieId; -- Id klasy na podstawie zajęcia

    DECLARE @UczenId BIGINT;
    SELECT TOP 1 @UczenId = Uczniowie_Id_osoby FROM Uczen_klasa WHERE Klasy_Id_klasy = @KlasaId3 ORDER BY NEWID(); -- Losowy uczeń z odpowiedniej klasy

    DECLARE @Obecny BIT = CAST(RAND() * 2 AS INT);

    INSERT INTO Uczestnictwo (Uczniowie_Id_osoby, Zajecia_Id_zajec, Obecny, Text)
    VALUES (@UczenId, @ZajecieId, @Obecny, 'Przykładowy Tekst');

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
                    ELSE 'Wyróżnienie' END;

    INSERT INTO Konkursy_uczniowie (Wynik, Id_konkursu, Uczniowie_Id_Osoby)
    VALUES (@Miejsce, @KonkursId, @UczenIdKon);

    SET @CounterKonUczen = @CounterKonUczen + 1;
END;

PROCEDURY
--Dodawanie pracownika

CREATE PROCEDURE DodajPracownika
    @Imie VARCHAR(50),
    @Nazwisko VARCHAR(50),
    @Plec VARCHAR(50),
    @DataUrodzenia DATE,
    @Email VARCHAR(50),
    @Pensja BIGINT,
    @Etat BIGINT,
    @NumerTelefonu VARCHAR(15),
    @StanowiskoId NUMERIC(28)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION; 

        DECLARE @IdOsoby BIGINT;

        SELECT @IdOsoby = NEXT VALUE FOR Seq_Id_osoby;

        INSERT INTO Osoby (Id_osoby, Imie, Nazwisko, Plec, Data_urodzenia, Email)
        VALUES (@IdOsoby, @Imie, @Nazwisko, @Plec, @DataUrodzenia, @Email);

        INSERT INTO Pracownicy (Pensja, Etat, Numer_telefonu, Id_Osoby, Stanowisko_ID)
        VALUES (@Pensja, @Etat, @NumerTelefonu, @IdOsoby, @StanowiskoId);

        COMMIT TRANSACTION; 
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION; 

        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH;
END;


EXEC DodajPracownika
    @Imie = 'Jan',
    @Nazwisko = 'Kowalski',
    @Plec = 'Mężczyzna',
    @DataUrodzenia = '1985-06-15',
    @Email = 'jan.kowalski2@example.com',
    @Pensja = 50000,
    @Etat = 1,
    @NumerTelefonu = '123456789',
    @StanowiskoId = 3;


---Procedura dodawania ucznia



CREATE PROCEDURE [dbo].[DodajUcznia]
    @Imie VARCHAR(50),
    @Nazwisko VARCHAR(50),
    @Plec VARCHAR(50),
    @DataUrodzenia DATE,
    @Email VARCHAR(50),
    @NumerTelefonuOpiekuna VARCHAR(15)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION; 

        DECLARE @IdOsoby BIGINT;


        SELECT @IdOsoby = NEXT VALUE FOR Seq_Id_osoby;

  
        INSERT INTO Osoby (Id_osoby, Imie, Nazwisko, Plec, Data_urodzenia, Email)
        VALUES (@IdOsoby, @Imie, @Nazwisko, @Plec, @DataUrodzenia, @Email);

   
        INSERT INTO Uczniowie (Numer_telefonu_opiekuna, Id_Osoby)
        VALUES (@NumerTelefonuOpiekuna, @IdOsoby);

        COMMIT TRANSACTION; 
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH;
END;
GO

EXEC DodajUcznia
    @Imie = 'Anna',
    @Nazwisko = 'Nowak',
    @Plec = 'Kobieta',
    @DataUrodzenia = '2010-04-25',
    @Email = 'anna.nowak2@example.com',
    @NumerTelefonuOpiekuna = '987654321';


---USUWANIE ZAJEĆ

CREATE PROCEDURE [dbo].[UsunZajecia]
    @IdZajec BIGINT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        DELETE FROM Oceny
        WHERE Uczestnictwo_ID IN (SELECT Uczestnictwo_ID FROM Uczestnictwo WHERE Zajecia_Id_zajec = @IdZajec);

        DELETE FROM Uczestnictwo
        WHERE Zajecia_Id_zajec = @IdZajec;

        DELETE FROM Zajecia
        WHERE Id_zajec = @IdZajec;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH;
END;
GO

EXEC UsunZajecia 122

FUNKCJE
scalar functions

--Średnia ucznia
CREATE FUNCTION dbo.SredniaUcznia (@Id_Ucznia BIGINT)
RETURNS FLOAT
AS
BEGIN
    DECLARE @Srednia FLOAT

    SELECT @Srednia = ROUND(AVG(Ocena), 2)
    FROM Oceny o
    INNER JOIN Uczestnictwo u ON o.Uczestnictwo_ID = u.Uczestnictwo_ID
    WHERE u.Uczniowie_Id_osoby = @Id_Ucznia

    RETURN (@Srednia)
END

SELECT dbo.SredniaUcznia(350) AS 'Średnia'

--Procent obecności ucznia
CREATE FUNCTION ObecnoscUcznia(@Uczniowie_Id_osoby BIGINT)
RETURNS FLOAT
AS
BEGIN
    DECLARE @LiczbaObecnosci INT;
    DECLARE @LiczbaZajec INT;
    DECLARE @ProcentObecnosci FLOAT;


    SELECT @LiczbaObecnosci = COUNT(*) 
    FROM Uczestnictwo 
    WHERE Uczniowie_Id_osoby = @Uczniowie_Id_osoby 
    AND Obecny = 1;


    SELECT @LiczbaZajec = COUNT(*) 
    FROM Uczestnictwo 
    WHERE Uczniowie_Id_osoby = @Uczniowie_Id_osoby;


        SET @ProcentObecnosci = ROUND((@LiczbaObecnosci * 100.0) / @LiczbaZajec, 2);

    RETURN @ProcentObecnosci;
END;


SELECT dbo.ObecnoscUcznia(265) AS Procent_Obecności;

--Liczba uczęstników konkursu

CREATE FUNCTION dbo.LiczbaUczestnikowKonkursu
(
    @IdKonkursu BIGINT
)
RETURNS INT
AS
BEGIN
    DECLARE @Liczba INT

    SELECT @Liczba = COUNT(*)
    FROM Konkursy_uczniowie
    WHERE Id_konkursu = @IdKonkursu

    RETURN @Liczba
END


SELECT dbo.LiczbaUczestnikowKonkursu(2) AS Liczba;




multi-statement valued function

CREATE FUNCTION dbo.ZagrozeniUczniowie
(
@IdKlasy BIGINT
)
RETURNS @Tabela TABLE
(
Imie VARCHAR(50), Nazwisko VARCHAR(50), Średnia FLOAT, Zagrozony VARCHAR(10)
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
	CASE WHEN Średnia< 1.75 THEN 'TAK'
	ELSE 'NIE'
	
	END
RETURN 
END

SELECT * FROM dbo.ZagrozeniUczniowie(5) ORDER BY Średnia DESC

inline valued functions


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


WIDOKI


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

	CREATE VIEW ZwycięzcyKonkurs AS
SELECT O.Imie, O.Nazwisko, KL.Kod Kod_Klasy, KON.Nazwa_konkursu

FROM
Uczniowie U
INNER JOIN Osoby O ON O.Id_osoby=U.Id_Osoby
INNER JOIN Konkursy_uczniowie KU ON KU.Uczniowie_Id_Osoby=U.Id_Osoby
INNER JOIN Konkursy KON ON KON.Id_konkursu=KU.Id_konkursu
INNER JOIN Uczen_klasa UK ON UK.Uczniowie_Id_osoby=U.Id_Osoby
INNER JOIN Klasy KL ON KL.Id_klasy=UK.Klasy_Id_klasy
WHERE KU.Wynik='Pierwsze Miejsce'

SELECT * FROM ZwycięzcyKonkurs


WIDOK INDEKSOWANY

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

SELECT

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

 SELECT TOP 10 O.Imie, O.Nazwisko, COUNT(UC.Obecny) AS LiczbaNieobecnosci
    FROM Uczniowie U
    INNER JOIN Uczestnictwo UC ON U.Id_Osoby = UC.Uczniowie_Id_osoby
	INNER JOIN Osoby O On O.Id_osoby = U.Id_Osoby
    WHERE UC.Obecny = 0 
    GROUP BY O.Imie, O.Nazwisko
    ORDER BY LiczbaNieobecnosci DESC
FUNKCJA RANKINGOWA
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


WYZWALACZ DML
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

    PRINT 'Dodano nową ocenę ' + CAST(@Ocena AS VARCHAR) + ' uczniowi ' + @Imie + ' ' + @Nazwisko + ' w dniu ' + CAST(@Data AS VARCHAR);
END;


INSERT INTO Oceny(Ocena, Komentarz, Data, Uczestnictwo_ID) VALUES (10, 'DOBRZE', '2024-05-05', 3);

WYZWALACZ DDL

CREATE TRIGGER NieUsuwaj
ON DATABASE
FOR DROP_TABLE
AS
	PRINT 'Nie możesz usunąć tabeli'
	ROLLBACK;

DROP TABLE dbo.Konkursy_uczniowie

WYZWALACZ insted of

CREATE TRIGGER SprawdzOcene
ON Oceny
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (SELECT * FROM inserted WHERE Ocena < 1 OR Ocena > 6)
    BEGIN
        ROLLBACK;
        
        THROW 50000, 'Ocena musi być z zakresu od 1 do 6.', 1;
    END
    ELSE
    BEGIN
        INSERT INTO Oceny (Ocena, Komentarz, Data, Uczestnictwo_ID)
        SELECT Ocena, Komentarz, Data, Uczestnictwo_ID
        FROM inserted;
    END
END


INSERT INTO Oceny (Ocena, Komentarz, Data, Uczestnictwo_ID) VALUES (4, 'abcdeF', '2025-03-04', 1)

