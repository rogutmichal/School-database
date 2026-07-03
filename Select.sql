--Top Students with Most Absences


SELECT TOP 10
    p.First_Name,
    p.Last_Name,
    COUNT(a.Present) AS Absence_Count
FROM Students s
INNER JOIN Attendance a
    ON s.Person_ID = a.Student_ID
INNER JOIN People p
    ON p.Person_ID = s.Person_ID
WHERE a.Present = 0
GROUP BY p.First_Name, p.Last_Name
ORDER BY Absence_Count DESC;
GO


--High Achieving Students (Average Grade > 4.75)


SELECT
    p.First_Name,
    p.Last_Name,
    c.Class_Code AS Class_Code,
    ROUND(AVG(g.Grade), 2) AS Average_Grade
FROM Classes c
JOIN Student_Classes sc
    ON c.Class_ID = sc.Class_ID
JOIN Students s
    ON sc.Student_ID = s.Person_ID
JOIN People p
    ON s.Person_ID = p.Person_ID
JOIN Attendance a
    ON s.Person_ID = a.Student_ID
JOIN Grades g
    ON a.Attendance_ID = g.Attendance_ID
GROUP BY
    p.First_Name,
    p.Last_Name,
    c.Class_Code
HAVING
    ROUND(AVG(g.Grade), 2) > 4.75
ORDER BY
    Average_Grade DESC;
GO