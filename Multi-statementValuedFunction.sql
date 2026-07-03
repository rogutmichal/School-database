--Students at Risk 

CREATE FUNCTION dbo.AtRiskStudents
(
    @ClassID BIGINT
)
RETURNS @Result TABLE
(
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    AverageGrade FLOAT,
    AtRisk VARCHAR(10)
)
AS
BEGIN
    INSERT INTO @Result
    SELECT
        p.First_Name,
        p.Last_Name,
        ROUND(AVG(g.Grade), 2),
        NULL
    FROM People p
    INNER JOIN Students s
        ON s.Person_ID = p.Person_ID
    INNER JOIN Attendance a
        ON a.Student_ID = s.Person_ID
    INNER JOIN Grades g
        ON g.Attendance_ID = a.Attendance_ID
    INNER JOIN Student_Classes sc
        ON sc.Student_ID = s.Person_ID
    WHERE sc.Class_ID = @ClassID
    GROUP BY p.First_Name, p.Last_Name;

    UPDATE @Result
    SET AtRisk =
        CASE
            WHEN AverageGrade < 1.75 THEN 'YES'
            ELSE 'NO'
        END;

    RETURN;
END;
GO


--Example

SELECT *
FROM dbo.AtRiskStudents(5)
ORDER BY AverageGrade DESC;
GO