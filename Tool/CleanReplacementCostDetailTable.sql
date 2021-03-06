/****** Script for SelectTopNRows command from SSMS  ******/

  UPDATE [dbo].[ComponentInput]
  SET [ReplacementCostDetailApportionment] = null
  Where [ReplacementCostDetailApportionment]  in
  ( 
  Select [Oid]
  FROM [dbo].[ReplacementCostDetailComponent]
  where 
		[GCRecord] is not null and [Oid] in
		(
			Select [ReplacementCostDetailApportionment]
			From [dbo].[ComponentInput]
			Where [GCRecord] is not null
		)
  )	
  Delete
  FROM [dbo].[ReplacementCostDetailComponent]
  where 
		[GCRecord] is not null 
		 