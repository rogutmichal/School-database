--Average Grade per Class

CREATE VIEW ClassAverageGrades AS
SELECT
    c.Class_Code,
    c.Class_Name,
    ROUND(AVG(g.Grade), 2) AS Average_Grade
FROM Classes c
INNER JOIN Student_Classes sc
    ON c.Class_ID = sc.Class_ID
INNER JOIN Attendance a
    ON sc.Student_ID = a.Student_ID
INNER JOIN Grades g
    ON a.Attendance_ID = g.Attendance_ID
GROUP BY
    c.Class_ID,
    c.Class_Code,
    c.Class_Name;
GO

--Example

SELECT * FROM ClassAverageGrades
ORDER BY Class_Code;
GO

--Average Salary by Position

CREATE VIEW AverageSalaryByPosition AS
SELECT
    p.Position_Name AS Position,
    AVG(e.Salary) AS Average_Salary
FROM Employees e
INNER JOIN Positions p
    ON e.Position_ID = p.Position_ID
GROUP BY
    p.Position_Name;
GO



--Example

SELECT * FROM AverageSalaryByPosition;
GO

--Competition Winners


CREATE VIEW CompetitionWinners AS
SELECT
    pe.First_Name,
    pe.Last_Name,
    c.Class_Code AS Class_Code,
    co.Competition_Name
FROM Students s
INNER JOIN People pe
    ON pe.Person_ID = s.Person_ID
INNER JOIN Competition_Students cs
    ON cs.Student_ID = s.Person_ID
INNER JOIN Competitions co
    ON co.Competition_ID = cs.Competition_ID
INNER JOIN Student_Classes sc
    ON sc.Student_ID = s.Person_ID
INNER JOIN Classes c
    ON c.Class_ID = sc.Class_ID
WHERE cs.Result = 'First Place';
GO


--Example

SELECT * FROM CompetitionWinners;
GO