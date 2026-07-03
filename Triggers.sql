--Grade Notification


CREATE TRIGGER NotifyNewGrade
ON Grades
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Grade FLOAT,
            @StudentID BIGINT,
            @FirstName VARCHAR(50),
            @LastName VARCHAR(50),
            @GradeDate DATE;

    -- Get inserted grade data
    SELECT
        @Grade = i.Grade,
        @StudentID = a.Student_ID,
        @GradeDate = i.Grade_Date,
        @FirstName = p.First_Name,
        @LastName = p.Last_Name
    FROM inserted i
    INNER JOIN Attendance a
        ON i.Attendance_ID = a.Attendance_ID
    INNER JOIN Students s
        ON a.Student_ID = s.Person_ID
    INNER JOIN People p
        ON s.Person_ID = p.Person_ID;

    PRINT 'New grade ' + CAST(@Grade AS VARCHAR)
        + ' has been added for student '
        + @FirstName + ' ' + @LastName
        + ' on ' + CAST(@GradeDate AS VARCHAR);
END;
GO

-- Example

INSERT INTO Grades (Grade, Comment, Grade_Date, Attendance_ID)
VALUES (4, 'GOOD', '2024-05-05', 3);
GO


--Prevent Table Deletion


CREATE TRIGGER PreventTableDrop
ON DATABASE
FOR DROP_TABLE
AS
BEGIN
    PRINT 'You are not allowed to drop tables';
    ROLLBACK;
END;
GO

-- Example


DROP TABLE dbo.Competition_Students;
GO

--- Validate Grade Range


CREATE TRIGGER ValidateGrade
ON Grades
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (
        SELECT *
        FROM inserted
        WHERE Grade < 1 OR Grade > 6
    )
    BEGIN
        ROLLBACK;

        THROW 50000, 'Grade must be in range from 1 to 6.', 1;
    END
    ELSE
    BEGIN
        INSERT INTO Grades (Grade, Comment, Grade_Date, Attendance_ID)
        SELECT
            Grade,
            Comment,
            Grade_Date,
            Attendance_ID
        FROM inserted;
    END
END;
GO

-- Example 


INSERT INTO Grades (Grade, Comment, Grade_Date, Attendance_ID)
VALUES (9, 'abcdeF', '2025-03-04', 1);
GO