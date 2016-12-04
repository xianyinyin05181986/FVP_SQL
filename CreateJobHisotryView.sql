

EXEC sys.sp_dropextendedproperty @name=N'MS_DiagramPaneCount' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AssetLevelSummaryValuationView'

GO

EXEC sys.sp_dropextendedproperty @name=N'MS_DiagramPane1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AssetLevelSummaryValuationView'

GO

/****** Object:  View [dbo].[AssetLevelSummaryValuationView]    Script Date: 18/10/2016 5:34:59 PM ******/
DROP VIEW [dbo].[AssetLevelSummaryValuationView]
GO

/****** Object:  View [dbo].[AssetLevelSummaryValuationView]    Script Date: 18/10/2016 5:34:59 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[AssetLevelSummaryValuationView]
AS
SELECT        SUM(dbo.Phase2ComponentValuation.Gross) AS GROSSMV, SUM(dbo.Phase2ComponentValuation.FairValue) AS FAIRVALUE, COUNT(dbo.Phase2ComponentValuation.SummaryValuation) AS SummaryValuationId, 
                         COUNT(dbo.SummaryValuationBase.Oid) AS SummaryId2, MAX(DISTINCT dbo.SummaryValuationBase.Asset) AS AssetSummaryId, dbo.Asset.Oid AS AssetOid, dbo.Asset.Client AS ClientId
FROM            dbo.Asset INNER JOIN
                         dbo.SummaryValuationBase ON dbo.Asset.Oid = dbo.SummaryValuationBase.Asset LEFT OUTER JOIN
                         dbo.Phase2ComponentValuation ON dbo.SummaryValuationBase.Oid = dbo.Phase2ComponentValuation.SummaryValuation
GROUP BY dbo.Asset.Oid, dbo.Asset.Client
HAVING        (COUNT(dbo.Phase2ComponentValuation.SummaryValuation) IS NOT NULL)

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[42] 4[18] 2[16] 3) )"
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
               Top = 6
               Left = 547
               Bottom = 344
               Right = 819
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "SummaryValuationBase"
            Begin Extent = 
               Top = 6
               Left = 308
               Bottom = 328
               Right = 509
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Phase2ComponentValuation"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 334
               Right = 270
            End
            DisplayFlags = 280
            TopColumn = 28
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
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
         Alias = 900
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


EXEC sys.sp_dropextendedproperty @name=N'MS_DiagramPaneCount' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AssetValuationIndex'

GO

EXEC sys.sp_dropextendedproperty @name=N'MS_DiagramPane1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AssetValuationIndex'

GO

/****** Object:  View [dbo].[AssetValuationIndex]    Script Date: 18/10/2016 5:36:14 PM ******/
DROP VIEW [dbo].[AssetValuationIndex]
GO

/****** Object:  View [dbo].[AssetValuationIndex]    Script Date: 18/10/2016 5:36:14 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[AssetValuationIndex]
AS
SELECT        AssetRegister, Oid, Cost, Income, Market, CASE WHEN Cost = 0 AND Income = 1 AND Market = 1 THEN CostSummaryValuation WHEN Cost = 1 AND Income = 0 AND 
                         Market = 1 THEN IncomeSummaryValuation WHEN Cost = 1 AND Income = 1 AND Market = 0 THEN MarketSummaryValuation WHEN Cost = 1 AND Income = 1 AND Market = 1 THEN NULL 
                         ELSE CombinedSummaryValuation END AS CurrentValuation
FROM            dbo.ValuationApproachView

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[13] 3) )"
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
         Begin Table = "ValuationApproachView"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 321
               Right = 313
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
      Begin ColumnWidths = 11
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
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AssetValuationIndex'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AssetValuationIndex'
GO

EXEC sys.sp_dropextendedproperty @name=N'MS_DiagramPaneCount' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'SummaryValuationView'

GO

EXEC sys.sp_dropextendedproperty @name=N'MS_DiagramPane1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'SummaryValuationView'

GO

/****** Object:  View [dbo].[SummaryValuationView]    Script Date: 18/10/2016 5:36:41 PM ******/
DROP VIEW [dbo].[SummaryValuationView]
GO

