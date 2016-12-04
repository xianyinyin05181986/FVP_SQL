USE [fvp-database]
GO

Select * from 
 [dbo].[ReplacementCost]
 Where  [dbo].[ReplacementCost].[Asset] is null

  delete
 from [dbo].[ReplacementCostApportionment]
 where [Oid] in 
 (
	 select [Oid]
	 From [dbo].[ReplacementCost]
	 Where [GCRecord] is not null
 )


  delete
 from [dbo].[ReplacementCostDirectCost]
 where [Oid] in 
 (
	 select [Oid]
	 From [dbo].[ReplacementCost]
	 Where [GCRecord] is not null
 )
delete
 From [dbo].[ReplacementCost]
 Where [GCRecord] is not null


update [dbo].[ReplacementCost]
set [dbo].[ReplacementCost].[Asset] = [dbo].[ReplacementCostApportionment].[Asset]
from [dbo].[ReplacementCost]
inner join [dbo].[ReplacementCostApportionment]
on [dbo].[ReplacementCost].[Oid] = [dbo].[ReplacementCostApportionment].[Oid]
WHERE [dbo].[ReplacementCostApportionment].[Asset] is not null
 And [dbo].[ReplacementCost].[Asset] is null

 update [dbo].[ReplacementCost]
set [dbo].[ReplacementCost].[Asset] = [dbo].[ReplacementCostDirectCost].[Asset]
from [dbo].[ReplacementCost]
inner join [dbo].[ReplacementCostDirectCost]
on [dbo].[ReplacementCost].[Oid] = [dbo].[ReplacementCostDirectCost].[Oid]
WHERE [dbo].[ReplacementCostDirectCost].[Asset] is not null
 And [dbo].[ReplacementCost].[Asset] is null

 Select Count([ApportionmentOrDirectCost] )
 From [dbo].[Asset]
 where 
 
 [ApportionmentOrDirectCost] =0 And
 [Client] in 
 (
 Select [Oid]
 From [dbo].[FairValueProClient]
 where [Name] = 'APV_Sept2016'
 )  
--Update Replacement Cost with [Asset] has Null value
-- Direcot Cost
Update [dbo].[ReplacementCost]
Set [dbo].[ReplacementCost].[Asset] = [dbo].[Asset].[Oid]
From [dbo].[Asset]
inner join [dbo].[ReplacementCostDirectCost]
on [dbo].[Asset].[ReplacementCostDirectCost] = [dbo].[ReplacementCostDirectCost].[Oid]
inner join [dbo].[ReplacementCost]
on [dbo].[ReplacementCostDirectCost].[Oid] =[dbo].[ReplacementCost].[Oid]
--Apportionment
Update [dbo].[ReplacementCost]
Set [dbo].[ReplacementCost].[Asset] = [dbo].[Asset].[Oid]
From [dbo].[Asset]
inner join [dbo].[ReplacementCostApportionment]
on [dbo].[Asset].[ReplacementCostApportionment] = [dbo].[ReplacementCostApportionment].[Oid]
inner join [dbo].[ReplacementCost]
on [dbo].[ReplacementCostApportionment].[Oid] =[dbo].[ReplacementCost].[Oid]