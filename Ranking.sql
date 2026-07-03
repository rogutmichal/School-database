---Student Ranking with Class Averages

SELECT
    s.Person_ID AS Student_ID,
    p.First_Name AS FirstName,
    p.Last_Name AS LastName,
    sc.Class_ID,

    ROUND(AVG(g.Grade), 2) AS Student_Average,

    ROUND(
        AVG(AVG(g.Grade)) OVER (PARTITION BY sc.Class_ID),
        2
    ) AS Class_Average,

    DENSE_RANK() OVER (
        ORDER BY ROUND(AVG(g.Grade), 2) DESC
    ) AS Ranking_Position

FROM Attendance a
INNER JOIN Grades g
    ON a.Attendance_ID = g.Attendance_ID
INNER JOIN Students s
    ON a.Student_ID = s.Person_ID
INNER JOIN People p
    ON s.Person_ID = p.Person_ID
INNER JOIN Student_Classes sc
    ON s.Person_ID = sc.Student_ID

GROUP BY
    s.Person_ID,
    p.First_Name,
    p.Last_Name,
    sc.Class_ID;
GO