--Student Ranking + Previous Student Average (LAG)


SELECT
    s.Person_ID AS Student_ID,
    p.First_Name,
    p.Last_Name,
    ROUND(AVG(g.Grade), 2) AS Student_Average,

    RANK() OVER (
        ORDER BY ROUND(AVG(g.Grade), 2) DESC
    ) AS Ranking_Position,

    ROUND(
        LAG(AVG(g.Grade)) OVER (
            ORDER BY ROUND(AVG(g.Grade), 2) DESC
        ),
        2
    ) AS Previous_Student_Average

FROM Attendance a
INNER JOIN Grades g
    ON a.Attendance_ID = g.Attendance_ID
INNER JOIN Students s
    ON a.Student_ID = s.Person_ID
INNER JOIN People p
    ON s.Person_ID = p.Person_ID

GROUP BY
    s.Person_ID,
    p.First_Name,
    p.Last_Name;
GO

--Student Ranking + Next Student Average (LEAD)


SELECT
    s.Person_ID AS Student_ID,
    p.First_Name,
    p.Last_Name,
    ROUND(AVG(g.Grade), 2) AS Student_Average,

    RANK() OVER (
        ORDER BY ROUND(AVG(g.Grade), 2) DESC
    ) AS Ranking_Position,

    ROUND(
        LEAD(AVG(g.Grade)) OVER (
            ORDER BY ROUND(AVG(g.Grade), 2) DESC
        ),
        2
    ) AS Next_Student_Average

FROM Attendance a
INNER JOIN Grades g
    ON a.Attendance_ID = g.Attendance_ID
INNER JOIN Students s
    ON a.Student_ID = s.Person_ID
INNER JOIN People p
    ON s.Person_ID = p.Person_ID

GROUP BY
    s.Person_ID,
    p.First_Name,
    p.Last_Name;
GO