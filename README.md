# School Database (SQL Server)

This project presents a complete school database created in Microsoft SQL Server. The goal of the project was to design a relational database and implement key T-SQL programming features such as stored procedures, functions, views, indexes, and triggers.

## Features

The project includes:

* a relational school database design,
* a script for creating all tables and relationships,
* a script for populating the database with sample data,
* stored procedures,
* scalar functions,
* Inline Table-Valued Functions,
* Multi-Statement Table-Valued Functions,
* views,
* an indexed view,
* indexes,
* ranking functions (`DENSE_RANK`, `LAG`, `LEAD`),
* DML, DDL, and INSTEAD OF triggers,
* sample SQL queries.

## Project Structure

| File | Description |
|------|-------------|
| `Szkoła.docx` | Project documentation and all assignment requirements |
| `TworzenieTabel.docx` | Creating tables and keys |
| `Uzupelnianie calej bazy.sql` | Populating the database with sample data |
| `procedury.sql` | Stored procedures |
| `scalar function.sql` | Scalar functions |
| `inline valued functions.sql` | Inline table-valued functions |
| `multi-statement valued function.sql` | Multi-statement table-valued functions |
| `Widoki.sql` | View definitions |
| `widok indeksowany.sql` | Indexed view |
| `indeksy.sql` | Creating indexes |
| `ranking.sql` | Queries using ranking functions |
| `funkcje rankingowe lag, lead.sql` | Examples of LAG and LEAD functions |
| `trigger dml.sql` | DML trigger |
| `trigger ddl.sql` | DDL trigger |
| `trigger instead.sql` | INSTEAD OF trigger |
| `selecty.sql` | Sample SQL queries |
| `szkola.dmd` | Database diagram |

## Database Model

The database represents the operation of a school and includes, among others, the following entities:

* People
* Students
* Employees
* Classes
* Lessons
* Participation
* Grades
* Competitions
* Subjects
* Positions

Relationships between the tables are implemented using primary and foreign keys.

## SQL Features Used

The project makes use of:

* PRIMARY KEY
* FOREIGN KEY
* UNIQUE
* IDENTITY
* SEQUENCE
* Stored Procedures
* Scalar Functions
* Table-Valued Functions
* Views
* Indexed Views
* Clustered and Nonclustered Indexes
* Window Functions (`DENSE_RANK`, `LAG`, `LEAD`)
* Transactions
* Exception Handling (`TRY...CATCH`)
* DML Triggers
* DDL Triggers
* INSTEAD OF Triggers

## Example Functionality

* adding students and employees,
* deleting lessons together with related records,
* calculating a student's average grade,
* calculating student attendance,
* identifying at-risk students,
* displaying class averages,
* ranking students by average grade,
* preventing accidental table deletion,
* validating grades using triggers.

## Technologies

* Microsoft SQL Server
* Transact-SQL (T-SQL)

## Installation and Setup

### Requirements

* Microsoft SQL Server
* SQL Server Management Studio (SSMS)

### Script Execution Order

After creating a new database, execute the scripts in the following order:

1. **Create the database tables**

   * Copy and execute the script from **TworzenieTabel.sql**, which creates all tables, primary keys, and foreign keys.

2. **Populate the database with sample data**

   ```text
   Uzupelnianie calej bazy.sql
   ```

3. **Add stored procedures**

   ```text
   procedury.sql
   ```

4. **Add functions**

   ```text
   scalar function.sql
   inline valued functions.sql
   multi-statement valued function.sql
   ```

5. **Create views**

   ```text
   Widoki.sql
   widok indeksowany.sql
   ```

6. **Create indexes**

   ```text
   indeksy.sql
   ```

7. **Add triggers**

   ```text
   trigger dml.sql
   trigger ddl.sql
   trigger instead.sql
   ```

8. **Run the sample queries**

   ```text
   selecty.sql
   ranking.sql
   funkcje rankingowe lag, lead.sql
   ```

After executing all scripts, the database will contain the complete schema, sample data, and all project components (stored procedures, functions, views, indexes, and triggers).

