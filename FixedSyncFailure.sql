USE [fvp-database]
GO
--

--Alter Procedure fvp_Remove_Error_Column_ForeignKey_Index
Create Procedure [dbo].[fvp_Remove_Error_Column_ForeignKey_Index]
AS
Begin
--Valuer
IF EXISTS (
	SELECT name 
	FROM sysindexes 
	WHERE name = 'iInspectedBy_Valuer'
	) 
	DROP INDEX [iInspectedBy_Valuer] ON [dbo].[Valuer]


IF EXISTS (
		SELECT * 
		  FROM sys.foreign_keys 
		   WHERE object_id = OBJECT_ID(N'FK_Valuer_InspectedBy')
		   AND parent_object_id = OBJECT_ID(N'dbo.Valuer')
		)

ALTER TABLE [dbo].[Valuer] 
DROP CONSTRAINT [FK_Valuer_InspectedBy]

IF EXISTS(
    SELECT *
    FROM sys.columns 
    WHERE Name      = N'InspectedBy'
      AND Object_ID = Object_ID(N'Valuer')
    )
Begin
	Alter table [dbo].[Valuer]
	Drop column [InspectedBy]
End


IF EXISTS(
    SELECT *
    FROM sys.columns 
    WHERE Name      = N'ToBeValue'
      AND Object_ID = Object_ID(N'Valuer')
    )
Begin
	Alter table [dbo].[Valuer]
	Drop column [ToBeValue]
End
--DirectComparisonSale
IF EXISTS(
    SELECT *
    FROM sys.columns 
    WHERE Name      = N'BuildingRate'
      AND Object_ID = Object_ID(N'[dbo].DirectComparisonSale')
    )
Begin
	Alter table [dbo].[DirectComparisonSale]
	Drop column [BuildingRate]
End

--MarketValue
IF EXISTS (
		SELECT * 
		  FROM sys.foreign_keys 
		   WHERE object_id = OBJECT_ID(N'FK_Asset_MarketValue')
		   AND parent_object_id = OBJECT_ID(N'dbo.Asset')
		)
ALTER TABLE [dbo].[Asset] 
DROP CONSTRAINT [FK_Asset_MarketValue]

--Valuer
IF EXISTS (
		SELECT * 
		  FROM sys.foreign_keys 
		   WHERE object_id = OBJECT_ID(N'FK_Asset_Valuer')
		   AND parent_object_id = OBJECT_ID(N'dbo.Asset')
		)
ALTER TABLE [dbo].[Asset] 
DROP CONSTRAINT [FK_Asset_Valuer]

--Analysis Approach
IF EXISTS (
		SELECT * 
		  FROM sys.foreign_keys 
		   WHERE object_id = OBJECT_ID(N'FK_Asset_AnalysisOfApproach')
		   AND parent_object_id = OBJECT_ID(N'dbo.Asset')
		)
ALTER TABLE [dbo].[Asset] 
DROP CONSTRAINT [FK_Asset_AnalysisOfApproach]


--FVMInputLevel
IF EXISTS(
    SELECT *
    FROM sys.columns 
    WHERE Name      = N'FVMInputLevel'
      AND Object_ID = Object_ID(N'FinancialReportingClassification')
    )
Begin
	Alter table [dbo].[FinancialReportingClassification]
	Drop column [FVMInputLevel]
End

--DirectComparison spelling mistake
	-- Index
	IF EXISTS (
	SELECT name 
	FROM sysindexes 
	WHERE name = 'iDirectComparsion_DirectComparisonSale'
	) 
	DROP INDEX [iDirectComparsion_DirectComparisonSale] ON [dbo].[DirectComparisonSale]
	-- Foreign Key
	IF EXISTS (
	SELECT * 
	  FROM sys.foreign_keys 
	   WHERE object_id = OBJECT_ID(N'FK_DirectComparisonSale_DirectComparsion')
	   AND parent_object_id = OBJECT_ID(N'dbo.DirectComparisonSale')
	)
	Begin
		ALTER TABLE [dbo].[DirectComparisonSale] 
		DROP CONSTRAINT [FK_DirectComparisonSale_DirectComparsion]
	End
	-- Column
	IF EXISTS(
		SELECT *
		FROM sys.columns 
		WHERE Name  = 'DirectComparsion'
		  AND Object_ID = Object_ID(N'DirectComparisonSale')
		)
	Begin
		ALTER TABLE [dbo].[DirectComparisonSale] 
		DROP column [DirectComparsion]
	End
--Asset Table Clean
IF EXISTS(
		SELECT *
		FROM sys.columns 
		WHERE Name  = 'ToBeValued'
		  AND Object_ID = Object_ID(N'Asset')
		)
	Alter Table [dbo].[Asset]
	Drop column [ToBeValued]
