-- Add Employee
CREATE PROCEDURE AddEmployee
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @Gender VARCHAR(50),
    @BirthDate DATE,
    @Email VARCHAR(50),
    @Salary BIGINT,
    @EmploymentType BIT,
    @PhoneNumber VARCHAR(15),
    @PositionID NUMERIC(28)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @PersonID BIGINT;

        SELECT @PersonID = NEXT VALUE FOR Seq_Person_ID;

        INSERT INTO People (Person_ID, First_Name, Last_Name, Gender, Birth_Date, Email)
        VALUES (@PersonID, @FirstName, @LastName, @Gender, @BirthDate, @Email);

        INSERT INTO Employees (Salary, Employment_Type, Phone_Number, Person_ID, Position_ID)
        VALUES (@Salary, @EmploymentType, @PhoneNumber, @PersonID, @PositionID);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH;
END;
GO
---EXEC example 

EXEC AddEmployee
    @FirstName = 'John',
    @LastName = 'Smith',
    @Gender = 'Male',
    @BirthDate = '1985-06-15',
    @Email = 'john.smith2@example.com',
    @Salary = 50000,
    @EmploymentType = 1,
    @PhoneNumber = '123456789',
    @PositionID = 3;
GO


---Add Student Procedure

CREATE PROCEDURE AddStudent
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @Gender VARCHAR(50),
    @BirthDate DATE,
    @Email VARCHAR(50),
    @GuardianPhoneNumber VARCHAR(15)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @PersonID BIGINT;

        SELECT @PersonID = NEXT VALUE FOR Seq_Person_ID;

        INSERT INTO People (Person_ID, First_Name, Last_Name, Gender, Birth_Date, Email)
        VALUES (@PersonID, @FirstName, @LastName, @Gender, @BirthDate, @Email);

        INSERT INTO Students (Guardian_Phone_Number, Person_ID)
        VALUES (@GuardianPhoneNumber, @PersonID);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH;
END;
GO

----EXEC example

EXEC AddStudent
    @FirstName = 'Anna',
    @LastName = 'Nowak',
    @Gender = 'Female',
    @BirthDate = '2010-04-25',
    @Email = 'anna.nowak2@example.com',
    @GuardianPhoneNumber = '987654321';
GO


   --- Delete Lesson

   CREATE PROCEDURE DeleteLesson
    @LessonID BIGINT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        DELETE FROM Grades
        WHERE Attendance_ID IN (
            SELECT Attendance_ID
            FROM Attendance
            WHERE Lesson_ID = @LessonID
        );

        DELETE FROM Attendance
        WHERE Lesson_ID = @LessonID;

        DELETE FROM Lessons
        WHERE Lesson_ID = @LessonID;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH;
END;
GO


---EXEC example


EXEC DeleteLesson 122;
GO