/****** Object:  View [dbo].[SummaryValuationView]    Script Date: 18/10/2016 5:36:41 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[SummaryValuationView]
AS
SELECT        SUM(dbo.Phase2ComponentValuation.Gross) AS GROSSMV, SUM(dbo.Phase2ComponentValuation.FairValue) AS FAIRVALUE, COUNT(dbo.Phase2ComponentValuation.SummaryValuation) AS Expr3, 
                         COUNT(dbo.SummaryValuationBase.Oid) AS Expr4, MAX(DISTINCT dbo.SummaryValuationBase.Asset) AS Expr5, dbo.Asset.Oid AS AssetOid, dbo.Asset.Client AS ClientId
FROM            dbo.Asset INNER JOIN
                         dbo.SummaryValuationBase ON dbo.Asset.Oid = dbo.SummaryValuationBase.Asset LEFT OUTER JOIN
                         dbo.Phase2ComponentValuation ON dbo.SummaryValuationBase.Oid = dbo.Phase2ComponentValuation.SummaryValuation
GROUP BY dbo.Asset.Oid, dbo.Asset.Client
HAVING        (COUNT(dbo.Phase2ComponentValuation.SummaryValuation) IS NOT NULL)

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[42] 4[18] 2[16] 3) )"
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
         Begin Table = "Phase2ComponentValuation"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 334
               Right = 270
            End
            DisplayFlags = 280
            TopColumn = 28
         End
         Begin Table = "SummaryValuationBase"
            Begin Extent = 
               Top = 6
               Left = 308
               Bottom = 328
               Right = 509
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Asset"
            Begin Extent = 
               Top = 6
               Left = 547
               Bottom = 344
               Right = 819
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
      Begin ColumnWidths = 9
         Width = 284
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
         Alias = 900
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'SummaryValuationView'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'SummaryValuationView'
GO
EXEC sys.sp_dropextendedproperty @name=N'MS_DiagramPaneCount' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ValuationApproachView'

GO

EXEC sys.sp_dropextendedproperty @name=N'MS_DiagramPane1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ValuationApproachView'

GO

/****** Object:  View [dbo].[ValuationApproachView]    Script Date: 18/10/2016 5:37:02 PM ******/
DROP VIEW [dbo].[ValuationApproachView]
GO

/****** Object:  View [dbo].[ValuationApproachView]    Script Date: 18/10/2016 5:37:02 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[ValuationApproachView]
AS
SELECT        dbo.Asset.AssetRegister, dbo.AssetRegister.Oid, dbo.AssetRegister.Cost, dbo.AssetRegister.Income, dbo.AssetRegister.Market, dbo.Asset.CostSummaryValuation, dbo.Asset.MarketSummaryValuation, 
                         dbo.Asset.IncomeSummaryValuation, dbo.Asset.CombinedSummaryValuation
FROM            dbo.Asset INNER JOIN
                         dbo.AssetRegister ON dbo.Asset.Oid = dbo.AssetRegister.Asset

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[29] 4[22] 2[19] 3) )"
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
               Top = 4
               Left = 462
               Bottom = 324
               Right = 734
            End
            DisplayFlags = 280
            TopColumn = 10
         End
         Begin Table = "AssetRegister"
            Begin Extent = 
               Top = 1
               Left = 793
               Bottom = 248
               Right = 1040
            End
            DisplayFlags = 280
            TopColumn = 2
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
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
         Column = 1440
         Alias = 900
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ValuationApproachView'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ValuationApproachView'
GO

EXEC sys.sp_dropextendedproperty @name=N'MS_DiagramPaneCount' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JobHistoryReportView'

GO

EXEC sys.sp_dropextendedproperty @name=N'MS_DiagramPane2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JobHistoryReportView'

GO

EXEC sys.sp_dropextendedproperty @name=N'MS_DiagramPane1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JobHistoryReportView'

GO

/****** Object:  View [dbo].[JobHistoryReportView]    Script Date: 18/10/2016 5:37:15 PM ******/
DROP VIEW [dbo].[JobHistoryReportView]
GO

