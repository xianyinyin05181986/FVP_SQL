-- =============================================================================================
-- Create Stored Procedure Template for Azure SQL Database and Azure SQL Data Warehouse Database
-- =============================================================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateComponentsConsumptionProfileWithJobOid]
	-- Add the parameters for the stored procedure here
	@p1 uniqueIdentifier
As
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [dbo].[ComponentInput]
   SET 
      [dbo].[ComponentInput].[ConsumptionProfile] = [dbo].[ComponentMatrixConsumptionProfileView].[ValuationProfile]
     From  [dbo].[ComponentInput]
	inner join [dbo].[ComponentMatrixConsumptionProfileView]
		On [dbo].[ComponentMatrixConsumptionProfileView].[ComponentId] = [dbo].[ComponentInput].[Oid]
	Where [dbo].[ComponentInput].[Asset] In
 (
		Select [Oid]  
		From [dbo].[Asset]
		Where  [GCRecord] is Null
		  And [dbo].[Asset].[AssetRegister] in
		  (
			Select [Oid]
			From [dbo].[AssetRegister]
			Where [dbo].[AssetRegister].[Job] = @p1
				And [GCRecord] is Null
		  )
  ) 


END
GO
