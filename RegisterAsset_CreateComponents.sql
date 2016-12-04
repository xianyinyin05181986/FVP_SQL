DROP PROCEDURE [dbo].[CreateComponentInputForAssetRegister]
GO

/****** Object:  StoredProcedure [dbo].[DeleteAssetRecord]    Script Date: 24/11/2016 2:07:38 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[CreateComponentInputForAssetRegister]
	-- Add the parameters for the stored procedure here
	@assetRegisterOid uniqueidentifier
AS
Begin
	Select dbo.asset.Oid into #assetstoShow
	From dbo.Asset
	Where dbo.Asset.AssetRegister =@assetRegisterOid

	IF OBJECT_ID('tempdb..#ComponentToCreate') IS NOT NULL
	DROP TABLE #ComponentToCreate

	Select
	Distinct
	dbo.AssetHierarchy.AssetHierarchyName As AssetClass,
	dbo.AssetType.AssetTypeName As AssetType,
	dbo.AssetSubType.AssetSubTypeName As AssetSubtype,
	dbo.AssetRegister.AssetId,
	dbo.AssetRegister.Asset As AssetOid,
	dbo.ComponentAssetHierarchy.ComponentName As Component,
	dbo.ComponentAssetHierarchy.Oid As ComponentHierarchyOid,
	dbo.ComponentAssetHierarchy.Apportionment,
	dbo.AssetRegister.Client
	into #ComponentToCreate
	From  dbo.AssetRegister
	inner join dbo.AssetHierarchy on dbo.AssetHierarchy.Oid = dbo.AssetRegister.AssetClass
	inner join dbo.AssetType on dbo.AssetType.Oid =dbo.AssetRegister.AssetType
	inner join dbo.AssetSubType on dbo.AssetSubType.Oid = dbo.AssetRegister.AssetSubType
	inner join dbo.ComponentAssetHierarchy on dbo.ComponentAssetHierarchy.AssetSubtype = dbo.AssetSubType.Oid
	Where dbo.AssetRegister.Asset in 
	(Select * from #assetstoShow)

	--Select * from #ComponentToCreate

	Declare @componentId uniqueidentifier,
			 @componentInputOid uniqueidentifier,
			 @assetOid uniqueidentifier,
			 @clientOid uniqueidentifier,
			 @apportionment float,
			 @componentName nvarchar(100)
	While (Select Count(*) From #ComponentToCreate)>0
	Begin
		Select top(1)  @componentId = ComponentHierarchyOid,
					   @assetOid = AssetOid,
					   @clientOid = Client,
					   @apportionment=Apportionment,
					   @componentName =Component
		from #ComponentToCreate
		--				=================================================
		--				||            Start Create Component           ||
		--				=================================================
		Set @componentInputOid = NEWID()

		Insert into dbo.ComponentInput
		(
			Oid
			,Asset
			,Client
			,Apportionment
			,Name
			,Component_AssetHierarchy
		)
		Values
		(
			@componentInputOid
			,@assetOid
			,@clientOid
			,@apportionment
			,@componentName
			,@componentId
		)

		--			=================================================
		--			||            End Create Component             ||
		--			=================================================
		Delete
		From #ComponentToCreate
		where ComponentHierarchyOid =@componentId
	End

	--Select dbo.ComponentInput.Asset,
	--		dbo.AssetHierarchy.AssetHierarchyName,
	--		dbo.AssetType.AssetTypeName,
	--		dbo.AssetSubType.AssetSubTypeName,
	--		 dbo.ComponentAssetHierarchy.Oid
	--From dbo.ComponentInput
	--inner join dbo.AssetRegister on dbo.ComponentInput.Asset = dbo.AssetRegister.Asset
	--inner join dbo.AssetHierarchy on dbo.AssetHierarchy.Oid = dbo.AssetRegister.AssetClass
	--inner join dbo.AssetType on dbo.AssetType.Oid =dbo.AssetRegister.AssetType
	--inner join dbo.AssetSubType on dbo.AssetSubType.Oid = dbo.AssetRegister.AssetSubType
	--inner join dbo.ComponentAssetHierarchy on dbo.ComponentInput.Component_AssetHierarchy= dbo.ComponentAssetHierarchy.Oid
	--Where dbo.ComponentInput.Asset in 
	--(Select * from #assetstoShow)

	IF OBJECT_ID('tempdb..#ComponentToCreate') IS NOT NULL
	    DROP TABLE #ComponentToCreate
	IF OBJECT_ID('tempdb..#assetstoShow') IS NOT NULL
		DROP TABLE #assetstoShow
End

