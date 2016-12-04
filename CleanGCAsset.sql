USE [FVPTesting]
GO

IF EXISTS
	 (
	 select *
	From [dbo].[ComponentValidationReport]
	where [Component] in 
		(
		  Select [Oid]
		  From [ComponentInput]
		  where [GCRecord] is not null
		) or [GCRecord] is not null
	)
Delete
From [dbo].[ComponentValidationReport]
where [Component] in 
(
  Select [Oid]
  From [ComponentInput]
  where [GCRecord] is not null
) or [GCRecord] is not null

IF EXISTS (
 Select *
 From [dbo].[CharacteristicsItem]
 where [ComponentInput] in
  (
  Select [Oid]
  From [dbo].[ComponentInput]
  where [GCRecord] is not null
  ) or [GCRecord] is not null
)
 Delete
 From [dbo].[CharacteristicsItem]
 where [ComponentInput] in
  (
  Select [Oid]
  From [dbo].[ComponentInput]
  where [GCRecord] is not null
  ) or [GCRecord] is not null

  Delete
  From [ComponentInput]
  where [GCRecord] is not null
  
  Delete
  FROM [dbo].[ReplacementCostDetailComponent]
  where [GCRecord] is null


Delete
From [dbo].[AssetAttribute]
where [Oid] in
(
Select [Oid]
From
[dbo].[CharacteristicsItemBase]
where [GCRecord] is not null
)

Delete
From 
[dbo].[ReplacementCost]
Where 
[Asset] is null

ALTER TABLE [dbo].[Phase2ComponentValuationBase] DROP CONSTRAINT [FK_Phase2ComponentValuationBase_Oid]
Delete
From [dbo].[Phase2ComponentValuationBase]
Where [Oid] in
(
Select [Oid]
From [dbo].[Phase2ComponentValuation]
WHere [ComponentInput] is null
)

Delete from
[dbo].[Phase2OtherApproachValuation]
where [Oid] in
(
	select [oid]
	from [dbo].[Phase2ComponentValuationBase]
	where [Oid] in 
	(
	select [Oid]
	from [dbo].[Phase2ComponentValuation]
	where [GCRecord] is not null
	)
)


delete
from [dbo].[Phase2ComponentValuationBase]
where [Oid] in 
(
select [Oid]
from [dbo].[Phase2ComponentValuation]
where [GCRecord] is not null
)

Delete
From [dbo].[Phase2ComponentValuation]
WHere [ComponentInput] is null

DELETE FROM [dbo].[Phase2OtherApproachValuation]
      WHERE [Oid] In
	  (
	  Select [Oid]
	   FROM [dbo].[Phase2ComponentValuation]
       WHERE [GCRecord] is not null
	   Or    [Oid] In
			  (
			  Select [Oid]
			   FROM [dbo].[Phase2ComponentValuation]
			   WHERE [GCRecord] is not null
			   or   [SummaryValuation] in
				  (
				  Select [Oid] From [dbo].[SummaryValuationBase]
				  WHERE [GCRecord] is not null
				  ) 
			  )
	  )

DELETE FROM [dbo].[Phase2CostComponentValuation]
      WHERE [Oid] In
	  (
	  Select [Oid]
	   FROM [dbo].[Phase2ComponentValuation]
       WHERE [GCRecord] is not null
	   or   [SummaryValuation] in
		  (
		  Select [Oid] From [dbo].[SummaryValuationBase]
		  WHERE [GCRecord] is not null
		  ) 
	  )

DELETE FROM [dbo].[Phase2ComponentValuationBase]
      WHERE [Oid] In
	  (
	  Select [Oid]
	   FROM [dbo].[Phase2ComponentValuation]
       WHERE [GCRecord] is not null 
		Or [SummaryValuation] in
		  (
		  Select [Oid] From [dbo].[SummaryValuationBase]
		  WHERE [GCRecord] is not null
		  ) 
	  )

DELETE FROM [dbo].[Phase2ComponentValuation]
      WHERE [GCRecord] is not null 

DELETE FROM [dbo].[Phase2ComponentValuation]
      WHERE [SummaryValuation] in
	  (
	  Select [Oid] From [dbo].[SummaryValuationBase]
      WHERE [GCRecord] is not null
	  )

