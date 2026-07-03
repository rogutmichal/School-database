--Students in a Class

CREATE FUNCTION dbo.StudentsInClass
(
    @ClassID BIGINT
)
RETURNS TABLE
AS
RETURN
(
    SELECT
        People.First_Name,
        People.Last_Name
    FROM Student_Classes
    INNER JOIN People
        ON Student_Classes.Student_ID = People.Person_ID
    WHERE Student_Classes.Class_ID = @ClassID
);
GO


--Example

SELECT * FROM dbo.StudentsInClass(13);
GO

--Employees by Position


CREATE FUNCTION dbo.EmployeesByPosition
(
    @PositionName VARCHAR(50)
)
RETURNS TABLE
AS
RETURN
(
    SELECT
        People.First_Name AS FirstName,
        People.Last_Name AS LastName,
        People.Email AS Email,
        Employees.Salary AS Salary,
        Employees.Phone_Number AS PhoneNumber
    FROM Employees
    INNER JOIN People
        ON Employees.Person_ID = People.Person_ID
    INNER JOIN Positions
        ON Employees.Position_ID = Positions.Position_ID
    WHERE Positions.Position_Name = @PositionName
);
GO


-- Example

SELECT * FROM dbo.EmployeesByPosition('Teacher');
GO