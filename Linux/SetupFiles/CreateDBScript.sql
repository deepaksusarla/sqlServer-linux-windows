GO
CREATE TABLE  #tmp (backupFileName VARCHAR(1000),depth INT,files INT)
DECLARE @backupDataBasesPath VARCHAR(1000) = '/sqldb_backup/backup/'
INSERT INTO #tmp EXEC xp_dirtree @backupDataBasesPath,1,1
DECLARE @fileName VARCHAR(1000)

WHILE (SELECT Count(*) FROM #tmp WHERE backupFileName is not null and right(backupFileName,4)='.bak') > 0

BEGIN
	DECLARE @DBNAME NVARCHAR(50) 
	SELECT TOP 1 @filename=backupFileName,@DBNAME=SUBSTRING(backupFileName,0,CHARINDEX('-',backupFileName)) FROM #tmp WHERE backupFileName is not null and right(backupFileName,4)='.bak'
	IF (NOT EXISTS(SELECT * FROM master.sys.databases WHERE name=@DBNAME))
		BEGIN
			Print @DBNAME
			Print 'DB Not exists'
			DECLARE @createdb NVARCHAR(max) ='CREATE DATABASE '+@DBNAME
			EXECUTE (@createdb)
			DELETE FROM #tmp WHERE backupFileName = @FileName
		END
END

DROP TABLE #tmp
GO