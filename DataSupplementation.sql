USE School;
GO

CREATE SEQUENCE [dbo].[Seq_Person_ID]
AS [bigint]
START WITH 1
INCREMENT BY 1
MINVALUE -9223372036854775808
MAXVALUE 9223372036854775807
CACHE
GO

--- Subjects
INSERT INTO Subjects (Subject_Name) VALUES 
('biology'),
('chemistry'),
('physics'),
('geography'),
('history'),
('computer science'),
('english'),
('german'),
('french'),
('polish'),
('mathematics'),
('music'),
('art'),
('technology'),
('civics'),
('physical education');
GO

--- Positions
INSERT INTO Positions (Position_Name) VALUES 
('Teacher'),
('School Principal'),
('Vice Principal'),
('School Secretary'),
('School Pedagogue'),
('School Psychologist'),
('Librarian'),
('Support Teacher'),
('Janitor'),
('School Cook');
GO

--- Employees
CREATE SEQUENCE [dbo].[Seq_Employee]
AS [bigint]
START WITH 1
INCREMENT BY 1
CACHE
GO

DECLARE @Counter INT = 1;

WHILE @Counter <= 40
BEGIN
    DECLARE @Num NUMERIC(28);
    SELECT @Num = NEXT VALUE FOR Seq_Employee;

    DECLARE @PersonID BIGINT;
    SELECT @PersonID = NEXT VALUE FOR Seq_Person_ID;

    DECLARE @FirstName VARCHAR(50);
    DECLARE @LastName VARCHAR(50);
    DECLARE @Gender VARCHAR(50);
    DECLARE @BirthDate DATE;
    DECLARE @Email VARCHAR(50);
    DECLARE @Salary BIGINT;
    DECLARE @EmploymentType BIT;
    DECLARE @Phone VARCHAR(15);
    DECLARE @PositionID NUMERIC(28);

    SET @FirstName = CONCAT('EmpFirst', CAST(@Num AS VARCHAR(10)));
    SET @LastName = CONCAT('EmpLast', CAST(@Num AS VARCHAR(10)));
    SET @Gender = CASE WHEN RAND() > 0.5 THEN 'Male' ELSE 'Female' END;
    SET @BirthDate = DATEADD(YEAR, -CAST(RAND() * 60 + 20 AS INT), GETDATE());
    SET @Email = LOWER(@FirstName + '.' + @LastName + '@example.com');
    SET @Salary = CAST(ROUND(RAND() * 2000 + 3000, 0) AS BIGINT);
    SET @EmploymentType = CAST(ROUND(RAND(), 0) AS BIT);
    SET @Phone = CAST(ROUND(RAND() * 900000000 + 100000000, 0) AS BIGINT);

    SELECT TOP 1 @PositionID = Position_ID FROM Positions ORDER BY NEWID();

    INSERT INTO People (Person_ID, First_Name, Last_Name, Gender, Birth_Date, Email)
    VALUES (@PersonID, @FirstName, @LastName, @Gender, @BirthDate, @Email);

    INSERT INTO Employees (Salary, Employment_Type, Phone_Number, Person_ID, Position_ID)
    VALUES (@Salary, @EmploymentType, @Phone, @PersonID, @PositionID);

    SET @Counter = @Counter + 1;
END;
GO

--- Students
CREATE SEQUENCE [dbo].[Seq_Student]
AS [bigint]
START WITH 1
INCREMENT BY 1
CACHE
GO

DECLARE @Counter2 INT = 1;

WHILE @Counter2 <= 500
BEGIN
    DECLARE @Num2 NUMERIC(28);
    SELECT @Num2 = NEXT VALUE FOR Seq_Student;

    DECLARE @PersonID2 BIGINT;
    SELECT @PersonID2 = NEXT VALUE FOR Seq_Person_ID;

    DECLARE @FirstName2 VARCHAR(50);
    DECLARE @LastName2 VARCHAR(50);
    DECLARE @Gender2 VARCHAR(50);
    DECLARE @BirthDate2 DATE;
    DECLARE @Email2 VARCHAR(50);
    DECLARE @GuardianPhone VARCHAR(15);

    SET @FirstName2 = CONCAT('StudFirst', CAST(@Num2 AS VARCHAR(10)));
    SET @LastName2 = CONCAT('StudLast', CAST(@Num2 AS VARCHAR(10)));
    SET @Gender2 = CASE WHEN RAND() > 0.5 THEN 'Male' ELSE 'Female' END;
    SET @BirthDate2 = DATEADD(YEAR, -CAST(RAND() * 7 + 8 AS INT), GETDATE());
    SET @Email2 = LOWER(@FirstName2 + '.' + @LastName2 + '@example.com');
    SET @GuardianPhone = CAST(ROUND(RAND() * 900000000 + 100000000, 0) AS BIGINT);

    INSERT INTO People (Person_ID, First_Name, Last_Name, Gender, Birth_Date, Email)
    VALUES (@PersonID2, @FirstName2, @LastName2, @Gender2, @BirthDate2, @Email2);

    INSERT INTO Students (Guardian_Phone_Number, Person_ID)
    VALUES (@GuardianPhone, @PersonID2);

    SET @Counter2 = @Counter2 + 1;
END;
GO

--- Classes
DECLARE @SchoolYear DATE = '2023-09-01';

DECLARE @ClassCodes TABLE (Code VARCHAR(30));

INSERT INTO @ClassCodes VALUES 
('1a'), ('1b'), ('1c'), ('1d'),
('2a'), ('2b'), ('2c'), ('2d'),
('3a'), ('3b'), ('3c'), ('3d'),
('4a'), ('4b'), ('4c'), ('4d');

