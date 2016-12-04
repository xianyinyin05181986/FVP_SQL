-- =============================================================================================
-- Create Stored Procedure Template for Azure SQL Database and Azure SQL Data Warehouse Database
-- =============================================================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Yinyin Xian
-- Create date: 29th Nov 2016
-- Description:	Update Component Input Client And Group
-- =============================================
CREATE PROCEDURE [dbo].[UpdateClientAndGroupForComponentInput]
	-- Add the parameters for the stored procedure here
	@jobOid uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	 select [dbo].[ComponentInput].[Oid] into #componentToDelete
	 from [dbo].[ComponentInput]
	 inner join [dbo].[ComponentAssetHierarchy] on [dbo].[ComponentInput].[Component_AssetHierarchy] =[dbo].[ComponentAssetHierarchy].[Oid] and [dbo].[ComponentAssetHierarchy].[GCRecord] is not null
	 inner join [dbo].[AssetRegister] on [dbo].[AssetRegister].[Asset] = [dbo].[ComponentInput].[Asset]
	 inner join [dbo].[Job] on [dbo].[AssetRegister].[Job] =[dbo].[Job].[Oid]
	 Where [dbo].[Job].[Oid] = @jobOid and [dbo].[Job].[JobStatus] = 1

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
END
GO
