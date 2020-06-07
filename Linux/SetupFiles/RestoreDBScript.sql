GO
CREATE TABLE  #tmp (backupFileName VARCHAR(1000),depth INT,files INT)

DECLARE @backupDataBasesPath VARCHAR(1000) = '/sqldb_backup/backup/'
DECLARE @dataBasesPath VARCHAR(1000) = '/var/opt/mssql/data/'

INSERT INTO #tmp EXEC xp_dirtree @backupDataBasesPath,1,1

DECLARE @fileName VARCHAR(1000)

WHILE (SELECT Count(*) FROM #tmp WHERE backupFileName is not null and right(backupFileName,4)='.bak') > 0

BEGIN
	DECLARE @DBNAME NVARCHAR(50) 
	SELECT TOP 1 @filename=backupFileName,@DBNAME=SUBSTRING(backupFileName,0,CHARINDEX('-',backupFileName)) FROM #tmp WHERE backupFileName is not null and right(backupFileName,4)='.bak'
	DECLARE @frompath NVARCHAR(MAX) = 'N'+''''+@backupDataBasesPath+(SELECT TOP 1 backupFileName FROM #tmp WHERE right(backupFileName,4)='.bak')+''''
	DECLARE @topath NVARCHAR(MAX) = 'N'+''''+@dataBasesPath+@DBNAME+'.mdf'+''''
	DECLARE @logpath NVARCHAR(MAX) = 'N'+''''+@dataBasesPath+@DBNAME+'_log.ldf'+''''

	Declare @frommove nvarchar(50)=(SELECT name	FROM sys.master_files AS mf where DB_NAME(database_id)=@DBNAME and type=0)

	Declare @logname nvarchar(50)=(SELECT name FROM sys.master_files AS mf where DB_NAME(database_id)=@DBNAME and type=1)
	
	DECLARE @testcmd NVARCHAR(max)= 'RESTORE DATABASE '+'['+ @DBNAME+']'+' FROM DISK ='+ @frompath+' WITH  FILE = 1,  MOVE '+'N'+''''+@frommove+''''+ ' TO '+@topath+',  MOVE '+'N'+''''+@logname+''''+' TO '+@logpath+',REPLACE,  STATS = 5'
	
	execute sp_executesql @testcmd
	
	DECLARE @alterauth NVARCHAR(max) ='ALTER AUTHORIZATION ON DATABASE:: '+@DBNAME+' TO Concento'
	execute sp_executesql @alterauth
	
	DELETE FROM #tmp WHERE backupFileName = @FileName
END

DROP TABLE #tmp
GO


