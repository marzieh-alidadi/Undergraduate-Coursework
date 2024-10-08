---------------------------- ################################## faze 2 & 3 ###################################


---------------********* faze 2 ********* :


-----TABLEs

 /*
 create table BloodBank
(
Name varchar(30) Primary key,
Address varchar(50),
ContactNumbar varchar(20),
)

create table DonationRecord
(
DonationID char(10) primary key,
BloodBankName varchar(30),
DonationDate varchar(10),
ExpiryDate varchar(10),
foreign key (BloodBankName) references BloodBank (Name),
)

create table Donor
(
ID char(10) primary key,
Name varchar(30),
BirthDate varchar(10),
Sex char(7),
BloodGroup char(2),
Address varchar(50),
ContactNumbar varchar(20),
EmailAddress varchar(320),
MedicalReport varchar(200),
)

create table Donation
(
ID char(10) primary key,
DonorID char(10),
AmountDonated numeric(10,2),
foreign key (ID) references DonationRecord (DonationID),
foreign key (DonorId) references Donor (ID),
)

create table TransfusionRecord
(
TransfusionID char(10) primary key,
BloodBankName varchar(30),
TransfutionDate varchar(10),
foreign key (BloodBankName) references BloodBank (Name),
)

create table Recipient
(
ID char(10) primary key,
Name varchar(30),
BirthDate varchar(10),
Sex char(7),
BloodGroup char(2),
Address varchar(50),
ContactNumbar varchar(20),
EmailAddress varchar(320),
MedicalReport varchar(200),
)

create table Transfusion
(
ID char(10) primary key,
RecipientID char(10),
AmountAccepted numeric(10,2),
foreign key (ID) references TransfusionRecord (TransfusionID),
foreign key (RecipientID) references Recipient (ID),
)

*/


----INSERTs

/*
insert into BloodBank (Name,Address,ContactNumbar) values ('Ehda','Isfahan','12345678')
insert into BloodBank (Name,Address,ContactNumbar) values ('Hayat','Ahvaz','23456789')
insert into BloodBank (Name,Address,ContactNumbar) values ('Zendagi','Yazd','34567890')
*/

/*
insert into DonationRecord(DonationID,BloodBankName,DonationDate,ExpiryDate) values ('1234','Ehda','12/03/1367','12/05/1367')
insert into DonationRecord(DonationID,BloodBankName,DonationDate,ExpiryDate) values ('2345','Hayat','07/05/1389','07/07/1389')
insert into DonationRecord(DonationID,BloodBankName,DonationDate,ExpiryDate) values ('3456','Zendagi','25/08/1398','25/10/1398')
*/

/*
insert into Donor(ID ,Name,BloodGroup,MedicalReport) values ('4321','ParisaMomeni','A+','none')
insert into Donor(ID ,Name,BloodGroup,MedicalReport) values ('5432','MoeinAlidadi','O+','none')
insert into Donor(ID ,Name,BloodGroup,MedicalReport) values ('6543','LeilaBehzadi','O+','none')
*/

/*
insert into Donation(ID,DonorID,AmountDonated) values ('1234','4321',34.9)
insert into Donation(ID,DonorID,AmountDonated) values ('2345','5432',45.3)
insert into Donation(ID,DonorID,AmountDonated) values ('3456','6543',26)
*/

/*
insert into TransfusionRecord(TransfusionID,BloodBankName,TransfutionDate) values ('1235','Ehda','11/08/1367')
insert into TransfusionRecord(TransfusionID,BloodBankName,TransfutionDate) values ('2346','Hayat','07/06/1379')
insert into TransfusionRecord(TransfusionID,BloodBankName,TransfutionDate) values ('3457','Zendagi','15/09/1398')

insert into TransfusionRecord(TransfusionID,BloodBankName,TransfutionDate) values ('7890','Ehda','11/08/1367')
insert into TransfusionRecord(TransfusionID,BloodBankName,TransfutionDate) values ('6789','Ehda','11/08/1367')
insert into TransfusionRecord(TransfusionID,BloodBankName,TransfutionDate) values ('5678','Ehda','11/08/1367')
insert into TransfusionRecord(TransfusionID,BloodBankName,TransfutionDate) values ('4567','Ehda','11/08/1367')



*/

/*
insert into Recipient(ID ,Name,BloodGroup,MedicalReport) values ('4322','FaezehHosseini','A+','none')
insert into Recipient(ID ,Name,BloodGroup,MedicalReport) values ('5433','MehdiAlidadi','O+','none')
insert into Recipient(ID ,Name,BloodGroup,MedicalReport) values ('6544','LalehBehzadi','O+','none')

delete from Recipient where ID='4322'
delete from Recipient where ID='5433'
delete from Recipient where ID='6544'


*/


/*
insert into Transfusion(ID,RecipientID,AmountAccepted) values ('1235','4322',24.9)
insert into Transfusion(ID,RecipientID,AmountAccepted) values ('2346','5433',45.3)
insert into Transfusion(ID,RecipientID,AmountAccepted) values ('3457','6544',26)

delete from Transfusion where RecipientID='4322'
delete from Transfusion where RecipientID='5433'
delete from Transfusion where RecipientID='6544'

*/



