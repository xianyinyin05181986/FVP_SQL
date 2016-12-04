
EXEC sys.sp_dropextendedproperty @name=N'MS_DiagramPaneCount' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AssetLevelSummaryValuationView'

GO

EXEC sys.sp_dropextendedproperty @name=N'MS_DiagramPane1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AssetLevelSummaryValuationView'

GO

/****** Object:  View [dbo].[AssetLevelSummaryValuationView]    Script Date: 21/10/2016 9:16:50 AM ******/
DROP VIEW [dbo].[AssetLevelSummaryValuationView]
GO

/****** Object:  View [dbo].[AssetLevelSummaryValuationView]    Script Date: 21/10/2016 9:16:50 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[AssetLevelSummaryValuationView]
AS
SELECT        dbo.Asset.Oid AS AssetOid, dbo.Asset.Client AS ClientId, SUM(dbo.SummaryValuationView.GROSSMV) AS GROSSMV, SUM(dbo.SummaryValuationView.FairValue) AS FAIRVALUE, 
                         MAX(DISTINCT dbo.SummaryValuationView.ValuationId) AS ValuationID, dbo.Asset.JobType, dbo.Asset.AssetClass, dbo.Asset.AssetType, dbo.Asset.AssetSubType, dbo.Asset.ValuerName, dbo.Asset.Valuer, 
                         dbo.Asset.FinancialReportingClassification, dbo.Asset.PreviousValuation
FROM            dbo.Asset INNER JOIN
                         dbo.SummaryValuationView ON dbo.Asset.Oid = dbo.SummaryValuationView.AssetOid
GROUP BY dbo.Asset.Oid, dbo.Asset.Client, dbo.Asset.JobType, dbo.Asset.AssetClass, dbo.Asset.AssetType, dbo.Asset.AssetSubType, dbo.Asset.ValuerName, dbo.Asset.Valuer, dbo.Asset.FinancialReportingClassification, 
                         dbo.Asset.PreviousValuation

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[47] 4[10] 2[20] 3) )"
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
         Begin Table = "Asset"
            Begin Extent = 
               Top = 3
               Left = 906
               Bottom = 341
               Right = 1178
            End
            DisplayFlags = 280
            TopColumn = 25
         End
         Begin Table = "SummaryValuationView"
            Begin Extent = 
               Top = 23
               Left = 609
               Bottom = 251
               Right = 828
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
      Begin ColumnWidths = 16
         Width = 284
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
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 1875
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AssetLevelSummaryValuationView'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AssetLevelSummaryValuationView'
GO


