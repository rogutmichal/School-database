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
| `TablesCreating.docx` | Creating tables and keys |
| `DataSupplementation.sql` | Populating the database with sample data |
| `Procedures.sql` | Stored procedures |
| `ScalarFunctions.sql` | Scalar functions |
| `InlineValueFunctions.sql` | Inline table-valued functions |
| `Multi-statementValuedFunction.sql` | Multi-statement table-valued functions |
| `Views.sql` | View definitions |
| `IndexView'.sql` | Indexed view |
| `Index.sql` | Creating indexes |
| `Ranking.sql` | Queries using ranking functions |
| `Laq, Lead.sql` | Examples of LAG and LEAD functions |
| `Triggers.sql` | Triggers |
| `Select.sql` | Sample SQL queries |

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

   * Copy and execute the script from **TableCreating.sql**, which creates all tables, primary keys, and foreign keys.

2. **Populate the database with sample data**

   ```text
  DataSupplementation..sql
   ```

3. **Add stored procedures**

   ```text
   Procedures.sql
   ```

4. **Add functions**

   ```text
   ScalarFunction.sql
   InlineValuedFunctions.sql
   Multi-StatementValuedFunction.sql
   ```

5. **Create views**

   ```text
   Views.sql
   IndexedView.sql
   ```

6. **Create indexes**

   ```text
   Index.sql
   ```

7. **Add triggers**

   ```text
   Triggers.sql
   ```

8. **Run the sample queries**

   ```text
   Select.sql
   Ranking.sql
   Lag, Lead.sql
   ```

After executing all scripts, the database will contain the complete schema, sample data, and all project components (stored procedures, functions, views, indexes, and triggers).

