USE [FVPTesting]
GO

EXEC sys.sp_dropextendedproperty @name=N'MS_DiagramPaneCount' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ComponentMatrixConsumptionProfileView'

GO

EXEC sys.sp_dropextendedproperty @name=N'MS_DiagramPane2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ComponentMatrixConsumptionProfileView'

GO

EXEC sys.sp_dropextendedproperty @name=N'MS_DiagramPane1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ComponentMatrixConsumptionProfileView'

GO

/****** Object:  View [dbo].[ComponentMatrixConsumptionProfileView]    Script Date: 4/11/2016 2:39:00 PM ******/
DROP VIEW [dbo].[ComponentMatrixConsumptionProfileView]
GO

/****** Object:  View [dbo].[ComponentMatrixConsumptionProfileView]    Script Date: 4/11/2016 2:39:00 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[ComponentMatrixConsumptionProfileView]
AS
SELECT        dbo.DefaultMatrixRow.ValuationProfile, dbo.ComponentInput.Oid AS ComponentId, dbo.ComponentInput.Client
FROM            dbo.ComponentAssetHierarchy INNER JOIN
                         dbo.AssetType INNER JOIN
                         dbo.AssetHierarchy ON dbo.AssetType.AssetClass = dbo.AssetHierarchy.Oid INNER JOIN
                         dbo.AssetSubType ON dbo.AssetType.Oid = dbo.AssetSubType.AssetType ON dbo.ComponentAssetHierarchy.AssetSubtype = dbo.AssetSubType.Oid RIGHT OUTER JOIN
                         dbo.DefaultMatrixRow RIGHT OUTER JOIN
                         dbo.ComponentInput ON dbo.DefaultMatrixRow.Client = dbo.ComponentInput.Client AND dbo.DefaultMatrixRow.LifeLength = dbo.ComponentInput.LifeLength AND 
                         dbo.DefaultMatrixRow.LifeVariability = dbo.ComponentInput.LifeVariability ON dbo.ComponentAssetHierarchy.Oid = dbo.ComponentInput.Component_AssetHierarchy AND 
                         dbo.AssetHierarchy.Oid = dbo.DefaultMatrixRow.AssetClass

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[55] 4[8] 2[15] 3) )"
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
         Top = -96
         Left = 0
      End
      Begin Tables = 
         Begin Table = "ComponentInput"
            Begin Extent = 
               Top = 10
               Left = 0
               Bottom = 224
               Right = 294
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "AssetHierarchy"
            Begin Extent = 
               Top = 169
               Left = 604
               Bottom = 380
               Right = 804
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "AssetType"
            Begin Extent = 
               Top = 283
               Left = 358
               Bottom = 605
               Right = 552
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "AssetSubType"
            Begin Extent = 
               Top = 247
               Left = 47
               Bottom = 440
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "ComponentAssetHierarchy"
            Begin Extent = 
               Top = 41
               Left = 342
               Bottom = 246
               Right = 536
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "DefaultMatrixRow"
            Begin Extent = 
               Top = 1
               Left = 898
               Bottom = 350
               Right = 1092
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
   ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ComponentMatrixConsumptionProfileView'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'      Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 2145
         Width = 1500
         Width = 2130
         Width = 3345
         Width = 1515
         Width = 3480
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1275
         Alias = 2280
         Table = 2370
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ComponentMatrixConsumptionProfileView'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ComponentMatrixConsumptionProfileView'
GO


