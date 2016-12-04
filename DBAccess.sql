CREATE LOGIN GOV_Vanuatu WITH password='1231!#ASDF!a';

Use [FairValueProDevDb0416]

CREATE USER [GOV_Vanuatu] FOR LOGIN [GOV_Vanuatu]
GO
ALTER ROLE [db_datareader] ADD MEMBER [GOV_Vanuatu]
ALTER ROLE [db_accessadmin] ADD MEMBER [GOV_Vanuatu]
ALTER ROLE [db_datawriter] ADD MEMBER [GOV_Vanuatu]
ALTER ROLE [db_backupoperator] ADD MEMBER [GOV_Vanuatu]
ALTER ROLE [db_ddladmin] ADD MEMBER [GOV_Vanuatu]
ALTER ROLE [db_owner] ADD MEMBER [GOV_Vanuatu]
GO