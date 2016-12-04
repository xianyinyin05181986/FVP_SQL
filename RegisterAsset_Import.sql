

/****** Object:  StoredProcedure [dbo].[ImportAsset]    Script Date: 22/11/2016 3:14:35 PM ******/
DROP PROCEDURE [dbo].[ImportAsset]
GO

/****** Object:  StoredProcedure [dbo].[ImportAsset]    Script Date: 22/11/2016 3:14:35 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Yinyin Xian
-- Create date: 22 Nov 2016
-- Description:	Asset Register Import
-- =============================================
CREATE PROCEDURE [dbo].[ImportAsset]
	-- Add the parameters for the stored procedure here
	      @job nvarchar(100)
		 ,@clientOid uniqueidentifier
		 ,@assetid nvarchar(100)
		 ,@assetName nvarchar(100) 
		 ,@assetClass nvarchar(100) 
		 ,@assetType nvarchar(100)
		 ,@assetSubtype nvarchar(100)
		 ,@cost int
		 ,@income int
		 ,@market int
		 ,@apportionmentOrDirectCost int
		 ,@streetAddress nvarchar(100) 
		 ,@suburb nvarchar(100)
		 ,@town nvarchar(100)
		 ,@state nvarchar(100)
		 ,@country nvarchar(100)
		 ,@postCode nvarchar(100)
		 ,@longtitude float
		 ,@latitude float
		 ,@facility nvarchar(100)
         ,@valuer nvarchar(100)
         ,@inspectionCompleted int
         ,@inspectionIsRequired int
         ,@insuranceRequired int
         ,@heritageAsset int
         ,@valuationStatus int
         ,@toBeValued int
         ,@heldforSaleorInvestment int
         ,@controledforFinancialPurpose int
         ,@assetHistory int
		 --,@result nvarchar(100) output
		
AS
BEGIN 
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	Declare @AssetClassOid As uniqueidentifier,
			 @AssetTypeOid As uniqueidentifier,
			 @AssetSubtypeOid As uniqueidentifier,
			 @newaddressOid uniqueidentifier
			 ,@result nvarchar(100)
	SET NOCOUNT ON;
	
	-- Validate Asset Hierarchy
	IF Not Exists(
		Select dbo.AssetHierarchy.Oid
		From dbo.AssetHierarchy
		inner join dbo.AssetType 
			on dbo.AssetType.AssetClass = dbo.AssetHierarchy.Oid
			and dbo.AssetType.AssetTypeName = @assetType
		inner join dbo.AssetSubType
			on dbo.AssetSubType.AssetType = dbo.AssetType.Oid
			and dbo.AssetSubType.AssetSubTypeName=@assetSubtype
		where dbo.AssetHierarchy.AssetHierarchyName =@assetClass					
	) 
		Begin
			 RAISERROR('Invalid Hierarchy Setup',16,1)
			Return 
		End
	Else
		Begin
			Select  
			@AssetClassOid = dbo.AssetHierarchy.Oid,
			@AssetTypeOid=dbo.AssetType.Oid,
			@AssetSubtypeOid = dbo.AssetSubType.Oid
			From dbo.AssetHierarchy
			inner join dbo.AssetType 
				on dbo.AssetType.AssetClass = dbo.AssetHierarchy.Oid
				and dbo.AssetType.AssetTypeName = @assetType
			inner join dbo.AssetSubType
				on dbo.AssetSubType.AssetType = dbo.AssetType.Oid
				and dbo.AssetSubType.AssetSubTypeName=@assetSubtype
			where dbo.AssetHierarchy.AssetHierarchyName =@assetClass					
		End

	--- Validate User
	If not Exists(
	  Select dbo.FairValueProUser.Oid
	  From dbo.FairValueProUser
	  inner join SecuritySystemUser on dbo.FairValueProUser.Oid = dbo.SecuritySystemUser.Oid
	  inner join dbo.FairValueProClient on dbo.FairValueProUser.Client = dbo.FairValueProClient.Oid
	  where SecuritySystemUser.UserName = @valuer
	)
		Begin
		    RAISERROR('Invalid Valuer',16,1)
			return 
		end
    -- Insert statements for procedure here
	Else If @job is not null and @job != '' and EXISTS(
		Select 
		  [dbo].[AssetRegister].[Oid]
		 ,[dbo].[AssetRegister].[AssetId]
		 ,[dbo].AssetRegister.Client
		 ,[dbo].Job.Name
		 ,[dbo].Job.Oid
		From [dbo].[AssetRegister]
		inner join [dbo].Job on [dbo].[AssetRegister].[Job] = [dbo].Job.Oid
					-- Asset need to be assigned to a job
					And [dbo].Job.JobStatus =1
					-- Job need to be open 
					And [dbo].Job.GCRecord is null
					-- Not deleted 	
		where   [dbo].Job.Name = @job
			And [dbo].[AssetRegister].Client =@clientOid
			And [dbo].AssetRegister.GCRecord is null
			And [dbo].AssetRegister.AssetId =@assetid
			--No need to check Asset Name		
	)
	
	Begin  

	Set  @result = 'Update A:Input Job Exists And Asset Exist!'

	Update [dbo].[AssetRegister]
	Set Name=@assetName
	    ,Cost=@cost
		,Income =@income
		,Market =@market
		,ApportionmentOrDirectCost=@apportionmentOrDirectCost
		,Facility=@facility
		,ValuerName=@valuer
		,InspectionCompleted=@inspectionCompleted
		,InspectionIsRequired=@inspectionIsRequired
		,InsuranceRequired=@insuranceRequired
		,HeritageAsset=@heritageAsset
		,ValuationStatus=@valuationStatus
		,ToBeValued=@toBeValued
		,HeldforSaleorInvestment=@heldforSaleorInvestment
		,ControledforFinancialPurpose=@controledforFinancialPurpose
		,AssetHistory=@assetHistory
		,AssetClass =dbo.AssetHierarchy.Oid
		,AssetType =dbo.AssetType.Oid
		,AssetSubType =dbo.AssetSubType.Oid
	From [dbo].[AssetRegister]
		inner join [dbo].Job on [dbo].[AssetRegister].[Job] = [dbo].Job.Oid
					-- Asset need to be assigned to a job
					And [dbo].Job.JobStatus =1
					-- Job need to be open 
					And [dbo].Job.GCRecord is null
					-- Not deleted 
		 inner join dbo.AssetHierarchy on 
				dbo.AssetHierarchy.GCRecord is null 
				And
				dbo.AssetHierarchy.AssetHierarchyName=@assetClass
		 inner join dbo.AssetType on 
				AssetType.AssetClass =dbo.AssetHierarchy.Oid 
				And
				dbo.AssetType.GCRecord is null 
				And
				dbo.AssetType.AssetTypeName=@assetType
		 inner join dbo.AssetSubType on 
				dbo.AssetSubType.AssetType = dbo.AssetType.Oid 
				And
				dbo.AssetSubType.GCRecord is null 
				And
				dbo.AssetSubType.AssetSubTypeName=@assetSubtype
	where   [dbo].Job.Name = @job
			And [dbo].[AssetRegister].Client =@clientOid
			And [dbo].AssetRegister.GCRecord is null
			And [dbo].AssetRegister.AssetId =@assetid

	Update dbo.MyAddress
	
	Set Latitude = @latitude,
		Longitude =@longtitude,
		StreetAddress =@streetAddress,
		Suburb=@suburb,
		Town =@town,
		State=@state,
		Country =@country,
		PostCode =@postCode
	From dbo.MyAddress inner join dbo.AssetRegister on dbo.MyAddress.Oid = dbo.AssetRegister.DefaultAddress
	inner join [dbo].Job on [dbo].[AssetRegister].[Job] = [dbo].Job.Oid
					-- Asset need to be assigned to a job
					And [dbo].Job.JobStatus =1
					-- Job need to be open 
					And [dbo].Job.GCRecord is null
					-- Not deleted 
	where  [dbo].Job.Name = @job
			And [dbo].[AssetRegister].Client =@clientOid
			And [dbo].AssetRegister.GCRecord is null
			And [dbo].AssetRegister.AssetId =@assetid

	--Update Hierarchy Need to be sperated
	End
	
	--Update B

	Else If (@job is null or @job = '') And EXISTS
	(
		Select 
			  [dbo].[AssetRegister].[Oid]
			 ,[dbo].[AssetRegister].[AssetId]
			 ,[dbo].AssetRegister.Client
			From [dbo].[AssetRegister]
				inner join dbo.AssetHierarchy on dbo.AssetHierarchy.Oid = dbo.AssetRegister.AssetClass
				And dbo.AssetHierarchy.GCRecord is null
				And dbo.AssetHierarchy.Client = @clientOid
			where [dbo].[AssetRegister].Client =@clientOid
				And dbo.AssetRegister.Job is null
				And dbo.AssetRegister.AssetId =@assetid
			--No need to check Asset Name
	)
	Begin

	Set  @result = 'Update B: Not job input but asset Exist'

	Update [dbo].[AssetRegister]
	Set Name=@assetName
	    ,Cost=@cost
		,Income =@income
		,Market =@market
		,ApportionmentOrDirectCost=@apportionmentOrDirectCost
		,Facility=@facility
		,ValuerName=@valuer
		,InspectionCompleted=@inspectionCompleted
		,InspectionIsRequired=@inspectionIsRequired
		,InsuranceRequired=@insuranceRequired
		,HeritageAsset=@heritageAsset
		,ValuationStatus=@valuationStatus
		,ToBeValued=@toBeValued
		,HeldforSaleorInvestment=@heldforSaleorInvestment
		,ControledforFinancialPurpose=@controledforFinancialPurpose
		,AssetHistory=@assetHistory
		,AssetClass =dbo.AssetHierarchy.Oid
		,AssetType =dbo.AssetType.Oid
		,AssetSubType =dbo.AssetSubType.Oid
	From [dbo].[AssetRegister]
	    --  Job is null
		inner join dbo.AssetHierarchy on 
				dbo.AssetHierarchy.GCRecord is null 
				And
				dbo.AssetHierarchy.AssetHierarchyName=@assetClass
		 inner join dbo.AssetType on 
				AssetType.AssetClass =dbo.AssetHierarchy.Oid 
				And
				dbo.AssetType.GCRecord is null 
				And
				dbo.AssetType.AssetTypeName=@assetType
		 inner join dbo.AssetSubType on 
				dbo.AssetSubType.AssetType = dbo.AssetType.Oid 
				And
				dbo.AssetSubType.GCRecord is null 
				And
				dbo.AssetSubType.AssetSubTypeName=@assetSubtype
	where  
			[dbo].[AssetRegister].Client =@clientOid
			And [dbo].AssetRegister.GCRecord is null
			And [dbo].AssetRegister.AssetId =@assetid
	
	Update dbo.MyAddress
	
	Set Latitude = @latitude,
		Longitude =@longtitude,
		StreetAddress =@streetAddress,
		Suburb=@suburb,
		Town =@town,
		State=@state,
		Country =@country,
		PostCode =@postCode
	From dbo.MyAddress inner join dbo.AssetRegister on dbo.MyAddress.Oid = dbo.AssetRegister.DefaultAddress
					-- Asset does not need to be assigned to a job
	where   [dbo].[AssetRegister].Client =@clientOid
			And [dbo].AssetRegister.GCRecord is null
			And [dbo].AssetRegister.AssetId =@assetid

	--Update Hierarchy Need to be sperated

	End
	--*****************************
	--*          Insert A         *
	--*****************************
	Else if @job is not null And EXISTS
	(
		 Select dbo.Job.Oid
		 From dbo.Job
		 inner join dbo.JobSetting on dbo.JobSetting.Job = dbo.Job.Oid
		 Where dbo.Job.Name =@job
		 And dbo.Job.Client =@clientOid
		 And dbo.Job.JobStatus =1
		 And dbo.Job.GCRecord is null
		 And dbo.JobSetting.AssetClass in (Select dbo.AssetHierarchy.Oid From dbo.AssetHierarchy where dbo.AssetHierarchy.AssetHierarchyName=@assetClass)
	)
		Begin
			Declare @newAssetRegisterOid uniqueidentifier,
					@valuationChoicesOid uniqueidentifier
			Set @newAssetRegisterOid = NEWID()
			Set @valuationChoicesOid = NEWID()

			Set  @result = 'Insert A:Input Job is open but Asset does not exsit'
			-- Initialize Address A
			Set @newaddressOid = NEWID()
		
		    

			INSERT INTO [dbo].[MyAddress]
				   ([Oid]
				   ,[Title]
				   ,[Latitude]
				   ,[Longitude]
				   ,[StreetAddress]
				   ,[Suburb]
				   ,[Town]
				   ,[State]
				   ,[Country]
				   ,[PostCode]
				--   ,[OptimisticLockField]
				--  ,[GCRecord]
				)
			 VALUES
				   (@newaddressOid
				   ,'UNKNOWN'
				   ,@latitude
				   ,@longtitude
				   ,@streetAddress
				   ,@suburb
				   ,@town
				   ,@state
				   ,@country
				   ,@postCode
				   --,<OptimisticLockField, int,>
				   --,<GCRecord, int,>
				   )
		-- Initialize Valuation Choices
				INSERT INTO [dbo].[ValuationChoices]
			   ([Oid]
			   ,[Name]
			   ,[Client]
			   ,[FairValueProGroup]
			   ,[Cost]
			   ,[Income]
			   ,[Market]
			   ,[InsuranceRequired]
			   ,[InspectionCompleted]
			   ,[InspectionIsRequired]
			   ,[Facility]
			   )
		 VALUES
			   (
			   @valuationChoicesOid
			   ,'Valuation Choices'
			   ,@clientOid
			   ,(Select [Group] From dbo.FairValueProClient where dbo.FairValueProClient.Oid=@clientOid)
				,@cost
				,@income
				,@market
			   ,@insuranceRequired
			   ,@inspectionCompleted
			   ,@inspectionIsRequired
			   ,@facility
			) 
			--Insert AssetRegister A
			INSERT INTO [dbo].[AssetRegister]
				   ([Oid]
				   ,[Name]
				   ,[Client]
				   ,[FairValueProGroup]
				   ,[AssetId]
				   ,[AssetClass]
				   ,[AssetType]
				   ,[AssetSubType]
				   ,[Cost]
				   ,[Income]
				   ,[Market]
				   ,[ValuationChoices]
				   ,[ApportionmentOrDirectCost]
				   ,[Facility]
				   ,[ValuerName]
				   ,[InspectionCompleted]
				   ,[InspectionIsRequired]
				   ,[InsuranceRequired]
				   ,[HeritageAsset]
				   ,[AssetHistory]
				   ,[ValuationStatus]
				   ,[ToBeValued]
				   ,[HeldforSaleorInvestment]
				   ,[ControledforFinancialPurpose]
				   ,[Job]
				  -- ,[Asset]
				   ,[DefaultAddress]
				   --,[OptimisticLockField]
				  -- ,[GCRecord]
				  )
			 VALUES
				   (
				   @newAssetRegisterOid
				   ,@assetName
				   ,@clientOid
				   ,(Select [Group] From dbo.FairValueProClient where dbo.FairValueProClient.Oid=@clientOid)
				   ,@assetid
				   ,@AssetClassOid
				   ,@AssetTypeOid
				   ,@AssetSubtypeOid
				   ,@cost
				   ,@income
				   ,@market
				   ,@valuationChoicesOid
				   ,@apportionmentOrDirectCost
				   ,@facility
				   ,@valuer
				   ,@inspectionCompleted
				   ,@inspectionIsRequired
				   ,@insuranceRequired
				   ,@heritageAsset
				   ,@assetHistory
				   ,@valuationStatus
				   ,@toBeValued
				   ,@heldforSaleorInvestment
				   ,@controledforFinancialPurpose
				   ,(select [Oid] From dbo.Job where dbo.job.Name=@job)
				   --,<Asset, uniqueidentifier,>
				   ,@newaddressOid
				   --,<OptimisticLockField, int,>
				   --,<GCRecord, int,>
				   )
		exec dbo.RegisterAsset @newAssetRegisterOid
		exec dbo.CreateComponentInputForAssetRegister @newAssetRegisterOid
		exec dbo.RegisterAsset_ResetReplacementCostDirectCost @newAssetRegisterOid
		End

	--*****************************
	--*          Insert B         *
	--*****************************
	
	else if( @job is null or @job='') 
	and not exists
	(
		select dbo.AssetRegister.Oid
		From dbo.AssetRegister
		where dbo.AssetRegister.GCRecord is null
		And dbo.AssetRegister.AssetId =@assetid
		And dbo.AssetRegister.Client =@clientOid
	)
		Begin
			Declare @newAssetRegisterOid_B uniqueidentifier,
			@valuationChoicesOid_B uniqueidentifier
			Set @newAssetRegisterOid_B = NEWID()
			Set @valuationChoicesOid_B = NEWID()
			Set  @result = 'Insert B: Not input Job And Asset does not exist'
			-- Initialize Address B
			Set @newaddressOid = NEWID()
			-- Address
			INSERT INTO [dbo].[MyAddress]
				   ([Oid]
				   ,[Title]
				   ,[Latitude]
				   ,[Longitude]
				   ,[StreetAddress]
				   ,[Suburb]
				   ,[Town]
				   ,[State]
				   ,[Country]
				   ,[PostCode]
				--   ,[OptimisticLockField]
				--  ,[GCRecord]
				)
			 VALUES
				   (@newaddressOid
				   ,'UNKNOWN'
				   ,@latitude
				   ,@longtitude
				   ,@streetAddress
				   ,@suburb
				   ,@town
				   ,@state
				   ,@country
				   ,@postCode
				   --,<OptimisticLockField, int,>
				   --,<GCRecord, int,>
				   )
				-- Initialize Valuation Choices
				INSERT INTO [dbo].[ValuationChoices]
			   ([Oid]
			   ,[Name]
			   ,[Client]
			   ,[FairValueProGroup]
			   ,[Cost]
			   ,[Income]
			   ,[Market]
			   ,[InsuranceRequired]
			   ,[InspectionCompleted]
			   ,[InspectionIsRequired]
			   ,[Facility]
			   )
		 VALUES
			   (
			   @valuationChoicesOid_B
			   ,'Valuation Choices'
			   ,@clientOid
			   ,(Select [Group] From dbo.FairValueProClient where dbo.FairValueProClient.Oid=@clientOid)
				,@cost
				,@income
				,@market
			   ,@insuranceRequired
			   ,@inspectionCompleted
			   ,@inspectionIsRequired
			   ,@facility
			) 
			--Insert AssetRegister B
			INSERT INTO [dbo].[AssetRegister]
				   ([Oid]
				   ,[Name]
				   ,[Client]
				   ,[FairValueProGroup]
				   ,[AssetId]
				   ,[AssetClass]
				   ,[AssetType]
				   ,[AssetSubType]
				   ,[Cost]
				   ,[Income]
				   ,[Market]
				   ,[ValuationChoices]
				   ,[ApportionmentOrDirectCost]
				   ,[Facility]
				   ,[ValuerName]
				   ,[InspectionCompleted]
				   ,[InspectionIsRequired]
				   ,[InsuranceRequired]
				   ,[HeritageAsset]
				   ,[AssetHistory]
				   ,[ValuationStatus]
				   ,[ToBeValued]
				   ,[HeldforSaleorInvestment]
				   ,[ControledforFinancialPurpose]
				  -- ,[Asset]
				   ,[DefaultAddress]
				   --,[OptimisticLockField]
				  -- ,[GCRecord]
				  )
			 VALUES
				   (
				   @newAssetRegisterOid_B
				   ,@assetName
				   ,@clientOid
				   ,(Select [Group] From dbo.FairValueProClient where dbo.FairValueProClient.Oid=@clientOid)
				   ,@assetid
				   ,@AssetClassOid
				   ,@AssetTypeOid
				   ,@AssetSubtypeOid
				   ,@cost
				   ,@income
				   ,@market
				   ,@valuationChoicesOid_B
				   ,@apportionmentOrDirectCost
				   ,@facility
				   ,@valuer
				   ,@inspectionCompleted
				   ,@inspectionIsRequired
				   ,@insuranceRequired
				   ,@heritageAsset
				   ,@assetHistory
				   ,@valuationStatus
				   ,@toBeValued
				   ,@heldforSaleorInvestment
				   ,@controledforFinancialPurpose
				   --,<Asset, uniqueidentifier,>
				   ,@newaddressOid
				   --,<OptimisticLockField, int,>
				   --,<GCRecord, int,>
				   )
			exec dbo.RegisterAsset @newAssetRegisterOid_B
			exec dbo.CreateComponentInputForAssetRegister @newAssetRegisterOid_B
			exec dbo.RegisterAsset_ResetReplacementCostDirectCost @newAssetRegisterOid_B
		End
	Else 
		Set  @result = 'Other'
END 

GO

--Declare @myresult nvarchar(100)
--exec [dbo].[ImportAsset] 
-- null -- Job Name can not change
-- ,'F7978A17-2FD8-4162-88DE-CAE6585A997D' -- Client Id cant  change
-- ,'empty Job 10', -- Asset Id cant  change
--  'Sam' --  Asset Name can Update
-- ,'Buildings DRC' -- Asset Hierarchy can update
-- ,'12.31' -- Asset Type can update
-- ,'Non-Permanent' -- Asset Sub type can update
-- ,0
-- ,0
-- ,0
-- ,0
-- ,'streetAddress22'
-- ,'suburb22'
-- ,'town'
-- ,'state'
-- ,'country'
-- ,'postCode'
-- ,1 --Long
-- ,1 --Lat
-- ,'facility'
-- ,'APV_Test_User'
-- ,0,0,0,0,0,0,0,0,0,@myresult  OUtput
-- select @myresult as result
 
-- select 
--    dbo.MyAddress.*,
--   dbo.AssetRegister.Job
--   ,dbo.AssetRegister.Name as AssetName
--   ,dbo.AssetHierarchy.AssetHierarchyName
--   ,dbo.AssetType.AssetTypeName
--   ,dbo.AssetSubType.AssetSubTypeName
--   --,dbo.AssetRegister.AssetClass
--   --,dbo.AssetRegister.AssetType
--   --,dbo.AssetRegister.AssetSubType
--   ,dbo.AssetRegister.*
-- from dbo.AssetRegister
--	 inner join dbo.MyAddress on dbo.MyAddress.Oid = dbo.AssetRegister.DefaultAddress
-- 	 inner join dbo.AssetHierarchy on 
--	            --dbo.AssetHierarchy.Oid = dbo.AssetRegister.AssetClass
--				--And 
--				dbo.AssetHierarchy.GCRecord is null 
--				And
--				dbo.AssetHierarchy.AssetHierarchyName='Buildings DRC'
--	 inner join dbo.AssetType on 
--				--dbo.AssetType.Oid = dbo.AssetRegister.AssetType 
--				--And 
--				AssetType.AssetClass =dbo.AssetHierarchy.Oid 
--				And
--				dbo.AssetType.AssetTypeName='12.31'
--	 inner join dbo.AssetSubType on 
--				--dbo.AssetSubType.Oid = dbo.AssetRegister.AssetSubType 
--				--And 
--				dbo.AssetSubType.AssetType = dbo.AssetType.Oid 
--				And
--				dbo.AssetSubType.AssetSubTypeName='Non-Permanent'
-- where dbo.AssetRegister.AssetId='empty Job 10'
--       And dbo.AssetRegister.Client ='F7978A17-2FD8-4162-88DE-CAE6585A997D'
	    
--Delete From dbo.AssetRegister where dbo.AssetRegister.Oid ='04E6A2BC-83FD-47B2-A1C1-79EAC7EF1955'