DELETE FROM [dbo].[MarketSummaryValuation]
Where [Oid] in
	(
	Select [Oid] 
	From [dbo].[SummaryValuationBase]
     WHERE [GCRecord] is not null
	 )

DELETE FROM [dbo].[IncomeSummaryValuation]
Where [Oid] in
	(
	Select [Oid] 
	From [dbo].[SummaryValuationBase]
     WHERE [GCRecord] is not null
	 )
DELETE FROM [dbo].[CombinedSummaryValuation]
Where [Oid] in
	(
	Select [Oid] 
	From [dbo].[SummaryValuationBase]
     WHERE [GCRecord] is not null
	 )

DELETE FROM [dbo].[OtherSummaryValuation]
Where [Oid] in
	(
	Select [Oid] 
	From [dbo].[SummaryValuationBase]
     WHERE [GCRecord] is not null
	 )

DELETE FROM [dbo].[CostSummaryValuation]
Where [Oid] in
	(
	Select [Oid] 
	From [dbo].[SummaryValuationBase]
     WHERE [GCRecord] is not null
	 )

DELETE FROM [dbo].[SummaryValuationBase]
      WHERE [GCRecord] is not null

ALTER TABLE [dbo].[Asset] DROP CONSTRAINT [FK_Asset_InsuranceValuation]
DELETE FROM [dbo].[InsuranceValuation]
      WHERE [GCRecord] is not null

DELETE FROM [dbo].[AnalysisOfApproach]
      WHERE [GCRecord] is not null

DELETE FROM [dbo].[AReportUserList]
      WHERE [GCRecord] is not null

DELETE FROM [dbo].[AssetRegister]
      WHERE [GCRecord] is not null

AlTER TABLE [dbo].[Asset] DROP CONSTRAINT [FK_Asset_Valuer]
ALTER TABLE [dbo].[Valuer] DROP CONSTRAINT [FK_Valuer_Asset]

DELETE FROM [dbo].[Valuer]
      WHERE [GCRecord] is not null 

DELETE FROM [dbo].[Valuer]
	  where
			[Asset] In
	(
	  Select [Oid]
	  FROM [dbo].[Asset]
      WHERE [GCRecord] is not null
	)

ALTER TABLE [dbo].[Asset] DROP CONSTRAINT [FK_Asset_ReplacementCostApportionment]

DELETE [dbo].[ReplacementCostApportionment]
	Where [Asset] in
	(
	Select [Oid]
	  FROM [dbo].[Asset]
      WHERE [GCRecord] is not null
	)
	
ALTER TABLE [dbo].[Asset] DROP CONSTRAINT [FK_Asset_ReplacementCostDirectCost]
DELETE [dbo].[ReplacementCostDirectCost]
	Where [Asset] in
	(
	Select [Oid]
	  FROM [dbo].[Asset]
      WHERE [GCRecord] is not null
	)
	

DELETE [dbo].[ReplacementCost]
 WHERE [GCRecord] is not null

DELETE FROM [dbo].[ReplacementCostDetailComponent]
 WHERE [GCRecord] is not null

ALTER TABLE [dbo].[AnalysisOfApproach] DROP CONSTRAINT [FK_AnalysisOfApproach_Asset]
Delete From [dbo].[AnalysisOfApproach]
Where [Asset] in 
	(
		Select [Oid] From [dbo].[Asset]
		WHERE [GCRecord] is not null
	)
DELETE FROM [dbo].[Asset]
      WHERE [GCRecord] is not null


Delete FROM [dbo].[Asset]
      WHERE [GCRecord] is not null
	  Or [AssetRegister] In
		  (
		  Select [Oid] FROM [dbo].[AssetRegister]
		  WHERE [GCRecord] is not null
		  )

Select * FROM [dbo].[Asset]
      WHERE [GCRecord] is not null
	  Or [AssetRegister] In
		  (
		  Select [Oid] FROM [dbo].[AssetRegister]
		  WHERE [GCRecord] is not null
		  )

Select * FROM [dbo].[AssetRegister]
      WHERE [GCRecord] is not null
	  Or [Asset] in
	  (
	  Select [Oid] FROM [dbo].[Asset]
      WHERE [GCRecord] is not null
	  )
Select * FROM [dbo].[Asset]
      WHERE [GCRecord] is not null

Delete
FROM [dbo].[ComponentValidationReport]
  where [GCRecord] is not null

GO