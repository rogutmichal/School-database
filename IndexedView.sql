--Number of Lessons per Employee


CREATE VIEW dbo.EmployeeLessonCount
WITH SCHEMABINDING
AS
SELECT
    p.Person_ID,
    p.First_Name,
    p.Last_Name,
    COUNT_BIG(*) AS Lesson_Count
FROM dbo.Lessons l
INNER JOIN dbo.Employees e
    ON e.Person_ID = l.Employee_ID
INNER JOIN dbo.People p
    ON p.Person_ID = e.Person_ID
GROUP BY
    p.Person_ID,
    p.First_Name,
    p.Last_Name;
GO

CREATE UNIQUE CLUSTERED INDEX ucidx_employee_lesson_count
ON dbo.EmployeeLessonCount(Person_ID);
GO


-- Example

SELECT * FROM dbo.EmployeeLessonCount;
GO

