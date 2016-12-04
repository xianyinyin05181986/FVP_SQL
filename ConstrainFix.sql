
USE [fvp-database]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Asset_AnalysisOfApproach]') AND parent_object_id = OBJECT_ID(N'[dbo].[Asset]'))
ALTER TABLE [dbo].[Asset] DROP CONSTRAINT [FK_Asset_AnalysisOfApproach]

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Asset_InsuranceValuation]') AND parent_object_id = OBJECT_ID(N'[dbo].[Asset]'))
ALTER TABLE [dbo].[Asset] DROP CONSTRAINT [FK_Asset_InsuranceValuation]

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Asset_MarketValue]') AND parent_object_id = OBJECT_ID(N'[dbo].[Asset]'))
ALTER TABLE [dbo].[Asset] DROP CONSTRAINT [FK_Asset_MarketValue]

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Asset_ReplacementCostApportionment]') AND parent_object_id = OBJECT_ID(N'[dbo].[Asset]'))
ALTER TABLE [dbo].[Asset] DROP CONSTRAINT [FK_Asset_ReplacementCostApportionment]

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Asset_ReplacementCostDirectCost]') AND parent_object_id = OBJECT_ID(N'[dbo].[Asset]'))
ALTER TABLE [dbo].[Asset] DROP CONSTRAINT [FK_Asset_ReplacementCostDirectCost]

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Asset_Valuer]') AND parent_object_id = OBJECT_ID(N'[dbo].[Asset]'))
ALTER TABLE [dbo].[Asset] DROP CONSTRAINT [FK_Asset_Valuer]


ALTER TABLE [dbo].[Asset] DROP  COLUMN [ToBeValued]
ALTER TABLE [dbo].[Asset] DROP COLUMN [ControledforFinancialPurpose]
ALTER TABLE [dbo].[Asset] DROP  COLUMN [FVPInputLevel]

ALTER TABLE [dbo].[FinancialReportingClassification] ADD FVPInputLevel INT NULL
GO



