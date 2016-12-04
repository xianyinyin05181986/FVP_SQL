USE [fvp-database]
GO

/****** Object:  StoredProcedure [dbo].[Address_bulkinsert]    Script Date: 2/12/2016 11:51:25 AM ******/
DROP PROCEDURE  [dbo].[ComponentLevelReportByJobNameAndClientName] 
GO

/****** Object:  StoredProcedure [dbo].[Address_bulkinsert]    Script Date: 2/12/2016 11:51:25 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE  [dbo].[ComponentLevelReportByJobNameAndClientName] 
	@jobName nvarchar(100),
	@clientName nvarchar(100)
AS
BEGIN
	  Select 
       [dbo].[FairValueProClient].[Name] as ClientName
	  ,[dbo].[Job].[Name] as JobName 
	  ,[dbo].[AssetHierarchy].[AssetHierarchyName] As [Asset Class]
	  ,[dbo].[AssetType].[AssetTypeName] As [Asset Type]
	  ,[dbo].[AssetSubType].[AssetSubTypeName] As [Asset Subtype]
	  ,[dbo].[Phase2ComponentValuation].[Name] As [Component]
      ,[dbo].[Phase2ComponentValuation].[Apportionment]
      ,[dbo].[Phase2ComponentValuation].[Gross]
      ,[dbo].[Phase2ComponentValuation].[AccumDepreciation]
      ,[dbo].[Phase2ComponentValuation].[FairValue]
      ,[dbo].[Phase2ComponentValuation].[PercentageGross]
      ,[dbo].[Phase2ComponentValuation].[RV_Total]
      ,[dbo].[Phase2ComponentValuation].[RV_Percentage_Total]
      ,[dbo].[Phase2ComponentValuation].[DeprAmount_Total]
      ,[dbo].[Phase2ComponentValuation].[DeprExp_Total]
      ,[dbo].[Phase2ComponentValuation].[WeightedAverageUsefullife]
      ,[dbo].[Phase2ComponentValuation].[WeightedAverageRUL]
      ,[dbo].[Phase2ComponentValuation].[Gross_Short]
      ,[dbo].[Phase2ComponentValuation].[RV_Short]
      ,[dbo].[Phase2ComponentValuation].[DeprAmount_Short]
      ,[dbo].[Phase2ComponentValuation].[Score]
      ,[dbo].[Phase2ComponentValuation].[RSPPercentage_Short]
      ,[dbo].[Phase2ComponentValuation].[FV_Short]
      ,[dbo].[Phase2ComponentValuation].[Usefullife_Short]
      ,[dbo].[Phase2ComponentValuation].[RUL_Short]
      ,[dbo].[Phase2ComponentValuation].[LongLifePercentage]
      ,[dbo].[Phase2ComponentValuation].[Gross_Long]
      ,[dbo].[Phase2ComponentValuation].[RV_Long]
      ,[dbo].[Phase2ComponentValuation].[DeprAmount_Long]
      ,[dbo].[Phase2ComponentValuation].[RVPercentage_Long]
      ,[dbo].[Phase2ComponentValuation].[RSPPercentage_Long]
      ,[dbo].[Phase2ComponentValuation].[FV_Long]
      ,[dbo].[Phase2ComponentValuation].[Usefullife_Long]
      ,[dbo].[Phase2ComponentValuation].[RUL_Long]
      ,[dbo].[Phase2ComponentValuation].[DeprExp_Long]
      ,[dbo].[Phase2ComponentValuation].[DeprExp_Short]
      ,[dbo].[Phase2ComponentValuation].[RVPercentage_Short]
      ,[dbo].[Phase2ComponentValuation].[WeightedFvProp]
      ,[dbo].[Phase2ComponentValuation].[WeightedProp]
      ,[dbo].[Phase2ComponentValuation].[MarketValue]
  FROM [dbo].[AssetRegister] 
  inner join [dbo].[Job] on [dbo].[Job].[Oid]=[dbo].[AssetRegister].[Job] and [dbo].[Job].[Name] =@jobName
  inner join [dbo].[FairValueProClient] on [dbo].[FairValueProClient].[Oid] = [dbo].[AssetRegister].[Client] 
  and [dbo].[FairValueProClient].[Name]=@clientName 
  inner join [dbo].[AssetHierarchy] on [dbo].[AssetHierarchy].[Oid] =  [dbo].[AssetRegister].[AssetClass]
  inner join [dbo].[AssetType] on [dbo].[AssetType].[Oid] = [dbo].[AssetRegister].[AssetType]
  inner join [dbo].[AssetSubType] on [dbo].[AssetSubType].[Oid] = [dbo].[AssetRegister].[AssetSubType]
  inner join [dbo].[AssetComponentValuationView] on [dbo].[AssetComponentValuationView] .[AssetRegisterOid] =[dbo].[AssetRegister].[Oid]
  inner join [dbo].[Phase2ComponentValuation] on [dbo].[Phase2ComponentValuation].[Oid] =[dbo].[AssetComponentValuationView].[ComponentValuationOid] 
  inner join [dbo].[ComponentInput] on [dbo].[ComponentInput].[Oid] = [dbo].[Phase2ComponentValuation].[ComponentInput]
  inner join [dbo].[ComponentType] on [dbo].[ComponentType].[Oid] = [dbo].[ComponentInput].[ComponentType]
  inner join [dbo].[ComponentSubType] on [dbo].[ComponentSubType].[Oid] = [dbo].[ComponentInput].[ComponentSubType]
 
END
GO