---------------********* faze 3 ********* :

------VEIWs

/*
CREATE VIEW RecipientList
AS
    select [Name] as RecipientName
	from Recipient
*/

/*
CREATE VIEW DonorList
AS
    select [Name] DonorName
	from Donor
*/

/*
CREATE VIEW TotalAmountDonated
AS
    select sum(AmountDonated) as TotalAmountDonated
	from Donation
*/

/*
CREATE VIEW TotalAmountAccepted
AS
    select sum(AmountAccepted) as TotalAmountAccepted
	from Transfusion
*/


-----STORED PROCEDUREs

/*
CREATE PROCEDURE SpecialGroupDonorList @Group char(2)
AS

    select [Name] as DonorName ,BloodGroup
	from Donor
	where @Group=BloodGroup
*/
/*
	EXEC SpecialGroupDonorList @Group = "O+";
*/


/*
CREATE PROCEDURE SpecialGroupRecipientList @Group char(2)
AS

    select [Name] as RecipientName ,BloodGroup
	from Recipient
	where @Group=BloodGroup
*/
/*
	EXEC SpecialGroupRecipientList @Group = "O+";
*/


/*
CREATE PROCEDURE DonorWithNoDiseaseList
AS
    select ID ,[Name] as DonorName ,BloodGroup
	from Donor
	where MedicalReport='none'
*/
/*
	EXEC DonorWithNoDiseaseList 
*/


/*
CREATE PROCEDURE RecipientWithNoDiseaseList
AS
    select ID ,[Name] as RecipientName ,BloodGroup
	from Recipient
	where MedicalReport='none'
*/
/*
	EXEC RecipientWithNoDiseaseList 
*/


------TRIGGERs


-->log for Recipients changes

/*
create table RecipientLog
(
ID char(10),
Name varchar(30),
BirthDate varchar(10),
Sex char(7),
BloodGroup char(2),
Address varchar(50),
ContactNumbar varchar(20),
EmailAddress varchar(320),
MedicalReport varchar(200),
)
*/


/*
create trigger RecipientLoggerUpdate
on Recipient
after update 
as 
insert into RecipientLog(ID ,Name,BirthDate,Sex,BloodGroup,Address,ContactNumbar,EmailAddress,MedicalReport)
select * from inserted where exists (select * from deleted)
*/


/*
create trigger RecipientLoggerInsert
on Recipient
after insert 
as 
insert into RecipientLog(ID ,Name,BirthDate,Sex,BloodGroup,Address,ContactNumbar,EmailAddress,MedicalReport)
select * from inserted
*/
/*
insert into Recipient(ID ,Name,BloodGroup,MedicalReport) values ('7655','ArminaKiani','O+','none')
*/
/*
select * from RecipientLog
*/



/*
create trigger RecipientLoggerDelete
on Recipient
after delete 
as 
insert into RecipientLog(ID ,Name,BirthDate,Sex,BloodGroup,Address,ContactNumbar,EmailAddress,MedicalReport)
select * from deleted
*/





-->log for Donors changes

/*
create table DonorLog
(
ID char(10),
Name varchar(30),
BirthDate varchar(10),
Sex char(7),
BloodGroup char(2),
Address varchar(50),
ContactNumbar varchar(20),
EmailAddress varchar(320),
MedicalReport varchar(200),
)
*/


/*
create trigger DonorLoggerUpdate
on Donor
after update 
as 
insert into DonorLog(ID ,Name,BirthDate,Sex,BloodGroup,Address,ContactNumbar,EmailAddress,MedicalReport)
select * from inserted where exists (select * from deleted)
*/


/*
create trigger DonorLoggerInsert
on Donor
after insert 
as 
insert into DonorLog(ID ,Name,BirthDate,Sex,BloodGroup,Address,ContactNumbar,EmailAddress,MedicalReport)
select * from inserted
*/
/*
insert into Donor(ID ,Name,BloodGroup,MedicalReport) values ('7654','FatemeJorfi','B+','none')
*/
/*
select * from DonorLog
*/



/*
create trigger DonorLoggerDelete
on Donor
after delete 
as 
insert into DonorLog(ID ,Name,BirthDate,Sex,BloodGroup,Address,ContactNumbar,EmailAddress,MedicalReport)
select * from deleted
*/




----FUNCTIONs


/*
CREATE FUNCTION TotalSpecialGroupAmountAccepted(@Group char(2))
RETURNS numeric(10,2)
AS
BEGIN
 DECLARE @ret numeric(10,2);
 SELECT @ret = SUM(AmountAccepted)
 FROM Transfusion inner join Recipient on (Transfusion.RecipientID=Recipient.ID)
 WHERE BloodGroup = @Group;
 IF (@ret IS NULL)
 SET @ret = 0;
 RETURN @ret;
END;
*/
/*
SELECT Name, BloodGroup,AmountAccepted, dbo.TotalSpecialGroupAmountAccepted(BloodGroup) AS TotAmount
FROM Transfusion inner join Recipient on (Transfusion.RecipientID=Recipient.ID) 
WHERE BloodGroup='A+'
*/






