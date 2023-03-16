#RUN QUERY FIRST
EXEC sp_configure 'show advanced options', 1;
GO
RECONFIGURE;
GO

EXEC sp_configure 'xp_cmdshell',1
GO
RECONFIGURE
GO

#Then mount network drive:
EXEC XP_CMDSHELL 'net use H: \\RemoteServerName\ShareName'