INSERT INTO Classes (School_Year, Class_Code, Class_Name)
SELECT 
    @SchoolYear,
    Code,
    CASE 
        WHEN RIGHT(Code, 1) = 'a' THEN 'Humanities'
        WHEN RIGHT(Code, 1) = 'b' THEN 'Math-Physics'
        WHEN RIGHT(Code, 1) = 'c' THEN 'Biology-Chemistry'
        WHEN RIGHT(Code, 1) = 'd' THEN 'Geography'
    END
FROM @ClassCodes;
GO

--- Student_Classes
DECLARE @Start DATE = '2023-09-01';
DECLARE @End DATE = '2024-06-30';

DECLARE @StudentCount INT;
SELECT @StudentCount = COUNT(*) FROM Students;

DECLARE @i INT = 1;

WHILE @i <= @StudentCount
BEGIN
    DECLARE @ClassID BIGINT;
    SELECT TOP 1 @ClassID = Class_ID FROM Classes ORDER BY NEWID();

    INSERT INTO Student_Classes (Student_ID, Class_ID, Start_Date, End_Date)
    VALUES (@i, @ClassID, @Start, @End);

    SET @i = @i + 1;
END;
GO

--- Lessons
DECLARE @StartDate DATETIME = '2023-09-01';
DECLARE @EndDate DATETIME = '2024-06-30';

DECLARE @CounterLessons INT = 1;

WHILE @CounterLessons <= 1000
BEGIN
    DECLARE @Room BIGINT = CAST(RAND() * 21 + 10 AS BIGINT);
    DECLARE @Subject VARCHAR(50);
    SELECT TOP 1 @Subject = Subject_Name FROM Subjects ORDER BY NEWID();

    DECLARE @DateTime DATETIME = DATEADD(DAY, RAND() * DATEDIFF(DAY, @StartDate, @EndDate), @StartDate);
    SET @DateTime = DATEADD(HOUR, CAST(RAND() * 9 AS INT) + 8, @DateTime);

    DECLARE @EmployeeID BIGINT;
    SELECT TOP 1 @EmployeeID = Person_ID FROM Employees ORDER BY NEWID();

    DECLARE @ClassID2 BIGINT;
    SELECT TOP 1 @ClassID2 = Class_ID FROM Classes ORDER BY NEWID();

    INSERT INTO Lessons (Room_Number, Subject_Name, Lesson_DateTime, Class_ID, Employee_ID)
    VALUES (@Room, @Subject, @DateTime, @ClassID2, @EmployeeID);

    SET @CounterLessons = @CounterLessons + 1;
END;
GO

--- Attendance
DECLARE @CounterAtt INT = 1;

WHILE @CounterAtt <= 10000
BEGIN
    DECLARE @LessonID BIGINT;
    SELECT TOP 1 @LessonID = Lesson_ID FROM Lessons ORDER BY NEWID();

    DECLARE @ClassID3 BIGINT;
    SELECT @ClassID3 = Class_ID FROM Lessons WHERE Lesson_ID = @LessonID;

    DECLARE @StudentID BIGINT;
    SELECT TOP 1 @StudentID = Student_ID FROM Student_Classes WHERE Class_ID = @ClassID3 ORDER BY NEWID();

    DECLARE @Present BIT = CAST(RAND() * 2 AS INT);

    INSERT INTO Attendance (Student_ID, Lesson_ID, Present, Notes)
    VALUES (@StudentID, @LessonID, @Present, 'Sample note');

    SET @CounterAtt = @CounterAtt + 1;
END;
GO

--- Grades
DECLARE @CounterGrades INT = 1;

WHILE @CounterGrades <= 2000
BEGIN
    DECLARE @AttendanceID NUMERIC(28);
    SELECT TOP 1 @AttendanceID = Attendance_ID FROM Attendance ORDER BY NEWID();

    DECLARE @Grade BIGINT = CAST(RAND() * 6 + 1 AS BIGINT);

    INSERT INTO Grades (Grade, Comment, Grade_Date, Attendance_ID)
    SELECT @Grade, 'comment', Lesson_DateTime, @AttendanceID
    FROM Lessons
    WHERE Lesson_ID = (SELECT TOP 1 Lesson_ID FROM Attendance WHERE Attendance_ID = @AttendanceID);

    SET @CounterGrades = @CounterGrades + 1;
END;
GO

--- Competitions
DECLARE @CounterComp INT = 1;

WHILE @CounterComp <= 15
BEGIN
    INSERT INTO Competitions (Competition_Name)
    VALUES (CONCAT('Competition', @CounterComp));

    SET @CounterComp = @CounterComp + 1;
END;
GO

--- Competition_Students
DECLARE @CounterCS INT = 1;

WHILE @CounterCS <= 100
BEGIN
    DECLARE @CompID BIGINT;
    SELECT TOP 1 @CompID = Competition_ID FROM Competitions ORDER BY NEWID();

    DECLARE @StudID BIGINT;
    SELECT TOP 1 @StudID = Person_ID FROM Students ORDER BY NEWID();

    DECLARE @Result VARCHAR(50);
    SET @Result = CASE CAST(RAND() * 4 AS INT)
        WHEN 0 THEN 'First Place'
        WHEN 1 THEN 'Second Place'
        WHEN 2 THEN 'Third Place'
        ELSE 'Honorable Mention'
    END;

    INSERT INTO Competition_Students (Result, Competition_ID, Student_ID)
    VALUES (@Result, @CompID, @StudID);

    SET @CounterCS = @CounterCS + 1;
END;
GO