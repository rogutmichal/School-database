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
    @Plec = 'Mê¿czyzna',
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


---USUWANIE ZAJEÆ

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
