-- =============================================================================================
-- Create Stored Procedure Template for Azure SQL Database and Azure SQL Data Warehouse Database
-- =============================================================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Yinyin Xian
-- Create date: 21 Nov 2016
-- Description:	Re-Assgin Assets to a Job
-- =============================================
CREATE PROCEDURE [dbo].[ReassignAssetForJob]
	-- Add the parameters for the stored procedure here
	@jobOid uniqueidentifier ,
	@clientOid uniqueidentifier
AS
BEGIN
	Update [dbo].[AssetRegister]
	Set [dbo].[AssetRegister].[Job] = @jobOid
	Where [dbo].[AssetRegister].[Client] =@clientOid
	 And [dbo].[AssetRegister].[GCRecord] is null
	 And [dbo].[AssetRegister].[Job] is null
	 And [dbo].[AssetRegister].[AssetClass] is not null
	 And [dbo].[AssetRegister].[AssetClass] in 
	(
		Select [dbo].[AssetHierarchy].[Oid]
		From [dbo].[AssetHierarchy]
		inner join [dbo].[JobSetting] on [dbo].[JobSetting].[AssetClass] =[dbo].[AssetHierarchy].[Oid] 
			   And [dbo].[JobSetting].[Job] =@jobOid
	)
END
GO
