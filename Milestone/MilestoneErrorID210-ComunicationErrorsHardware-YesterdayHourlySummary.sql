SELECT FORMAT(LogService.ObjectName.ID, '0000') + ' ' + LogService.ObjectName.Name AS [Camera],
	   COUNT(*) AS [Total Errors],
	   SUM(CASE WHEN DATEPART(HOUR,LogService.Message.receivetime) IN (0,1,2) THEN 1 ELSE 0 END) AS [0-2],
	   SUM(CASE WHEN DATEPART(HOUR,LogService.Message.receivetime) IN (3,4,5) THEN 1 ELSE 0 END) AS [3-5],
	   SUM(CASE WHEN DATEPART(HOUR,LogService.Message.receivetime) IN (6,7,8) THEN 1 ELSE 0 END) AS [6-8],
	   SUM(CASE WHEN DATEPART(HOUR,LogService.Message.receivetime) IN (9,10,11) THEN 1 ELSE 0 END) AS [9-11],
	   SUM(CASE WHEN DATEPART(HOUR,LogService.Message.receivetime) IN (12,13,14) THEN 1 ELSE 0 END) AS [12-14],
	   SUM(CASE WHEN DATEPART(HOUR,LogService.Message.receivetime) IN (15,16,17) THEN 1 ELSE 0 END) AS [15-17],
	   SUM(CASE WHEN DATEPART(HOUR,LogService.Message.receivetime) IN (18,19,20) THEN 1 ELSE 0 END) AS [18-20],
	   SUM(CASE WHEN DATEPART(HOUR,LogService.Message.receivetime) IN (21,22,23) THEN 1 ELSE 0 END) AS [21-23]
FROM   LogService.MessageId INNER JOIN
                         LogService.Message ON LogService.MessageId.ID = LogService.Message.ID_MessageId INNER JOIN
                         LogService.ObjectName ON LogService.Message.idObjectName = LogService.ObjectName.ID INNER JOIN
                         LogService.MessageText ON LogService.MessageId.ID = LogService.MessageText.ID_MessageId AND LogService.Message.ID_MessageText = LogService.MessageText.ID
WHERE DATEDIFF(DAY,LogService.Message.receivetime ,GETDATE()) = 1 AND LogService.MessageId.ID =210
GROUP BY LogService.ObjectName.ID, LogService.ObjectName.Name
ORDER BY [Total Errors] DESC