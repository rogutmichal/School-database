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