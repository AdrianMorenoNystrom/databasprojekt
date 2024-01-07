CREATE PROCEDURE GetStudentById
	@StudentId INT
AS
BEGIN
	SELECT 
	StudentIdPK,
	FörNamn,
	EfterNamn,
	Personnummer
	FROM StudentTabell WHERE StudentIdPK = @StudentId;
END;

--För att köra proceduren.
--EXEC GetStudentById @StudentId = 1005;