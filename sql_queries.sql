----------------- postgresql -----------------

DECLARE status integer;
status := 1;
RAISE NOTICE '%-status', status;


CASE
  WHEN tb1."IsMale" = 0 THEN 'Female'
  WHEN tb1."IsMale" = 1 THEN 'Male'
END

----------------- mssql -----------------


SELECT FORMAT(CAST('01/01/2018' AS DATE), 'yyyy-MM') --2018-01
SELECT FORMAT(DATEADD(MM, -2,'01/01/2018'), 'yyyy-MM') --2017-11-01


--execute in command prompt
sqlcmd -S myServer\instanceName -i C:\myScript.sql
sqlcmd -S myServer\instanceName -i C:\myScript.sql -o C:\Output.txt


USE DBNAME
SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE
FROM DBNAME.INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = N't_Employee'

SELECT SCHEMA_NAME(schema_id) AS [SchemaName],
[Tables].name AS [TableName],
SUM([Partitions].[rows]) AS [TotalRowCount]
FROM sys.tables AS [Tables]
JOIN sys.partitions AS [Partitions]
ON [Tables].[object_id] = [Partitions].[object_id]
AND [Partitions].index_id IN ( 0, 1 )
--WHERE [Tables].name = N'name of the table'
WHERE [Partitions].[rows] > 0
GROUP BY SCHEMA_NAME(schema_id), [Tables].name


SET @VarFolder = 'C:' + '\' + 'sample'
SET @WinCmd = 'md "' + @VarFolder + '"'
EXEC master..xp_cmdshell @WinCmd, NO_OUTPUT

SET @SourceFile = 'C:\sample\sample.xlsm'
SET @OutputPath = 'C:\sample\prod\sample.xlsm'
SET @WinCmd = 'copy "' + @SourceFile + '" "' + @OutputPath + '"'
EXEC master..xp_cmdshell @WinCmd, NO_OUTPUT

SET @ExcelCmd = 'INSERT INTO OPENROWSET (
					  ''Microsoft.ACE.OLEDB.12.0'',
					  ''Excel 12.0 Xml;HDR=YES;Database=' + @OutputPath + ''',
					  ''SELECT * FROM [' + 'SheetName' + '$' + 'A2:C2' + ']''
				   )
				   ' + 'SELECT 1,2,3 FROM table'
EXEC master.dbo.sp_executesql @ExcelCmd


SELECT * FROM (
SELECT
	[Status] = 'Half', -- Half, FullPayment
	[Amount] = 100,
	[TypeID] = '1' --1,2,3
) SrcTbl
PIVOT (
	SUM(Amount)
	FOR [TypeID] IN ([Half], [FullPayment])
) PvtTbl