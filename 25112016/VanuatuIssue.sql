/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [dbo].[Asset].[Oid],[dbo].[Asset].[Client]
  FROM [dbo].[Asset]
  Inner Join [dbo].[AssetRegister] on [dbo].[AssetRegister].[Asset] = [dbo].[Asset].[Oid]
  Where [dbo].[AssetRegister].[AssetId] ='201100- 12'
 
 Select [Oid],[Client]
 From [dbo].[ComponentInput]
 Where [dbo].[ComponentInput].[Asset] = 'EA5F8A1E-9DD1-4700-860E-AAC110D30628'
 And [dbo].[ComponentInput].[GCRecord] is null

Select [dbo].[DimensionComponent].[Oid]
From [dbo].[DimensionComponent]
Where [dbo].[DimensionComponent].[Asset] ='EA5F8A1E-9DD1-4700-860E-AAC110D30628'
And  [dbo].[DimensionComponent].[Oid] in 
(Select [Oid]
From [dbo].[DimensionBase]
 
)
IF OBJECT_ID('tempdb..#dimensionToUpdateClient') IS NOT NULL
		DROP TABLE #dimensionToUpdateClient
Select [dbo].[ReplacementCostDetailComponent].[Oid] into #dimensionToUpdateClient
From [dbo].[ReplacementCostDetailComponent] 
inner join [dbo].[ReplacementCost] on [dbo].[ReplacementCostDetailComponent].[ReplacmentCost] = [dbo].[ReplacementCost].[Oid]
inner join [dbo].[Asset] on [dbo].[Asset].[ReplacementCostApportionment] =[dbo].[ReplacementCost].[Oid]
Where [dbo].[ReplacementCostDetailComponent].[Client] is null and [dbo].[ReplacementCost].[Asset]='EA5F8A1E-9DD1-4700-860E-AAC110D30628' 
       And [dbo].[ReplacementCost].[Name] ='Replacement Cost Apportionment'

Update [dbo].[ReplacementCostDetailComponent]
Set [dbo].[ReplacementCostDetailComponent].[Client] = [dbo].[Asset].[Client]
From [dbo].[ReplacementCostDetailComponent] 
		inner join [dbo].[ReplacementCost] on [dbo].[ReplacementCostDetailComponent].[ReplacmentCost] = [dbo].[ReplacementCost].[Oid]
		inner join [dbo].[Asset] on [dbo].[ReplacementCost].[Asset]= [dbo].[Asset].[Oid]
Where 	 [dbo].[Asset].[GCRecord] is null
		 And 



 UPdate [dbo].[ComponentInput]
 Set [dbo].[ComponentInput].[Client] = [dbo].[Asset].[Client],
	  [dbo].[ComponentInput].[FairValueProGroup] =[dbo].[Asset].[FairValueProGroup]
 From [dbo].[ComponentInput] 
 inner join [dbo].[Asset] on [dbo].[Asset].[Oid] = [dbo].[ComponentInput].[Asset]
 Where [dbo].[ComponentInput].[GCRecord] is null
 And [dbo].[ComponentInput].[Client] is null
 And [dbo].[Asset].[GCRecord] is null
 And [dbo].[Asset].[Client] ='3FEE00A0-AD4F-4D6B-A6BA-17C17467FDDBB'

 Select  [dbo].[Asset].[FairvalueproGroup]
 From [dbo].[Asset]
 Where [dbo].[Asset].[Client] ='3FEE00A0-AD4F-4D6B-A6BA-17C17467FDDBB'

update  [dbo].[ComponentInput]
Set [dbo].[ComponentInput].[FairValueProGroup] = 'AAEDB8BA-145B-4176-AC69-F79B18BC2F85'
 where [dbo].[ComponentInput].[Client] ='3FEE00A0-AD4F-4D6B-A6BA-17C17467FDDBB'

 Select 

 Select *
 From [dbo].[FairValueProClient]
 Where [Oid] ='1530AFB2-34F9-4E5C-9415-76CCE995FE39'

 select [dbo].[ComponentInput].[Oid] into #componentToDelete
 from [dbo].[ComponentInput]
 inner join [dbo].[ComponentAssetHierarchy] on [dbo].[ComponentInput].[Component_AssetHierarchy] =[dbo].[ComponentAssetHierarchy].[Oid]
 and [dbo].[ComponentAssetHierarchy].[GCRecord] is not null

 Delete 
 from [dbo].[ComponentValidationReport]
 where [dbo].[ComponentValidationReport].[Component] in
 (
  Select * from #componentToDelete
 )

 Delete
 from [dbo].[ComponentInput]
 where [dbo].[ComponentInput].[Oid] in
 (
  Select * from #componentToDelete
 )

 Drop Table #componentToDelete



 Select [dbo].[Asset].[Client]
 From [dbo].[AssetRegister]
 inner join [dbo].[Asset] on [dbo].[Asset].[Oid] = [dbo].[AssetRegister].[Asset]

 Select *
 From  [dbo].[AssetRegister]
 Where [dbo].[AssetRegister].[AssetId]= '42956' or [Name]='42956'

