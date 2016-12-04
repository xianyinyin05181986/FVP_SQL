
EXEC sys.sp_dropextendedproperty @name=N'MS_DiagramPaneCount' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ComponentLevelReport'

GO

EXEC sys.sp_dropextendedproperty @name=N'MS_DiagramPane2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ComponentLevelReport'

GO

EXEC sys.sp_dropextendedproperty @name=N'MS_DiagramPane1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ComponentLevelReport'

GO

/****** Object:  View [dbo].[ComponentLevelReport]    Script Date: 7/11/2016 2:22:33 PM ******/
DROP VIEW [dbo].[ComponentLevelReport]
GO

/****** Object:  View [dbo].[ComponentLevelReport]    Script Date: 7/11/2016 2:22:33 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[ComponentLevelReport] WITH SCHEMABINDING  
AS
SELECT        dbo.ValuationApproachView.AssetRegister AS AssetRegisterOid, dbo.AssetRegister.Asset AS AssetOid, dbo.AssetRegister.Name AS AssetRegisterName, 
                         dbo.ComponentAssetHierarchy.Name AS ComponentName, dbo.ValuationApproachView.CurrentValuation AS ValuationOid, dbo.Phase2ComponentValuation.Name, dbo.AssetRegister.AssetClass, 
                         dbo.AssetRegister.AssetType, dbo.AssetRegister.AssetSubType, dbo.ComponentInput.Component_AssetHierarchy
FROM            dbo.ComponentAssetHierarchy INNER JOIN
                         dbo.ComponentInput ON dbo.ComponentAssetHierarchy.Oid = dbo.ComponentInput.Component_AssetHierarchy LEFT OUTER JOIN
                         dbo.Phase2ComponentValuation ON dbo.ComponentInput.Oid = dbo.Phase2ComponentValuation.ComponentInput LEFT OUTER JOIN
                         dbo.Asset INNER JOIN
                         dbo.ValuationApproachView ON dbo.Asset.Oid = dbo.ValuationApproachView.AssetOid INNER JOIN
                         dbo.SummaryValuationBase ON dbo.ValuationApproachView.CurrentValuation = dbo.SummaryValuationBase.Oid LEFT OUTER JOIN
                         dbo.AssetRegister ON dbo.Asset.Oid = dbo.AssetRegister.Asset ON dbo.Phase2ComponentValuation.SummaryValuation = dbo.SummaryValuationBase.Oid AND dbo.ComponentInput.Asset = dbo.Asset.Oid
WHERE        (dbo.Asset.GCRecord IS NULL) AND (dbo.ComponentInput.GCRecord IS NULL) AND (dbo.AssetRegister.AssetClass IS NOT NULL) AND (dbo.AssetRegister.AssetType IS NOT NULL) AND 
                         (dbo.AssetRegister.AssetSubType IS NOT NULL)

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[47] 4[16] 2[16] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[50] 4[25] 3) )"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[50] 2[17] 3) )"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1[56] 3) )"
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
         Configuration = "(V (3) )"
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
         Top = -288
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Phase2ComponentValuation"
            Begin Extent = 
               Top = 274
               Left = 280
               Bottom = 666
               Right = 512
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "ComponentInput"
            Begin Extent = 
               Top = 274
               Left = 547
               Bottom = 558
               Right = 841
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Asset"
            Begin Extent = 
               Top = 0
               Left = 888
               Bottom = 299
               Right = 1160
            End
            DisplayFlags = 280
            TopColumn = 19
         End
         Begin Table = "ValuationApproachView"
            Begin Extent = 
               Top = 0
               Left = 34
               Bottom = 257
               Right = 346
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "SummaryValuationBase"
            Begin Extent = 
               Top = 319
               Left = 45
               Bottom = 556
               Right = 246
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "AssetRegister"
            Begin Extent = 
               Top = 104
               Left = 528
               Bottom = 234
               Right = 775
            End
            DisplayFlags = 280
            TopColumn = 26
         End
         Begin Table = "ComponentAssetHierarchy"
            Begin Extent = 
               Top = 350
               Left = 1003
               Bottom = 480' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ComponentLevelReport'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'
               Right = 1197
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
         Width = 3450
         Width = 1830
         Width = 4170
         Width = 3435
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
         Alias = 1755
         Table = 2115
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ComponentLevelReport'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ComponentLevelReport'
GO


