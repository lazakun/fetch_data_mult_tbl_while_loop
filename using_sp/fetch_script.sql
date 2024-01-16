CREATE TABLE #my_dest_table (
	[BusinessEntityID] [int] NOT NULL,
	[NationalIDNumber] [nvarchar](15) NOT NULL,
	[LoginID] [nvarchar](256) NOT NULL,
	[OrganizationNode] [hierarchyid] NULL,
	[OrganizationLevel] [smallint] NULL,
	[JobTitle] [nvarchar](50) NOT NULL,
	[BirthDate] [date] NOT NULL,
	[MaritalStatus] [nchar](1) NOT NULL,
	[Gender] [nchar](1) NOT NULL,
	[HireDate] [date] NOT NULL,
	[SalariedFlag] [smallint] NOT NULL,
	[VacationHours] [smallint] NOT NULL,
	[SickLeaveHours] [smallint] NOT NULL,
	[CurrentFlag] [smallint] NOT NULL,
	[rowguid] [uniqueidentifier] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
	[table_name] [nvarchar](500) NULL);


CREATE TABLE #my_temp_table (
        id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
        table_name VARCHAR(500));

USE tempdb;
INSERT INTO #my_temp_table
select name from AdventureWorks2019.sys.tables
where name in ('Employee_Buyer','Employee_Janitor','Employee_Prod_Tech','Employee_Sales_Rep')

--drop table #my_temp_table

declare @runid int = (select min(id) from #my_temp_table)
declare @table_name varchar(200)

while @runid <=(select max(id) from #my_temp_table)

begin 
set @table_name = (select table_name from #my_temp_table where id = @runid)


exec('insert into #my_dest_table
exec AdventureWorks2019.[dbo].[fetch_script] '+@table_name)

  set @runid = @runid + 1

  end 
  go

  select * from #my_dest_table
