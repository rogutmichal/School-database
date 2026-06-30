# School Database (SQL Server)

Projekt przedstawia kompletną bazę danych szkoły stworzoną w Microsoft SQL Server. Celem projektu było zaprojektowanie relacyjnej bazy danych oraz implementacja najważniejszych elementów programowania w T-SQL, takich jak procedury składowane, funkcje, widoki, indeksy oraz wyzwalacze.

## Funkcjonalności

Projekt zawiera:

* projekt relacyjnej bazy danych szkoły,
* skrypt tworzący wszystkie tabele i relacje,
* skrypt uzupełniający bazę przykładowymi danymi,
* procedury składowane,
* funkcje skalarne,
* funkcje tabelaryczne (Inline Table-Valued Functions),
* funkcje wieloinstrukcyjne (Multi-Statement Table-Valued Functions),
* widoki,
* widok indeksowany,
* indeksy,
* funkcje rankingowe (`DENSE_RANK`, `LAG`, `LEAD`),
* wyzwalacze DML, DDL oraz INSTEAD OF,
* przykładowe zapytania SQL.

## Struktura projektu

| Plik                                  | Opis                                           |
| ------------------------------------- | ---------------------------------------------- |
| `Szkoła.docx`                         | Dokumentacja projektu oraz wszystkie polecenia |
| `Uzupelnianie calej bazy.sql`         | Wypełnienie bazy przykładowymi danymi          |
| `procedury.sql`                       | Procedury składowane                           |
| `scalar function.sql`                 | Funkcje skalarne                               |
| `inline valued functions.sql`         | Funkcje tabelaryczne inline                    |
| `multi-statement valued function.sql` | Funkcje tabelaryczne wieloinstrukcyjne         |
| `Widoki.sql`                          | Definicje widoków                              |
| `widok indeksowany.sql`               | Widok indeksowany                              |
| `indeksy.sql`                         | Tworzenie indeksów                             |
| `ranking.sql`                         | Zapytania wykorzystujące funkcje rankingowe    |
| `funkcje rankingowe lag, lead.sql`    | Przykłady funkcji LAG i LEAD                   |
| `trigger dml.sql`                     | Wyzwalacz DML                                  |
| `trigger ddl.sql`                     | Wyzwalacz DDL                                  |
| `trigger instead.sql`                 | Wyzwalacz INSTEAD OF                           |
| `selecty.sql`                         | Przykładowe zapytania SQL                      |
| `szkola.dmd`                          | Diagram bazy danych                            |

## Model bazy danych

Baza danych opisuje działanie szkoły i zawiera między innymi następujące encje:

* Osoby
* Uczniowie
* Pracownicy
* Klasy
* Zajęcia
* Uczestnictwo
* Oceny
* Konkursy
* Przedmioty
* Stanowiska

Relacje pomiędzy tabelami zostały zrealizowane przy użyciu kluczy głównych i obcych.

## Zastosowane elementy SQL

Projekt wykorzystuje:

* PRIMARY KEY
* FOREIGN KEY
* UNIQUE
* IDENTITY
* SEQUENCE
* Procedury składowane
* Funkcje skalarne
* Funkcje tabelaryczne
* Widoki
* Widoki indeksowane
* Indeksy klastrowane i nieklastrowane
* Funkcje okna (`DENSE_RANK`, `LAG`, `LEAD`)
* Transakcje
* Obsługę wyjątków (`TRY...CATCH`)
* Wyzwalacze DML
* Wyzwalacze DDL
* Wyzwalacze INSTEAD OF

## Przykładowe funkcjonalności

* dodawanie uczniów i pracowników,
* usuwanie zajęć wraz z powiązanymi rekordami,
* obliczanie średniej ocen ucznia,
* obliczanie frekwencji ucznia,
* wyszukiwanie uczniów zagrożonych,
* wyświetlanie średnich klas,
* ranking uczniów według średniej ocen,
* zabezpieczenie przed usunięciem tabel,
* walidacja poprawności ocen za pomocą wyzwalacza.

## Technologie

* Microsoft SQL Server
* Transact-SQL (T-SQL)

## Autor

Projekt wykonany w ramach zajęć z baz danych.
