/****** Script for SelectTopNRows command from SSMS  ******/
SELECT
	   [dbo].[AssetRegister].[Job] As JobOid
	  ,[dbo].[AssetRegister].[Client] As ClientOid
	  ,[dbo].[AssetHierarchy].[Name] As AssetClass
	  ,[dbo].[AssetType].[Name]  As AssetType
	  ,[dbo].[AssetSubType].[Name] As AssetSubtype	
	  ,[dbo].[InsuranceValuation].[Oid] As InsuranceOid
      ,[dbo].[InsuranceValuation].[LeadBuildMonths] LeadTime
      ,[dbo].[InsuranceValuation].[DemoMonths] As RebuildTime
      ,[dbo].[InsuranceValuation].[EscallationFactorPercentage] As AnnualCostEscalationFactorPerc
      ,[dbo].[InsuranceValuation].[ProfessionalFeesPercentage] 
      ,[dbo].[InsuranceValuation].[UnitRateOfRemovalOfDebris]
  FROM [dbo].[InsuranceValuation]
       inner join [dbo].[AssetRegister] on [dbo].[AssetRegister].[Asset] = [dbo].[InsuranceValuation].[Asset]
	   inner join [dbo].[AssetHierarchy] on [dbo].[AssetRegister].[AssetClass] = [dbo].[AssetHierarchy].[Oid]
	   inner join [dbo].[AssetType] on [dbo].[AssetRegister].[AssetType] = [dbo].[AssetType].[Oid]
	   inner join [dbo].[AssetSubType] on [dbo].[AssetRegister].[AssetSubType] = [dbo].[AssetSubType].[Oid]
  Where [dbo].[InsuranceValuation].[GCRecord] is null
		And  [dbo].[AssetRegister].[GCRecord] is null
		And   [dbo].[AssetRegister].[Job] is not null