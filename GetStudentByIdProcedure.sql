CREATE PROCEDURE GetStudentById
	@StudentId INT
AS
BEGIN
	SELECT 
	StudentIdPK,
	F�rNamn,
	EfterNamn,
	Personnummer
	FROM StudentTabell WHERE StudentIdPK = @StudentId;
END;

--F�r att k�ra proceduren.
--EXEC GetStudentById @StudentId = 1005;