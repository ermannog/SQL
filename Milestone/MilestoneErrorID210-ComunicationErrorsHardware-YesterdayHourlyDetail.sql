SELECT FORMAT(LogService.ObjectName.ID, '0000') + ' ' + LogService.ObjectName.Name AS [Camera],
       DATEPART(HOUR,LogService.Message.receivetime) AS [Hour],
	   COUNT(*) AS Errors
FROM   LogService.MessageId INNER JOIN
                         LogService.Message ON LogService.MessageId.ID = LogService.Message.ID_MessageId INNER JOIN
                         LogService.ObjectName ON LogService.Message.idObjectName = LogService.ObjectName.ID INNER JOIN
                         LogService.MessageText ON LogService.MessageId.ID = LogService.MessageText.ID_MessageId AND LogService.Message.ID_MessageText = LogService.MessageText.ID
WHERE DATEDIFF(DAY,LogService.Message.receivetime ,GETDATE()) = 1 AND LogService.MessageId.ID =210
GROUP BY LogService.ObjectName.ID, LogService.ObjectName.Name, DATEPART(HOUR,LogService.Message.receivetime)
ORDER BY DATEPART(HOUR, LogService.Message.receivetime), Errors DESC, LogService.ObjectName.ID