/****** Object:  View [dbo].[JobHistoryReportView]    Script Date: 18/10/2016 5:37:15 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[JobHistoryReportView]
AS
SELECT DISTINCT 
                         MAX(DISTINCT dbo.Job.JobType) AS jobtype, dbo.Job.Name AS JobName, COUNT(dbo.AssetRegister.Oid) AS AssetRegisterOid, dbo.AssetRegister.Job AS JobOidFromAssetRegister, 
                         COUNT(dbo.AssetLevelSummaryValuationView.AssetOid) AS NoOfAssets, SUM(dbo.AssetLevelSummaryValuationView.FAIRVALUE) AS FV, SUM(dbo.AssetLevelSummaryValuationView.GROSSMV) AS GMV, 
                         dbo.Job.Oid AS JobOid, MIN(DISTINCT dbo.Job.EffectiveDateofValuation) AS EDate, MAX(DISTINCT dbo.Job.DraftDueDate) AS DraftDate, dbo.AssetRegister.AssetClass, MAX(DISTINCT dbo.Job.FinalDueDate) 
                         AS FinalDate, MAX(DISTINCT dbo.Job.JobNumber) AS JobNo, MAX(DISTINCT dbo.Job.JobStatus) AS Status, dbo.AssetHierarchy.Name AS AssetClassName, MAX(DISTINCT dbo.FairValueProClient.Name) 
                         AS ClientName, MAX(DISTINCT dbo.FairValueProGroup.Name) AS GroupName
FROM            dbo.Job INNER JOIN
                         dbo.AssetRegister ON dbo.Job.Oid = dbo.AssetRegister.Job INNER JOIN
                         dbo.AssetLevelSummaryValuationView ON dbo.AssetRegister.Asset = dbo.AssetLevelSummaryValuationView.AssetOid INNER JOIN
                         dbo.AssetHierarchy ON dbo.AssetRegister.AssetClass = dbo.AssetHierarchy.Oid INNER JOIN
                         dbo.FairValueProClient ON dbo.Job.Client = dbo.FairValueProClient.Oid AND dbo.AssetRegister.Client = dbo.FairValueProClient.Oid AND dbo.AssetHierarchy.Client = dbo.FairValueProClient.Oid AND 
                         dbo.AssetHierarchy.ClientObject = dbo.FairValueProClient.Oid INNER JOIN
                         dbo.FairValueProGroup ON dbo.Job.FairValueProGroup = dbo.FairValueProGroup.Oid
GROUP BY dbo.Job.Name, dbo.AssetRegister.Job, dbo.Job.Oid, dbo.AssetRegister.AssetClass, dbo.AssetHierarchy.Name

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[21] 4[28] 2[24] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[50] 2[25] 3) )"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4[30] 2[40] 3) )"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2[66] 3) )"
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
         Top = -96
         Left = -4455
      End
      Begin Tables = 
         Begin Table = "Job"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 299
               Right = 257
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "AssetRegister"
            Begin Extent = 
               Top = 6
               Left = 295
               Bottom = 298
               Right = 542
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "AssetLevelSummaryValuationView"
            Begin Extent = 
               Top = 6
               Left = 580
               Bottom = 323
               Right = 1007
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "AssetHierarchy"
            Begin Extent = 
               Top = 102
               Left = 1161
               Bottom = 232
               Right = 1361
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "FairValueProClient"
            Begin Extent = 
               Top = 102
               Left = 4671
               Bottom = 232
               Right = 4881
            End
            DisplayFlags = 280
            TopColumn = 15
         End
         Begin Table = "FairValueProGroup"
            Begin Extent = 
               Top = 102
               Left = 4919
               Bottom = 232
               Right = 5113
            End
            DisplayFlags = 280
            TopColumn = 3
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 19
        ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JobHistoryReportView'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N' Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1380
         Width = 1350
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
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 615
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JobHistoryReportView'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JobHistoryReportView'
GO
