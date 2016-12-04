

  Delete 
  From [dbo].[Phase2ComponentValuationBase]
  where [Oid] in 
  (
	Select [Oid]
	FROM [dbo].[Phase2ComponentValuation]
	where [GCRecord] is not null
  )
GO

	Delete
	FROM [dbo].[Phase2ComponentValuation]
	where [GCRecord] is not null

Go


Delete
From [dbo].[OtherSummaryValuation]
Where [Oid] in 
(
	Select [Oid]
	From [dbo].[SummaryValuationBase]
	Where [GCRecord] is not null
)
Go

Delete
From [dbo].[SummaryValuationBase]
Where [GCRecord] is not null
GO