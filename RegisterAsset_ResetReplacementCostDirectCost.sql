DROP PROCEDURE [dbo].[RegisterAsset_ResetReplacementCostDirectCost]
GO

/****** Object:  StoredProcedure [dbo].[DeleteAssetRecord]    Script Date: 24/11/2016 2:07:38 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[RegisterAsset_ResetReplacementCostDirectCost]
	-- Add the parameters for the stored procedure here
	@assetRegisterOid uniqueidentifier
AS
Begin

	
	Declare @clientOid uniqueidentifier,@replacementCostOid uniqueidentifier,@groupOid uniqueidentifier

	Select @clientOid =dbo.AssetRegister.Client,
			@replacementCostOid =dbo.ReplacementCost.Oid,
			@groupOid =dbo.AssetRegister.FairValueProGroup
	from dbo.AssetRegister
	inner join dbo.ReplacementCost on dbo.ReplacementCost.Asset = dbo.AssetRegister.Asset
	inner join dbo.ReplacementCostDirectCost on dbo.ReplacementCostDirectCost.Oid = dbo.ReplacementCost.Oid
	
	where dbo.AssetRegister.Oid =@assetRegisterOid

	IF OBJECT_ID('tempdb..#replacementCostDetail') IS NOT NULL
	DROP TABLE #replacementCostDetail

	Select dbo.ReplacementCostDetailComponent.Oid,
		dbo.ReplacementCostDetailComponent.ItemType,
		dbo.ReplacementCostDetailComponent.AreaType,
		dbo.ReplacementCostDetailComponent.ComponentInput as ComponentInputOid,
		dbo.ReplacementCostDetailComponent.Component,
		dbo.ReplacementCostDetailComponent.ReplacmentCost As ReplacementCostOid
	 into #replacementCostDetail
	From dbo.ReplacementCostDetailComponent
	inner join dbo.ReplacementCostDirectCost on dbo.ReplacementCostDirectCost.Oid = dbo.ReplacementCostDetailComponent.ReplacmentCost
	inner join dbo.ReplacementCost on dbo.ReplacementCost.Oid = dbo.ReplacementCostDirectCost.Oid
	inner join dbo.AssetRegister on dbo.AssetRegister.Asset = dbo.ReplacementCost.Asset
	where dbo.AssetRegister.Oid =@assetRegisterOid
	   And dbo.AssetRegister.GCRecord is null

	IF OBJECT_ID('tempdb..#componentInputList') IS NOT NULL
	DROP TABLE #componentInputList

	Select dbo.ComponentInput.Oid,
			dbo.ComponentAssetHierarchy.ComponentName As Component,
			dbo.ComponentInput.ComponentType As ComponentTypeOid,
			dbo.ComponentInput.ComponentSubType As ComponentSubtypeOid
			into #componentInputList
	From dbo.ComponentInput
	inner join dbo.AssetRegister on dbo.AssetRegister.Asset = dbo.ComponentInput.Asset And dbo.AssetRegister.GCRecord is null
	inner join dbo.ComponentAssetHierarchy on dbo.ComponentInput.Component_AssetHierarchy = dbo.ComponentAssetHierarchy.Oid
	Where dbo.AssetRegister.Oid =@assetRegisterOid 

   
    ---=================================================================================================---
	---                 Delete All the Old Replacement Cost Detail
	---=================================================================================================---
	Delete 
	From dbo.ReplacementCostDetailComponent
	Where dbo.ReplacementCostDetailComponent.Oid in
	(Select Oid From #replacementCostDetail)

	Declare @replacementDetailOid uniqueidentifier,
	@componentInputOid uniqueidentifier,
	@componentName nvarchar(100),
	@componentTypeName nvarchar(100),
	@componentSubtypeName nvarchar(100),
	@componentTypeOid uniqueidentifier,
	@unitRate float 
	While (Select COUNT(*) From #componentInputList)>0
	Begin 
			select Top(1) @componentInputOid = #componentInputList.Oid,
				@componentName = #componentInputList.Component,
				@componentTypeName =dbo.ComponentType.ComponentTypeName,
				@componentSubtypeName =dbo.ComponentSubType.ComponentSubTypeName,
				@componentTypeOid = #componentInputList.ComponentTypeOid
			from #componentInputList
			left outer join dbo.ComponentType on dbo.ComponentType.Oid =ComponentTypeOid
			left outer join dbo.ComponentSubType on dbo.ComponentSubType.Oid =ComponentSubtypeOid
			
			if @componentSubtypeName is not null
			Begin
				select @unitRate = dbo.ComponentLevelAssumption.UnitRate
				from dbo.ComponentLevelAssumption
				inner join #componentInputList on #componentInputList.ComponentSubtypeOid = dbo.ComponentLevelAssumption.ComponentSubType
				and dbo.ComponentLevelAssumption.GCRecord is null
			End
	---=================================================================================================---
	---                 Insert New Replacement Cost Detail
	---=================================================================================================---
	       Insert into dbo.ReplacementCostDetailComponent
		   (
			Oid,Client,Component,Name,ComponentInput,ComponentType,ReplacmentCost,ItemType,AreaType,FairValueProGroup
		   )
		   Values
		   (
		    NEWID(),@clientOid,@componentName,@componentName,@componentInputOid,@componentTypeOid,@replacementCostOid,@componentTypeName,@componentSubtypeName,@groupOid
		   )

			delete 
			from #componentInputList
			where #componentInputList.Oid = @componentInputOid
	End

	
	IF OBJECT_ID('tempdb..#replacementCostDetail') IS NOT NULL
	DROP TABLE #replacementCostDetail

	IF OBJECT_ID('tempdb..#componentInputList') IS NOT NULL
	DROP TABLE #componentInputList
End