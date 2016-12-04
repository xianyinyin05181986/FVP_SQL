
EXEC sys.sp_dropextendedproperty @name=N'MS_DiagramPaneCount' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AssetLevelReportView'

GO

EXEC sys.sp_dropextendedproperty @name=N'MS_DiagramPane2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AssetLevelReportView'

GO

EXEC sys.sp_dropextendedproperty @name=N'MS_DiagramPane1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AssetLevelReportView'

GO

/****** Object:  View [dbo].[AssetLevelReportView]    Script Date: 3/11/2016 10:06:25 AM ******/
DROP VIEW [dbo].[AssetLevelReportView]
GO

/****** Object:  View [dbo].[AssetLevelReportView]    Script Date: 3/11/2016 10:06:25 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



DROP VIEW [dbo].[AssetLevelReportView]
GO

/****** Object:  View [dbo].[AssetLevelReportView]    Script Date: 3/11/2016 10:13:01 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[AssetLevelReportView]
AS
SELECT        dbo.AssetHierarchy.Name AS AssetClassName, dbo.AssetType.Name AS AssetTypeName, dbo.AssetSubType.Name AS AssetSubTypeName, dbo.AssetRegister.Oid AS AssetRegisterOid, 
                         dbo.AssetRegister.Client AS ClientOid, dbo.Job.Name AS JobName, dbo.AssetRegister.Job AS JobOid, dbo.Job.JobStatus, dbo.AssetRegister.Name AS AssetName, dbo.AssetRegister.AssetId, 
                         dbo.AssetRegister.Facility, dbo.MyAddress.StreetAddress, dbo.MyAddress.Suburb, dbo.MyAddress.Town, dbo.MyAddress.State, dbo.MyAddress.Country, dbo.MyAddress.PostCode, 
                         dbo.AssetRegister.ToBeValued, dbo.SummaryValuationView.Accumulated_Depreciation AS PreviousDepreciation, dbo.SummaryValuationView.FairValue AS PreviousFairValue, 
                         dbo.SummaryValuationView.GROSSMV AS PreviousGrossOrMv, SummaryValuationView_1.GROSSMV, SummaryValuationView_1.FairValue AS FAIRVALUE, SummaryValuationView_1.Accumulated_Depreciation, 
                         dbo.FinancialReportingClassification.PrevHAndBUse, dbo.FinancialReportingClassification.PrevFVMInputLevel, dbo.FinancialReportingClassification.PrevFVMTechnique, 
                         dbo.FinancialReportingClassification.HAndBUse, dbo.FinancialReportingClassification.FairValueMeasurementClass, dbo.FinancialReportingClassification.FinancialAssetSubClass, 
                         dbo.FinancialReportingClassification.FinancialAssetClass, dbo.AssetRegister.HeldforSaleorInvestment, dbo.AssetRegister.ControledforFinancialPurpose, 
                         dbo.FinancialAssetClass.Name AS FinnacialAssetClassName, dbo.FinancialAssetType.Name AS FinancialSubClassName, dbo.FairValueMeasurementClass.Name AS FVMClass, 
                         dbo.Asset.InsuranceValuation AS InsuranceOid, dbo.Job.JobNumber
FROM            dbo.Asset LEFT OUTER JOIN
                         dbo.FinancialAssetClass LEFT OUTER JOIN
                         dbo.FinancialReportingClassification ON dbo.FinancialAssetClass.Oid = dbo.FinancialReportingClassification.FinancialAssetClass LEFT OUTER JOIN
                         dbo.FinancialAssetType ON dbo.FinancialReportingClassification.FinancialAssetSubClass = dbo.FinancialAssetType.Oid LEFT OUTER JOIN
                         dbo.FairValueMeasurementClass ON dbo.FinancialReportingClassification.FairValueMeasurementClass = dbo.FairValueMeasurementClass.Oid ON 
                         dbo.Asset.FinancialReportingClassification = dbo.FinancialReportingClassification.Oid LEFT OUTER JOIN
                         dbo.SummaryValuationView AS SummaryValuationView_1 ON dbo.Asset.Oid = SummaryValuationView_1.AssetOid LEFT OUTER JOIN
                         dbo.SummaryValuationView ON dbo.Asset.PreviousValuation = dbo.SummaryValuationView.ValuationId RIGHT OUTER JOIN
                         dbo.AssetRegister LEFT OUTER JOIN
                         dbo.MyAddress ON dbo.AssetRegister.DefaultAddress = dbo.MyAddress.Oid ON dbo.Asset.Oid = dbo.AssetRegister.Asset LEFT OUTER JOIN
                         dbo.AssetHierarchy ON dbo.AssetRegister.AssetClass = dbo.AssetHierarchy.Oid LEFT OUTER JOIN
                         dbo.AssetType ON dbo.AssetRegister.AssetType = dbo.AssetType.Oid LEFT OUTER JOIN
                         dbo.AssetSubType ON dbo.AssetRegister.AssetSubType = dbo.AssetSubType.Oid LEFT OUTER JOIN
                         dbo.Job ON dbo.AssetRegister.Job = dbo.Job.Oid
WHERE        (dbo.AssetRegister.GCRecord IS NULL)


GO




EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[55] 4[12] 2[11] 3) )"
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
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Job"
            Begin Extent = 
               Top = 159
               Left = 952
               Bottom = 300
               Right = 1171
            End
            DisplayFlags = 280
            TopColumn = 6
         End
         Begin Table = "AssetRegister"
            Begin Extent = 
               Top = 0
               Left = 709
               Bottom = 425
               Right = 956
            End
            DisplayFlags = 280
            TopColumn = 9
         End
         Begin Table = "Asset"
            Begin Extent = 
               Top = 0
               Left = 268
               Bottom = 350
               Right = 540
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "AssetHierarchy"
            Begin Extent = 
               Top = 9
               Left = 990
               Bottom = 139
               Right = 1190
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "AssetType"
            Begin Extent = 
               Top = 3
               Left = 1160
               Bottom = 133
               Right = 1354
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "AssetSubType"
            Begin Extent = 
               Top = 150
               Left = 1178
               Bottom = 280
               Right = 1373
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "MyAddress"
            Begin Extent = 
               Top = 308
               Left = 1174
               Bottom = 438
               Right = 1368
            End
        ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AssetLevelReportView'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'    DisplayFlags = 280
            TopColumn = 6
         End
         Begin Table = "SummaryValuationView"
            Begin Extent = 
               Top = 292
               Left = 32
               Bottom = 592
               Right = 269
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "SummaryValuationView_1"
            Begin Extent = 
               Top = 45
               Left = 34
               Bottom = 287
               Right = 266
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "FinancialReportingClassification"
            Begin Extent = 
               Top = 418
               Left = 292
               Bottom = 702
               Right = 529
            End
            DisplayFlags = 280
            TopColumn = 5
         End
         Begin Table = "FinancialAssetClass"
            Begin Extent = 
               Top = 402
               Left = 944
               Bottom = 532
               Right = 1167
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "FinancialAssetType"
            Begin Extent = 
               Top = 556
               Left = 720
               Bottom = 686
               Right = 942
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "FairValueMeasurementClass"
            Begin Extent = 
               Top = 696
               Left = 718
               Bottom = 826
               Right = 987
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
      Begin ColumnWidths = 37
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 3405
         Width = 1695
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2595
         Alias = 2355
         Table = 1170
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AssetLevelReportView'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AssetLevelReportView'
GO


