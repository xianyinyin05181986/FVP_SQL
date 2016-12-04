-- =================================================================================
-- Create View template for Azure SQL Database and Azure SQL Data Warehouse Database
-- =================================================================================

IF object_id(N'[dbo].[ConsumptionDetailInComponentReportView]', 'V') IS NOT NULL


	DROP VIEW [dbo].[ConsumptionDetailInComponentReportView]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[ConsumptionDetailInComponentReportView]
WITH SCHEMABINDING 
AS

/****** Script for SelectTopNRows command from SSMS  ******/
SELECT distinct
	   [dbo].[AssetHierarchy].[Client] As ClientOid
	  ,[dbo].[AssetRegister].[Job] As JobOid
	  ,[dbo].[AssetHierarchy].[AssetHierarchyName] As AssetClassName
	  ,[dbo].[ConsumptionProfile].[ConsumptionProfileName]
	  ,[dbo].[ConsumptionProfile].[Oid] As ProfileOid
      ,[dbo].[ConsumptionProfileRow].[Severity]
      ,[dbo].[ConsumptionProfileRow].[ConsumptionScore]
      ,[dbo].[ConsumptionProfileRow].[PercentageOfRul]
      ,[dbo].[ConsumptionProfileRow].[PercentageOfRsp]
      ,[dbo].[ConsumptionProfileRow].[ObsolescenceFactor]
  FROM [dbo].[AssetHierarchy]
		  inner join [dbo].[GeneralAssumptions] on [dbo].[GeneralAssumptions].[AssetClass]= [dbo].[AssetHierarchy].[Oid]
		  inner join [dbo].[ConsumptionProfile] on [dbo].[GeneralAssumptions].[Oid] =[dbo].[ConsumptionProfile].[GeneralAssumption]
		  inner join [dbo].[ConsumptionProfileRow] on [dbo].[ConsumptionProfileRow].[ConsumptionProfile] = [dbo].[ConsumptionProfile].[Oid]
		  inner join [dbo].[AssetRegister] on [dbo].[AssetRegister].[AssetClass] = [dbo].[AssetHierarchy].[Oid]
		  inner join [dbo].[ComponentInput] on [dbo].[ComponentInput].[ConsumptionProfile] = [dbo].[ConsumptionProfile].[Oid]
						And [dbo].[AssetRegister].[Asset] = [dbo].[ComponentInput].[Asset]
   Where     [dbo].[ConsumptionProfileRow].[GCRecord] is null  
			     And [dbo].[AssetRegister].[GCRecord] is null 
				 And [dbo].[ComponentInput].[GCRecord] is null
				 And [dbo].[AssetRegister].[Job] is not null
Go
