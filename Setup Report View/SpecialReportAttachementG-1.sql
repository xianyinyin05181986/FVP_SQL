USE [fvp-database]
GO

/****** Object:  View [dbo].[InsuranceReportView]    Script Date: 18/11/2016 3:40:14 PM ******/
DROP VIEW [dbo].[InsuranceReportView]
GO

/****** Object:  View [dbo].[InsuranceReportView]    Script Date: 18/11/2016 3:40:14 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[InsuranceReportView]
WITH SCHEMABINDING 
AS

/****** Script for SelectTopNRows command from SSMS  ******/
SELECT
	   [dbo].[AssetRegister].[Job] As JobOid
	  ,[dbo].[AssetRegister].[Client] As ClientOid
	  ,[dbo].[AssetHierarchy].[Name] As AssetClass
	  ,[dbo].[AssetType].[Name]  As AssetType
	  ,[dbo].[AssetSubType].[Name] As AssetSubtype	
	  ,[dbo].[InsuranceValuation].[Oid] As InsuranceOid
      ,[dbo].[InsuranceValuation].[LeadBuildMonths] 
      ,[dbo].[InsuranceValuation].[DemoMonths] 
      ,[dbo].[InsuranceValuation].[EscallationFactorPercentage] 
      ,[dbo].[InsuranceValuation].[ProfessionalFeesPercentage] 
      ,[dbo].[InsuranceValuation].[UnitRateOfRemovalOfDebris]
	  ,[dbo].[Insurance].[LeadMonths] As LeadTime
	  ,[dbo].[Insurance].[Demolition] As RebuildTime
	  ,[dbo].[Insurance].[EscalationFactor] As AnnualCostEscalationFactorPerc
	  ,[dbo].[Insurance].[ProfessionalFees] 
	  ,[dbo].[Insurance].[RatePerMetre]
  FROM [dbo].[InsuranceValuation]
       inner join [dbo].[AssetRegister] on [dbo].[AssetRegister].[Asset] = [dbo].[InsuranceValuation].[Asset]
	   inner join [dbo].[AssetHierarchy] on [dbo].[AssetRegister].[AssetClass] = [dbo].[AssetHierarchy].[Oid]
	   inner join [dbo].[AssetType] on [dbo].[AssetRegister].[AssetType] = [dbo].[AssetType].[Oid]
	   inner join [dbo].[AssetSubType] on [dbo].[AssetRegister].[AssetSubType] = [dbo].[AssetSubType].[Oid]
	   inner join [dbo].[Insurance] on [dbo].[Insurance].[AssetSubType] = [dbo].[AssetSubType].[Oid]
  Where [dbo].[InsuranceValuation].[GCRecord] is null
		And  [dbo].[AssetRegister].[GCRecord] is null
		And   [dbo].[AssetRegister].[Job] is not null


GO
CREATE unique CLUSTERED INDEX [iInsuranceValuation_InsuranceReportView] ON [dbo].[InsuranceReportView]
(
	[InsuranceOid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