IF EXISTS(
		SELECT *
		FROM sys.columns 
		WHERE Name  = 'Income'
		  AND Object_ID = Object_ID(N'Asset')
		)
	Alter Table [dbo].[Asset]
	Drop column [Income]
IF EXISTS(
		SELECT *
		FROM sys.columns 
		WHERE Name  = 'Cost'
		  AND Object_ID = Object_ID(N'Asset')
		)
	Alter Table [dbo].[Asset]
	Drop column [Cost]
IF EXISTS(
		SELECT *
		FROM sys.columns 
		WHERE Name  = 'Market'
		  AND Object_ID = Object_ID(N'Asset')
		)
	Alter Table [dbo].[Asset]
	Drop column [Market]
IF EXISTS(
		SELECT *
		FROM sys.columns 
		WHERE Name  = 'ControledforFinancialPurpose'
		  AND Object_ID = Object_ID(N'Asset')
		)
	Alter Table [dbo].[Asset]
	Drop column [ControledforFinancialPurpose]
--Insurance Valuation
IF EXISTS(
		SELECT *
		FROM sys.columns 
		WHERE Name  = 'SquareMetreOfAssets'
		  AND Object_ID = Object_ID(N'InsuranceValuation')
		)
	Alter Table [dbo].[InsuranceValuation]
	Drop column [SquareMetreOfAssets]
IF EXISTS (
		SELECT * 
		  FROM sys.foreign_keys 
		   WHERE object_id = OBJECT_ID(N'FK_Asset_InsuranceValuation')
		   AND parent_object_id = OBJECT_ID(N'dbo.Asset')
		)
	ALTER TABLE [dbo].[Asset] 
	DROP CONSTRAINT [FK_Asset_InsuranceValuation]
--Replacement Cost
	--Asset Foregin Key
	IF EXISTS (
		SELECT * 
		  FROM sys.foreign_keys 
		   WHERE object_id = OBJECT_ID(N'FK_Asset_ReplacementCostApportionment')
		   AND parent_object_id = OBJECT_ID(N'dbo.Asset')
		)
	ALTER TABLE [dbo].[Asset] 
	DROP CONSTRAINT [FK_Asset_ReplacementCostApportionment]
	
	IF EXISTS (
		SELECT * 
		  FROM sys.foreign_keys 
		   WHERE object_id = OBJECT_ID(N'FK_Asset_ReplacementCostDirectCost')
		   AND parent_object_id = OBJECT_ID(N'dbo.Asset')
		)
	ALTER TABLE [dbo].[Asset] 
	DROP CONSTRAINT [FK_Asset_ReplacementCostDirectCost]
	
	IF EXISTS (
		SELECT * 
		  FROM sys.foreign_keys 
		   WHERE object_id = OBJECT_ID(N'FK_ReplacementCostApportionment_Asset')
		   AND parent_object_id = OBJECT_ID(N'dbo.ReplacementCostApportionment')
		)
	ALTER TABLE [dbo].[ReplacementCostApportionment] 
	DROP CONSTRAINT [FK_ReplacementCostApportionment_Asset]

	IF EXISTS (
		SELECT * 
		  FROM sys.foreign_keys 
		   WHERE object_id = OBJECT_ID(N'FK_ReplacementCost_Asset')
		   AND parent_object_id = OBJECT_ID(N'ReplacementCost')
		)
		Alter Table [dbo].[ReplacementCost]
		Drop Constraint [FK_ReplacementCost_Asset]
	IF EXISTS(
		SELECT *
		FROM sys.columns 
		WHERE Name  = 'Asset'
		  AND Object_ID = Object_ID(N'ReplacementCostApportionment')
		)
	Alter Table [dbo].[ReplacementCostApportionment]
	Drop Column [Asset]
	IF EXISTS(
		SELECT *
		FROM sys.columns 
		WHERE Name  = 'Asset'
		  AND Object_ID = Object_ID(N'ReplacementCostDirectCost')
		)
	Alter Table [dbo].[ReplacementCostDirectCost]
	Drop Column [Asset]
End

--Select *
--from [dbo].[ReplacementCost]
--where 
--asset is null
--asset not in 
--(
--Select [Oid]
--from [asset]
--)
exec [dbo].[fvp_Remove_Error_Column_ForeignKey_Index]


--SELECT c.name AS ColName, t.name AS TableName
--FROM sys.columns c
--    JOIN sys.tables t ON c.object_id = t.object_id
--WHERE c.name LIKE '%FVMInputLevel%'
 
-- SELECT COLUMN_NAME, TABLE_NAME 
--FROM INFORMATION_SCHEMA.COLUMNS 
--WHERE COLUMN_NAME LIKE '%FVMInputLevel%'

