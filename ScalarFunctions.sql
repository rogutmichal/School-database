-- Student Average Grade
CREATE FUNCTION dbo.StudentAverage (@StudentID BIGINT)
RETURNS FLOAT
AS
BEGIN
    DECLARE @Average FLOAT;

    SELECT @Average = ROUND(AVG(Grade), 2)
    FROM Grades g
    INNER JOIN Attendance a ON g.Attendance_ID = a.Attendance_ID
    WHERE a.Student_ID = @StudentID;

    RETURN (@Average);
END;
GO

-- Example

SELECT dbo.StudentAverage(350) AS Average;
GO



-- Student Attendance Percentage
CREATE FUNCTION dbo.StudentAttendancePercentage (@StudentID BIGINT)
RETURNS FLOAT
AS
BEGIN
    DECLARE @PresentCount INT;
    DECLARE @TotalLessons INT;
    DECLARE @AttendancePercent FLOAT;

    SELECT @PresentCount = COUNT(*)
    FROM Attendance
    WHERE Student_ID = @StudentID
      AND Present = 1;

    SELECT @TotalLessons = COUNT(*)
    FROM Attendance
    WHERE Student_ID = @StudentID;

    IF @TotalLessons = 0
        RETURN 0;

    SET @AttendancePercent = ROUND((@PresentCount * 100.0) / @TotalLessons, 2);

    RETURN @AttendancePercent;
END;
GO



-- Example


SELECT dbo.StudentAttendancePercentage(265) AS AttendancePercentage;
GO


-- Number of Competition Participants
CREATE FUNCTION dbo.CompetitionParticipantCount
(
    @CompetitionID BIGINT
)
RETURNS INT
AS
BEGIN
    DECLARE @Count INT;

    SELECT @Count = COUNT(*)
    FROM Competition_Students
    WHERE Competition_ID = @CompetitionID;

    RETURN @Count;
END;
GO


-- Example 

SELECT dbo.CompetitionParticipantCount(2) AS ParticipantCount;
GO