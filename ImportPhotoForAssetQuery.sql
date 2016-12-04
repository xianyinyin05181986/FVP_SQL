USE [fvp-database]
GO
-- =============================================
-- Author:		Yinyin Xian
-- Create date: 3rd Dec 2016
-- Description:	Insert Photo using AssetId,ClientOid 
-- =============================================
/****** Object:  StoredProcedure [dbo].[InsertPhotoForAsset]    Script Date: 4/12/2016 12:52:12 AM ******/
DROP PROCEDURE [dbo].[InsertPhotoForAsset]
GO
-- =============================================================================================
-- Create Stored Procedure Template for Azure SQL Database and Azure SQL Data Warehouse Database
-- =============================================================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[InsertPhotoForAsset]
	-- Add the parameters for the stored procedure here
	@assetId nvarchar(100),
	@filename nvarchar(100),
	@fileDataOid uniqueidentifier,
	@clientOid uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Declare @assetOid uniqueidentifier
	,@groupOid uniqueidentifier
	
	Select @assetOid = [dbo].[AssetRegister].[Asset],
			@groupOid = [dbo].[AssetRegister].[FairValueProGroup]
	From [dbo].[AssetRegister]
	Where [dbo].[AssetRegister].[AssetId] =@assetId 
	and [dbo].[AssetRegister].[Client] =@clientOid
	and [dbo].[AssetRegister].[GCRecord] is null

	Print (@assetOid)
	IF @assetOid is null
	Return 
	 
    -- Insert statements for procedure here

	Declare @filenameToinsert nvarchar(100)


	IF Exists
	(
		Select [dbo].[UploadDocument].[Name]
		From [dbo].[UploadDocument]
		Where [dbo].[UploadDocument].[Asset] =@assetOid and [dbo].[UploadDocument].[Name] =@filename
	)
		Begin
		
			Select @filenameToinsert = [dbo].[UploadDocument].[Name] +'_Copy'
			From [dbo].[UploadDocument]
			Where [dbo].[UploadDocument].[Asset] = @assetOid

			Print(@filenameToinsert)
		End
	Else
		Begin
			Set @filenameToinsert  = @filename
		End



	Insert into [dbo].[UploadDocument]
	(
		[Oid],
		[Name],
		[Commments],
		[Client],
		[FairValueProGroup],
		[UploadFile],
		[TypeOfDocument],
		[Asset]
	)
	Values
	(
		NewId()
		,@filenameToinsert
		,@filenameToinsert
		,@clientOid
		,@groupOid
		,@fileDataOid
		,1
		,@assetOid
	)
END
GO

