

EXEC sys.sp_dropextendedproperty @name=N'MS_DiagramPaneCount' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'NewAssetSummaryValuationReportView'

GO

EXEC sys.sp_dropextendedproperty @name=N'MS_DiagramPane2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'NewAssetSummaryValuationReportView'

GO

EXEC sys.sp_dropextendedproperty @name=N'MS_DiagramPane1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'NewAssetSummaryValuationReportView'

GO

/****** Object:  View [dbo].[NewAssetSummaryValuationReportView]    Script Date: 7/11/2016 2:49:57 PM ******/
DROP VIEW [dbo].[NewAssetSummaryValuationReportView]
GO

/****** Object:  View [dbo].[NewAssetSummaryValuationReportView]    Script Date: 7/11/2016 2:49:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[NewAssetSummaryValuationReportView] WITH SCHEMABINDING 
AS
SELECT        dbo.AssetRegister.Client AS ClientOid, dbo.AssetRegister.Oid AS AssetRegisterOid, dbo.AssetHierarchy.Name AS AssetClass, dbo.AssetType.Name AS AssetType, dbo.AssetSubType.Name AS AssetSubtType, 
                         dbo.AssetRegister.Job AS JobOid
						 --, dbo.Job.Name AS JobName
						 --, dbo.Job.JobStatus
						 , dbo.AssetRegister.Name AS AssetName, dbo.AssetRegister.AssetId, dbo.AssetRegister.Facility, dbo.MyAddress.StreetAddress, 
                         dbo.MyAddress.Suburb, dbo.MyAddress.Town, dbo.MyAddress.State, dbo.MyAddress.Country, dbo.MyAddress.PostCode, dbo.AssetRegister.ToBeValued, dbo.Asset.PreviousValuation AS PreviousValuationOid, 
                         CASE WHEN dbo.AssetRegister.Cost = 0 AND dbo.AssetRegister.Income = 1 AND dbo.AssetRegister.Market = 1 THEN dbo.Asset.CostSummaryValuation WHEN dbo.AssetRegister.Cost = 1 AND 
                         dbo.AssetRegister.Income = 0 AND dbo.AssetRegister.Market = 1 THEN dbo.Asset.IncomeSummaryValuation WHEN dbo.AssetRegister.Cost = 1 AND dbo.AssetRegister.Income = 1 AND 
                         dbo.AssetRegister.Market = 0 THEN dbo.Asset.MarketSummaryValuation WHEN dbo.AssetRegister.Cost = 1 AND dbo.AssetRegister.Income = 1 AND dbo.AssetRegister.Market = 1 THEN NULL 
                         ELSE dbo.Asset.CombinedSummaryValuation END AS CurrentValuationOid, dbo.AssetRegister.HeldforSaleorInvestment, dbo.AssetRegister.ControledforFinancialPurpose, 
                         dbo.Asset.InsuranceValuation AS InsuranceOid, dbo.FinancialAssetClass.Name AS FinancialAssetClass, dbo.FinancialAssetType.Name AS FinancialAssetSubClass, 
                         dbo.FairValueMeasurementClass.Name AS FairValueMeasurementClass, dbo.FinancialReportingClassification.HAndBUse
FROM            dbo.AssetRegister INNER JOIN
                         dbo.AssetHierarchy ON dbo.AssetRegister.AssetClass = dbo.AssetHierarchy.Oid INNER JOIN
                         dbo.AssetType ON dbo.AssetRegister.AssetType = dbo.AssetType.Oid INNER JOIN
                         dbo.AssetSubType ON dbo.AssetRegister.AssetSubType = dbo.AssetSubType.Oid INNER JOIN
                         dbo.Asset ON dbo.AssetRegister.Asset = dbo.Asset.Oid INNER JOIN
                         dbo.MyAddress ON dbo.AssetRegister.DefaultAddress = dbo.MyAddress.Oid INNER JOIN
                         dbo.FinancialReportingClassification ON dbo.Asset.FinancialReportingClassification = dbo.FinancialReportingClassification.Oid INNER JOIN
                         dbo.FinancialAssetClass ON dbo.FinancialReportingClassification.FinancialAssetClass = dbo.FinancialAssetClass.Oid INNER JOIN
                         dbo.FinancialAssetType ON dbo.FinancialReportingClassification.FinancialAssetSubClass = dbo.FinancialAssetType.Oid INNER JOIN
                         dbo.FairValueMeasurementClass ON dbo.FinancialReportingClassification.FairValueMeasurementClass = dbo.FairValueMeasurementClass.Oid 
                         --LEFT OUTER JOIN dbo.Job ON dbo.AssetRegister.Job = dbo.Job.Oid
WHERE        (dbo.AssetRegister.GCRecord IS NULL)

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[12] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = -192
         Left = 0
      End
      Begin Tables = 
         Begin Table = "AssetRegister"
            Begin Extent = 
               Top = 2
               Left = 14
               Bottom = 315
               Right = 261
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "AssetHierarchy"
            Begin Extent = 
               Top = 3
               Left = 309
               Bottom = 133
               Right = 519
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "AssetType"
            Begin Extent = 
               Top = 0
               Left = 539
               Bottom = 130
               Right = 733
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "AssetSubType"
            Begin Extent = 
               Top = 0
               Left = 750
               Bottom = 130
               Right = 945
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Job"
            Begin Extent = 
               Top = 360
               Left = 12
               Bottom = 490
               Right = 225
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "Asset"
            Begin Extent = 
               Top = 149
               Left = 520
               Bottom = 422
               Right = 830
            End
            DisplayFlags = 280
            TopColumn = 13
         End
         Begin Table = "MyAddress"
            Begin Extent = 
               Top = 332
               Left = 304
               Bottom = 561
               Right = 499
            End
            Di' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'NewAssetSummaryValuationReportView'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'splayFlags = 280
            TopColumn = 3
         End
         Begin Table = "FinancialReportingClassification"
            Begin Extent = 
               Top = 3
               Left = 1156
               Bottom = 388
               Right = 1393
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "FinancialAssetClass"
            Begin Extent = 
               Top = 122
               Left = 877
               Bottom = 252
               Right = 1100
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "FinancialAssetType"
            Begin Extent = 
               Top = 284
               Left = 881
               Bottom = 414
               Right = 1103
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "FairValueMeasurementClass"
            Begin Extent = 
               Top = 440
               Left = 891
               Bottom = 676
               Right = 1095
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 28
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 945
         Width = 1500
         Width = 1545
         Width = 2310
         Width = 1230
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 3480
         Width = 1500
         Width = 1500
         Width = 3465
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1305
         Alias = 2430
         Table = 2430
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'NewAssetSummaryValuationReportView'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'NewAssetSummaryValuationReportView'
GO