/*
CREATE FUNCTION TotalSpecialGroupAmountDonated(@Group char(2))
RETURNS numeric(10,2)
AS
BEGIN
 DECLARE @ret numeric(10,2);
 SELECT @ret = SUM(AmountDonated)
 FROM Donation inner join Donor on (Donation.DonorID=Donor.ID)
 WHERE BloodGroup = @Group;
 IF (@ret IS NULL)
 SET @ret = 0;
 RETURN @ret;
END;
*/
/*
SELECT Name, BloodGroup,AmountDonated, dbo.TotalSpecialGroupAmountDonated(BloodGroup) AS TotAmount
FROM Donation inner join Donor on (Donation.DonorID=Donor.ID)
WHERE BloodGroup='A+'
*/





/*
CREATE FUNCTION FindRecipientByID (@ID int)
RETURNS TABLE
AS
RETURN
(
 SELECT Recipient.ID as RecipientID,Name as RecipientName, BloodGroup, MedicalReport, Transfusion.ID as TransfusionID
 FROM Recipient JOIN Transfusion on(Recipient.ID=Transfusion.RecipientID)
 WHERE Recipient.ID = @ID
);
*/
/*
select * from FindRecipientByID(0987)
*/





/*
CREATE FUNCTION FindDonorByID (@ID int)
RETURNS TABLE
AS
RETURN
(
 SELECT Donor.ID as DonorID,Name as DonorName, BloodGroup, MedicalReport, Donation.ID as DonationID
 FROM Donor JOIN Donation on(Donor.ID=Donation.DonorID)
 WHERE Donor.ID = @ID
);
*/
/*
select * from FindDonorByID(4321)
*/

----LOGINs

/*
create role bankAdmin 
*/
/*
CREATE LOGIN bankAdmin  WITH   PASSWORD='PASS' 
*/
/*
grant all 
ON dbo.Recipient
to bankAdmin
*/

/*
create role publicUser
*/
/*
CREATE LOGIN publicUser  WITH   PASSWORD='usr' 
*/
/*
deny insert 
ON dbo.Recipient
to publicUser
*/


----pivot

/*
select ID,['O+'] as O,['A+'] as A
from 
(select Transfusion.id,BloodGroup,AmountAccepted
from Recipient inner join Transfusion on(Recipient.id=Transfusion.Recipientid)
) as ps
pivot(
sum(AmountAccepted)
for  BloodGroup
in (['O+'],['A+'])
)as pvt
*/

/*
INSERT INTO [dbo].[Recipient]
           ([ID]
           ,[Name]
           ,[Sex]
           ,[BloodGroup]
           )
     VALUES
           (0987
           ,'somebody1'
           ,'female'
           ,'O+'
           )



INSERT INTO [dbo].[Recipient]
           ([ID]
           ,[Name]
           ,[Sex]
           ,[BloodGroup]
           )
     VALUES
           (0987
           ,'somebody1'
           ,'female'
           ,'O+'
           )


INSERT INTO [dbo].[Recipient]
           ([ID]
           ,[Name]
           ,[Sex]
           ,[BloodGroup]
           )
     VALUES
           (9876
           ,'somebody2'
           ,'male'
           ,'O+'
           )


INSERT INTO [dbo].[Recipient]
           ([ID]
           ,[Name]
           ,[Sex]
           ,[BloodGroup]
           )
     VALUES
           (8765
           ,'somebody3'
           ,'female'
           ,'A+'
           )


INSERT INTO [dbo].[Recipient]
           ([ID]
           ,[Name]
           ,[Sex]
           ,[BloodGroup]
           )
     VALUES
           (7654
           ,'somebody4'
           ,'male'
           ,'A+'
           )

		   */




		   /*
		   
INSERT INTO [dbo].[Transfusion]
           ([ID]
           ,[RecipientID]
           ,[AmountAccepted])
     VALUES
           (4567
           ,7654
           ,1000)


		    
INSERT INTO [dbo].[Transfusion]
           ([ID]
           ,[RecipientID]
           ,[AmountAccepted])
     VALUES
           (5678
           ,8765
           ,1000)

 
INSERT INTO [dbo].[Transfusion]
           ([ID]
           ,[RecipientID]
           ,[AmountAccepted])
     VALUES
           (6789
           ,9876
           ,1000)

 
INSERT INTO [dbo].[Transfusion]
           ([ID]
           ,[RecipientID]
           ,[AmountAccepted])
     VALUES
           (7890
           ,0987
           ,1000)

		   */



/*
select ID,['female'] as female,['male'] as male
from 
(select Transfusion.id,sex,AmountAccepted
from Recipient inner join Transfusion on(Recipient.id=Transfusion.Recipientid)
) as ps
pivot(
sum(AmountAccepted)
for  sex
in (['female'],['male'])
)as pvt
*/






