DROP PROCEDURE [dbo].[CreateAttributesForAssetRegister]
GO

/****** Object:  StoredProcedure [dbo].[DeleteAssetRecord]    Script Date: 24/11/2016 2:07:38 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[CreateAttributesForAssetRegister]
	-- Add the parameters for the stored procedure here
	@assetRegisterOid uniqueidentifier
AS
Begin
	Declare
			 @assetOid uniqueidentifier,@clientOid uniqueidentifier,@groupOid uniqueidentifier
	IF Exists
	(
		Select dbo.AssetRegister.Asset,
			dbo.AssetRegister.AssetSubtype
		From dbo.AssetRegister
		where dbo.AssetRegister.Asset is not null 
			and dbo.AssetRegister.AssetSubtype is not null
			and dbo.AssetRegister.GCRecord is null
	)
	Begin 
	    Select @assetOid=dbo.AssetRegister.Asset,
				@clientOid =dbo.AssetRegister.Client,
				@groupOid =dbo.AssetRegister.FairValueProGroup
		From dbo.AssetRegister
		where dbo.AssetRegister.Asset is not null 
			and dbo.AssetRegister.AssetSubtype is not null
			and dbo.AssetRegister.GCRecord is null
		IF OBJECT_ID('tempdb..#AttributeNameToCreate') IS NOT NULL
	    DROP TABLE #AttributeNameToCreate

		Select dbo.AssetAttributeName.Name into #AttributeNameToCreate
		From dbo.AssetRegister
		inner join [dbo].[AssetAttributeName] on dbo.AssetRegister.AssetSubType =dbo.AssetAttributeName.AssetSubtype
		where dbo.AssetRegister.Asset is not null 
			and dbo.AssetRegister.AssetSubtype is not null
			and dbo.AssetRegister.GCRecord is null

		Declare @name nvarchar(100),
				@attributeOid uniqueidentifier
		While (Select Count(*) From #AttributeNameToCreate)>0
		Begin
			Select Top(1) @name = #AttributeNameToCreate.Name  
			From #AttributeNameToCreate
			
			If not exists (
				Select dbo.AssetAttribute.Oid
				From dbo.AssetAttribute
				inner join dbo.CharacteristicsItemBase on dbo.CharacteristicsItemBase.Oid = dbo.AssetAttribute.Oid and dbo.CharacteristicsItemBase.Name =@name
			)
			Begin
				Set @attributeOid = NEWID()
				Insert into dbo.CharacteristicsItemBase
				(
					Oid,Name,Client,FairValueProGroup,ObjectType
				) 
				Values
				(
					@attributeOid,@name,@clientOid,@groupOid,74
				)
				Insert into dbo.AssetAttribute
				(
					Oid,Asset
				)
				Values
				(
					@attributeOid,@assetOid
				)

				Delete
				From #AttributeNameToCreate
				Where Name =@name
			End
		End
		IF OBJECT_ID('tempdb..#AttributeNameToCreate') IS NOT NULL
	    DROP TABLE #AttributeNameToCreate
	End
End


Select dbo.AssetAttribute.*,
	dbo.CharacteristicsItemBase.ObjectType,
	dbo.CharacteristicsItemBase.GCRecord
 From dbo.AssetAttribute
 inner join dbo.CharacteristicsItemBase on dbo.AssetAttribute.Oid = dbo.CharacteristicsItemBase.Oid

 Select Oid  into #assetAttributesToDelete
 From dbo.AssetAttribute
 Where dbo.AssetAttribute.Asset is null

 Delete 
 From dbo.AssetAttribute
 Where dbo.AssetAttribute.Oid in (Select * From #assetAttributesToDelete)

 Delete 
 From dbo.CharacteristicsItemBase
 Where dbo.CharacteristicsItemBase.Oid in (Select * From #assetAttributesToDelete)

IF OBJECT_ID('tempdb..#assetAttributesToDelete') IS NOT NULL
	DROP TABLE #assetAttributesToDelete