SELECT FORMAT(LogService.Message.ID_MessageId, '0000') + ' ' + LogService.MessageText.Message AS [Event],
       FORMAT(LogService.ObjectName.ID, '0000') + ' ' + LogService.ObjectName.Name AS [Object],
	   FORMAT(LogService.Message.receivetime, 'yyyy') As [Year],
	   FORMAT(LogService.Message.receivetime, 'MM') As [Month],
	   FORMAT(LogService.Message.receivetime, 'dd') As [Day],
	   FORMAT(LogService.Message.receivetime, 'dddd') As [DayWeek],
       FORMAT(LogService.Message.receivetime, 'HHHH') As [Hour],
	   FORMAT(LogService.Message.receivetime, 'mm') As [Minute],
	   FORMAT(LogService.Message.receivetime, 'ss') As [Second]
FROM LogService.Message INNER JOIN
     LogService.MessageId ON LogService.Message.ID_MessageId = LogService.MessageId.ID INNER JOIN
     LogService.MessageText ON LogService.Message.ID_MessageText = LogService.MessageText.ID AND LogService.MessageId.ID = LogService.MessageText.ID_MessageId INNER JOIN
     LogService.ObjectName ON LogService.Message.idObjectName = LogService.ObjectName.ID
WHERE (DATEDIFF(DAY, LogService.Message.receivetime, GETDATE()) BETWEEN 1 AND 7) AND LogService.MessageText.idSeverity <> 3
ORDER BY LogService.Message.receivetime