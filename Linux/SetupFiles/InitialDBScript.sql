USE [master];
GO
CREATE LOGIN Concento WITH PASSWORD = 'Concento#1', CHECK_POLICY = OFF
GO
CREATE DATABASE CONCENTO
GO
ALTER AUTHORIZATION ON DATABASE:: CONCENTO TO Concento;
GO
CREATE DATABASE DEPLOY2
GO
ALTER AUTHORIZATION ON DATABASE:: DEPLOY2 TO Concento;
GO
CREATE DATABASE ENRICH
GO
ALTER AUTHORIZATION ON DATABASE:: ENRICH TO Concento;
GO
CREATE DATABASE REPORT
GO
ALTER AUTHORIZATION ON DATABASE:: REPORT TO Concento;
GO
CREATE DATABASE FOO
GO
ALTER AUTHORIZATION ON DATABASE:: FOO TO Concento;
GO
CREATE DATABASE srcFOO
GO
ALTER AUTHORIZATION ON DATABASE:: srcFOO TO Concento;
GO
CREATE DATABASE BAR
GO
ALTER AUTHORIZATION ON DATABASE:: BAR TO Concento;
GO
CREATE DATABASE tgtBAR
GO
ALTER AUTHORIZATION ON DATABASE:: tgtBAR TO Concento;
GO
CREATE DATABASE wrkFOO2BAR
GO
ALTER AUTHORIZATION ON DATABASE:: wrkFOO2BAR TO Concento;
GO

