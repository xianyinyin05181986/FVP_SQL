USE [fvp-database]
GO

/****** Object:  StoredProcedure [dbo].[DisplayClientInformation]    Script Date: 4/12/2016 4:21:43 AM ******/
DROP PROCEDURE [dbo].[DisplayClientInformation]
GO

/****** Object:  StoredProcedure [dbo].[DisplayClientInformation]    Script Date: 4/12/2016 4:21:44 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






-- =============================================
-- Author:		Yinyin Xian
-- Create date: 30 Nov 2016
-- Description:	Asset Register Import
-- =============================================
CREATE PROCEDURE [dbo].[DisplayClientInformation]
		@clientName nvarchar(100)
As
Begin
	Declare @clientOid uniqueidentifier

	Select @clientOid = [dbo].[FairValueProClient].[Oid]
	From [dbo].[FairValueProClient]
	Where [dbo].[FairValueProClient].[Name] = @clientName

	select *
	From [dbo].[FairValueProClient]
	where [dbo].[FairValueProClient].[Oid] =@clientOid

	select count(*) as AssetRegister#,[Job]
	from [dbo].[AssetRegister]
	where [Client] = @clientOid and [GCRecord] is null
	Group by [Job] 

	select count(*) as RegisteredAsset#
	from [dbo].[AssetRegister]
	where [Client] = @clientOid and [GCRecord] is null and [dbo].[AssetRegister].[Asset] is not null

	select count(*) as Asset#
	from [dbo].[Asset]
	where [Client] = @clientOid and [GCRecord] is null 

	select [Oid]  into #AssetRegisterOid
	from [dbo].[AssetRegister]
	where [Client] = @clientOid and [GCRecord] is null

	select [Oid] into #AssetOid
	from [dbo].[Asset]
	where [Client] = @clientOid and [GCRecord] is null 

	select count(*) as Component#
	from [dbo].[ComponentInput]
	where [Client] = @clientOid and [GCRecord] is null  


	select count(*) as File#
	From [dbo].[UploadDocument]
	where [dbo].[UploadDocument].[Asset] in
	(Select * from #AssetOid)

	IF OBJECT_ID('tempdb..#AssetOid') IS NOT NULL
		DROP TABLE #AssetOid
	IF OBJECT_ID('tempdb..#AssetRegisterOid') IS NOT NULL
		DROP TABLE #AssetRegisterOid
End


GO


