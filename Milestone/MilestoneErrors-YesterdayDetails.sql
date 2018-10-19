SELECT FORMAT(LogService.Message.ID_MessageId, '0000') + ' ' + LogService.MessageText.Message AS [Event],
       FORMAT(LogService.ObjectName.ID, '0000') + ' ' + LogService.ObjectName.Name AS [Object],
       FORMAT(LogService.Message.receivetime, 'HH:mm:ss') As [Time]
FROM LogService.Message INNER JOIN
     LogService.MessageId ON LogService.Message.ID_MessageId = LogService.MessageId.ID INNER JOIN
     LogService.MessageText ON LogService.Message.ID_MessageText = LogService.MessageText.ID AND LogService.MessageId.ID = LogService.MessageText.ID_MessageId INNER JOIN
     LogService.ObjectName ON LogService.Message.idObjectName = LogService.ObjectName.ID
WHERE (DATEDIFF(DAY, LogService.Message.receivetime, GETDATE()) = 1) AND LogService.MessageText.idSeverity <> 3
ORDER BY LogService.Message.receivetime