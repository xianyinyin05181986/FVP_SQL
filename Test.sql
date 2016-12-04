

exec [dbo].[RegisterAsset] '04E6A2BC-83FD-47B2-A1C1-79EAC7EF1955'

exec [dbo].[CreateComponentInputForAssetRegister] '04E6A2BC-83FD-47B2-A1C1-79EAC7EF1955'
exec [dbo].[RegisterAsset_ResetReplacementCostDirectCost] '283D5F03-8DF6-4523-B37E-030155D32779'
exec dbo.DeleteAssetRecord '04E6A2BC-83FD-47B2-A1C1-79EAC7EF1955'

exec [dbo].[SelectAssetDetail] '283D5F03-8DF6-4523-B37E-030155D32779'

exec [dbo].[RegisterAsset] '3E417C8E-D019-4B8A-8A1B-0008305536F7'

select dbo.ComponentInput.*
from dbo.ComponentInput
inner join dbo.AssetRegister on dbo.AssetRegister.Asset = dbo.ComponentInput.Asset
  inner join dbo.AssetHierarchy on dbo.AssetHierarchy.Oid = dbo.AssetRegister.AssetClass
   inner join dbo.AssetType on dbo.AssetType.Oid =dbo.AssetRegister.AssetType
   inner join dbo.AssetSubType on dbo.AssetSubType.Oid = dbo.AssetRegister.AssetSubType
where dbo.AssetRegister.Oid = '04E6A2BC-83FD-47B2-A1C1-79EAC7EF1955'



