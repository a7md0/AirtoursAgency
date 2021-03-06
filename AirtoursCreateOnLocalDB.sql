USE [master]

/*                                                                        */
/*              Northwind.SQL - Creates the Northwind database                  */ 
/*                                                                        */
/*
** Copyright Microsoft, Inc. 1994 - 2000
** All Rights Reserved.
*/

SET NOCOUNT ON
GO

set nocount    on
set dateformat mdy

USE master

declare @dttm varchar(55)
select  @dttm=convert(varchar,getdate(),113)
raiserror('Beginning AirtoursCreateOnLocalDB.SQL at %s ....',1,1,@dttm) with nowait

GO

if exists (select * from sysdatabases where name='Airtours')
begin
  raiserror('Dropping existing Airtours database ....',0,1)
  DROP database Airtours 
end
GO

CHECKPOINT
go

raiserror('Creating Airtours database....',0,1)

GO
/****** Object:  Database [Airtours]    Script Date: 04/25/2017 13:13:37 ******/
CREATE DATABASE [Airtours] 
GO
ALTER DATABASE [Airtours] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Airtours].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Airtours] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [Airtours] SET ANSI_NULLS OFF
GO
ALTER DATABASE [Airtours] SET ANSI_PADDING OFF
GO
ALTER DATABASE [Airtours] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [Airtours] SET ARITHABORT OFF
GO
ALTER DATABASE [Airtours] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [Airtours] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [Airtours] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [Airtours] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [Airtours] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [Airtours] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [Airtours] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [Airtours] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [Airtours] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [Airtours] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [Airtours] SET  ENABLE_BROKER
GO
ALTER DATABASE [Airtours] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [Airtours] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [Airtours] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [Airtours] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [Airtours] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [Airtours] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [Airtours] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [Airtours] SET  READ_WRITE
GO
ALTER DATABASE [Airtours] SET RECOVERY FULL
GO
ALTER DATABASE [Airtours] SET  MULTI_USER
GO
ALTER DATABASE [Airtours] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [Airtours] SET DB_CHAINING OFF
GO
EXEC sys.sp_db_vardecimal_storage_format N'Airtours', N'ON'
GO
USE [Airtours]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 04/25/2017 13:13:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[EmployeeID] [int] IDENTITY(1,1) NOT NULL,
	[Lname] [nvarchar](20) NULL,
	[Fname] [nvarchar](15) NULL,
	[BirthDate] [datetime] NULL,
	[HireDate] [datetime] NULL,
	[Address] [nvarchar](20) NULL,
	[City] [nvarchar](20) NULL,
	[Region] [nvarchar](20) NULL,
	[Phone] [nvarchar](20) NULL,
	[Notes] [ntext] NULL,
 CONSTRAINT [aaaaaEmployee_PK] PRIMARY KEY NONCLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'EmployeeID'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'EmployeeID'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'EmployeeID'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'17' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'EmployeeID'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'EmployeeID'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'EmployeeID'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'EmployeeID'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'480' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'EmployeeID'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'EmployeeID'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'EmployeeID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'EmployeeID'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'EmployeeID'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'EmployeeID'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'EmployeeID'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'EmployeeID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'EmployeeID'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Employee' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'EmployeeID'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'EmployeeID'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'EmployeeID'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Lname'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Lname'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Lname'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Lname'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Lname'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Lname'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Lname'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'1125' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Lname'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Lname'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Lname'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Lname'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Lname'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Lname' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Lname'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Lname'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Lname'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'20' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Lname'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Lname' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Lname'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Employee' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Lname'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Lname'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Lname'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Lname'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Fname'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Fname'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Fname'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Fname'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Fname'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Fname'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Fname'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'1050' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Fname'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Fname'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Fname'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Fname'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Fname'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Fname' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Fname'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Fname'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Fname'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'15' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Fname'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Fname' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Fname'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Employee' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Fname'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Fname'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Fname'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Fname'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'BirthDate'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'BirthDate'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'BirthDate'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'BirthDate'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'BirthDate'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'BirthDate'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'BirthDate'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'1035' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'BirthDate'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'BirthDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'BirthDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'BirthDate'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'BirthDate' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'BirthDate'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'BirthDate'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'BirthDate'
GO
EXEC sys.sp_addextendedproperty @name=N'ShowDatePicker', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'BirthDate'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'BirthDate'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'BirthDate' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'BirthDate'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Employee' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'BirthDate'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'BirthDate'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'BirthDate'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'HireDate'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'HireDate'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'HireDate'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'HireDate'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'HireDate'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'HireDate'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'HireDate'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'840' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'HireDate'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'HireDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'HireDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'HireDate'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'HireDate' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'HireDate'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'HireDate'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'HireDate'
GO
EXEC sys.sp_addextendedproperty @name=N'ShowDatePicker', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'HireDate'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'HireDate'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'HireDate' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'HireDate'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Employee' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'HireDate'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'HireDate'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'HireDate'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Address' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'5' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'20' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Address' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Employee' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'City'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'City'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'City'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'City'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'City'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'City'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'City'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'810' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'City'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'City'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'City'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'City'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'City'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'City' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'City'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'6' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'City'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'City'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'20' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'City'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'City' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'City'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Employee' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'City'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'City'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'City'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'City'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Region'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Region'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Region'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Region'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Region'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Region'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Region'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'915' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Region'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Region'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Region'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Region'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Region'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Region' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Region'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'7' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Region'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Region'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'20' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Region'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Region' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Region'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Employee' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Region'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Region'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Region'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Region'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'1215' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Phone' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'20' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Phone' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Employee' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Notes'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Notes'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Notes'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Notes'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Notes'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Notes'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Notes'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Notes'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Notes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Notes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Notes'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Notes' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Notes'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'9' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Notes'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Notes'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Notes'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Notes' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Notes'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Employee' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Notes'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Notes'
GO
EXEC sys.sp_addextendedproperty @name=N'TextFormat', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Notes'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'12' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Notes'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Notes'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee'
GO
EXEC sys.sp_addextendedproperty @name=N'DateCreated', @value=N'16/02/2014 10:02:34 a.m.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee'
GO
EXEC sys.sp_addextendedproperty @name=N'DisplayViewsOnSharePointSite', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee'
GO
EXEC sys.sp_addextendedproperty @name=N'FilterOnLoad', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee'
GO
EXEC sys.sp_addextendedproperty @name=N'HideNewField', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee'
GO
EXEC sys.sp_addextendedproperty @name=N'LastUpdated', @value=N'7/05/2014 8:06:30 a.m.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Employee' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee'
GO
EXEC sys.sp_addextendedproperty @name=N'OrderByOnLoad', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee'
GO
EXEC sys.sp_addextendedproperty @name=N'RecordCount', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee'
GO
EXEC sys.sp_addextendedproperty @name=N'TotalsRow', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee'
GO
EXEC sys.sp_addextendedproperty @name=N'Updatable', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee'
GO
SET IDENTITY_INSERT [dbo].[Employee] ON
INSERT [dbo].[Employee] ([EmployeeID], [Lname], [Fname], [BirthDate], [HireDate], [Address], [City], [Region], [Phone], [Notes]) VALUES (1, N'Jayasinghe', N'Nihal', CAST(0x00005D4000000000 AS DateTime), CAST(0x00008D4100000000 AS DateTime), N'PO Box 2234', N'Sharjah', N'Sharjah', N'06 223 1112', NULL)
INSERT [dbo].[Employee] ([EmployeeID], [Lname], [Fname], [BirthDate], [HireDate], [Address], [City], [Region], [Phone], [Notes]) VALUES (2, N'Price', N'Jason', CAST(0x000065E800000000 AS DateTime), CAST(0x00008CAA00000000 AS DateTime), N'PO Box 4322', N'Dubai', N'Dubai', N'04 332 1123', NULL)
INSERT [dbo].[Employee] ([EmployeeID], [Lname], [Fname], [BirthDate], [HireDate], [Address], [City], [Region], [Phone], [Notes]) VALUES (3, N'Mulder', N'Karl', CAST(0x0000692400000000 AS DateTime), CAST(0x00008E3A00000000 AS DateTime), N'PO Box 1211', N'Sharjah', N'Sharjah', N'06 288 4450', N'Temporary hire')
INSERT [dbo].[Employee] ([EmployeeID], [Lname], [Fname], [BirthDate], [HireDate], [Address], [City], [Region], [Phone], [Notes]) VALUES (4, N'Da Cunha', N'Pius', CAST(0x0000644E00000000 AS DateTime), CAST(0x00008A6800000000 AS DateTime), N'PO Box 3382', N'Dubai', N'Dubai', N'04 998 5278', NULL)
INSERT [dbo].[Employee] ([EmployeeID], [Lname], [Fname], [BirthDate], [HireDate], [Address], [City], [Region], [Phone], [Notes]) VALUES (5, N'Diodori', N'Anna', CAST(0x0000634C00000000 AS DateTime), CAST(0x0000878C00000000 AS DateTime), N'PO Box 2387', N'Sharjah', N'Sharjah', N'06 532 9483', NULL)
INSERT [dbo].[Employee] ([EmployeeID], [Lname], [Fname], [BirthDate], [HireDate], [Address], [City], [Region], [Phone], [Notes]) VALUES (6, N'Ganglani', N'Florence', CAST(0x0000691E00000000 AS DateTime), CAST(0x00008CAC00000000 AS DateTime), N'PO Box 2209', N'Dubai', N'Dubai', N'04 661 9962', NULL)
INSERT [dbo].[Employee] ([EmployeeID], [Lname], [Fname], [BirthDate], [HireDate], [Address], [City], [Region], [Phone], [Notes]) VALUES (7, N'Al Muhairi', N'Asma Saif', CAST(0x00006BA300000000 AS DateTime), CAST(0x00008C0F00000000 AS DateTime), N'PO Box 5519', N'Sharjah', N'Sharjah', N'06 995 2837', NULL)
INSERT [dbo].[Employee] ([EmployeeID], [Lname], [Fname], [BirthDate], [HireDate], [Address], [City], [Region], [Phone], [Notes]) VALUES (8, N'Al Huwaidi', N'Ahmed', CAST(0x000070F900000000 AS DateTime), CAST(0x00008F0800000000 AS DateTime), N'PO Box 5188', N'Dubai', N'Dubai', N'04 232 2355', N'Work Placement Student from HCT')
SET IDENTITY_INSERT [dbo].[Employee] OFF
/****** Object:  Table [dbo].[Customer]    Script Date: 04/25/2017 13:13:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[CustomerID] [int] IDENTITY(1,1) NOT NULL,
	[Lname] [nvarchar](20) NULL,
	[Fname] [nvarchar](15) NULL,
	[Phone] [nvarchar](25) NULL,
	[Address] [nvarchar](20) NULL,
	[City] [nvarchar](50) NULL,
	[Region] [nvarchar](20) NULL,
	[PostalCode] [nvarchar](15) NULL,
	[Country] [nvarchar](20) NULL,
	[Fax] [nvarchar](20) NULL,
	[Email] [nvarchar](30) NULL,
	[Miles] [int] NULL,
	[Password] [nvarchar](255) NULL,
	[CreditCardNumber] [nvarchar](25) NULL,
	[SecurityCode] [int] NULL,
 CONSTRAINT [aaaaaCustomer_PK] PRIMARY KEY NONCLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'CustomerID'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'CustomerID'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'CustomerID'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'17' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'CustomerID'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'CustomerID'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'CustomerID'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'CustomerID'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'CustomerID'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'CustomerID'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'CustomerID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'CustomerID'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'CustomerID'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'CustomerID'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'CustomerID'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'CustomerID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'CustomerID'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Customer' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'CustomerID'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'CustomerID'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'CustomerID'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Lname'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Lname'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Lname'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Lname'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Lname'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Lname'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Lname'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'1305' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Lname'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Lname'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Lname'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Lname'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Lname'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Lname' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Lname'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Lname'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Lname'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'20' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Lname'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Lname' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Lname'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Customer' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Lname'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Lname'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Lname'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Lname'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Fname'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Fname'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Fname'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Fname'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Fname'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Fname'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Fname'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'900' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Fname'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Fname'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Fname'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Fname'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Fname'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Fname' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Fname'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Fname'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Fname'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'15' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Fname'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Fname' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Fname'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Customer' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Fname'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Fname'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Fname'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Fname'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Phone' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'25' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Phone' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Customer' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'2025' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Address' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'20' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Address' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Customer' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'City'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'City'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'City'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'City'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'City'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'City'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'City'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'City'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'City'
GO
EXEC sys.sp_addextendedproperty @name=N'DefaultValue', @value=N'"Dubai"' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'City'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'City'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'City'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'City'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'City' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'City'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'5' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'City'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'City'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'50' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'City'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'City' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'City'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Customer' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'City'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'City'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'City'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'City'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Region'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Region'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Region'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Region'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Region'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Region'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Region'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'1575' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Region'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Region'
GO
EXEC sys.sp_addextendedproperty @name=N'DefaultValue', @value=N'"Dubai"' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Region'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Region'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Region'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Region'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Region' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Region'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'6' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Region'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Region'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'20' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Region'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Region' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Region'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Customer' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Region'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Region'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Region'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Region'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'PostalCode'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'PostalCode'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'PostalCode'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'PostalCode'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'PostalCode'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'PostalCode'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'PostalCode'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'915' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'PostalCode'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'PostalCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'PostalCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'PostalCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'PostalCode'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'PostalCode' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'PostalCode'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'7' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'PostalCode'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'PostalCode'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'15' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'PostalCode'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'PostalCode' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'PostalCode'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Customer' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'PostalCode'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'PostalCode'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'PostalCode'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'PostalCode'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Country'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Country'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Country'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Country'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Country'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Country'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Country'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'780' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Country'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Country'
GO
EXEC sys.sp_addextendedproperty @name=N'DefaultValue', @value=N'"UAE"' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Country'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Country'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Country'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Country'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Country' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Country'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Country'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Country'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'20' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Country'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Country' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Country'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Customer' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Country'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Country'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Country'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Country'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Fax'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Fax'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Fax'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Fax'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Fax'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Fax'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Fax'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Fax'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Fax'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Fax'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Fax'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Fax'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Fax' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Fax'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'9' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Fax'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Fax'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'20' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Fax'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Fax' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Fax'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Customer' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Fax'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Fax'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Fax'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Fax'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Email'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Email'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Email'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Email'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Email'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Email'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Email'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'1980' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Email'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Email'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Email'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Email'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Email'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Email' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Email'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Email'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Email'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'30' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Email'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Email' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Email'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Customer' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Email'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Email'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Email'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Email'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Miles'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Miles'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Miles'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Miles'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Miles'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Miles'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Miles'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Miles'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Miles'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Miles'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Miles'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Miles' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Miles'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'11' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Miles'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Miles'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Miles'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Miles' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Miles'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Customer' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Miles'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Miles'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Miles'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Password'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Password'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Password'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Password'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Password'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Password'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Password'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Password'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Password'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Password'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Password'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Password'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Password' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Password'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'12' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Password'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Password'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Password'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Password' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Password'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Customer' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Password'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Password'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Password'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Password'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'CreditCardNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'CreditCardNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'CreditCardNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'CreditCardNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'CreditCardNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'CreditCardNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'CreditCardNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'1740' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'CreditCardNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'CreditCardNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'CreditCardNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'CreditCardNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'CreditCardNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'CreditCardNumber' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'CreditCardNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'13' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'CreditCardNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'CreditCardNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'CreditCardNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'CreditCardNumber' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'CreditCardNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Customer' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'CreditCardNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'CreditCardNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'7' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'CreditCardNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'SecurityCode'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'SecurityCode'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'SecurityCode'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'SecurityCode'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'SecurityCode'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'SecurityCode'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'SecurityCode'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'SecurityCode'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'SecurityCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'SecurityCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'SecurityCode'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'SecurityCode' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'SecurityCode'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'14' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'SecurityCode'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'SecurityCode'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'SecurityCode'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'SecurityCode' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'SecurityCode'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Customer' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'SecurityCode'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'SecurityCode'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'SecurityCode'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer'
GO
EXEC sys.sp_addextendedproperty @name=N'DateCreated', @value=N'16/02/2014 10:02:34 a.m.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer'
GO
EXEC sys.sp_addextendedproperty @name=N'DisplayViewsOnSharePointSite', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer'
GO
EXEC sys.sp_addextendedproperty @name=N'FilterOnLoad', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer'
GO
EXEC sys.sp_addextendedproperty @name=N'HideNewField', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer'
GO
EXEC sys.sp_addextendedproperty @name=N'LastUpdated', @value=N'7/05/2014 8:06:30 a.m.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Customer' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer'
GO
EXEC sys.sp_addextendedproperty @name=N'OrderByOnLoad', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer'
GO
EXEC sys.sp_addextendedproperty @name=N'RecordCount', @value=N'50' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer'
GO
EXEC sys.sp_addextendedproperty @name=N'TotalsRow', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer'
GO
EXEC sys.sp_addextendedproperty @name=N'Updatable', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customer'
GO
SET IDENTITY_INSERT [dbo].[Customer] ON
INSERT [dbo].[Customer] ([CustomerID], [Lname], [Fname], [Phone], [Address], [City], [Region], [PostalCode], [Country], [Fax], [Email], [Miles], [Password], [CreditCardNumber], [SecurityCode]) VALUES (1, N'Hanson', N'Rita', N'Canada (604) 555-2933', N'304 King Edward Pl.', N'Vancouver', N'British Columbia', N'V3F 4A9', N'Canada', NULL, N'rhanson@hotmail.com', NULL, N'xbgtdmlz', 4.92090008238665E+15, 790)
INSERT [dbo].[Customer] ([CustomerID], [Lname], [Fname], [Phone], [Address], [City], [Region], [PostalCode], [Country], [Fax], [Email], [Miles], [Password], [CreditCardNumber], [SecurityCode]) VALUES (2, N'Zahoor', N'Ali', N'(06) 294-5552', N'PO Box 4774', N'Sharjah', N'Sharjah', NULL, N'UAE', NULL, NULL, NULL, N'koedxgcs', 2.08287729415955E+15, 843)
INSERT [dbo].[Customer] ([CustomerID], [Lname], [Fname], [Phone], [Address], [City], [Region], [PostalCode], [Country], [Fax], [Email], [Miles], [Password], [CreditCardNumber], [SecurityCode]) VALUES (3, N'Minsk', N'Jeremy', N'(04) 337-6724', N'PO Box 4482', N'Dubai', N'Dubai', NULL, N'UAE', NULL, NULL, NULL, N'kwhnlbge', 9.67866442972908E+15, 478)
INSERT [dbo].[Customer] ([CustomerID], [Lname], [Fname], [Phone], [Address], [City], [Region], [PostalCode], [Country], [Fax], [Email], [Miles], [Password], [CreditCardNumber], [SecurityCode]) VALUES (4, N'Lockwood', N'Francis', N'(06) 448-3372', N'PO Box 7983', N'Sharjah', N'Sharjah', NULL, N'UAE', N'(04) 645-6657', NULL, NULL, N'pweypzpv', 9.06442492687396E+15, 791)
INSERT [dbo].[Customer] ([CustomerID], [Lname], [Fname], [Phone], [Address], [City], [Region], [PostalCode], [Country], [Fax], [Email], [Miles], [Password], [CreditCardNumber], [SecurityCode]) VALUES (5, N'Peterson', N'Helen', N'(02) 123-2323', N'PO Box 4453', N'Abu Dhabi', N'Abu Dhabi', NULL, N'UAE', NULL, NULL, NULL, N'besijzdf', 3.13743501550249E+15, 516)
INSERT [dbo].[Customer] ([CustomerID], [Lname], [Fname], [Phone], [Address], [City], [Region], [PostalCode], [Country], [Fax], [Email], [Miles], [Password], [CreditCardNumber], [SecurityCode]) VALUES (6, N'Yorres', N'Jamie', N'(06) 222-7382', N'PO Box 234', N'Dubai', N'Dubai', NULL, N'UAE', NULL, NULL, NULL, N'uuarxfdm', 9.9701370426445E+15, 271)
INSERT [dbo].[Customer] ([CustomerID], [Lname], [Fname], [Phone], [Address], [City], [Region], [PostalCode], [Country], [Fax], [Email], [Miles], [Password], [CreditCardNumber], [SecurityCode]) VALUES (7, N'Rahmatullah', N'Ahmed', N'(04) 552-6637', N'PO Box 2282', N'Dubai', N'Dubai', NULL, N'UAE', NULL, NULL, NULL, N'nsyhbdgp', 3.3399555438058E+15, 578)
INSERT [dbo].[Customer] ([CustomerID], [Lname], [Fname], [Phone], [Address], [City], [Region], [PostalCode], [Country], [Fax], [Email], [Miles], [Password], [CreditCardNumber], [SecurityCode]) VALUES (8, N'Stearn', N'Andrew', N'(06) 233-4873', N'PO Box 2283', N'Sharjah', N'Sharjah', NULL, N'UAE', NULL, NULL, NULL, N'lcxmztia', 7.79328642913228E+15, 965)
INSERT [dbo].[Customer] ([CustomerID], [Lname], [Fname], [Phone], [Address], [City], [Region], [PostalCode], [Country], [Fax], [Email], [Miles], [Password], [CreditCardNumber], [SecurityCode]) VALUES (9, N'Al Kamil', N'Saeed', N'(04) 221-3256', N'PO Box 4352', N'Dubai', N'Dubai', NULL, N'UAE', NULL, NULL, NULL, N'qbhkmjep', 6.73424642143933E+15, 160)
INSERT [dbo].[Customer] ([CustomerID], [Lname], [Fname], [Phone], [Address], [City], [Region], [PostalCode], [Country], [Fax], [Email], [Miles], [Password], [CreditCardNumber], [SecurityCode]) VALUES (10, N'Smith', N'Rebecca', N'USA (619) 555-3066', N'456 Breezewood Ave.', N'San Diego', N'CA', N'92111', N'USA', NULL, NULL, NULL, N'vknzfsfa', 4.68138849740752E+15, 630)
INSERT [dbo].[Customer] ([CustomerID], [Lname], [Fname], [Phone], [Address], [City], [Region], [PostalCode], [Country], [Fax], [Email], [Miles], [Password], [CreditCardNumber], [SecurityCode]) VALUES (11, N'Gallanagh', N'Margaret', N'(04) 552-7474', N'PO Box 338', N'Dubai', N'Dubai', NULL, N'UAE', NULL, NULL, NULL, N'awghetqp', 2.47134464331324E+15, 975)
INSERT [dbo].[Customer] ([CustomerID], [Lname], [Fname], [Phone], [Address], [City], [Region], [PostalCode], [Country], [Fax], [Email], [Miles], [Password], [CreditCardNumber], [SecurityCode]) VALUES (12, N'Rodas', N'Mario', N'(06) 553-3526', N'PO Box 2289', N'Sharjah', N'Sharjah', NULL, N'UAE', NULL, N'mrodas@hotmail.com', NULL, N'gdpnrcby', 6.14697571135938E+15, 306)
INSERT [dbo].[Customer] ([CustomerID], [Lname], [Fname], [Phone], [Address], [City], [Region], [PostalCode], [Country], [Fax], [Email], [Miles], [Password], [CreditCardNumber], [SecurityCode]) VALUES (13, N'Morales', N'Martin', N'(04) 229-3332', N'PO Box 7659', N'Dubai', N'Dubai', NULL, N'UAE', NULL, NULL, NULL, N'qtoqyziv', 5.74931824742567E+15, 791)
INSERT [dbo].[Customer] ([CustomerID], [Lname], [Fname], [Phone], [Address], [City], [Region], [PostalCode], [Country], [Fax], [Email], [Miles], [Password], [CreditCardNumber], [SecurityCode]) VALUES (14, N'Lindsay', N'Bruce', N'(04) 213-3485', N'PO Box 43442', N'Dubai', N'Dubai', NULL, N'UAE', NULL, NULL, NULL, N'punwwotu', 4.54635777936409E+15, 152)
INSERT [dbo].[Customer] ([CustomerID], [Lname], [Fname], [Phone], [Address], [City], [Region], [PostalCode], [Country], [Fax], [Email], [Miles], [Password], [CreditCardNumber], [SecurityCode]) VALUES (15, N'Amin', N'Ahmed', N'(06) 443-2523', N'PO Box 2872', N'Sharjah', N'Sharjah', NULL, N'UAE', NULL, NULL, NULL, N'glfbsjpb', 4.42611165623634E+15, 624)
INSERT [dbo].[Customer] ([CustomerID], [Lname], [Fname], [Phone], [Address], [City], [Region], [PostalCode], [Country], [Fax], [Email], [Miles], [Password], [CreditCardNumber], [SecurityCode]) VALUES (16, N'Al Kousi', N'Muhammad', N'(04) 766-3245', N'PO Box 2382', N'Dubai', N'Dubai', NULL, N'UAE', NULL, NULL, NULL, N'kithyrmv', 8.78018005016291E+15, 238)
INSERT [dbo].[Customer] ([CustomerID], [Lname], [Fname], [Phone], [Address], [City], [Region], [PostalCode], [Country], [Fax], [Email], [Miles], [Password], [CreditCardNumber], [SecurityCode]) VALUES (17, N'Dodsworth', N'Annabella', N'(04) 747-3467', N'PO Box 2736', N'Dubai', N'Dubai', NULL, N'UAE', NULL, NULL, NULL, N'lqzsvtvp', 8.83377823447375E+15, 748)
INSERT [dbo].[Customer] ([CustomerID], [Lname], [Fname], [Phone], [Address], [City], [Region], [PostalCode], [Country], [Fax], [Email], [Miles], [Password], [CreditCardNumber], [SecurityCode]) VALUES (18, N'Herron', N'Tom', N'(04) 243-3343', N'PO Box 4644', N'Dubai', N'Dubai', NULL, N'UAE', NULL, NULL, NULL, N'zdknpuvk', 4.73969179105183E+15, 177)
INSERT [dbo].[Customer] ([CustomerID], [Lname], [Fname], [Phone], [Address], [City], [Region], [PostalCode], [Country], [Fax], [Email], [Miles], [Password], [CreditCardNumber], [SecurityCode]) VALUES (19, N'MacIntyre', N'Roberta', N'(04) 233-3478', N'PO Box 2762', N'Dubai', N'Dubai', NULL, N'UAE', NULL, NULL, NULL, N'slvofiwv', 1.30226121618256E+15, 298)
INSERT [dbo].[Customer] ([CustomerID], [Lname], [Fname], [Phone], [Address], [City], [Region], [PostalCode], [Country], [Fax], [Email], [Miles], [Password], [CreditCardNumber], [SecurityCode]) VALUES (20, N'Al Houssaini', N'Noura', N'(06) 146-3984', N'PO Box 2329', N'Sharjah', N'Sharjah', NULL, N'UAE', NULL, NULL, NULL, N'zaccgbun', 9.39134704472321E+15, 232)
INSERT [dbo].[Customer] ([CustomerID], [Lname], [Fname], [Phone], [Address], [City], [Region], [PostalCode], [Country], [Fax], [Email], [Miles], [Password], [CreditCardNumber], [SecurityCode]) VALUES (21, N'Carter', N'Dale', NULL, N'23 Tsawassen Blvd.', N'Tsawassen', N'British Columbia', NULL, N'Canada', NULL, N'dalec@hotmail.com', NULL, N'bkemdlnd', 8.64184391159634E+15, 777)
INSERT [dbo].[Customer] ([CustomerID], [Lname], [Fname], [Phone], [Address], [City], [Region], [PostalCode], [Country], [Fax], [Email], [Miles], [Password], [CreditCardNumber], [SecurityCode]) VALUES (22, N'LeClair', N'John', N'(04) 652-7253', N'PO Box 5538', N'Dubai', N'Dubai', NULL, N'UAE', NULL, NULL, NULL, N'jwugdhuf', 1.12613939506999E+15, 917)
INSERT [dbo].[Customer] ([CustomerID], [Lname], [Fname], [Phone], [Address], [City], [Region], [PostalCode], [Country], [Fax], [Email], [Miles], [Password], [CreditCardNumber], [SecurityCode]) VALUES (23, N'Karam', N'Sameera', N'(06) 664-7654', N'PO Box 3576', N'Sharjah', N'Sharjah', NULL, N'UAE', NULL, NULL, NULL, N'ehzrnuad', 5.76211636723849E+15, 894)
INSERT [dbo].[Customer] ([CustomerID], [Lname], [Fname], [Phone], [Address], [City], [Region], [PostalCode], [Country], [Fax], [Email], [Miles], [Password], [CreditCardNumber], [SecurityCode]) VALUES (24, N'Foster', N'Michael', N'(04) 324-3274', N'PO Box 2847', N'Dubai', N'Dubai', NULL, N'UAE', NULL, NULL, NULL, N'pjtbdzoh', 6.22772312506855E+15, 215)
INSERT [dbo].[Customer] ([CustomerID], [Lname], [Fname], [Phone], [Address], [City], [Region], [PostalCode], [Country], [Fax], [Email], [Miles], [Password], [CreditCardNumber], [SecurityCode]) VALUES (25, N'Hernandez', N'Jim', N'(050) 334-8838', N'PO Box 2376', N'Dubai', N'Dubai', NULL, N'UAE', NULL, NULL, NULL, N'yinfycyu', 1.07753199898167E+15, 865)
INSERT [dbo].[Customer] ([CustomerID], [Lname], [Fname], [Phone], [Address], [City], [Region], [PostalCode], [Country], [Fax], [Email], [Miles], [Password], [CreditCardNumber], [SecurityCode]) VALUES (26, N'AlNuaimi', N'Naila', N'(06) 552-7437', N'PO Box 8746', N'Sharjah', N'Sharjah', NULL, N'UAE', N'(06) 763-6323', NULL, NULL, N'qwbbxjnq', 9.88376434233916E+15, 668)
INSERT [dbo].[Customer] ([CustomerID], [Lname], [Fname], [Phone], [Address], [City], [Region], [PostalCode], [Country], [Fax], [Email], [Miles], [Password], [CreditCardNumber], [SecurityCode]) VALUES (27, N'Novak', N'Brett', N'(04) 662-7537', N'PO Box 2367', N'Dubai', N'Dubai', NULL, N'UAE', NULL, NULL, NULL, N'zjmitgkm', 8.16071298790875E+15, 112)
INSERT [dbo].[Customer] ([CustomerID], [Lname], [Fname], [Phone], [Address], [City], [Region], [PostalCode], [Country], [Fax], [Email], [Miles], [Password], [CreditCardNumber], [SecurityCode]) VALUES (28, N'Pisa', N'Terri', N'(04) 287-3848', N'PO Box 2744', N'Dubai', N'Dubai', NULL, N'UAE', NULL, NULL, NULL, N'mzsbgbhy', 4.22765771724287E+15, 290)
INSERT [dbo].[Customer] ([CustomerID], [Lname], [Fname], [Phone], [Address], [City], [Region], [PostalCode], [Country], [Fax], [Email], [Miles], [Password], [CreditCardNumber], [SecurityCode]) VALUES (29, N'Tarrant', N'Harvey', N'(04) 765-7469', N'PO Box 2872', N'Dubai', N'Dubai', NULL, N'UAE', NULL, NULL, NULL, N'yrsprtts', 9.88097163813166E+15, 563)
INSERT [dbo].[Customer] ([CustomerID], [Lname], [Fname], [Phone], [Address], [City], [Region], [PostalCode], [Country], [Fax], [Email], [Miles], [Password], [CreditCardNumber], [SecurityCode]) VALUES (30, N'Kumar', N'Rajesh', N'(04) 546-8490', N'PO Box 3910', N'Dubai', N'Dubai', NULL, N'UAE', NULL, NULL, NULL, N'icetzadh', 2.84318413258573E+15, 625)
INSERT [dbo].[Customer] ([CustomerID], [Lname], [Fname], [Phone], [Address], [City], [Region], [PostalCode], [Country], [Fax], [Email], [Miles], [Password], [CreditCardNumber], [SecurityCode]) VALUES (31, N'Al Hamour', N'Ghanima', N'(04) 554-7878', N'PO Box 2764', N'Dubai', N'Dubai', NULL, N'UAE', NULL, NULL, NULL, N'bheofiad', 5.83947798398676E+15, 690)
INSERT [dbo].[Customer] ([CustomerID], [Lname], [Fname], [Phone], [Address], [City], [Region], [PostalCode], [Country], [Fax], [Email], [Miles], [Password], [CreditCardNumber], [SecurityCode]) VALUES (32, N'Gordon-Miller', N'Barbara', N'(06) 668-5553', N'PO Box 2837', N'Sharjah', N'Sharjah', NULL, N'UAE', NULL, NULL, NULL, N'ytwodjux', 9.33346757379192E+15, 249)
INSERT [dbo].[Customer] ([CustomerID], [Lname], [Fname], [Phone], [Address], [City], [Region], [PostalCode], [Country], [Fax], [Email], [Miles], [Password], [CreditCardNumber], [SecurityCode]) VALUES (33, N'Valerio', N'Nina', N'(04) 664-8829', N'PO Box 4590', N'Dubai', N'Dubai', NULL, N'UAE', N'(04) 729-8789', NULL, NULL, N'kezfojal', 9.55235578748582E+15, 972)
INSERT [dbo].[Customer] ([CustomerID], [Lname], [Fname], [Phone], [Address], [City], [Region], [PostalCode], [Country], [Fax], [Email], [Miles], [Password], [CreditCardNumber], [SecurityCode]) VALUES (34, N'Raj', N'Rajagopalan', N'(04) 773-7546', N'PO Box 4421', N'Dubai', N'Dubai', NULL, N'UAE', NULL, NULL, NULL, N'mufnimsm', 3.29341777649366E+15, 206)
INSERT [dbo].[Customer] ([CustomerID], [Lname], [Fname], [Phone], [Address], [City], [Region], [PostalCode], [Country], [Fax], [Email], [Miles], [Password], [CreditCardNumber], [SecurityCode]) VALUES (35, N'Malone', N'Henry', N'(04) 551-8726', N'PO Box 7658', N'Dubai', N'Dubai', NULL, N'UAE', NULL, NULL, NULL, N'olcclpin', 7.03253613185644E+15, 467)
INSERT [dbo].[Customer] ([CustomerID], [Lname], [Fname], [Phone], [Address], [City], [Region], [PostalCode], [Country], [Fax], [Email], [Miles], [Password], [CreditCardNumber], [SecurityCode]) VALUES (36, N'Kurtz', N'Barry', N'(04) 762-8732', N'PO Box 2778', N'Dubai', N'Dubai', NULL, N'UAE', NULL, NULL, NULL, N'tejnnlgt', 7.09894661146983E+15, 398)
INSERT [dbo].[Customer] ([CustomerID], [Lname], [Fname], [Phone], [Address], [City], [Region], [PostalCode], [Country], [Fax], [Email], [Miles], [Password], [CreditCardNumber], [SecurityCode]) VALUES (37, N'Dolan', N'Tamarra', N'(04) 627-8946', N'PO Box 2674', N'Dubai', N'Dubai', NULL, N'UAE', NULL, NULL, NULL, N'zyirxeij', 7.33526653244202E+15, 899)
INSERT [dbo].[Customer] ([CustomerID], [Lname], [Fname], [Phone], [Address], [City], [Region], [PostalCode], [Country], [Fax], [Email], [Miles], [Password], [CreditCardNumber], [SecurityCode]) VALUES (38, N'Leverling', N'Janice', N'(03) 784-8474', N'PO Box 2873', N'Al Ain', N'Al Ain', NULL, N'UAE', NULL, NULL, NULL, N'qfsmwuot', 8.05164035379262E+15, 719)
INSERT [dbo].[Customer] ([CustomerID], [Lname], [Fname], [Phone], [Address], [City], [Region], [PostalCode], [Country], [Fax], [Email], [Miles], [Password], [CreditCardNumber], [SecurityCode]) VALUES (39, N'Al Hussaini', N'Hassan', N'(04) 770-7889', N'PO Box 2378', N'Dubai', N'Dubai', NULL, N'UAE', NULL, NULL, NULL, N'pqyrcnrk', 3.07743522755279E+15, 283)
INSERT [dbo].[Customer] ([CustomerID], [Lname], [Fname], [Phone], [Address], [City], [Region], [PostalCode], [Country], [Fax], [Email], [Miles], [Password], [CreditCardNumber], [SecurityCode]) VALUES (40, N'Wright', N'John', N'(04) 483-3760', N'PO Box 263', N'Dubai', N'Dubai', NULL, N'UAE', NULL, NULL, NULL, N'lnmesdav', 9.98767971014403E+15, 254)
INSERT [dbo].[Customer] ([CustomerID], [Lname], [Fname], [Phone], [Address], [City], [Region], [PostalCode], [Country], [Fax], [Email], [Miles], [Password], [CreditCardNumber], [SecurityCode]) VALUES (41, N'Davidson', N'Paula', N'(04) 557-7739', N'PO Box 6798', N'Dubai', N'Dubai', NULL, N'UAE', NULL, NULL, NULL, N'mghbkock', 7.79751012777876E+15, 245)
INSERT [dbo].[Customer] ([CustomerID], [Lname], [Fname], [Phone], [Address], [City], [Region], [PostalCode], [Country], [Fax], [Email], [Miles], [Password], [CreditCardNumber], [SecurityCode]) VALUES (42, N'Mahesh', N'Darukhanawalla', N'(06) 742-8237', N'PO Box 8230', N'Sharjah', N'Sharjah', NULL, N'UAE', NULL, NULL, NULL, N'osjbthmm', 1.71862362973948E+15, 157)
INSERT [dbo].[Customer] ([CustomerID], [Lname], [Fname], [Phone], [Address], [City], [Region], [PostalCode], [Country], [Fax], [Email], [Miles], [Password], [CreditCardNumber], [SecurityCode]) VALUES (43, N'Seifferd', N'Connie', N'(04) 987-8787', N'PO Box 2790', N'Dubai', N'Dubai', NULL, N'UAE', NULL, NULL, NULL, N'mvyprfit', 5.6449496912078E+15, 779)
INSERT [dbo].[Customer] ([CustomerID], [Lname], [Fname], [Phone], [Address], [City], [Region], [PostalCode], [Country], [Fax], [Email], [Miles], [Password], [CreditCardNumber], [SecurityCode]) VALUES (44, N'Bernstein', N'Beverly', N'(04) 677-2837', N'PO Box 8740', N'Dubai', N'Dubai', NULL, N'UAE', NULL, N'bevb@emirates.net.ae', NULL, N'qjqkrobv', 8.24918765820588E+15, 855)
INSERT [dbo].[Customer] ([CustomerID], [Lname], [Fname], [Phone], [Address], [City], [Region], [PostalCode], [Country], [Fax], [Email], [Miles], [Password], [CreditCardNumber], [SecurityCode]) VALUES (45, N'Albert', N'Joseph', N'(04) 661-8723', N'PO Box 8734', N'Dubai', N'Dubai', NULL, N'UAE', NULL, NULL, NULL, N'cnxyhcgz', 7.44285306344221E+15, 763)
INSERT [dbo].[Customer] ([CustomerID], [Lname], [Fname], [Phone], [Address], [City], [Region], [PostalCode], [Country], [Fax], [Email], [Miles], [Password], [CreditCardNumber], [SecurityCode]) VALUES (46, N'Rajendran', N'Nileshwar', N'(04) 748-8734', N'PO Box 2799', N'Dubai', N'Dubai', NULL, N'UAE', NULL, N'rajen@emirates.net.ae', NULL, N'xlyhgmyr', 6.88447805226172E+15, 617)
INSERT [dbo].[Customer] ([CustomerID], [Lname], [Fname], [Phone], [Address], [City], [Region], [PostalCode], [Country], [Fax], [Email], [Miles], [Password], [CreditCardNumber], [SecurityCode]) VALUES (47, N'Ting', N'Jennifer', N'(04) 783-6784', N'PO Box 3879', N'Dubai', N'Dubai', NULL, N'UAE', NULL, NULL, NULL, N'hdgkvyps', 8.76720799014216E+15, 507)
INSERT [dbo].[Customer] ([CustomerID], [Lname], [Fname], [Phone], [Address], [City], [Region], [PostalCode], [Country], [Fax], [Email], [Miles], [Password], [CreditCardNumber], [SecurityCode]) VALUES (48, N'Sprouter', N'Bruce', N'(06) 678-6789', N'PO Box 87999', N'Sharjah', N'Sharjah', NULL, N'UAE', NULL, NULL, NULL, N'tfpgthjv', 6.19514762304274E+15, 879)
INSERT [dbo].[Customer] ([CustomerID], [Lname], [Fname], [Phone], [Address], [City], [Region], [PostalCode], [Country], [Fax], [Email], [Miles], [Password], [CreditCardNumber], [SecurityCode]) VALUES (49, N'Al Rumaithi', N'Reem', N'(04) 662-8891', N'PO Box 7898', N'Dubai', N'Dubai', NULL, N'UAE', NULL, NULL, NULL, N'wpkjfedz', 1.27154925149363E+15, 297)
INSERT [dbo].[Customer] ([CustomerID], [Lname], [Fname], [Phone], [Address], [City], [Region], [PostalCode], [Country], [Fax], [Email], [Miles], [Password], [CreditCardNumber], [SecurityCode]) VALUES (50, N'Al Omaira', N'Khalifa', N'(04) 555-7891', N'PO Box 5900', N'Dubai', N'Dubai', NULL, N'UAE', NULL, NULL, NULL, N'hvnshgdl', 6.31254962144134E+15, 849)
SET IDENTITY_INSERT [dbo].[Customer] OFF
/****** Object:  Table [dbo].[Aircraft]    Script Date: 04/25/2017 13:13:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Aircraft](
	[AircraftID] [int] IDENTITY(1,1) NOT NULL,
	[Model] [nvarchar](255) NULL,
	[Manufacturer] [nvarchar](255) NULL,
	[BusinessCapacity] [int] NULL,
	[EconomyCapacity] [int] NULL,
 CONSTRAINT [aaaaaAircraft_PK] PRIMARY KEY NONCLUSTERED 
(
	[AircraftID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'AircraftID'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'AircraftID'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'AircraftID'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'17' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'AircraftID'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'AircraftID'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'AircraftID'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'AircraftID'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'AircraftID'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'AircraftID'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'AircraftID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'AircraftID'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'AircraftID'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'AircraftID'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'AircraftID'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'AircraftID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'AircraftID'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Aircraft' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'AircraftID'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'AircraftID'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'AircraftID'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'Model'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'Model'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'Model'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'Model'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'Model'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'Model'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'Model'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'Model'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'Model'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'Model'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'Model'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'Model'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Model' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'Model'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'Model'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'Model'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'Model'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Model' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'Model'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Aircraft' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'Model'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'Model'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'Model'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'Model'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'Manufacturer'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'Manufacturer'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'Manufacturer'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'Manufacturer'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'Manufacturer'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'Manufacturer'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'Manufacturer'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'Manufacturer'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'Manufacturer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'Manufacturer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'Manufacturer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'Manufacturer'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Manufacturer' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'Manufacturer'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'Manufacturer'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'Manufacturer'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'Manufacturer'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Manufacturer' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'Manufacturer'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Aircraft' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'Manufacturer'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'Manufacturer'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'Manufacturer'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'Manufacturer'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'BusinessCapacity'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'BusinessCapacity'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'BusinessCapacity'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'BusinessCapacity'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'BusinessCapacity'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'BusinessCapacity'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'BusinessCapacity'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'BusinessCapacity'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'BusinessCapacity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'BusinessCapacity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'BusinessCapacity'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'BusinessCapacity' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'BusinessCapacity'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'BusinessCapacity'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'BusinessCapacity'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'BusinessCapacity'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'BusinessCapacity' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'BusinessCapacity'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Aircraft' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'BusinessCapacity'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'BusinessCapacity'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'BusinessCapacity'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'EconomyCapacity'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'EconomyCapacity'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'EconomyCapacity'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'EconomyCapacity'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'EconomyCapacity'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'EconomyCapacity'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'EconomyCapacity'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'EconomyCapacity'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'EconomyCapacity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'EconomyCapacity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'EconomyCapacity'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'EconomyCapacity' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'EconomyCapacity'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'EconomyCapacity'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'EconomyCapacity'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'EconomyCapacity'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'EconomyCapacity' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'EconomyCapacity'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Aircraft' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'EconomyCapacity'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'EconomyCapacity'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft', @level2type=N'COLUMN',@level2name=N'EconomyCapacity'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft'
GO
EXEC sys.sp_addextendedproperty @name=N'DateCreated', @value=N'16/02/2014 10:02:34 a.m.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft'
GO
EXEC sys.sp_addextendedproperty @name=N'DisplayViewsOnSharePointSite', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft'
GO
EXEC sys.sp_addextendedproperty @name=N'FilterOnLoad', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft'
GO
EXEC sys.sp_addextendedproperty @name=N'HideNewField', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft'
GO
EXEC sys.sp_addextendedproperty @name=N'LastUpdated', @value=N'7/05/2014 8:06:30 a.m.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Aircraft' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft'
GO
EXEC sys.sp_addextendedproperty @name=N'OrderByOnLoad', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft'
GO
EXEC sys.sp_addextendedproperty @name=N'RecordCount', @value=N'25' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft'
GO
EXEC sys.sp_addextendedproperty @name=N'TotalsRow', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft'
GO
EXEC sys.sp_addextendedproperty @name=N'Updatable', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Aircraft'
GO
SET IDENTITY_INSERT [dbo].[Aircraft] ON
INSERT [dbo].[Aircraft] ([AircraftID], [Model], [Manufacturer], [BusinessCapacity], [EconomyCapacity]) VALUES (1, N'A300', N'Airbus', 20, 120)
INSERT [dbo].[Aircraft] ([AircraftID], [Model], [Manufacturer], [BusinessCapacity], [EconomyCapacity]) VALUES (2, N'A310', N'Airbus', 24, 140)
INSERT [dbo].[Aircraft] ([AircraftID], [Model], [Manufacturer], [BusinessCapacity], [EconomyCapacity]) VALUES (3, N'A320', N'Airbus', 30, 160)
INSERT [dbo].[Aircraft] ([AircraftID], [Model], [Manufacturer], [BusinessCapacity], [EconomyCapacity]) VALUES (4, N'A321', N'Airbus', 36, 180)
INSERT [dbo].[Aircraft] ([AircraftID], [Model], [Manufacturer], [BusinessCapacity], [EconomyCapacity]) VALUES (5, N'A330', N'Airbus', 44, 200)
INSERT [dbo].[Aircraft] ([AircraftID], [Model], [Manufacturer], [BusinessCapacity], [EconomyCapacity]) VALUES (6, N'A340', N'Airbus', 48, 220)
INSERT [dbo].[Aircraft] ([AircraftID], [Model], [Manufacturer], [BusinessCapacity], [EconomyCapacity]) VALUES (7, N'AT42', NULL, 24, 120)
INSERT [dbo].[Aircraft] ([AircraftID], [Model], [Manufacturer], [BusinessCapacity], [EconomyCapacity]) VALUES (8, N'AT72', NULL, 30, 128)
INSERT [dbo].[Aircraft] ([AircraftID], [Model], [Manufacturer], [BusinessCapacity], [EconomyCapacity]) VALUES (9, N'B575', N'Boeing', 32, 100)
INSERT [dbo].[Aircraft] ([AircraftID], [Model], [Manufacturer], [BusinessCapacity], [EconomyCapacity]) VALUES (10, N'B707', N'Boeing', 36, 130)
INSERT [dbo].[Aircraft] ([AircraftID], [Model], [Manufacturer], [BusinessCapacity], [EconomyCapacity]) VALUES (11, N'B727', N'Boeing', 30, 160)
INSERT [dbo].[Aircraft] ([AircraftID], [Model], [Manufacturer], [BusinessCapacity], [EconomyCapacity]) VALUES (12, N'B737', N'Boeing', 20, 120)
INSERT [dbo].[Aircraft] ([AircraftID], [Model], [Manufacturer], [BusinessCapacity], [EconomyCapacity]) VALUES (13, N'B747', N'Boeing', 100, 500)
INSERT [dbo].[Aircraft] ([AircraftID], [Model], [Manufacturer], [BusinessCapacity], [EconomyCapacity]) VALUES (14, N'B757', N'Boeing', 44, 180)
INSERT [dbo].[Aircraft] ([AircraftID], [Model], [Manufacturer], [BusinessCapacity], [EconomyCapacity]) VALUES (15, N'B767', N'Boeing', 34, 190)
INSERT [dbo].[Aircraft] ([AircraftID], [Model], [Manufacturer], [BusinessCapacity], [EconomyCapacity]) VALUES (16, N'B768', N'Boeing', 32, 160)
INSERT [dbo].[Aircraft] ([AircraftID], [Model], [Manufacturer], [BusinessCapacity], [EconomyCapacity]) VALUES (17, N'B777', N'Boeing', 60, 340)
INSERT [dbo].[Aircraft] ([AircraftID], [Model], [Manufacturer], [BusinessCapacity], [EconomyCapacity]) VALUES (18, N'B777+', N'Boeing', 30, 120)
INSERT [dbo].[Aircraft] ([AircraftID], [Model], [Manufacturer], [BusinessCapacity], [EconomyCapacity]) VALUES (19, N'DC10', NULL, 24, 128)
INSERT [dbo].[Aircraft] ([AircraftID], [Model], [Manufacturer], [BusinessCapacity], [EconomyCapacity]) VALUES (20, N'EQV', NULL, 30, 120)
INSERT [dbo].[Aircraft] ([AircraftID], [Model], [Manufacturer], [BusinessCapacity], [EconomyCapacity]) VALUES (21, N'IL86', N'Ilyushin', 20, 128)
INSERT [dbo].[Aircraft] ([AircraftID], [Model], [Manufacturer], [BusinessCapacity], [EconomyCapacity]) VALUES (22, N'L101', NULL, 24, 120)
INSERT [dbo].[Aircraft] ([AircraftID], [Model], [Manufacturer], [BusinessCapacity], [EconomyCapacity]) VALUES (23, N'MD90', N'McDonnell Douglas', 30, 128)
INSERT [dbo].[Aircraft] ([AircraftID], [Model], [Manufacturer], [BusinessCapacity], [EconomyCapacity]) VALUES (24, N'TU54', N'Tupolev', 20, 130)
INSERT [dbo].[Aircraft] ([AircraftID], [Model], [Manufacturer], [BusinessCapacity], [EconomyCapacity]) VALUES (25, N'YK42', NULL, 24, 130)
SET IDENTITY_INSERT [dbo].[Aircraft] OFF
/****** Object:  Table [dbo].[Flight]    Script Date: 04/25/2017 13:13:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Flight](
	[FlightID] [int] IDENTITY(1,1) NOT NULL,
	[FlightNumber] [nvarchar](10) NULL,
	[Origin] [nvarchar](25) NULL,
	[Destination] [nvarchar](25) NULL,
	[Departure] [datetime] NULL,
	[Arrival] [datetime] NULL,
	[Airline] [nvarchar](25) NULL,
	[AircraftID] [int] NULL,
	[Terminal] [nvarchar](1) NULL,
	[Stops] [nvarchar](1) NULL,
	[Fare] [money] NULL,
	[Days] [nvarchar](7) NULL,
	[Miles] [int] NULL,
 CONSTRAINT [aaaaaFlight_PK] PRIMARY KEY NONCLUSTERED 
(
	[FlightID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'FlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'FlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'FlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'17' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'FlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'FlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'FlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'FlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'FlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'FlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'Ⅴ낔㨂䀭풃묛㧯' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'FlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'FlightID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'FlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'FlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'FlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'FlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'FlightID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'FlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Flight' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'FlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'FlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'FlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'FlightNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'FlightNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'FlightNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'FlightNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'FlightNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'FlightNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'FlightNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'FlightNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'FlightNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'ﯧꔰ읁䝊ㆎ珈䭐겯' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'FlightNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'FlightNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'FlightNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'FlightNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'FlightNumber' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'FlightNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'FlightNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'FlightNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'FlightNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'FlightNumber' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'FlightNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Flight' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'FlightNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'FlightNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'FlightNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'FlightNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Origin'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Origin'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Origin'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Origin'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Origin'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Origin'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Origin'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'1620' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Origin'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Origin'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'站棣䊒Ҡ뢾꾓䷭' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Origin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Origin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Origin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Origin'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Origin' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Origin'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Origin'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Origin'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'25' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Origin'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Origin' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Origin'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Flight' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Origin'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Origin'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Origin'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Origin'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Destination'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Destination'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Destination'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Destination'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Destination'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Destination'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Destination'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'1620' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Destination'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Destination'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'⤆讃퐒䜧ﲓ�녗姑' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Destination'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Destination'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Destination'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Destination'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Destination' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Destination'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Destination'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Destination'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'25' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Destination'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Destination' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Destination'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Flight' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Destination'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Destination'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Destination'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Destination'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Departure'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Departure'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Departure'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Departure'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Departure'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Departure'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Departure'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Departure'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Departure'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'ᔎﾶ䤈톛咿鯅咎' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Departure'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=N'Short Time' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Departure'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Departure'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Departure'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Departure' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Departure'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Departure'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Departure'
GO
EXEC sys.sp_addextendedproperty @name=N'ShowDatePicker', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Departure'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Departure'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Departure' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Departure'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Flight' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Departure'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Departure'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Departure'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Arrival'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Arrival'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Arrival'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Arrival'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Arrival'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Arrival'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Arrival'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Arrival'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Arrival'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'겎墨즖乎芏皬㮝堌' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Arrival'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=N'Short Time' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Arrival'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Arrival'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Arrival'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Arrival' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Arrival'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'5' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Arrival'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Arrival'
GO
EXEC sys.sp_addextendedproperty @name=N'ShowDatePicker', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Arrival'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Arrival'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Arrival' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Arrival'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Flight' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Arrival'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Arrival'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Arrival'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Airline'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Airline'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Airline'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Airline'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Airline'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Airline'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Airline'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'2340' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Airline'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Airline'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'䗱⼐️䌕튔煑唃' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Airline'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Airline'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Airline'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Airline'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Airline' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Airline'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'6' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Airline'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Airline'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'25' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Airline'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Airline' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Airline'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Flight' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Airline'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Airline'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Airline'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Airline'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'AircraftID'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'AircraftID'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'AircraftID'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'AircraftID'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'AircraftID'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'AircraftID'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'AircraftID'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'AircraftID'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'AircraftID'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'謼恤沜例鮖迀⋍谒' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'AircraftID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'AircraftID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'AircraftID'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'AircraftID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'AircraftID'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'7' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'AircraftID'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'AircraftID'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'AircraftID'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'AircraftID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'AircraftID'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Flight' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'AircraftID'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'AircraftID'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'AircraftID'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Terminal'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Terminal'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Terminal'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Terminal'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Terminal'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Terminal'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Terminal'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Terminal'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Terminal'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'鹥鵙憬䫨麙啭豴鲅' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Terminal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Terminal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Terminal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Terminal'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Terminal' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Terminal'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Terminal'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Terminal'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Terminal'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Terminal' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Terminal'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Flight' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Terminal'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Terminal'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Terminal'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Terminal'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Stops'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Stops'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Stops'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Stops'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Stops'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Stops'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Stops'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Stops'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Stops'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'鶬燌侍₉ᑷ鴁' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Stops'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Stops'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Stops'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Stops'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Stops' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Stops'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'9' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Stops'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Stops'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Stops'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Stops' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Stops'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Flight' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Stops'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Stops'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Stops'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Stops'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Fare'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Fare'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Fare'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Fare'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Fare'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Fare'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Fare'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Fare'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Fare'
GO
EXEC sys.sp_addextendedproperty @name=N'DefaultValue', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Fare'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'骈脜�䀂䲣뼂ܥ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Fare'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Fare'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=N'£#,##0.00;-£#,##0.00' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Fare'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Fare' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Fare'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Fare'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Fare'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Fare'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Fare' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Fare'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Flight' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Fare'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Fare'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'5' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Fare'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Days'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Days'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Days'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Days'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Days'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Days'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Days'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Days'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Days'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'鎲袜橷䧤▣娳蓟' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Days'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Days'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Days'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Days'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Days' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Days'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'11' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Days'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Days'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'7' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Days'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Days' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Days'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Flight' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Days'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Days'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Days'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Days'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Miles'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Miles'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Miles'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Miles'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Miles'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Miles'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Miles'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Miles'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Miles'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'⻌愛※䒶辨�鶋값' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Miles'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Miles'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Miles'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Miles' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Miles'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'12' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Miles'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Miles'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Miles'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Miles' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Miles'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Flight' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Miles'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Miles'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight', @level2type=N'COLUMN',@level2name=N'Miles'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight'
GO
EXEC sys.sp_addextendedproperty @name=N'DateCreated', @value=N'16/02/2014 10:02:34 a.m.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight'
GO
EXEC sys.sp_addextendedproperty @name=N'DisplayViewsOnSharePointSite', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight'
GO
EXEC sys.sp_addextendedproperty @name=N'FilterOnLoad', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight'
GO
EXEC sys.sp_addextendedproperty @name=N'HideNewField', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight'
GO
EXEC sys.sp_addextendedproperty @name=N'LastUpdated', @value=N'7/05/2014 8:06:30 a.m.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Flight' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight'
GO
EXEC sys.sp_addextendedproperty @name=N'OrderByOnLoad', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight'
GO
EXEC sys.sp_addextendedproperty @name=N'RecordCount', @value=N'565' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight'
GO
EXEC sys.sp_addextendedproperty @name=N'TotalsRow', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight'
GO
EXEC sys.sp_addextendedproperty @name=N'Updatable', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Flight'
GO
SET IDENTITY_INSERT [dbo].[Flight] ON
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (1, N'EK 623', N'Tehran', N'Dubai', CAST(0xFFFFFFFE00AD08E0 AS DateTime), CAST(0xFFFFFFFE00D63BC0 AS DateTime), N'Emirates', 2, N'3', NULL, 90.0000, N'13456', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (2, N'IR 659', N'Tehran', N'Dubai', CAST(0xFFFFFFFE00C042C0 AS DateTime), CAST(0xFFFFFFFE00E6B680 AS DateTime), N'Iran Air', 11, N'1', NULL, 60.0000, N'24', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (3, N'C2 7950', N'Tehran', N'Dubai', CAST(0xFFFFFFFE00CDFE60 AS DateTime), CAST(0xFFFFFFFE00F73140 AS DateTime), N'Caspian Airlines', 25, N'2', NULL, 50.0000, N'14', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (4, N'IRM 5041', N'Tehran', N'Dubai', CAST(0xFFFFFFFE00D21D10 AS DateTime), CAST(0xFFFFFFFE00FB4FF0 AS DateTime), N'Mahan Air', 24, N'2', NULL, 40.0000, N'37', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (5, N'IR 611', N'Tehran', N'Dubai', CAST(0xFFFFFFFE010D2A40 AS DateTime), CAST(0xFFFFFFFE01339E00 AS DateTime), N'Iran Air', 13, N'1', NULL, 60.0000, N'6', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (6, N'IRQ 1115', N'Tehran', N'Dubai', CAST(0xFFFFFFFE010FE960 AS DateTime), CAST(0xFFFFFFFE0130DEE0 AS DateTime), N'Qeshm Air', 24, N'2', NULL, 40.0000, N'14', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (7, N'Y7 6853', N'Tehran', N'Dubai', CAST(0xFFFFFFFE014C5620 AS DateTime), CAST(0xFFFFFFFE0179A7B0 AS DateTime), N'Iran Assemam', 11, N'2', NULL, 45.0000, N'1234567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (8, N'EK 625', N'Tehran', N'Dubai', CAST(0xFFFFFFFE015E3070 AS DateTime), CAST(0xFFFFFFFE01876350 AS DateTime), N'Emirates', 2, N'3', NULL, 90.0000, N'27', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (9, N'IR 514', N'Tehran', N'Dubai', CAST(0xFFFFFFFE0041EB00 AS DateTime), CAST(0xFFFFFFFE006B1DE0 AS DateTime), N'Iran Air', 24, N'1', NULL, 60.0000, N'5', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (10, N'Y7 6743', N'Tehran', N'Dubai', CAST(0xFFFFFFFE006B1DE0 AS DateTime), CAST(0xFFFFFFFE0095B050 AS DateTime), N'Iran Assemam', 11, N'2', NULL, 45.0000, N'1234567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (11, N'IR 923', N'Tehran', N'Dubai', CAST(0xFFFFFFFE00B54640 AS DateTime), CAST(0xFFFFFFFE00E13840 AS DateTime), N'Iran Air', 24, N'1', NULL, 60.0000, N'4', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (12, N'IR 997', N'Tehran', N'Dubai', CAST(0xFFFFFFFE0130DEE0 AS DateTime), CAST(0xFFFFFFFE015CD0E0 AS DateTime), N'Iran Air', 24, N'1', NULL, 60.0000, N'123457', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (13, N'SR 372', N'Zurich', N'Dubai', CAST(0xFFFFFFFE00D0BD80 AS DateTime), CAST(0xFFFFFFFE018603C0 AS DateTime), N'Swissair', 5, N'1', N'1', 130.0000, N'7', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (14, N'EK 032', N'Zurich', N'Dubai', CAST(0xFFFFFFFE00F05370 AS DateTime), CAST(0xFFFFFFFE000DBBA0 AS DateTime), N'Emirates', 1, N'3', N'1', 150.0000, N'1234567', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (15, N'SR 394', N'Zurich', N'Dubai', CAST(0xFFFFFFFE00A62B10 AS DateTime), CAST(0xFFFFFFFE01391C40 AS DateTime), N'Swissair', 5, N'1', NULL, 130.0000, N'246', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (16, N'SR 376', N'Zurich', N'Dubai', CAST(0xFFFFFFFE00D0BD80 AS DateTime), CAST(0xFFFFFFFE01650E40 AS DateTime), N'Swissair', 5, N'1', NULL, 130.0000, N'5', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (17, N'SR 398', N'Zurich', N'Dubai', CAST(0xFFFFFFFE00D0BD80 AS DateTime), CAST(0xFFFFFFFE01650E40 AS DateTime), N'Swissair', 5, N'1', NULL, 130.0000, N'13', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (18, N'Y7 6744', N'Dubai', N'Tehran', CAST(0xFFFFFFFE00EEF3E0 AS DateTime), CAST(0xFFFFFFFE011826C0 AS DateTime), N'Iran Assemam', 11, N'2', NULL, 45.0000, N'246', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (19, N'IR 658', N'Dubai', N'Tehran', CAST(0xFFFFFFFE00F73140 AS DateTime), CAST(0xFFFFFFFE01206420 AS DateTime), N'Iran Air', 10, N'1', NULL, 60.0000, N'24', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (20, N'Y7 6744', N'Dubai', N'Tehran', CAST(0xFFFFFFFE00F73140 AS DateTime), CAST(0xFFFFFFFE011F0490 AS DateTime), N'Iran Assemam', 11, N'2', NULL, 45.0000, N'136', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (21, N'IRM 5040', N'Dubai', N'Tehran', CAST(0xFFFFFFFE010BCAB0 AS DateTime), CAST(0xFFFFFFFE0134FD90 AS DateTime), N'Mahan Air', 24, N'2', NULL, 40.0000, N'457', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (22, N'C2 7940', N'Dubai', N'Tehran', CAST(0xFFFFFFFE010FE960 AS DateTime), CAST(0xFFFFFFFE01391C40 AS DateTime), N'Caspian Airlines', 25, N'2', NULL, 50.0000, N'14', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (23, N'Y7 6744', N'Dubai', N'Tehran', CAST(0xFFFFFFFE011826C0 AS DateTime), CAST(0xFFFFFFFE014159A0 AS DateTime), N'Iran Assemam', 11, N'2', NULL, 45.0000, N'5', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (24, N'IRM 5037', N'Dubai', N'Tehran', CAST(0xFFFFFFFE01206420 AS DateTime), CAST(0xFFFFFFFE01391C40 AS DateTime), N'Mahan Air', 24, N'2', NULL, 40.0000, N'26', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (25, N'EK 624', N'Dubai', N'Tehran', CAST(0xFFFFFFFE012CC030 AS DateTime), CAST(0xFFFFFFFE0155F310 AS DateTime), N'Emirates', 2, N'3', NULL, 90.0000, N'27', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (26, N'IRQ 1114', N'Dubai', N'Tehran', CAST(0xFFFFFFFE01391C40 AS DateTime), CAST(0xFFFFFFFE01650E40 AS DateTime), N'Qeshm Air', 24, N'2', NULL, 40.0000, N'14', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (27, N'Y7 6754', N'Dubai', N'Tehran', CAST(0xFFFFFFFE018A2270 AS DateTime), CAST(0xFFFFFFFE0027D350 AS DateTime), N'Iran Assemam', 11, N'2', NULL, 45.0000, N'1234567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (28, N'EK 622', N'Dubai', N'Tehran', CAST(0xFFFFFFFE007B98A0 AS DateTime), CAST(0xFFFFFFFE00A4CB80 AS DateTime), N'Emirates', 2, N'3', NULL, 90.0000, N'13456', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (29, N'IR 610', N'Dubai', N'Tehran', CAST(0xFFFFFFFE008C1360 AS DateTime), CAST(0xFFFFFFFE00B54640 AS DateTime), N'Iran Air', 13, N'1', NULL, 60.0000, N'1', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (30, N'IR 515', N'Dubai', N'Tehran', CAST(0xFFFFFFFE0146D7E0 AS DateTime), CAST(0xFFFFFFFE015F9000 AS DateTime), N'Iran Air', 24, N'1', NULL, 60.0000, N'6', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (31, N'IR 922', N'Dubai', N'Tehran', CAST(0xFFFFFFFE014F1540 AS DateTime), CAST(0xFFFFFFFE016A8C80 AS DateTime), N'Iran Air', 24, N'1', NULL, 60.0000, N'7', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (32, N'IR 996', N'Dubai', N'Tehran', CAST(0xFFFFFFFE016D4BA0 AS DateTime), CAST(0xFFFFFFFE0188C2E0 AS DateTime), N'Iran Air', 24, N'1', NULL, 60.0000, N'123457', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (33, N'SR 373', N'Dubai', N'Zurich', CAST(0xFFFFFFFE000F1B30 AS DateTime), CAST(0xFFFFFFFE0069BE50 AS DateTime), N'Swissair', 5, N'1', N'1', 130.0000, N'1', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (34, N'SR 377', N'Dubai', N'Zurich', CAST(0xFFFFFFFE002932E0 AS DateTime), CAST(0xFFFFFFFE00685EC0 AS DateTime), N'Swissair', 5, N'1', NULL, 130.0000, N'6', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (35, N'SR 395', N'Dubai', N'Zurich', CAST(0xFFFFFFFE002932E0 AS DateTime), CAST(0xFFFFFFFE00685EC0 AS DateTime), N'Swissair', 5, N'1', NULL, 130.0000, N'357', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (36, N'SR 399', N'Dubai', N'Zurich', CAST(0xFFFFFFFE002932E0 AS DateTime), CAST(0xFFFFFFFE00685EC0 AS DateTime), N'Swissair', 5, N'1', NULL, 130.0000, N'24', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (37, N'EK 031', N'Dubai', N'Zurich', CAST(0xFFFFFFFE006DDD00 AS DateTime), CAST(0xFFFFFFFE00DA5A70 AS DateTime), N'Emirates', 2, N'3', N'1', 150.0000, N'4', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (38, N'EK 031', N'Dubai', N'Zurich', CAST(0xFFFFFFFE00735B40 AS DateTime), CAST(0xFFFFFFFE00DA5A70 AS DateTime), N'Emirates', 2, N'3', N'1', 150.0000, N'123567', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (39, N'LH 632', N'Frankfurt', N'Dubai', CAST(0xFFFFFFFE00E13840 AS DateTime), CAST(0xFFFFFFFE01692CF0 AS DateTime), N'Lufthansa', 6, N'1', NULL, 140.0000, N'1234567', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (40, N'EK 016', N'Frankfurt', N'Dubai', CAST(0xFFFFFFFE00FB4FF0 AS DateTime), CAST(0xFFFFFFFE018344A0 AS DateTime), N'Emirates', 1, N'3', NULL, 150.0000, N'1234567', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (41, N'RA 230', N'Frankfurt', N'Dubai', CAST(0xFFFFFFFE010FE960 AS DateTime), CAST(0xFFFFFFFE002932E0 AS DateTime), N'Royal Nepal', 14, N'1', NULL, 110.0000, N'57', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (42, N'RA 232', N'Frankfurt', N'Dubai', CAST(0xFFFFFFFE010FE960 AS DateTime), CAST(0xFFFFFFFE002932E0 AS DateTime), N'Royal Nepal', 14, N'1', NULL, 110.0000, N'3', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (43, N'BI 034', N'Frankfurt', N'Dubai', CAST(0xFFFFFFFE00E6B680 AS DateTime), CAST(0xFFFFFFFE01808580 AS DateTime), N'Royal Brunei', 15, N'1', NULL, 120.0000, N'27', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (44, N'CX 751', N'Hong Kong', N'Dubai', CAST(0xFFFFFFFE00EC34C0 AS DateTime), CAST(0xFFFFFFFE016EAB30 AS DateTime), N'Cathay Pacific', 13, N'1', N'2', 180.0000, N'3467', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (45, N'EK 081', N'Hong Kong', N'Dubai', CAST(0xFFFFFFFE008C1360 AS DateTime), CAST(0xFFFFFFFE00DA5A70 AS DateTime), N'Emirates', 17, N'3', NULL, 200.0000, N'1246', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (46, N'CX 733', N'Hong Kong', N'Dubai', CAST(0xFFFFFFFE010E89D0 AS DateTime), CAST(0xFFFFFFFE0181E510 AS DateTime), N'Cathay Pacific', 17, N'1', N'1', 180.0000, N'27', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (47, N'CX 731', N'Hong Kong', N'Dubai', CAST(0xFFFFFFFE010FE960 AS DateTime), CAST(0xFFFFFFFE0151D460 AS DateTime), N'Cathay Pacific', 17, N'1', NULL, 180.0000, N'145', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (48, N'EK 083', N'Hong Kong', N'Dubai', CAST(0xFFFFFFFE016EAB30 AS DateTime), CAST(0xFFFFFFFE0048C8D0 AS DateTime), N'Emirates', 17, N'3', N'1', 200.0000, N'246', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (49, N'EK 462', N'Johannesburg', N'Dubai', CAST(0xFFFFFFFE011C4570 AS DateTime), CAST(0xFFFFFFFE00594390 AS DateTime), N'Emirates', 2, N'3', N'1', 240.0000, N'467', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (50, N'SA 7156', N'Johannesburg', N'Dubai', CAST(0xFFFFFFFE011C4570 AS DateTime), CAST(0xFFFFFFFE00594390 AS DateTime), N'South African Airways', 2, N'1', N'1', 220.0000, N'467', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (51, N'EK 464', N'Johannesburg', N'Dubai', CAST(0xFFFFFFFE013D3AF0 AS DateTime), CAST(0xFFFFFFFE00594390 AS DateTime), N'Emirates', 2, N'3', NULL, 240.0000, N'1235', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (52, N'SA 7158', N'Johannesburg', N'Dubai', CAST(0xFFFFFFFE013D3AF0 AS DateTime), CAST(0xFFFFFFFE00594390 AS DateTime), N'South African Airways', 2, N'1', NULL, 220.0000, N'1235', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (53, N'RA 229', N'Dubai', N'Frankfurt', CAST(0xFFFFFFFE00C5C100 AS DateTime), CAST(0xFFFFFFFE011AE5E0 AS DateTime), N'Royal Nepal', 14, N'1', NULL, 110.0000, N'57', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (54, N'RA 231', N'Dubai', N'Frankfurt', CAST(0xFFFFFFFE00C5C100 AS DateTime), CAST(0xFFFFFFFE011AE5E0 AS DateTime), N'Royal Nepal', 14, N'1', NULL, 110.0000, N'3', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (55, N'BI 033', N'Dubai', N'Frankfurt', CAST(0xFFFFFFFE00107AC0 AS DateTime), CAST(0xFFFFFFFE0062E080 AS DateTime), N'Royal Brunei', 15, N'1', NULL, 120.0000, N'27', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (56, N'BG 001', N'Dubai', N'Frankfurt', CAST(0xFFFFFFFE002932E0 AS DateTime), CAST(0xFFFFFFFE007B98A0 AS DateTime), N'Biman Bangladesh', 19, N'1', NULL, 95.0000, N'2', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (57, N'LH 633', N'Dubai', N'Frankfurt', CAST(0xFFFFFFFE005265C0 AS DateTime), CAST(0xFFFFFFFE00A4CB80 AS DateTime), N'Lufthansa', 1, N'1', NULL, 140.0000, N'1234567', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (58, N'EK 015', N'Dubai', N'Frankfurt', CAST(0xFFFFFFFE00903210 AS DateTime), CAST(0xFFFFFFFE00E297D0 AS DateTime), N'Emirates', 2, N'3', NULL, 150.0000, N'1234567', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (59, N'CX 730', N'Dubai', N'Hong Kong', CAST(0xFFFFFFFE01650E40 AS DateTime), CAST(0xFFFFFFFE00C5C100 AS DateTime), N'Cathay Pacific', 17, N'1', N'1', 180.0000, N'145', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (60, N'CX 732', N'Dubai', N'Hong Kong', CAST(0xFFFFFFFE0006DDD0 AS DateTime), CAST(0xFFFFFFFE00CB3F40 AS DateTime), N'Cathay Pacific', 17, N'1', NULL, 180.0000, N'13', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (61, N'EK 082', N'Dubai', N'Hong Kong', CAST(0xFFFFFFFE00358EF0 AS DateTime), CAST(0xFFFFFFFE0116C730 AS DateTime), N'Emirates', 17, N'3', N'1', 200.0000, N'246', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (62, N'EK 080', N'Dubai', N'Hong Kong', CAST(0xFFFFFFFE008C1360 AS DateTime), CAST(0xFFFFFFFE013FFA10 AS DateTime), N'Emirates', 17, N'3', NULL, 200.0000, N'1357', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (63, N'CX 750', N'Dubai', N'Hong Kong', CAST(0xFFFFFFFE018A2270 AS DateTime), CAST(0xFFFFFFFE00FB4FF0 AS DateTime), N'Cathay Pacific', 13, N'1', N'2', 180.0000, N'3467', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (64, N'EK 463', N'Dubai', N'Johannesburg', CAST(0xFFFFFFFE003C6CC0 AS DateTime), CAST(0xFFFFFFFE00C1A250 AS DateTime), N'Emirates', 2, N'3', N'1', 240.0000, N'146', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (65, N'EK 463', N'Dubai', N'Johannesburg', CAST(0xFFFFFFFE003C6CC0 AS DateTime), CAST(0xFFFFFFFE00A78AA0 AS DateTime), N'Emirates', 2, N'3', NULL, 240.0000, N'257', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (66, N'SA 7157', N'Dubai', N'Johannesburg', CAST(0xFFFFFFFE003C6CC0 AS DateTime), CAST(0xFFFFFFFE00C1A250 AS DateTime), N'South African Airways', 2, N'1', N'1', 220.0000, N'146', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (67, N'SA 7159', N'Dubai', N'Johannesburg', CAST(0xFFFFFFFE003C6CC0 AS DateTime), CAST(0xFFFFFFFE00A78AA0 AS DateTime), N'South African Airways', 2, N'1', NULL, 220.0000, N'257', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (68, N'EK 463', N'Dubai', N'Johannesburg', CAST(0xFFFFFFFE008ED280 AS DateTime), CAST(0xFFFFFFFE00F9F060 AS DateTime), N'Emirates', 2, N'3', NULL, 240.0000, N'3', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (69, N'SA 7159', N'Dubai', N'Johannesburg', CAST(0xFFFFFFFE008ED280 AS DateTime), CAST(0xFFFFFFFE00F9F060 AS DateTime), N'South African Airways', 2, N'1', NULL, 220.0000, N'3', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (70, N'BR 66', N'Paris', N'Dubai', CAST(0xFFFFFFFE00E297D0 AS DateTime), CAST(0xFFFFFFFE017DC660 AS DateTime), N'Eva Air', 13, N'1', NULL, 110.0000, N'146', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (71, N'EK 024', N'Paris', N'Dubai', CAST(0xFFFFFFFE00FF6EA0 AS DateTime), CAST(0xFFFFFFFE00041EB0 AS DateTime), N'Emirates', 1, N'3', NULL, 150.0000, N'357', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (72, N'AF 606', N'Paris', N'Dubai', CAST(0xFFFFFFFE00A78AA0 AS DateTime), CAST(0xFFFFFFFE014C5620 AS DateTime), N'Air France', 2, N'1', NULL, 140.0000, N'2357', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (73, N'AF 626', N'Paris', N'Dubai', CAST(0xFFFFFFFE00A78AA0 AS DateTime), CAST(0xFFFFFFFE014C5620 AS DateTime), N'Air France', 2, N'1', NULL, 140.0000, N'146', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (74, N'VN 532', N'Paris', N'Dubai', CAST(0xFFFFFFFE00CC9ED0 AS DateTime), CAST(0xFFFFFFFE016EAB30 AS DateTime), N'Vietnam Airlines', 15, N'1', NULL, 100.0000, N'257', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (75, N'VN 534', N'Paris', N'Dubai', CAST(0xFFFFFFFE00CC9ED0 AS DateTime), CAST(0xFFFFFFFE016EAB30 AS DateTime), N'Vietnam Airlines', 15, N'1', NULL, 100.0000, N'136', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (76, N'VN 533', N'Dubai', N'Paris', CAST(0xFFFFFFFE001A17B0 AS DateTime), CAST(0xFFFFFFFE0066FF30 AS DateTime), N'Vietnam Airlines', 15, N'1', NULL, 100.0000, N'257', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (77, N'VN 535', N'Dubai', N'Paris', CAST(0xFFFFFFFE001A17B0 AS DateTime), CAST(0xFFFFFFFE0066FF30 AS DateTime), N'Vietnam Airlines', 15, N'1', NULL, 100.0000, N'136', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (78, N'AF 605', N'Dubai', N'Paris', CAST(0xFFFFFFFE001CD6D0 AS DateTime), CAST(0xFFFFFFFE005EC1D0 AS DateTime), N'Air France', 2, N'1', NULL, 140.0000, N'1346', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (79, N'AF 627', N'Dubai', N'Paris', CAST(0xFFFFFFFE001CD6D0 AS DateTime), CAST(0xFFFFFFFE005EC1D0 AS DateTime), N'Air France', 2, N'1', NULL, 140.0000, N'257', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (80, N'BR 65', N'Dubai', N'Paris', CAST(0xFFFFFFFE002932E0 AS DateTime), CAST(0xFFFFFFFE007E57C0 AS DateTime), N'Eva Air', 13, N'1', NULL, 110.0000, N'146', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (81, N'EK 023', N'Dubai', N'Paris', CAST(0xFFFFFFFE0083D600 AS DateTime), CAST(0xFFFFFFFE00DBBA00 AS DateTime), N'Emirates', 1, N'3', NULL, 150.0000, N'357', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (82, N'BG 003', N'Dubai', N'Paris', CAST(0xFFFFFFFE004FA6A0 AS DateTime), CAST(0xFFFFFFFE0099CF00 AS DateTime), N'Biman Bangladesh', 19, N'1', NULL, 100.0000, N'6', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (83, N'SQ 404', N'Dubai', N'Singapore', CAST(0xFFFFFFFE016D4BA0 AS DateTime), CAST(0xFFFFFFFE002673C0 AS DateTime), N'Singapore Airlines', 17, N'1', NULL, 140.0000, N'136', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (84, N'SQ 428', N'Dubai', N'Singapore', CAST(0xFFFFFFFE016D4BA0 AS DateTime), CAST(0xFFFFFFFE002673C0 AS DateTime), N'Singapore Airlines', 17, N'1', NULL, 140.0000, N'247', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (85, N'SQ 424', N'Dubai', N'Singapore', CAST(0xFFFFFFFE00015F90 AS DateTime), CAST(0xFFFFFFFE0044AA20 AS DateTime), N'Singapore Airlines', 17, N'1', NULL, 140.0000, N'6', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (86, N'EK 077', N'Dubai', N'Singapore', CAST(0xFFFFFFFE0002BF20 AS DateTime), CAST(0xFFFFFFFE00594390 AS DateTime), N'Emirates', 17, N'3', N'1', 150.0000, N'1356', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (87, N'EK 069', N'Dubai', N'Singapore', CAST(0xFFFFFFFE002673C0 AS DateTime), CAST(0xFFFFFFFE0057E400 AS DateTime), N'Emirates', 17, N'3', NULL, 150.0000, N'1234567', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (88, N'BI 107', N'Dubai', N'Singapore', CAST(0xFFFFFFFE0128A180 AS DateTime), CAST(0xFFFFFFFE0006DDD0 AS DateTime), N'Royal Brunei', 14, N'1', N'1', 130.0000, N'36', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (89, N'BI 095', N'Dubai', N'Singapore', CAST(0xFFFFFFFE016A8C80 AS DateTime), CAST(0xFFFFFFFE00175890 AS DateTime), N'Royal Brunei', 15, N'1', NULL, 130.0000, N'4', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (90, N'SQ 403', N'Singapore', N'Dubai', CAST(0xFFFFFFFE01323E70 AS DateTime), CAST(0xFFFFFFFE0057E400 AS DateTime), N'Singapore Airlines', 17, N'1', NULL, 140.0000, N'6', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (91, N'BI 096', N'Singapore', N'Dubai', CAST(0xFFFFFFFE000DBBA0 AS DateTime), CAST(0xFFFFFFFE00C5C100 AS DateTime), N'Royal Brunei', 15, N'1', NULL, 130.0000, N'6', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (92, N'BI 108', N'Singapore', N'Dubai', CAST(0xFFFFFFFE0020F580 AS DateTime), CAST(0xFFFFFFFE0087F4B0 AS DateTime), N'Royal Brunei', 14, N'1', N'1', 130.0000, N'47', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (93, N'EK 068', N'Singapore', N'Dubai', CAST(0xFFFFFFFE002D5190 AS DateTime), CAST(0xFFFFFFFE00E6B680 AS DateTime), N'Emirates', 17, N'3', NULL, 150.0000, N'1234567', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (94, N'EK 076', N'Singapore', N'Dubai', CAST(0xFFFFFFFE0039ADA0 AS DateTime), CAST(0xFFFFFFFE01140810 AS DateTime), N'Emirates', 17, N'3', N'1', 150.0000, N'247', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (95, N'EK 076', N'Singapore', N'Dubai', CAST(0xFFFFFFFE008D72F0 AS DateTime), CAST(0xFFFFFFFE0167CD60 AS DateTime), N'Emirates', 17, N'3', N'1', 150.0000, N'5', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (96, N'SQ 403', N'Singapore', N'Dubai', CAST(0xFFFFFFFE01499700 AS DateTime), CAST(0xFFFFFFFE0071FBB0 AS DateTime), N'Singapore Airlines', 17, N'1', NULL, 140.0000, N'247', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (97, N'SQ 427', N'Singapore', N'Dubai', CAST(0xFFFFFFFE01499700 AS DateTime), CAST(0xFFFFFFFE00761A60 AS DateTime), N'Singapore Airlines', 11, N'1', NULL, 140.0000, N'135', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (98, N'OS 3331', N'Dubai', N'Vienna', CAST(0xFFFFFFFE0107AC00 AS DateTime), CAST(0xFFFFFFFE0188C2E0 AS DateTime), N'Austrian Airlines', 2, N'1', NULL, 124.0000, N'2', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (99, N'OS 3332', N'Vienna', N'Dubai', CAST(0xFFFFFFFE00F73140 AS DateTime), CAST(0xFFFFFFFE0146D7E0 AS DateTime), N'Austrian Airlines', 2, N'1', NULL, 124.0000, N'3', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (100, N'EK 944', N'Larnaca', N'Dubai', CAST(0xFFFFFFFE00B54640 AS DateTime), CAST(0xFFFFFFFE011826C0 AS DateTime), N'Emirates', 2, N'3', N'-', 120.0000, N'57', 5000)
GO
print 'Processed 100 total records'
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (101, N'RO 065', N'Larnaca', N'Dubai', CAST(0xFFFFFFFE01624F20 AS DateTime), CAST(0xFFFFFFFE000AFC80 AS DateTime), N'Tarom Romanian', 12, N'1', N'-', 90.0000, N'2', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (102, N'RO 065', N'Larnaca', N'Dubai', CAST(0xFFFFFFFE018344A0 AS DateTime), CAST(0xFFFFFFFE002BF200 AS DateTime), N'Tarom Romanian', 2, N'1', N'-', 90.0000, N'3', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (103, N'CY 382', N'Larnaca', N'Dubai', CAST(0xFFFFFFFE007779F0 AS DateTime), CAST(0xFFFFFFFE00D63BC0 AS DateTime), N'Cyprus Airways', 3, N'1', N'1', 110.0000, N'4', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (104, N'KM 836', N'Malta', N'Dubai', CAST(0xFFFFFFFE01140810 AS DateTime), CAST(0xFFFFFFFE00057E40 AS DateTime), N'Air Malta', 3, N'1', N'-', 120.0000, N'4', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (105, N'KM 840', N'Malta', N'Dubai', CAST(0xFFFFFFFE012482D0 AS DateTime), CAST(0xFFFFFFFE0015F900 AS DateTime), N'Air Malta', 3, N'1', N'-', 120.0000, N'6', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (106, N'KM 834', N'Malta', N'Dubai', CAST(0xFFFFFFFE00015F90 AS DateTime), CAST(0xFFFFFFFE008C1360 AS DateTime), N'Air Malta', 3, N'1', N'-', 120.0000, N'1', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (107, N'EK 028', N'Malta', N'Dubai', CAST(0xFFFFFFFE00EC34C0 AS DateTime), CAST(0xFFFFFFFE00057E40 AS DateTime), N'Emirates', 1, N'3', N'1', 140.0000, N'12356', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (108, N'KM 832', N'Malta', N'Dubai', CAST(0xFFFFFFFE01140810 AS DateTime), CAST(0xFFFFFFFE00057E40 AS DateTime), N'Air Malta', 3, N'1', N'-', 120.0000, N'135', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (109, N'PVV8807', N'Moscow', N'Dubai', CAST(0xFFFFFFFE00AFC800 AS DateTime), CAST(0xFFFFFFFE01140810 AS DateTime), N'Continental Airlines', 21, N'2', N'-', 100.0000, N'25', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (110, N'PVV8803', N'Moscow', N'Dubai', CAST(0xFFFFFFFE00B3E6B0 AS DateTime), CAST(0xFFFFFFFE011826C0 AS DateTime), N'Continental Airlines', 24, N'2', N'-', 100.0000, N'25', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (111, N'UE 2082', N'Moscow', N'Dubai', CAST(0xFFFFFFFE00D79B50 AS DateTime), CAST(0xFFFFFFFE01391C40 AS DateTime), N'Transeuropean Airlines', 21, N'1', N'-', 90.0000, N'6', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (112, N'CY 383', N'Dubai', N'Larnaca', CAST(0xFFFFFFFE00E297D0 AS DateTime), CAST(0xFFFFFFFE01090B90 AS DateTime), N'Cyprus Airways', 3, N'1', NULL, 110.0000, N'3', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (113, N'Cy 393', N'Dubai', N'Larnaca', CAST(0xFFFFFFFE01758900 AS DateTime), CAST(0xFFFFFFFE0018B820 AS DateTime), N'Cyprus Airways', 3, N'1', N'1', 110.0000, N'6', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (114, N'OK 401', N'Dubai', N'Larnaca', CAST(0xFFFFFFFE00015F90 AS DateTime), CAST(0xFFFFFFFE0036EE80 AS DateTime), N'Czech Airlines', 12, N'1', N'-', 90.0000, N'26', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (115, N'RO 066', N'Dubai', N'Larnaca', CAST(0xFFFFFFFE001B7740 AS DateTime), CAST(0xFFFFFFFE0039ADA0 AS DateTime), N'Tarom Romanian', 12, N'1', N'-', 90.0000, N'3', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (116, N'KM 833', N'Dubai', N'Malta', CAST(0xFFFFFFFE001339E0 AS DateTime), CAST(0xFFFFFFFE006F3C90 AS DateTime), N'Air Malta', 3, N'1', N'1', 120.0000, N'24', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (117, N'KM 837', N'Dubai', N'Malta', CAST(0xFFFFFFFE001339E0 AS DateTime), CAST(0xFFFFFFFE006F3C90 AS DateTime), N'Air Malta', 3, N'1', N'1', 120.0000, N'5', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (118, N'KM 841', N'Dubai', N'Malta', CAST(0xFFFFFFFE00251430 AS DateTime), CAST(0xFFFFFFFE006B1DE0 AS DateTime), N'Air Malta', 3, N'1', N'-', 120.0000, N'7', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (119, N'EK 027', N'Dubai', N'Malta', CAST(0xFFFFFFFE00895440 AS DateTime), CAST(0xFFFFFFFE00D63BC0 AS DateTime), N'Emirates', 1, N'3', N'1', 140.0000, N'12356', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (120, N'KM 835', N'Dubai', N'Malta', CAST(0xFFFFFFFE009C8E20 AS DateTime), CAST(0xFFFFFFFE00D4DC30 AS DateTime), N'Air Malta', 3, N'1', N'-', 120.0000, N'1', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (121, N'PVV8808', N'Dubai', N'Moscow', CAST(0xFFFFFFFE01391C40 AS DateTime), CAST(0xFFFFFFFE016EAB30 AS DateTime), N'Continental Airlines', 21, N'2', N'-', 100.0000, N'25', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (122, N'PVV8804', N'Dubai', N'Moscow', CAST(0xFFFFFFFE013D3AF0 AS DateTime), CAST(0xFFFFFFFE0172C9E0 AS DateTime), N'Continental Airlines', 24, N'2', N'-', 100.0000, N'25', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (123, N'UE 2083', N'Dubai', N'Moscow', CAST(0xFFFFFFFE015A11C0 AS DateTime), CAST(0xFFFFFFFE00149970 AS DateTime), N'Transeuropean Airlines', 21, N'2', N'-', 90.0000, N'6', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (124, N'kl  425', N'Amsterdam', N'Dubai', CAST(0xFFFFFFFE014418C0 AS DateTime), CAST(0xFFFFFFFE006B1DE0 AS DateTime), N'KLM', 15, N'1', N'1', 145.0000, N'24567', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (125, N'BR 76', N'Amsterdam', N'Dubai', CAST(0xFFFFFFFE00C1A250 AS DateTime), CAST(0xFFFFFFFE014DB5B0 AS DateTime), N'KLM', 13, N'1', NULL, 145.0000, N'357', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (126, N'KL 421', N'Amsterdam', N'Dubai', CAST(0xFFFFFFFE00E6B680 AS DateTime), CAST(0xFFFFFFFE01742970 AS DateTime), N'KLM', 15, N'1', NULL, 145.0000, N'1234567', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (127, N'KL421', N'Dubai', N'Amsterdam', CAST(0xFFFFFFFE0184A430 AS DateTime), CAST(0xFFFFFFFE0062E080 AS DateTime), N'KLM', 15, N'1', N'1', 145.0000, N'1234567', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (128, N'BR 75', N'Dubai', N'Amsterdam', CAST(0xFFFFFFFE004CE780 AS DateTime), CAST(0xFFFFFFFE00A4CB80 AS DateTime), N'Eva Air', 13, N'1', NULL, 110.0000, N'357', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (129, N'KL 425', N'Dubai', N'Amsterdam', CAST(0xFFFFFFFE007B98A0 AS DateTime), CAST(0xFFFFFFFE00D8FAE0 AS DateTime), N'KLM', 15, N'1', NULL, 145.0000, N'13567', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (130, N'OA 343', N'Athens', N'Dubai', CAST(0xFFFFFFFE00F47220 AS DateTime), CAST(0xFFFFFFFE0179A7B0 AS DateTime), N'Olympic Airways', 12, N'1', N'1', 120.0000, N'46', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (131, N'OA 345', N'Athens', N'Dubai', CAST(0xFFFFFFFE00F47220 AS DateTime), CAST(0xFFFFFFFE015B7150 AS DateTime), N'Olympic Airways', 12, N'1', NULL, 120.0000, N'13', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (132, N'OA 347', N'Athens', N'Dubai', CAST(0xFFFFFFFE00FCAF80 AS DateTime), CAST(0xFFFFFFFE0163AEB0 AS DateTime), N'Olympic Airways', 12, N'1', N'1', 120.0000, N'7', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (133, N'OA349', N'Athens', N'Dubai', CAST(0xFFFFFFFE00FCAF80 AS DateTime), CAST(0xFFFFFFFE01784820 AS DateTime), N'Olympic Airways', 12, N'1', NULL, 120.0000, N'2', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (134, N'EK 028', N'Athens', N'Dubai', CAST(0xFFFFFFFE012A0110 AS DateTime), CAST(0xFFFFFFFE00057E40 AS DateTime), N'Emirates', 2, N'3', NULL, 140.0000, N'12356', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (135, N'EK 027', N'Dubai', N'Athens', CAST(0xFFFFFFFE00895440 AS DateTime), CAST(0xFFFFFFFE00C88020 AS DateTime), N'Emirates', 1, N'3', NULL, 140.0000, N'12356', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (136, N'OA 346', N'Dubai', N'Athens', CAST(0xFFFFFFFE01692CF0 AS DateTime), CAST(0xFFFFFFFE003F2BE0 AS DateTime), N'Olympic Airways', 12, N'1', N'1', 120.0000, N'13', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (137, N'OA 348', N'Dubai', N'Athens', CAST(0xFFFFFFFE01716A50 AS DateTime), CAST(0xFFFFFFFE00476940 AS DateTime), N'Olympic Airways', 12, N'1', N'1', 120.0000, N'7', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (138, N'OA 350', N'Dubai', N'Athens', CAST(0xFFFFFFFE018603C0 AS DateTime), CAST(0xFFFFFFFE003C6CC0 AS DateTime), N'Olympic Airways', 12, N'1', NULL, 120.0000, N'2', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (139, N'OA 344', N'Dubai', N'Athens', CAST(0xFFFFFFFE01876350 AS DateTime), CAST(0xFFFFFFFE003DCC50 AS DateTime), N'Olympic Airways', 12, N'1', NULL, 120.0000, N'46', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (140, N'CX 751', N'Bangkok', N'Dubai', CAST(0xFFFFFFFE011826C0 AS DateTime), CAST(0xFFFFFFFE016EAB30 AS DateTime), N'Cathay Pacific', 13, N'1', NULL, 45.0000, N'12356', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (141, N'EK 6201', N'Bangkok', N'Dubai', CAST(0xFFFFFFFE012B60A0 AS DateTime), CAST(0xFFFFFFFE01650E40 AS DateTime), N'Emirates', 1, N'3', NULL, 140.0000, N'246', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (142, N'TG 517', N'Bangkok', N'Dubai', CAST(0xFFFFFFFE012B60A0 AS DateTime), CAST(0xFFFFFFFE01650E40 AS DateTime), N'Thai Airways', 17, N'1', NULL, 100.0000, N'246', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (143, N'OK 175', N'Bangkok', N'Dubai', CAST(0xFFFFFFFE000DBBA0 AS DateTime), CAST(0xFFFFFFFE004609B0 AS DateTime), N'Czech Airlines', 2, N'1', NULL, 105.0000, N'24', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (144, N'EK 083', N'Bangkok', N'Dubai', CAST(0xFFFFFFFE00149970 AS DateTime), CAST(0xFFFFFFFE0048C8D0 AS DateTime), N'Emirates', 1, N'3', NULL, 140.0000, N'1357', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (145, N'TG 4501', N'Bangkok', N'Dubai', CAST(0xFFFFFFFE00149970 AS DateTime), CAST(0xFFFFFFFE0048C8D0 AS DateTime), N'Thai Airways', 17, N'1', NULL, 100.0000, N'1357', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (146, N'BI033', N'Bangkok', N'Dubai', CAST(0xFFFFFFFE014DB5B0 AS DateTime), CAST(0xFFFFFFFE0002BF20 AS DateTime), N'Royal Brunei', 15, NULL, NULL, 120.0000, N'16', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (147, N'Ek 6200', N'Dubai', N'Bangkok', CAST(0xFFFFFFFE0176E890 AS DateTime), CAST(0xFFFFFFFE00869520 AS DateTime), N'Emirates', 1, N'3', NULL, 140.0000, N'246', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (148, N'TG 518', N'Dubai', N'Bangkok', CAST(0xFFFFFFFE0176E890 AS DateTime), CAST(0xFFFFFFFE00869520 AS DateTime), N'Thai Airways', 1, N'1', NULL, 100.0000, N'246', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (149, N'CX 750', N'Dubai', N'Bangkok', CAST(0xFFFFFFFE018344A0 AS DateTime), CAST(0xFFFFFFFE00AE6870 AS DateTime), N'Cathay Pacific', 13, N'1', N'1', 45.0000, N'3467', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (150, N'BI 034', N'Dubai', N'Bangkok', CAST(0xFFFFFFFE00057E40 AS DateTime), CAST(0xFFFFFFFE0095B050 AS DateTime), N'Royal Brunei', 15, N'1', NULL, 120.0000, N'13', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (151, N'EK 082', N'Dubai', N'Bangkok', CAST(0xFFFFFFFE00358EF0 AS DateTime), CAST(0xFFFFFFFE00C9DFB0 AS DateTime), N'Emirates', 18, N'3', NULL, 140.0000, N'2467', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (152, N'TG 4500', N'Dubai', N'Bangkok', CAST(0xFFFFFFFE00358EF0 AS DateTime), CAST(0xFFFFFFFE00C72090 AS DateTime), N'Thai Airways', 18, N'1', NULL, 100.0000, N'2467', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (153, N'OK 174', N'Dubai', N'Bangkok', CAST(0xFFFFFFFE003C6CC0 AS DateTime), CAST(0xFFFFFFFE00D63BC0 AS DateTime), N'Czech Airlines', 2, N'1', NULL, 105.0000, N'13', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (154, N'EK 611', N'Dhaka', N'Dubai', CAST(0xFFFFFFFE00B12790 AS DateTime), CAST(0xFFFFFFFE00FB4FF0 AS DateTime), N'Emirates', 1, N'3', N'1', 140.0000, N'16', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (155, N'EK 613', N'Dhaka', N'Dubai', CAST(0xFFFFFFFE00C9DFB0 AS DateTime), CAST(0xFFFFFFFE00FB4FF0 AS DateTime), N'Emirates', 2, N'3', NULL, 140.0000, N'3', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (156, N'BG 017', N'Dhaka', N'Dubai', CAST(0xFFFFFFFE011F0490 AS DateTime), CAST(0xFFFFFFFE01742970 AS DateTime), N'Biman Bangladesh', 19, N'1', N'1', 100.0000, N'3', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (157, N'BG 029', N'Dhaka', N'Dubai', CAST(0xFFFFFFFE011F0490 AS DateTime), CAST(0xFFFFFFFE01742970 AS DateTime), N'Biman Bangladesh', 19, N'1', N'1', 100.0000, N'6', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (158, N'EK 063', N'Dhaka', N'Dubai', CAST(0xFFFFFFFE0151D460 AS DateTime), CAST(0xFFFFFFFE0188C2E0 AS DateTime), N'Emirates', 17, N'3', NULL, 140.0000, N'2347', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (159, N'BG 001', N'Dhaka', N'Dubai', CAST(0xFFFFFFFE016A8C80 AS DateTime), CAST(0xFFFFFFFE00149970 AS DateTime), N'Biman Bangladesh', 19, N'1', NULL, 100.0000, N'1', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (160, N'BG 051', N'Dhaka', N'Dubai', CAST(0xFFFFFFFE016A8C80 AS DateTime), CAST(0xFFFFFFFE0018B820 AS DateTime), N'Biman Bangladesh', 2, N'1', NULL, 100.0000, N'6', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (161, N'BG 003', N'Dhaka', N'Dubai', CAST(0xFFFFFFFE00015F90 AS DateTime), CAST(0xFFFFFFFE00358EF0 AS DateTime), N'Biman Bangladesh', 19, N'1', NULL, 100.0000, N'6', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (162, N'BG 005', N'Dhaka', N'Dubai', CAST(0xFFFFFFFE00015F90 AS DateTime), CAST(0xFFFFFFFE00358EF0 AS DateTime), N'Biman Bangladesh', 19, N'1', NULL, 100.0000, N'7', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (163, N'BG 007', N'Dhaka', N'Dubai', CAST(0xFFFFFFFE00015F90 AS DateTime), CAST(0xFFFFFFFE00358EF0 AS DateTime), N'Biman Bangladesh', 19, N'1', NULL, 100.0000, N'4', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (164, N'IR 610', N'Dhaka', N'Dubai', CAST(0xFFFFFFFE0041EB00 AS DateTime), CAST(0xFFFFFFFE00761A60 AS DateTime), N'Iran Air', 13, N'1', NULL, 90.0000, N'1', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (165, N'EK 613', N'Dhaka', N'Dubai', CAST(0xFFFFFFFE00986F70 AS DateTime), CAST(0xFFFFFFFE00D0BD80 AS DateTime), N'Emirates', 2, N'3', NULL, 140.0000, N'45', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (166, N'BG 026', N'Dhaka', N'Dubai', CAST(0xFFFFFFFE0151D460 AS DateTime), CAST(0xFFFFFFFE002932E0 AS DateTime), N'Biman Bangladesh', 2, N'1', N'1', 100.0000, N'2', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (167, N'BG 045', N'Dhaka', N'Dubai', CAST(0xFFFFFFFE0172C9E0 AS DateTime), CAST(0xFFFFFFFE0020F580 AS DateTime), N'Biman Bangladesh', 2, N'1', NULL, 100.0000, N'1', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (168, N'IR 611', N'Dubai', N'Dhaka', CAST(0xFFFFFFFE01499700 AS DateTime), CAST(0xFFFFFFFE00358EF0 AS DateTime), N'Iran Air', 13, N'1', NULL, 90.0000, N'1', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (169, N'BG 028', N'Dubai', N'Dhaka', CAST(0xFFFFFFFE0002BF20 AS DateTime), CAST(0xFFFFFFFE00AD08E0 AS DateTime), N'Biman Bangladesh', 2, N'1', N'2', 100.0000, N'5', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (170, N'BG 018', N'Dubai', N'Dhaka', CAST(0xFFFFFFFE00057E40 AS DateTime), CAST(0xFFFFFFFE00903210 AS DateTime), N'Biman Bangladesh', 19, N'1', N'1', 100.0000, N'4', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (171, N'BG 030', N'Dubai', N'Dhaka', CAST(0xFFFFFFFE00057E40 AS DateTime), CAST(0xFFFFFFFE00903210 AS DateTime), N'Biman Bangladesh', 19, N'1', N'1', 100.0000, N'7', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (172, N'EK 610', N'Dubai', N'Dhaka', CAST(0xFFFFFFFE00149970 AS DateTime), CAST(0xFFFFFFFE00A0ACD0 AS DateTime), N'Emirates', 2, N'3', N'1', 140.0000, N'13', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (173, N'EK 612', N'Dubai', N'Dhaka', CAST(0xFFFFFFFE00149970 AS DateTime), CAST(0xFFFFFFFE0083D600 AS DateTime), N'Emirates', 2, N'3', NULL, 140.0000, N'45', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (174, N'EK 062', N'Dubai', N'Dhaka', CAST(0xFFFFFFFE002EB120 AS DateTime), CAST(0xFFFFFFFE009F4D40 AS DateTime), N'Emirates', 17, N'3', NULL, 140.0000, N'2347', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (175, N'EK 612', N'Dubai', N'Dhaka', CAST(0xFFFFFFFE002EB120 AS DateTime), CAST(0xFFFFFFFE009B2E90 AS DateTime), N'Emirates', 1, N'3', NULL, 140.0000, N'6', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (176, N'BG 052', N'Dubai', N'Dhaka', CAST(0xFFFFFFFE00317040 AS DateTime), CAST(0xFFFFFFFE00B964F0 AS DateTime), N'Biman Bangladesh', 2, N'1', N'1', 100.0000, N'6', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (177, N'BG 026', N'Dubai', N'Dhaka', CAST(0xFFFFFFFE003C6CC0 AS DateTime), CAST(0xFFFFFFFE00C5C100 AS DateTime), N'Biman Bangladesh', 2, N'1', N'1', 100.0000, N'3', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (178, N'BG 046', N'Dubai', N'Dhaka', CAST(0xFFFFFFFE00568470 AS DateTime), CAST(0xFFFFFFFE00DE7920 AS DateTime), N'Biman Bangladesh', 2, N'1', N'1', 100.0000, N'2', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (179, N'EK 322', N'Dhahran', N'Dubai', CAST(0xFFFFFFFE01365D20 AS DateTime), CAST(0xFFFFFFFE015A11C0 AS DateTime), N'Emirates', 2, N'3', NULL, 90.0000, N'3', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (180, N'SV 546', N'Dhahran', N'Dubai', CAST(0xFFFFFFFE011826C0 AS DateTime), CAST(0xFFFFFFFE013D3AF0 AS DateTime), N'Saudia', 23, N'1', NULL, 80.0000, N'1234567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (181, N'EK 322', N'Dhahran', N'Dubai', CAST(0xFFFFFFFE017F25F0 AS DateTime), CAST(0xFFFFFFFE00175890 AS DateTime), N'Emirates', 1, N'3', NULL, 90.0000, N'5', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (182, N'EK 321', N'Dubai', N'Dhahran', CAST(0xFFFFFFFE01206420 AS DateTime), CAST(0xFFFFFFFE012482D0 AS DateTime), N'Emirates', 2, N'3', NULL, 90.0000, N'3', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (183, N'UL 263', N'Dubai', N'Dhahran', CAST(0xFFFFFFFE0137BCB0 AS DateTime), CAST(0xFFFFFFFE013BDB60 AS DateTime), N'Sri Lankan', 22, N'1', NULL, 110.0000, N'2', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (184, N'SV 547', N'Dubai', N'Dhahran', CAST(0xFFFFFFFE014DB5B0 AS DateTime), CAST(0xFFFFFFFE015333F0 AS DateTime), N'Saudia', 23, N'1', NULL, 80.0000, N'1234567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (185, N'EK 321', N'Dubai', N'Dhahran', CAST(0xFFFFFFFE016A8C80 AS DateTime), CAST(0xFFFFFFFE016EAB30 AS DateTime), N'Emirates', 17, N'3', NULL, 90.0000, N'5', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (186, N'EK 703', N'Delhi', N'Dubai', CAST(0xFFFFFFFE00434A90 AS DateTime), CAST(0xFFFFFFFE0066FF30 AS DateTime), N'Emirates', 2, N'3', NULL, 120.0000, N'1357', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (187, N'AL 725', N'Delhi', N'Dubai', CAST(0xFFFFFFFE009DEDB0 AS DateTime), CAST(0xFFFFFFFE00C301E0 AS DateTime), N'Air India', 2, N'1', NULL, 90.0000, N'7', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (188, N'EK 701', N'Delhi', N'Dubai', CAST(0xFFFFFFFE009DEDB0 AS DateTime), CAST(0xFFFFFFFE00C1A250 AS DateTime), N'Emirates', 2, N'3', NULL, 120.0000, N'246', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (189, N'AL 723', N'Delhi', N'Dubai', CAST(0xFFFFFFFE014418C0 AS DateTime), CAST(0xFFFFFFFE01666DD0 AS DateTime), N'Air India', 13, N'1', NULL, 90.0000, N'2', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (190, N'AL 765', N'Delhi', N'Dubai', CAST(0xFFFFFFFE015A11C0 AS DateTime), CAST(0xFFFFFFFE017F25F0 AS DateTime), N'Air India', 2, N'1', NULL, 90.0000, N'3', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (191, N'EK 702', N'Dubai', N'Delhi', CAST(0xFFFFFFFE01758900 AS DateTime), CAST(0xFFFFFFFE00342F60 AS DateTime), N'Emirates', 2, N'3', NULL, 120.0000, N'2467', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (192, N'AL 844', N'Dubai', N'Delhi', CAST(0xFFFFFFFE00251430 AS DateTime), CAST(0xFFFFFFFE006DDD00 AS DateTime), N'Air India', 2, N'1', NULL, 90.0000, N'6', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (193, N'EK 700', N'Dubai', N'Delhi', CAST(0xFFFFFFFE0044AA20 AS DateTime), CAST(0xFFFFFFFE00903210 AS DateTime), N'Emirates', 2, N'3', NULL, 120.0000, N'246', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (194, N'AL 278', N'Dubai', N'Delhi', CAST(0xFFFFFFFE00BD83A0 AS DateTime), CAST(0xFFFFFFFE01064C70 AS DateTime), N'Air India', 2, N'1', NULL, 90.0000, N'2', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (195, N'AL 726', N'Dubai', N'Delhi', CAST(0xFFFFFFFE00E81610 AS DateTime), CAST(0xFFFFFFFE0130DEE0 AS DateTime), N'Air India', 2, N'1', NULL, 90.0000, N'4', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (196, N'AL 720', N'Dubai', N'Delhi', CAST(0xFFFFFFFE016A8C80 AS DateTime), CAST(0xFFFFFFFE002673C0 AS DateTime), N'Air India', 13, N'1', NULL, 90.0000, N'7', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (197, N'EK 224', N'Doha', N'Dubai', CAST(0xFFFFFFFE0130DEE0 AS DateTime), CAST(0xFFFFFFFE014F1540 AS DateTime), N'Emirates', 2, N'3', NULL, 70.0000, N'5', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (198, N'GF 516', N'Doha', N'Dubai', CAST(0xFFFFFFFE01499700 AS DateTime), CAST(0xFFFFFFFE016A8C80 AS DateTime), N'Gulf Air', 3, N'1', NULL, 55.0000, N'5', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (199, N'QR 104', N'Doha', N'Dubai', CAST(0xFFFFFFFE00869520 AS DateTime), CAST(0xFFFFFFFE00A78AA0 AS DateTime), N'Qatar Airways', 1, N'1', NULL, 50.0000, N'1234567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (200, N'GF 502', N'Doha', N'Dubai', CAST(0xFFFFFFFE00A36BF0 AS DateTime), CAST(0xFFFFFFFE00C46170 AS DateTime), N'Gulf Air', 3, N'1', NULL, 55.0000, N'1234567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (201, N'EK 222', N'Doha', N'Dubai', CAST(0xFFFFFFFE00A8EA30 AS DateTime), CAST(0xFFFFFFFE00C72090 AS DateTime), N'Emirates', 2, N'3', NULL, 70.0000, N'123', 5000)
GO
print 'Processed 200 total records'
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (202, N'GF 552', N'Doha', N'Dubai', CAST(0xFFFFFFFE00B54640 AS DateTime), CAST(0xFFFFFFFE00D63BC0 AS DateTime), N'Gulf Air', 3, N'1', NULL, 55.0000, N'4', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (203, N'QR 110', N'Doha', N'Dubai', CAST(0xFFFFFFFE00CF5DF0 AS DateTime), CAST(0xFFFFFFFE00F05370 AS DateTime), N'Qatar Airways', 3, N'1', NULL, 50.0000, N'1234567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (204, N'GF 552', N'Doha', N'Dubai', CAST(0xFFFFFFFE00DD1990 AS DateTime), CAST(0xFFFFFFFE00FE0F10 AS DateTime), N'Gulf Air', 3, N'1', NULL, 55.0000, N'3', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (205, N'EK 224', N'Doha', N'Dubai', CAST(0xFFFFFFFE00F9F060 AS DateTime), CAST(0xFFFFFFFE011826C0 AS DateTime), N'Emirates', 2, N'3', NULL, 70.0000, N'1234567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (206, N'GF 504', N'Doha', N'Dubai', CAST(0xFFFFFFFE01022DC0 AS DateTime), CAST(0xFFFFFFFE0121C3B0 AS DateTime), N'Gulf Air', 6, N'1', NULL, 55.0000, N'1234567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (207, N'QR 112', N'Doha', N'Dubai', CAST(0xFFFFFFFE011C4570 AS DateTime), CAST(0xFFFFFFFE013D3AF0 AS DateTime), N'Qatar Airways', 3, N'1', NULL, 50.0000, N'45', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (208, N'QR 118', N'Doha', N'Dubai', CAST(0xFFFFFFFE015B7150 AS DateTime), CAST(0xFFFFFFFE017C66D0 AS DateTime), N'Qatar Airways', 3, N'1', NULL, 50.0000, N'1234567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (209, N'EK 226', N'Doha', N'Dubai', CAST(0xFFFFFFFE017F25F0 AS DateTime), CAST(0xFFFFFFFE0011DA50 AS DateTime), N'Emirates', 17, N'3', NULL, 70.0000, N'1234567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (210, N'EK 223', N'Dubai', N'Doha', CAST(0xFFFFFFFE01206420 AS DateTime), CAST(0xFFFFFFFE01206420 AS DateTime), N'Emirates', 20, N'3', NULL, 70.0000, N'5', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (211, N'QR 113', N'Dubai', N'Doha', CAST(0xFFFFFFFE014DB5B0 AS DateTime), CAST(0xFFFFFFFE014DB5B0 AS DateTime), N'Qatar Airways', 3, N'1', NULL, 50.0000, N'1234567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (212, N'EK 221', N'Dubai', N'Doha', CAST(0xFFFFFFFE0087F4B0 AS DateTime), CAST(0xFFFFFFFE0087F4B0 AS DateTime), N'Emirates', 2, N'3', NULL, 70.0000, N'1234', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (213, N'GF 501', N'Dubai', N'Doha', CAST(0xFFFFFFFE008C1360 AS DateTime), CAST(0xFFFFFFFE008C1360 AS DateTime), N'Gulf Air', 3, N'1', NULL, 55.0000, N'1234567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (214, N'QR 105', N'Dubai', N'Doha', CAST(0xFFFFFFFE00B6A5D0 AS DateTime), CAST(0xFFFFFFFE00B6A5D0 AS DateTime), N'Qatar Airways', 1, N'1', NULL, 50.0000, N'1234567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (215, N'EK 223', N'Dubai', N'Doha', CAST(0xFFFFFFFE00EAD530 AS DateTime), CAST(0xFFFFFFFE00EAD530 AS DateTime), N'Emirates', 2, N'3', NULL, 70.0000, N'123467', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (216, N'QR 111', N'Dubai', N'Doha', CAST(0xFFFFFFFE00FF6EA0 AS DateTime), CAST(0xFFFFFFFE00FF6EA0 AS DateTime), N'Qatar Airways', 3, N'1', NULL, 50.0000, N'45', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (217, N'GF 507', N'Dubai', N'Doha', CAST(0xFFFFFFFE016A8C80 AS DateTime), CAST(0xFFFFFFFE016A8C80 AS DateTime), N'Gulf Air', 3, N'1', NULL, 55.0000, N'1234567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (218, N'EK 225', N'Dubai', N'Doha', CAST(0xFFFFFFFE016EAB30 AS DateTime), CAST(0xFFFFFFFE016EAB30 AS DateTime), N'Emirates', 17, N'3', NULL, 70.0000, N'1234567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (219, N'QR 119', N'Dubai', N'Doha', CAST(0xFFFFFFFE018A2270 AS DateTime), CAST(0xFFFFFFFE018A2270 AS DateTime), N'Qatar Airways', 3, N'1', NULL, 50.0000, N'1234567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (220, N'EK 063', N'Kuala Lampur', N'Dubai', CAST(0xFFFFFFFE0128A180 AS DateTime), CAST(0xFFFFFFFE0188C2E0 AS DateTime), N'Emirates', 17, N'3', N'1', 150.0000, N'2347', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (221, N'MH 160', N'Kuala Lampur', N'Dubai', CAST(0xFFFFFFFE00CDFE60 AS DateTime), CAST(0xFFFFFFFE011F0490 AS DateTime), N'Malaysia Airlines', 5, N'1', N'1', 110.0000, N'47', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (222, N'MH 090', N'Kuala Lampur', N'Dubai', CAST(0xFFFFFFFE00EEF3E0 AS DateTime), CAST(0xFFFFFFFE01650E40 AS DateTime), N'Malaysia Airlines', 17, N'1', NULL, 110.0000, N'146', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (223, N'MH 030', N'Kuala Lampur', N'Dubai', CAST(0xFFFFFFFE01022DC0 AS DateTime), CAST(0xFFFFFFFE017C66D0 AS DateTime), N'Malaysia Airlines', 5, N'1', NULL, 110.0000, N'25', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (224, N'EK 062', N'Dubai', N'Kuala Lampur', CAST(0xFFFFFFFE002EB120 AS DateTime), CAST(0xFFFFFFFE01064C70 AS DateTime), N'Emirates', 17, N'3', N'1', 100.0000, N'2347', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (225, N'TK 1168', N'Dubai', N'Kuala Lampur', CAST(0xFFFFFFFE005AA320 AS DateTime), CAST(0xFFFFFFFE0112A880 AS DateTime), N'Turkish Airlines', 2, N'1', NULL, 120.0000, N'16', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (226, N'MH 091', N'Dubai', N'Kuala Lampur', CAST(0xFFFFFFFE00659FA0 AS DateTime), CAST(0xFFFFFFFE00D63BC0 AS DateTime), N'Malaysia Airlines', 17, N'1', NULL, 110.0000, N'136', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (227, N'MH 031', N'Dubai', N'Kuala Lampur', CAST(0xFFFFFFFE00FCAF80 AS DateTime), CAST(0xFFFFFFFE0172C9E0 AS DateTime), N'Malaysia Airlines', 5, N'1', NULL, 110.0000, N'36', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (228, N'TK 1169', N'Kuala Lampur', N'Dubai', CAST(0x0000000000000000 AS DateTime), CAST(0xFFFFFFFE003C6CC0 AS DateTime), N'Turkish Airlines', 2, N'1', NULL, 120.0000, N'16', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (229, N'MH 161', N'Dubai', N'Kuala Lampur', CAST(0xFFFFFFFE01391C40 AS DateTime), CAST(0xFFFFFFFE007FB750 AS DateTime), N'Malaysia Airlines', 5, N'1', NULL, 110.0000, N'47', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (230, N'LZ 531', N'Kuwait', N'Dubai', CAST(0xFFFFFFFE003DCC50 AS DateTime), CAST(0xFFFFFFFE0062E080 AS DateTime), N'Balkan Bulgarian', 24, N'1', NULL, 60.0000, N'4', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (231, N'EK 102', N'Kuwait', N'Dubai', CAST(0xFFFFFFFE009B2E90 AS DateTime), CAST(0xFFFFFFFE00C301E0 AS DateTime), N'Emirates', 1, N'3', NULL, 90.0000, N'135', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (232, N'WY 414', N'Kuwait', N'Dubai', CAST(0xFFFFFFFE00FF6EA0 AS DateTime), CAST(0xFFFFFFFE012B60A0 AS DateTime), N'Oman Air', 3, N'1', NULL, 80.0000, N'14', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (233, N'KU 673', N'Kuwait', N'Dubai', CAST(0xFFFFFFFE010FE960 AS DateTime), CAST(0xFFFFFFFE013A7BD0 AS DateTime), N'Kuwait Airways', 1, N'1', NULL, 75.0000, N'1234567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (234, N'EK 104', N'Kuwait', N'Dubai', CAST(0xFFFFFFFE012A0110 AS DateTime), CAST(0xFFFFFFFE0151D460 AS DateTime), N'Emirates', 2, N'3', NULL, 90.0000, N'1234567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (235, N'UL 228', N'Kuwait', N'Dubai', CAST(0xFFFFFFFE0155F310 AS DateTime), CAST(0xFFFFFFFE018344A0 AS DateTime), N'Sri Lankan', 22, N'1', NULL, 70.0000, N'3', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (236, N'KU 669', N'Kuwait', N'Dubai', CAST(0xFFFFFFFE016A8C80 AS DateTime), CAST(0xFFFFFFFE00083D60 AS DateTime), N'Kuwait Airways', 3, N'1', NULL, 75.0000, N'1346', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (237, N'KU 675', N'Kuwait', N'Dubai', CAST(0xFFFFFFFE016A8C80 AS DateTime), CAST(0xFFFFFFFE00083D60 AS DateTime), N'Kuwait Airways', 3, N'1', NULL, 75.0000, N'146', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (238, N'LZ 532', N'Dubai', N'Kuwait', CAST(0xFFFFFFFE017F25F0 AS DateTime), CAST(0xFFFFFFFE018A2270 AS DateTime), N'Balkan Bulgarian', 24, N'1', NULL, 60.0000, N'4', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (239, N'KU 670', N'Dubai', N'Kuwait', CAST(0xFFFFFFFE007B98A0 AS DateTime), CAST(0xFFFFFFFE0083D600 AS DateTime), N'Kuwait Airways', 3, N'1', NULL, 75.0000, N'1346', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (240, N'KU 676', N'Dubai', N'Kuwait', CAST(0xFFFFFFFE007B98A0 AS DateTime), CAST(0xFFFFFFFE0083D600 AS DateTime), N'Kuwait Airways', 3, N'1', NULL, 75.0000, N'27', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (241, N'EK 101', N'Dubai', N'Kuwait', CAST(0xFFFFFFFE007FB750 AS DateTime), CAST(0xFFFFFFFE008AB3D0 AS DateTime), N'Emirates', 1, N'3', NULL, 90.0000, N'135', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (242, N'KU 676', N'Dubai', N'Kuwait', CAST(0xFFFFFFFE00986F70 AS DateTime), CAST(0xFFFFFFFE00A0ACD0 AS DateTime), N'Kuwait Airways', 3, N'1', NULL, 75.0000, N'5', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (243, N'WY 413', N'Dubai', N'Kuwait', CAST(0xFFFFFFFE00E297D0 AS DateTime), CAST(0xFFFFFFFE00EEF3E0 AS DateTime), N'Oman Air', 2, N'1', NULL, 80.0000, N'14', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (244, N'EK 103', N'Dubai', N'Kuwait', CAST(0xFFFFFFFE010E89D0 AS DateTime), CAST(0xFFFFFFFE01198650 AS DateTime), N'Emirates', 2, N'3', NULL, 90.0000, N'1234567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (245, N'UL 227', N'Dubai', N'Kuwait', CAST(0xFFFFFFFE012482D0 AS DateTime), CAST(0xFFFFFFFE0130DEE0 AS DateTime), N'Sri Lankan', 22, N'1', NULL, 70.0000, N'357', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (246, N'KU 674', N'Dubai', N'Kuwait', CAST(0xFFFFFFFE014F1540 AS DateTime), CAST(0xFFFFFFFE0158B230 AS DateTime), N'Kuwait Airways', 1, N'1', NULL, 75.0000, N'1234567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (247, N'OA 346', N'Dubai', N'Kuwait', CAST(0xFFFFFFFE01692CF0 AS DateTime), CAST(0xFFFFFFFE01742970 AS DateTime), N'Olympic Airways', 12, N'1', NULL, 120.0000, N'13', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (248, N'ET 662', N'Addis Ababa', N'Dubai', CAST(0xFFFFFFFE00D63BC0 AS DateTime), CAST(0xFFFFFFFE0128A180 AS DateTime), N'Ethiopian Airlines', 14, N'1', NULL, 100.0000, N'6', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (249, N'ET 642', N'Addis Ababa', N'Dubai', CAST(0xFFFFFFFE00903210 AS DateTime), CAST(0xFFFFFFFE00E297D0 AS DateTime), N'Ethiopian Airlines', 15, N'1', NULL, 100.0000, N'4', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (250, N'ET 612', N'Addis Ababa', N'Dubai', CAST(0xFFFFFFFE00903210 AS DateTime), CAST(0xFFFFFFFE01038D50 AS DateTime), N'Ethiopian Airlines', 15, N'1', N'1', 100.0000, N'1', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (251, N'ET 632', N'Addis Ababa', N'Dubai', CAST(0xFFFFFFFE00D63BC0 AS DateTime), CAST(0xFFFFFFFE0128A180 AS DateTime), N'Ethiopian Airlines', 15, N'1', NULL, 100.0000, N'3', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (252, N'ET 652', N'Addis Ababa', N'Dubai', CAST(0xFFFFFFFE00D63BC0 AS DateTime), CAST(0xFFFFFFFE0128A180 AS DateTime), N'Ethiopian Airlines', 14, N'1', NULL, 100.0000, N'5', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (253, N'ET 622', N'Addis Ababa', N'Dubai', CAST(0xFFFFFFFE00D63BC0 AS DateTime), CAST(0xFFFFFFFE0128A180 AS DateTime), N'Ethiopian Airlines', 14, N'1', NULL, 100.0000, N'2', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (254, N'ET 672', N'Addis Ababa', N'Dubai', CAST(0xFFFFFFFE00D63BC0 AS DateTime), CAST(0xFFFFFFFE0128A180 AS DateTime), N'Ethiopian Airlines', 14, N'1', NULL, 100.0000, N'7', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (255, N'ET 623', N'Dubai', N'Addis Ababa', CAST(0xFFFFFFFE005EC1D0 AS DateTime), CAST(0xFFFFFFFE00B54640 AS DateTime), N'Ethiopian Airlines', 15, N'1', N'1', 100.0000, N'2', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (256, N'ET 613', N'Dubai', N'Addis Ababa', CAST(0xFFFFFFFE0083D600 AS DateTime), CAST(0xFFFFFFFE00B54640 AS DateTime), N'Ethiopian Airlines', 14, N'1', NULL, 100.0000, N'1', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (257, N'ET 633', N'Dubai', N'Addis Ababa', CAST(0xFFFFFFFE0083D600 AS DateTime), CAST(0xFFFFFFFE00B54640 AS DateTime), N'Ethiopian Airlines', 14, N'1', NULL, 100.0000, N'3', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (258, N'ET 643', N'Dubai', N'Addis Ababa', CAST(0xFFFFFFFE0083D600 AS DateTime), CAST(0xFFFFFFFE00B54640 AS DateTime), N'Ethiopian Airlines', 15, N'1', NULL, 100.0000, N'4', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (259, N'ET 653', N'Dubai', N'Addis Ababa', CAST(0xFFFFFFFE0083D600 AS DateTime), CAST(0xFFFFFFFE00B54640 AS DateTime), N'Ethiopian Airlines', 15, N'1', NULL, 100.0000, N'5', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (260, N'ET 663', N'Dubai', N'Addis Ababa', CAST(0xFFFFFFFE0083D600 AS DateTime), CAST(0xFFFFFFFE00B54640 AS DateTime), N'Ethiopian Airlines', 14, N'1', NULL, 100.0000, N'6', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (261, N'ET 673', N'Dubai', N'Addis Ababa', CAST(0xFFFFFFFE0083D600 AS DateTime), CAST(0xFFFFFFFE00B54640 AS DateTime), N'Ethiopian Airlines', 14, N'1', NULL, 100.0000, N'7', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (262, N'EK 904', N'Amman', N'Dubai', CAST(0xFFFFFFFE0092F130 AS DateTime), CAST(0xFFFFFFFE00F9F060 AS DateTime), N'Emirates', 2, N'3', N'1', 130.0000, N'37', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (263, N'EK 904', N'Amman', N'Dubai', CAST(0xFFFFFFFE010FE960 AS DateTime), CAST(0xFFFFFFFE015E3070 AS DateTime), N'Emirates', 1, N'3', NULL, 130.0000, N'15', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (264, N'EK 923', N'Amman', N'Dubai', CAST(0xFFFFFFFE01391C40 AS DateTime), CAST(0xFFFFFFFE01876350 AS DateTime), N'Emirates', 1, N'3', NULL, 130.0000, N'26', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (265, N'RJ 190', N'Amman', N'Dubai', CAST(0xFFFFFFFE014C5620 AS DateTime), CAST(0xFFFFFFFE00149970 AS DateTime), N'Royal Jordanian', 2, N'1', NULL, 105.0000, N'15', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (266, N'RJ 602', N'Amman', N'Dubai', CAST(0xFFFFFFFE015A11C0 AS DateTime), CAST(0xFFFFFFFE0036EE80 AS DateTime), N'Royal Jordanian', 3, N'1', N'1', 105.0000, N'2467', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (267, N'RJ 600', N'Amman', N'Dubai', CAST(0xFFFFFFFE015E3070 AS DateTime), CAST(0xFFFFFFFE00225510 AS DateTime), N'Royal Jordanian', 3, N'1', NULL, 105.0000, N'3', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (268, N'EK 903', N'Dubai', N'Amman', CAST(0xFFFFFFFE00D79B50 AS DateTime), CAST(0xFFFFFFFE00FE0F10 AS DateTime), N'Emirates', 2, N'3', N'1', 130.0000, N'4', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (269, N'EK 903', N'Dubai', N'Amman', CAST(0xFFFFFFFE00EAD530 AS DateTime), CAST(0xFFFFFFFE00F9F060 AS DateTime), N'Emirates', 2, N'3', NULL, 130.0000, N'256', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (270, N'RJ 602', N'Dubai', N'Amman', CAST(0xFFFFFFFE006B1DE0 AS DateTime), CAST(0xFFFFFFFE00A36BF0 AS DateTime), N'Royal Jordanian', 3, N'1', N'1', 105.0000, N'3', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (271, N'EK 903', N'Dubai', N'Amman', CAST(0xFFFFFFFE00735B40 AS DateTime), CAST(0xFFFFFFFE00827670 AS DateTime), N'Emirates', 2, N'3', NULL, 130.0000, N'37', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (272, N'RJ 603', N'Dubai', N'Amman', CAST(0xFFFFFFFE00735B40 AS DateTime), CAST(0xFFFFFFFE00ABA950 AS DateTime), N'Royal Jordanian', 3, N'1', N'1', 105.0000, N'157', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (273, N'RJ 191', N'Dubai', N'Amman', CAST(0xFFFFFFFE008C1360 AS DateTime), CAST(0xFFFFFFFE00A36BF0 AS DateTime), N'Royal Jordanian', 2, N'1', NULL, 105.0000, N'26', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (274, N'RJ 601', N'Dubai', N'Amman', CAST(0xFFFFFFFE008ED280 AS DateTime), CAST(0xFFFFFFFE00A62B10 AS DateTime), N'Royal Jordanian', 3, N'1', NULL, 105.0000, N'4', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (275, N'EK 903', N'Dubai', N'Amman', CAST(0xFFFFFFFE00CB3F40 AS DateTime), CAST(0xFFFFFFFE010BCAB0 AS DateTime), N'Emirates', 2, N'3', N'1', 130.0000, N'1', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (276, N'NL 067', N'Islamabad', N'Dubai', CAST(0xFFFFFFFE00BAC480 AS DateTime), CAST(0xFFFFFFFE00E297D0 AS DateTime), N'Shaheen Air', 24, N'1', NULL, 90.0000, N'4', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (277, N'NL 065', N'Islamabad', N'Dubai', CAST(0xFFFFFFFE01549380 AS DateTime), CAST(0xFFFFFFFE0176E890 AS DateTime), N'Shaheen Air', 24, N'1', NULL, 90.0000, N'7', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (278, N'EK 665', N'Islamabad', N'Dubai', CAST(0xFFFFFFFE0039ADA0 AS DateTime), CAST(0xFFFFFFFE00602160 AS DateTime), N'Emirates', 2, N'3', NULL, 120.0000, N'37', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (279, N'PK 143', N'Islamabad', N'Dubai', CAST(0xFFFFFFFE0083D600 AS DateTime), CAST(0xFFFFFFFE00C9DFB0 AS DateTime), N'Pakistan Airlines', 1, N'1', N'1', 100.0000, N'12', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (280, N'PK 115', N'Islamabad', N'Dubai', CAST(0xFFFFFFFE00903210 AS DateTime), CAST(0xFFFFFFFE00B54640 AS DateTime), N'Pakistan Airlines', 1, N'1', NULL, 100.0000, N'3', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (281, N'EK 665', N'Islamabad', N'Dubai', CAST(0xFFFFFFFE009450C0 AS DateTime), CAST(0xFFFFFFFE00BAC480 AS DateTime), N'Emirates', 17, N'3', NULL, 120.0000, N'15', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (282, N'B4 1015', N'Islamabad', N'Dubai', CAST(0xFFFFFFFE00BD83A0 AS DateTime), CAST(0xFFFFFFFE00E6B680 AS DateTime), N'Bhoja Air', 25, N'1', NULL, 80.0000, N'47', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (283, N'E4 777', N'Islamabad', N'Dubai', CAST(0xFFFFFFFE01624F20 AS DateTime), CAST(0xFFFFFFFE018603C0 AS DateTime), N'Emirates', 12, N'3', NULL, 120.0000, N'57', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (284, N'SQ 403', N'Istanbul', N'Dubai', CAST(0xFFFFFFFE00C72090 AS DateTime), CAST(0xFFFFFFFE01198650 AS DateTime), N'Singapore Airlines', 17, N'1', NULL, 120.0000, N'6', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (285, N'EK 032', N'Istanbul', N'Dubai', CAST(0xFFFFFFFE014418C0 AS DateTime), CAST(0xFFFFFFFE0041EB00 AS DateTime), N'Emirates', 1, N'3', NULL, 140.0000, N'1234567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (286, N'MH 031', N'Istanbul', N'Dubai', CAST(0xFFFFFFFE00A0ACD0 AS DateTime), CAST(0xFFFFFFFE00E556F0 AS DateTime), N'Malaysia Airlines', 17, N'1', NULL, 110.0000, N'36', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (287, N'SQ 403', N'Istanbul', N'Dubai', CAST(0xFFFFFFFE00E297D0 AS DateTime), CAST(0xFFFFFFFE01339E00 AS DateTime), N'Singapore Airlines', 17, N'1', NULL, 120.0000, N'247', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (288, N'TK 1162', N'Istanbul', N'Dubai', CAST(0xFFFFFFFE0160EF90 AS DateTime), CAST(0xFFFFFFFE003C6CC0 AS DateTime), N'Turkish Airlines', 12, N'1', NULL, 125.0000, N'24', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (289, N'TK 1168', N'Istanbul', N'Dubai', CAST(0xFFFFFFFE016BEC10 AS DateTime), CAST(0xFFFFFFFE004A2860 AS DateTime), N'Turkish Airlines', 2, N'1', NULL, 125.0000, N'57', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (290, N'PK 124', N'Dubai', N'Islamabad', CAST(0xFFFFFFFE00EEF3E0 AS DateTime), CAST(0xFFFFFFFE0130DEE0 AS DateTime), N'Pakistan Airlines', 1, N'1', NULL, 100.0000, N'5', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (291, N'NL 078', N'Dubai', N'Islamabad', CAST(0xFFFFFFFE00F31290 AS DateTime), CAST(0xFFFFFFFE0134FD90 AS DateTime), N'Shaheen Air', 24, N'1', NULL, 90.0000, N'5', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (292, N'EK 664', N'Dubai', N'Islamabad', CAST(0xFFFFFFFE016EAB30 AS DateTime), CAST(0xFFFFFFFE00251430 AS DateTime), N'Emirates', 2, N'3', NULL, 120.0000, N'26', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (293, N'PK 118', N'Dubai', N'Islamabad', CAST(0xFFFFFFFE017B0740 AS DateTime), CAST(0xFFFFFFFE00317040 AS DateTime), N'Pakistan Airlines', 1, N'1', NULL, 100.0000, N'3', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (294, N'PK 104', N'Dubai', N'Islamabad', CAST(0xFFFFFFFE00107AC0 AS DateTime), CAST(0xFFFFFFFE006B1DE0 AS DateTime), N'Pakistan Airlines', 1, N'1', NULL, 100.0000, N'12', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (295, N'PK 104', N'Dubai', N'Islamabad', CAST(0xFFFFFFFE00107AC0 AS DateTime), CAST(0xFFFFFFFE0041EB00 AS DateTime), N'Pakistan Airlines', 1, N'1', NULL, 100.0000, N'37', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (296, N'EK 664', N'Dubai', N'Islamabad', CAST(0xFFFFFFFE003C6CC0 AS DateTime), CAST(0xFFFFFFFE007B98A0 AS DateTime), N'Emirates', 17, N'3', NULL, 120.0000, N'15', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (297, N'B4 1016', N'Dubai', N'Islamabad', CAST(0xFFFFFFFE0062E080 AS DateTime), CAST(0xFFFFFFFE009C8E20 AS DateTime), N'Bhoja Air', 25, N'1', NULL, 80.0000, N'47', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (298, N'E4 778', N'Dubai', N'Islamabad', CAST(0xFFFFFFFE010FE960 AS DateTime), CAST(0xFFFFFFFE014F1540 AS DateTime), N'Emirates', 12, N'3', NULL, 120.0000, N'57', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (299, N'NL 065', N'Dubai', N'Islamabad', CAST(0xFFFFFFFE01876350 AS DateTime), CAST(0xFFFFFFFE00568470 AS DateTime), N'Shaheen Air', 12, N'1', N'1', 90.0000, N'7', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (300, N'MH 030', N'Dubai', N'Istanbul', CAST(0xFFFFFFFE00099CF0 AS DateTime), CAST(0xFFFFFFFE005D6240 AS DateTime), N'Malaysia Airlines', 17, N'1', NULL, 110.0000, N'36', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (301, N'SQ 404', N'Dubai', N'Istanbul', CAST(0xFFFFFFFE0039ADA0 AS DateTime), CAST(0xFFFFFFFE00735B40 AS DateTime), N'Singapore Airlines', 17, N'1', NULL, 120.0000, N'247', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (302, N'SQ 424', N'Dubai', N'Istanbul', CAST(0xFFFFFFFE0044AA20 AS DateTime), CAST(0xFFFFFFFE007E57C0 AS DateTime), N'Singapore Airlines', 17, N'1', NULL, 120.0000, N'6', 5000)
GO
print 'Processed 300 total records'
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (303, N'TK 1169', N'Dubai', N'Istanbul', CAST(0xFFFFFFFE00476940 AS DateTime), CAST(0xFFFFFFFE00761A60 AS DateTime), N'Turkish Airlines', 2, N'1', NULL, 125.0000, N'27', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (304, N'TK 1163', N'Dubai', N'Istanbul', CAST(0xFFFFFFFE004A2860 AS DateTime), CAST(0xFFFFFFFE0078D980 AS DateTime), N'Turkish Airlines', 12, N'1', NULL, 125.0000, N'35', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (305, N'EK 031', N'Dubai', N'Istanbul', CAST(0xFFFFFFFE006DDD00 AS DateTime), CAST(0xFFFFFFFE00A62B10 AS DateTime), N'Emirates', 2, N'3', NULL, 140.0000, N'1234567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (306, N'EK 031', N'Dubai', N'Istanbul', CAST(0xFFFFFFFE00735B40 AS DateTime), CAST(0xFFFFFFFE00ABA950 AS DateTime), N'Emirates', 2, N'3', NULL, 140.0000, N'4', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (307, N'CX751', N'Mumbai', N'Dubai', CAST(0xFFFFFFFE0155F310 AS DateTime), CAST(0xFFFFFFFE016EAB30 AS DateTime), N'Cathay Pacific', 13, N'1', NULL, 110.0000, N'3467', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (308, N'BG 017', N'Mumbai', N'Dubai', CAST(0xFFFFFFFE015B7150 AS DateTime), CAST(0xFFFFFFFE01742970 AS DateTime), N'Biman Bangladesh', 19, N'1', NULL, 90.0000, N'3', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (309, N'BG 029', N'Mumbai', N'Dubai', CAST(0xFFFFFFFE015B7150 AS DateTime), CAST(0xFFFFFFFE01742970 AS DateTime), N'Biman Bangladesh', 19, N'1', NULL, 90.0000, N'6', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (310, N'AL 775', N'Mumbai', N'Dubai', CAST(0xFFFFFFFE002673C0 AS DateTime), CAST(0xFFFFFFFE0078D980 AS DateTime), N'Air India', 2, N'1', N'1', 100.0000, N'3', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (311, N'EK 501', N'Mumbai', N'Dubai', CAST(0xFFFFFFFE004A2860 AS DateTime), CAST(0xFFFFFFFE0062E080 AS DateTime), N'Emirates', 1, N'3', NULL, 130.0000, N'1234567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (312, N'AL711', N'Mumbai', N'Dubai', CAST(0xFFFFFFFE0078D980 AS DateTime), CAST(0xFFFFFFFE009191A0 AS DateTime), N'Air India', 1, N'1', NULL, 100.0000, N'6', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (313, N'AL 759', N'Mumbai', N'Dubai', CAST(0xFFFFFFFE00986F70 AS DateTime), CAST(0xFFFFFFFE00EEF3E0 AS DateTime), N'Air India', 2, N'1', N'1', 100.0000, N'7', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (314, N'EK 505', N'Mumbai', N'Dubai', CAST(0xFFFFFFFE00A0ACD0 AS DateTime), CAST(0xFFFFFFFE00B964F0 AS DateTime), N'Emirates', 20, N'3', NULL, 130.0000, N'124567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (315, N'AL 701', N'Mumbai', N'Dubai', CAST(0xFFFFFFFE00D37CA0 AS DateTime), CAST(0xFFFFFFFE014C5620 AS DateTime), N'Air India', 13, N'1', N'2', 100.0000, N'1', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (316, N'AL 709', N'Mumbai', N'Dubai', CAST(0xFFFFFFFE00DA5A70 AS DateTime), CAST(0xFFFFFFFE0134FD90 AS DateTime), N'Air India', 13, N'1', N'1', 100.0000, N'5', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (317, N'AL 771', N'Mumbai', N'Dubai', CAST(0xFFFFFFFE00F05370 AS DateTime), CAST(0xFFFFFFFE01206420 AS DateTime), N'Air India', 2, N'1', N'1', 100.0000, N'6', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (318, N'AL 755', N'Mumbai', N'Dubai', CAST(0xFFFFFFFE00FB4FF0 AS DateTime), CAST(0xFFFFFFFE0155F310 AS DateTime), N'Air India', 13, N'1', N'1', 100.0000, N'3', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (319, N'AL 747', N'Mumbai', N'Dubai', CAST(0xFFFFFFFE0125E260 AS DateTime), CAST(0xFFFFFFFE015A11C0 AS DateTime), N'Air India', 13, N'1', N'1', 100.0000, N'4', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (320, N'AL 765', N'Mumbai', N'Dubai', CAST(0xFFFFFFFE0130DEE0 AS DateTime), CAST(0xFFFFFFFE017F25F0 AS DateTime), N'Air India', 2, N'1', N'1', 100.0000, N'3', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (321, N'EK 503', N'Mumbai', N'Dubai', CAST(0xFFFFFFFE01391C40 AS DateTime), CAST(0xFFFFFFFE0151D460 AS DateTime), N'Emirates', 1, N'3', NULL, 130.0000, N'1234567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (322, N'AL 705', N'Mumbai', N'Dubai', CAST(0xFFFFFFFE013E9A80 AS DateTime), CAST(0xFFFFFFFE0155F310 AS DateTime), N'Air India', 13, N'1', NULL, 100.0000, N'7', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (323, N'AL 729', N'Mumbai', N'Dubai', CAST(0xFFFFFFFE017DC660 AS DateTime), CAST(0xFFFFFFFE000AFC80 AS DateTime), N'Air India', 2, N'1', NULL, 100.0000, N'1', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (324, N'AL 757', N'Mumbai', N'Dubai', CAST(0xFFFFFFFE0181E510 AS DateTime), CAST(0xFFFFFFFE000F1B30 AS DateTime), N'Air India', 2, N'1', NULL, 100.0000, N'2', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (325, N'AL 845', N'Mumbai', N'Dubai', CAST(0xFFFFFFFE01876350 AS DateTime), CAST(0xFFFFFFFE00149970 AS DateTime), N'Air India', 2, N'1', NULL, 100.0000, N'5', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (326, N'AL 932', N'Dubai', N'Mumbai', CAST(0xFFFFFFFE011148F0 AS DateTime), CAST(0xFFFFFFFE015752A0 AS DateTime), N'Air India', 1, N'1', NULL, 100.0000, N'2', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (327, N'CX 750', N'Dubai', N'Mumbai', CAST(0xFFFFFFFE018344A0 AS DateTime), CAST(0xFFFFFFFE003B0D30 AS DateTime), N'Cathay Pacific', 13, N'1', NULL, 110.0000, N'3467', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (328, N'BG 018', N'Dubai', N'Mumbai', CAST(0xFFFFFFFE018B3BB0 AS DateTime), CAST(0xFFFFFFFE0041EB00 AS DateTime), N'Biman Bangladesh', 19, N'1', NULL, 90.0000, N'3', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (329, N'BG 030', N'Dubai', N'Mumbai', CAST(0xFFFFFFFE018B3BB0 AS DateTime), CAST(0xFFFFFFFE0041EB00 AS DateTime), N'Biman Bangladesh', 19, N'1', NULL, 90.0000, N'6', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (330, N'AL 756', N'Dubai', N'Mumbai', CAST(0xFFFFFFFE001F95F0 AS DateTime), CAST(0xFFFFFFFE009DEDB0 AS DateTime), N'Air India', 2, N'1', N'1', 100.0000, N'3', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (331, N'AL 844', N'Dubai', N'Mumbai', CAST(0xFFFFFFFE00251430 AS DateTime), CAST(0xFFFFFFFE009DEDB0 AS DateTime), N'Air India', 2, N'1', N'1', 100.0000, N'6', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (332, N'EK 504', N'Dubai', N'Mumbai', CAST(0xFFFFFFFE0041EB00 AS DateTime), CAST(0xFFFFFFFE0087F4B0 AS DateTime), N'Emirates', 1, N'3', NULL, 130.0000, N'124567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (333, N'AL 774', N'Dubai', N'Mumbai', CAST(0xFFFFFFFE00895440 AS DateTime), CAST(0xFFFFFFFE010BCAB0 AS DateTime), N'Air India', 2, N'1', N'1', 100.0000, N'3', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (334, N'AL 728', N'Dubai', N'Mumbai', CAST(0xFFFFFFFE00BD83A0 AS DateTime), CAST(0xFFFFFFFE01365D20 AS DateTime), N'Air India', 2, N'1', N'1', 100.0000, N'2', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (335, N'EK 502', N'Dubai', N'Mumbai', CAST(0xFFFFFFFE00DE7920 AS DateTime), CAST(0xFFFFFFFE012482D0 AS DateTime), N'Emirates', 1, N'3', NULL, 130.0000, N'1234567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (336, N'AL 758', N'Dubai', N'Mumbai', CAST(0xFFFFFFFE00FF6EA0 AS DateTime), CAST(0xFFFFFFFE01876350 AS DateTime), N'Air India', 2, N'1', N'1', 100.0000, N'7', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (337, N'AL 748', N'Dubai', N'Mumbai', CAST(0xFFFFFFFE01038D50 AS DateTime), CAST(0xFFFFFFFE0163AEB0 AS DateTime), N'Air India', 1, N'1', N'1', 100.0000, N'5', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (338, N'AL 932', N'Dubai', N'Mumbai', CAST(0xFFFFFFFE01038D50 AS DateTime), CAST(0xFFFFFFFE01483770 AS DateTime), N'Air India', 2, N'1', NULL, 100.0000, N'2', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (339, N'AL 770', N'Dubai', N'Mumbai', CAST(0xFFFFFFFE0134FD90 AS DateTime), CAST(0xFFFFFFFE002932E0 AS DateTime), N'Air India', 2, N'1', N'1', 100.0000, N'6', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (340, N'AL 708', N'Dubai', N'Mumbai', CAST(0xFFFFFFFE0146D7E0 AS DateTime), CAST(0xFFFFFFFE00434A90 AS DateTime), N'Air India', 13, N'1', N'1', 100.0000, N'5', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (341, N'AL 740', N'Dubai', N'Mumbai', CAST(0xFFFFFFFE01483770 AS DateTime), CAST(0xFFFFFFFE00015F90 AS DateTime), N'Air India', 1, N'1', NULL, 100.0000, N'7', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (342, N'AL 700', N'Dubai', N'Mumbai', CAST(0xFFFFFFFE015CD0E0 AS DateTime), CAST(0xFFFFFFFE0057E400 AS DateTime), N'Air India', 13, N'1', N'1', 100.0000, N'1', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (343, N'AL 710', N'Dubai', N'Mumbai', CAST(0xFFFFFFFE016A8C80 AS DateTime), CAST(0xFFFFFFFE0023B4A0 AS DateTime), N'Air India', 1, N'1', NULL, 100.0000, N'6', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (344, N'AL 720', N'Dubai', N'Mumbai', CAST(0xFFFFFFFE016A8C80 AS DateTime), CAST(0xFFFFFFFE00568470 AS DateTime), N'Air India', 13, N'1', N'1', 100.0000, N'7', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (345, N'AL 754', N'Dubai', N'Mumbai', CAST(0xFFFFFFFE016A8C80 AS DateTime), CAST(0xFFFFFFFE00225510 AS DateTime), N'Air India', 13, N'1', NULL, 100.0000, N'3', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (346, N'AL 746', N'Dubai', N'Mumbai', CAST(0xFFFFFFFE016EAB30 AS DateTime), CAST(0xFFFFFFFE002673C0 AS DateTime), N'Air India', 13, N'1', NULL, 100.0000, N'4', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (347, N'EK 500', N'Dubai', N'Mumbai', CAST(0xFFFFFFFE0172C9E0 AS DateTime), CAST(0xFFFFFFFE002D5190 AS DateTime), N'Emirates', 1, N'3', NULL, 130.0000, N'1234567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (348, N'AL 722', N'Dubai', N'Mumbai', CAST(0xFFFFFFFE0176E890 AS DateTime), CAST(0xFFFFFFFE003F2BE0 AS DateTime), N'Air India', 13, N'1', NULL, 100.0000, N'2', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (349, N'PK 725', N'Karachi', N'Dubai', CAST(0xFFFFFFFE00735B40 AS DateTime), CAST(0xFFFFFFFE0083D600 AS DateTime), N'Pakistan Airlines', 13, N'1', NULL, 100.0000, N'3', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (350, N'E4 795', N'Karachi', N'Dubai', CAST(0xFFFFFFFE00A4CB80 AS DateTime), CAST(0xFFFFFFFE00E6B680 AS DateTime), N'Aeroasia', 12, N'2', N'1', 90.0000, N'6', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (351, N'PK 123', N'Karachi', N'Dubai', CAST(0xFFFFFFFE00AD08E0 AS DateTime), CAST(0xFFFFFFFE00C042C0 AS DateTime), N'Pakistan Airlines', 1, N'1', NULL, 100.0000, N'5', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (352, N'PK 795', N'Karachi', N'Dubai', CAST(0xFFFFFFFE00AD08E0 AS DateTime), CAST(0xFFFFFFFE00BD83A0 AS DateTime), N'Pakistan Airlines', 13, N'1', NULL, 100.0000, N'7', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (353, N'EK 605', N'Karachi', N'Dubai', CAST(0xFFFFFFFE00E6B680 AS DateTime), CAST(0xFFFFFFFE00F73140 AS DateTime), N'Emirates', 20, N'3', NULL, 120.0000, N'2347', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (354, N'NL 091', N'Karachi', N'Dubai', CAST(0xFFFFFFFE011C4570 AS DateTime), CAST(0xFFFFFFFE0134FD90 AS DateTime), N'Shaheen Air', 24, N'1', NULL, 80.0000, N'25', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (355, N'PK 119', N'Karachi', N'Dubai', CAST(0xFFFFFFFE01624F20 AS DateTime), CAST(0xFFFFFFFE0172C9E0 AS DateTime), N'Pakistan Airlines', 1, N'1', NULL, 100.0000, N'1234567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (356, N'PK189', N'Karachi', N'Dubai', CAST(0xFFFFFFFE017B0740 AS DateTime), CAST(0xFFFFFFFE00041EB0 AS DateTime), N'Pakistan Airlines', 1, N'1', NULL, 100.0000, N'3', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (357, N'PK 187', N'Karachi', N'Dubai', CAST(0xFFFFFFFE018A2270 AS DateTime), CAST(0xFFFFFFFE00107AC0 AS DateTime), N'Pakistan Airlines', 2, N'1', NULL, 100.0000, N'1', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (358, N'SR 395', N'Karachi', N'Dubai', CAST(0xFFFFFFFE00057E40 AS DateTime), CAST(0xFFFFFFFE0018B820 AS DateTime), N'Swissair', 5, N'1', NULL, 110.0000, N'357', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (359, N'SU 540', N'Karachi', N'Dubai', CAST(0xFFFFFFFE00083D60 AS DateTime), CAST(0xFFFFFFFE0018B820 AS DateTime), N'Aeroflot', 2, N'1', NULL, 90.0000, N'4', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (360, N'PK 191', N'Karachi', N'Dubai', CAST(0xFFFFFFFE00107AC0 AS DateTime), CAST(0xFFFFFFFE00251430 AS DateTime), N'Pakistan Airlines', 1, N'1', NULL, 100.0000, N'3', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (361, N'ET 643', N'Karachi', N'Dubai', CAST(0xFFFFFFFE0020F580 AS DateTime), CAST(0xFFFFFFFE00317040 AS DateTime), N'Ethiopian Airlines', 15, N'1', NULL, 100.0000, N'4', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (362, N'ET 663', N'Karachi', N'Dubai', CAST(0xFFFFFFFE0020F580 AS DateTime), CAST(0xFFFFFFFE00317040 AS DateTime), N'Ethiopian Airlines', 14, N'1', NULL, 100.0000, N'6', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (363, N'KQ 313', N'Karachi', N'Dubai', CAST(0xFFFFFFFE002673C0 AS DateTime), CAST(0xFFFFFFFE00384E10 AS DateTime), N'Kenya Airlines', 2, N'1', NULL, 85.0000, N'5', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (364, N'IY 861', N'Karachi', N'Dubai', CAST(0xFFFFFFFE005265C0 AS DateTime), CAST(0xFFFFFFFE0062E080 AS DateTime), N'Yemenia', 11, N'1', NULL, 90.0000, N'1', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (365, N'RJ 191', N'Karachi', N'Dubai', CAST(0xFFFFFFFE0066FF30 AS DateTime), CAST(0xFFFFFFFE007B98A0 AS DateTime), N'Royal Jordanian', 22, N'1', NULL, 100.0000, N'26', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (366, N'EK 601', N'Karachi', N'Dubai', CAST(0xFFFFFFFE00C9DFB0 AS DateTime), CAST(0xFFFFFFFE00DA5A70 AS DateTime), N'Emirates', 17, N'3', NULL, 120.0000, N'1234567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (367, N'E4 786', N'Karachi', N'Dubai', CAST(0xFFFFFFFE00D63BC0 AS DateTime), CAST(0xFFFFFFFE00E6B680 AS DateTime), N'Aeroasia', 12, N'2', NULL, 90.0000, N'2457', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (368, N'B4 1009', N'Karachi', N'Dubai', CAST(0xFFFFFFFE00E297D0 AS DateTime), CAST(0xFFFFFFFE00F890D0 AS DateTime), N'Bhoja Air', 25, N'1', NULL, 90.0000, N'136', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (369, N'EK 611', N'Karachi', N'Dubai', CAST(0xFFFFFFFE00EAD530 AS DateTime), CAST(0xFFFFFFFE00FB4FF0 AS DateTime), N'Emirates', 1, N'3', NULL, 120.0000, N'16', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (370, N'MH 160', N'Karachi', N'Dubai', CAST(0xFFFFFFFE010E89D0 AS DateTime), CAST(0xFFFFFFFE011F0490 AS DateTime), N'Malaysia Airlines', 5, N'1', NULL, 110.0000, N'47', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (371, N'EK 603', N'Karachi', N'Dubai', CAST(0xFFFFFFFE0172C9E0 AS DateTime), CAST(0xFFFFFFFE018344A0 AS DateTime), N'Emirates', 2, N'3', NULL, 100.0000, N'1234567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (372, N'KQ 311', N'Karachi', N'Dubai', CAST(0xFFFFFFFE01808580 AS DateTime), CAST(0xFFFFFFFE0006DDD0 AS DateTime), N'Kenya Airlines', 2, N'1', NULL, 85.0000, N'1', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (373, N'PK 144', N'Dubai', N'Karachi', CAST(0xFFFFFFFE00DE7920 AS DateTime), CAST(0xFFFFFFFE010FE960 AS DateTime), N'Royal Jordanian', 1, N'1', NULL, 100.0000, N'124567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (374, N'PK10', N'Dubai', N'Karachi', CAST(0xFFFFFFFE00F73140 AS DateTime), CAST(0xFFFFFFFE0128A180 AS DateTime), N'Pakistan Airlines', 1, N'1', NULL, 100.0000, N'3', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (375, N'E4 796', N'Dubai', N'Karachi', CAST(0xFFFFFFFE0107AC00 AS DateTime), CAST(0xFFFFFFFE01499700 AS DateTime), N'Aeroasia', 12, N'2', N'1', 90.0000, N'6', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (376, N'KQ 310', N'Dubai', N'Karachi', CAST(0xFFFFFFFE01365D20 AS DateTime), CAST(0xFFFFFFFE0167CD60 AS DateTime), N'Kenya Airlines', 2, N'1', NULL, 85.0000, N'1', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (377, N'NL 092', N'Dubai', N'Karachi', CAST(0xFFFFFFFE01457850 AS DateTime), CAST(0xFFFFFFFE01784820 AS DateTime), N'Shaheen Air', 24, N'1', NULL, 80.0000, N'25', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (378, N'IY 860', N'Dubai', N'Karachi', CAST(0xFFFFFFFE017B0740 AS DateTime), CAST(0xFFFFFFFE00317040 AS DateTime), N'Yemenia', 11, N'1', NULL, 90.0000, N'7', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (379, N'EK 610', N'Dubai', N'Karachi', CAST(0xFFFFFFFE0018B820 AS DateTime), CAST(0xFFFFFFFE004A2860 AS DateTime), N'Emirates', 2, N'3', NULL, 120.0000, N'13', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (380, N'PK 190', N'Dubai', N'Karachi', CAST(0xFFFFFFFE0018B820 AS DateTime), CAST(0xFFFFFFFE004A2860 AS DateTime), N'Pakistan Airlines', 1, N'1', NULL, 100.0000, N'4', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (381, N'RJ 190', N'Dubai', N'Karachi', CAST(0xFFFFFFFE0020F580 AS DateTime), CAST(0xFFFFFFFE00510630 AS DateTime), N'Royal Jordanian', 2, N'1', NULL, 100.0000, N'26', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (382, N'PK 188', N'Dubai', N'Karachi', CAST(0xFFFFFFFE0023B4A0 AS DateTime), CAST(0xFFFFFFFE005524E0 AS DateTime), N'Pakistan Airlines', 1, N'1', NULL, 100.0000, N'2', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (383, N'PK 192', N'Dubai', N'Karachi', CAST(0xFFFFFFFE0039ADA0 AS DateTime), CAST(0xFFFFFFFE006B1DE0 AS DateTime), N'Pakistan Airlines', 1, N'1', NULL, 100.0000, N'3', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (384, N'PK 727', N'Dubai', N'Karachi', CAST(0xFFFFFFFE004A2860 AS DateTime), CAST(0xFFFFFFFE007B98A0 AS DateTime), N'Pakistan Airlines', 13, N'1', NULL, 100.0000, N'4', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (385, N'PK 728', N'Dubai', N'Karachi', CAST(0xFFFFFFFE00735B40 AS DateTime), CAST(0xFFFFFFFE00AD08E0 AS DateTime), N'Pakistan Airlines', 13, N'1', NULL, 100.0000, N'1', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (386, N'EK 600', N'Dubai', N'Karachi', CAST(0xFFFFFFFE0083D600 AS DateTime), CAST(0xFFFFFFFE00B54640 AS DateTime), N'Emirates', 17, N'3', NULL, 120.0000, N'1234567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (387, N'E4 787', N'Dubai', N'Karachi', CAST(0xFFFFFFFE009450C0 AS DateTime), CAST(0xFFFFFFFE00C301E0 AS DateTime), N'Aeroasia', 12, N'2', NULL, 90.0000, N'2457', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (388, N'EK 604', N'Dubai', N'Karachi', CAST(0xFFFFFFFE00A0ACD0 AS DateTime), CAST(0xFFFFFFFE00D21D10 AS DateTime), N'Emirates', 20, N'3', NULL, 120.0000, N'2347', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (389, N'B4 1010', N'Dubai', N'Karachi', CAST(0xFFFFFFFE00F73140 AS DateTime), CAST(0xFFFFFFFE0128A180 AS DateTime), N'Bhoja Air', 25, N'1', NULL, 100.0000, N'247', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (390, N'E4 787', N'Dubai', N'Karachi', CAST(0xFFFFFFFE01206420 AS DateTime), CAST(0xFFFFFFFE014F1540 AS DateTime), N'Aeroasia', 12, N'2', NULL, 90.0000, N'1234567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (391, N'EK 602', N'Dubai', N'Karachi', CAST(0xFFFFFFFE012CC030 AS DateTime), CAST(0xFFFFFFFE015E3070 AS DateTime), N'Emirates', 2, N'3', NULL, 120.0000, N'3', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (392, N'ET 632', N'Dubai', N'Karachi', CAST(0xFFFFFFFE0134FD90 AS DateTime), CAST(0xFFFFFFFE016A8C80 AS DateTime), N'Ethiopian Airlines', 15, N'1', NULL, 100.0000, N'5', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (393, N'ET 652', N'Dubai', N'Karachi', CAST(0xFFFFFFFE0134FD90 AS DateTime), CAST(0xFFFFFFFE016A8C80 AS DateTime), N'Ethiopian Airlines', 14, N'1', NULL, 100.0000, N'47', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (394, N'MH 161', N'Dubai', N'Karachi', CAST(0xFFFFFFFE01391C40 AS DateTime), CAST(0xFFFFFFFE016BEC10 AS DateTime), N'Malaysia Airlines', 5, N'1', NULL, 110.0000, N'5', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (395, N'SU 539', N'Dubai', N'Karachi', CAST(0xFFFFFFFE01457850 AS DateTime), CAST(0xFFFFFFFE01784820 AS DateTime), N'Aeroflot', 2, N'1', NULL, 100.0000, N'246', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (396, N'SR 394', N'Dubai', N'Karachi', CAST(0xFFFFFFFE01499700 AS DateTime), CAST(0xFFFFFFFE0179A7B0 AS DateTime), N'Swissair', 1, N'1', NULL, 110.0000, N'4', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (397, N'KQ 312', N'Dubai', N'Karachi', CAST(0xFFFFFFFE015CD0E0 AS DateTime), CAST(0xFFFFFFFE001339E0 AS DateTime), N'Kenya Airlines', 2, N'1', NULL, 85.0000, N'4', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (398, N'MH 091', N'New York', N'Dubai', CAST(0xFFFFFFFE010BCAB0 AS DateTime), CAST(0xFFFFFFFE00510630 AS DateTime), N'Malaysia Airlines', 17, N'1', NULL, 210.0000, N'257', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (399, N'MH 090', N'Dubai', N'New York', CAST(0xFFFFFFFE0179A7B0 AS DateTime), CAST(0xFFFFFFFE00E3F760 AS DateTime), N'Malaysia Airlines', 17, N'1', NULL, 210.0000, N'146', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (400, N'EK 081', N'Rome', N'Dubai', CAST(0xFFFFFFFE00CDFE60 AS DateTime), CAST(0xFFFFFFFE018B3BB0 AS DateTime), N'Emirates', 1, N'3', N'1', 140.0000, N'57', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (401, N'EK 017', N'Rome', N'Dubai', CAST(0xFFFFFFFE00FCAF80 AS DateTime), CAST(0xFFFFFFFE018A2270 AS DateTime), N'Emirates', 1, N'3', NULL, 140.0000, N'1', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (402, N'BG 007', N'Dubai', N'Rome', CAST(0xFFFFFFFE00476940 AS DateTime), CAST(0xFFFFFFFE009191A0 AS DateTime), N'Biman Bangladesh', 19, N'1', NULL, 120.0000, N'4', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (403, N'EK 017', N'Dubai', N'Rome', CAST(0xFFFFFFFE007779F0 AS DateTime), CAST(0xFFFFFFFE00F47220 AS DateTime), N'Emirates', 1, N'3', N'1', 140.0000, N'16', 10000)
GO
print 'Processed 400 total records'
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (404, N'EK 018', N'Dubai', N'Rome', CAST(0xFFFFFFFE007779F0 AS DateTime), CAST(0xFFFFFFFE00C1A250 AS DateTime), N'Emirates', 1, N'3', NULL, 140.0000, N'57', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (405, N'EK 810', N'Colombo', N'Dubai', CAST(0xFFFFFFFE00AA49C0 AS DateTime), CAST(0xFFFFFFFE00F73140 AS DateTime), N'Emirates', 1, N'3', N'1', 130.0000, N'16', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (406, N'EK 801', N'Colombo', N'Dubai', CAST(0xFFFFFFFE00B3E6B0 AS DateTime), CAST(0xFFFFFFFE00D8FAE0 AS DateTime), N'Emirates', 2, N'3', NULL, 130.0000, N'3', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (407, N'UL 531', N'Colombo', N'Dubai', CAST(0xFFFFFFFE001339E0 AS DateTime), CAST(0xFFFFFFFE003B0D30 AS DateTime), N'Sri Lankan', 5, N'1', NULL, 110.0000, N'257', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (408, N'EK 815', N'Colombo', N'Dubai', CAST(0xFFFFFFFE00149970 AS DateTime), CAST(0xFFFFFFFE005EC1D0 AS DateTime), N'Emirates', 2, N'3', N'1', 130.0000, N'357', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (409, N'EK 077', N'Colombo', N'Dubai', CAST(0xFFFFFFFE00358EF0 AS DateTime), CAST(0xFFFFFFFE005AA320 AS DateTime), N'Emirates', 17, N'3', NULL, 130.0000, N'1356', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (410, N'UL 227', N'Colombo', N'Dubai', CAST(0xFFFFFFFE00FE0F10 AS DateTime), CAST(0xFFFFFFFE0125E260 AS DateTime), N'Sri Lankan', 22, N'1', NULL, 110.0000, N'3', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (411, N'UL 265', N'Colombo', N'Dubai', CAST(0xFFFFFFFE011AE5E0 AS DateTime), CAST(0xFFFFFFFE018603C0 AS DateTime), N'Sri Lankan', 22, N'1', N'1', 110.0000, N'1', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (412, N'UL 203', N'Colombo', N'Dubai', CAST(0xFFFFFFFE0142B930 AS DateTime), CAST(0xFFFFFFFE01716A50 AS DateTime), N'Sri Lankan', 3, N'1', NULL, 110.0000, N'4', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (413, N'UL 205', N'Colombo', N'Dubai', CAST(0xFFFFFFFE014F1540 AS DateTime), CAST(0xFFFFFFFE017DC660 AS DateTime), N'Sri Lankan', 3, N'1', NULL, 110.0000, N'67', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (414, N'RB 515', N'Damascus', N'Dubai', CAST(0xFFFFFFFE00AD08E0 AS DateTime), CAST(0xFFFFFFFE00F05370 AS DateTime), N'Syrian Arab Airlines', 3, N'1', NULL, 100.0000, N'6', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (415, N'EK 912', N'Damascus', N'Dubai', CAST(0xFFFFFFFE00B54640 AS DateTime), CAST(0xFFFFFFFE00F73140 AS DateTime), N'Emirates', 2, N'3', NULL, 120.0000, N'5', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (416, N'EK 912', N'Damascus', N'Dubai', CAST(0xFFFFFFFE011F0490 AS DateTime), CAST(0xFFFFFFFE0160EF90 AS DateTime), N'Emirates', 1, N'3', NULL, 120.0000, N'246', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (417, N'RB 525', N'Damascus', N'Dubai', CAST(0xFFFFFFFE01391C40 AS DateTime), CAST(0xFFFFFFFE017B0740 AS DateTime), N'Syrian Arab Airlines', 11, N'1', NULL, 100.0000, N'2', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (418, N'RB 525', N'Damascus', N'Dubai', CAST(0xFFFFFFFE0176E890 AS DateTime), CAST(0xFFFFFFFE002D5190 AS DateTime), N'Syrian Arab Airlines', 11, N'1', NULL, 100.0000, N'5', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (419, N'RB 525', N'Damascus', N'Dubai', CAST(0xFFFFFFFE007A3910 AS DateTime), CAST(0xFFFFFFFE00DA5A70 AS DateTime), N'Syrian Arab Airlines', 11, N'1', N'1', 100.0000, N'5', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (420, N'UL 204', N'Dubai', N'Colombo', CAST(0xFFFFFFFE0188C2E0 AS DateTime), CAST(0xFFFFFFFE00644010 AS DateTime), N'Sri Lankan', 3, N'1', NULL, 110.0000, N'4', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (421, N'UL 206', N'Dubai', N'Colombo', CAST(0xFFFFFFFE000AFC80 AS DateTime), CAST(0xFFFFFFFE00735B40 AS DateTime), N'Sri Lankan', 3, N'1', NULL, 110.0000, N'17', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (422, N'UL 228', N'Dubai', N'Colombo', CAST(0xFFFFFFFE000AFC80 AS DateTime), CAST(0xFFFFFFFE0071FBB0 AS DateTime), N'Sri Lankan', 22, N'1', NULL, 110.0000, N'3', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (423, N'UL 266', N'Dubai', N'Colombo', CAST(0xFFFFFFFE000DBBA0 AS DateTime), CAST(0xFFFFFFFE00735B40 AS DateTime), N'Sri Lankan', 22, N'1', NULL, 110.0000, N'1', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (424, N'UL 264', N'Dubai', N'Colombo', CAST(0xFFFFFFFE001339E0 AS DateTime), CAST(0xFFFFFFFE007A3910 AS DateTime), N'Sri Lankan', 22, N'1', NULL, 110.0000, N'3', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (425, N'EK 810', N'Dubai', N'Colombo', CAST(0xFFFFFFFE002EB120 AS DateTime), CAST(0xFFFFFFFE0095B050 AS DateTime), N'Emirates', 1, N'3', NULL, 130.0000, N'16', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (426, N'EK 076', N'Dubai', N'Colombo', CAST(0xFFFFFFFE0039ADA0 AS DateTime), CAST(0xFFFFFFFE009F4D40 AS DateTime), N'Emirates', 17, N'3', NULL, 130.0000, N'247', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (427, N'EK 800', N'Dubai', N'Colombo', CAST(0xFFFFFFFE0039ADA0 AS DateTime), CAST(0xFFFFFFFE009F4D40 AS DateTime), N'Emirates', 2, N'3', NULL, 130.0000, N'3', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (428, N'EK 814', N'Dubai', N'Colombo', CAST(0xFFFFFFFE00408B70 AS DateTime), CAST(0xFFFFFFFE00C9DFB0 AS DateTime), N'Emirates', 1, N'3', N'1', 130.0000, N'246', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (429, N'EK 076', N'Dubai', N'Colombo', CAST(0xFFFFFFFE008D72F0 AS DateTime), CAST(0xFFFFFFFE00F47220 AS DateTime), N'Emirates', 17, N'3', NULL, 130.0000, N'5', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (430, N'UL 532', N'Dubai', N'Colombo', CAST(0xFFFFFFFE0167CD60 AS DateTime), CAST(0xFFFFFFFE0041EB00 AS DateTime), N'Sri Lankan', 5, N'1', NULL, 110.0000, N'257', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (431, N'RB 526', N'Dubai', N'Damascus', CAST(0xFFFFFFFE00EAD530 AS DateTime), CAST(0xFFFFFFFE014DB5B0 AS DateTime), N'Syrian Arab Airlines', 11, N'1', NULL, 100.0000, N'5', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (432, N'EK 911', N'Dubai', N'Damascus', CAST(0xFFFFFFFE00EC34C0 AS DateTime), CAST(0xFFFFFFFE010E89D0 AS DateTime), N'Emirates', 1, N'3', NULL, 120.0000, N'246', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (433, N'RB 516', N'Dubai', N'Damascus', CAST(0xFFFFFFFE00EEF3E0 AS DateTime), CAST(0xFFFFFFFE011826C0 AS DateTime), N'Syrian Arab Airlines', 11, N'1', NULL, 100.0000, N'4', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (434, N'RB 516', N'Dubai', N'Damascus', CAST(0xFFFFFFFE0100CE30 AS DateTime), CAST(0xFFFFFFFE01232340 AS DateTime), N'Syrian Arab Airlines', 11, N'1', NULL, 100.0000, N'6', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (435, N'RB 526', N'Dubai', N'Damascus', CAST(0xFFFFFFFE004609B0 AS DateTime), CAST(0xFFFFFFFE006B1DE0 AS DateTime), N'Syrian Arab Airlines', 11, N'1', NULL, 100.0000, N'3', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (436, N'EK 911', N'Dubai', N'Damascus', CAST(0xFFFFFFFE007B98A0 AS DateTime), CAST(0xFFFFFFFE009F4D40 AS DateTime), N'Emirates', 2, N'3', NULL, 120.0000, N'5', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (437, N'RB 516', N'Dubai', N'Damascus', CAST(0xFFFFFFFE00827670 AS DateTime), CAST(0xFFFFFFFE00A62B10 AS DateTime), N'Syrian Arab Airlines', 11, N'1', NULL, 100.0000, N'6', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (438, N'EK 008', N'London (LGW)', N'Dubai', CAST(0xFFFFFFFE00A8EA30 AS DateTime), CAST(0xFFFFFFFE014DB5B0 AS DateTime), N'Emirates', 17, N'3', NULL, 170.0000, N'1234567', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (439, N'HM 027', N'London(LGW)', N'Dubai', CAST(0xFFFFFFFE01206420 AS DateTime), CAST(0xFFFFFFFE004609B0 AS DateTime), N'Air Seychelles', 15, N'1', NULL, 140.0000, N'3', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (440, N'PK 728', N'London(LHR)', N'Dubai', CAST(0xFFFFFFFE011148F0 AS DateTime), CAST(0xFFFFFFFE003B0D30 AS DateTime), N'Pakistan Airlines', 13, N'1', NULL, 140.0000, N'3', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (441, N'EK 004', N'London (LHR)', N'Dubai', CAST(0xFFFFFFFE0155F310 AS DateTime), CAST(0xFFFFFFFE006F3C90 AS DateTime), N'Emirates', 17, N'3', NULL, 170.0000, N'1234567', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (442, N'BI 096', N'London (LHR)', N'Dubai', CAST(0xFFFFFFFE00D37CA0 AS DateTime), CAST(0xFFFFFFFE0188C2E0 AS DateTime), N'Royal Brunei', 17, N'1', NULL, 130.0000, N'5', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (443, N'BI 098', N'London (LHR)', N'Dubai', CAST(0xFFFFFFFE00D4DC30 AS DateTime), CAST(0xFFFFFFFE018A2270 AS DateTime), N'Royal Brunei', 15, N'1', NULL, 130.0000, N'3', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (444, N'BA 107', N'London (LHR)', N'Dubai', CAST(0xFFFFFFFE00D63BC0 AS DateTime), CAST(0xFFFFFFFE0188C2E0 AS DateTime), N'Royal Brunei', 17, N'1', NULL, 130.0000, N'1234567', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (445, N'BI 098', N'London (LHR)', N'Dubai', CAST(0xFFFFFFFE00DBBA00 AS DateTime), CAST(0xFFFFFFFE00099CF0 AS DateTime), N'Royal Brunei', 15, N'1', NULL, 130.0000, N'5', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (446, N'EK 002', N'London (LHR)', N'Dubai', CAST(0xFFFFFFFE00E297D0 AS DateTime), CAST(0xFFFFFFFE018344A0 AS DateTime), N'Emirates', 17, N'3', NULL, 170.0000, N'1234567', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (447, N'BI 098', N'London (LHR)', N'Dubai', CAST(0xFFFFFFFE00FB4FF0 AS DateTime), CAST(0xFFFFFFFE0027D350 AS DateTime), N'Royal Brunei', 15, N'1', NULL, 130.0000, N'1', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (448, N'PK 722', N'London (LHR)', N'Dubai', CAST(0xFFFFFFFE011148F0 AS DateTime), CAST(0xFFFFFFFE002A9270 AS DateTime), N'Pakistan Airlines', 13, N'1', NULL, 140.0000, N'5', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (449, N'PK 728', N'London (LHR)', N'Dubai', CAST(0xFFFFFFFE01499700 AS DateTime), CAST(0xFFFFFFFE0062E080 AS DateTime), N'Pakistan Airlines', 13, N'1', NULL, 140.0000, N'7', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (450, N'BA 109', N'London (LHR)', N'Dubai', CAST(0xFFFFFFFE015B7150 AS DateTime), CAST(0xFFFFFFFE00827670 AS DateTime), N'British Airways', 17, N'1', NULL, 160.0000, N'1234567', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (451, N'EK 006', N'London (LHR)', N'Dubai', CAST(0xFFFFFFFE01700AC0 AS DateTime), CAST(0xFFFFFFFE0095B050 AS DateTime), N'Emirates', 2, N'3', NULL, 170.0000, N'1234567', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (452, N'HM 028', N'Dubai', N'London (LGW)', CAST(0xFFFFFFFE00149970 AS DateTime), CAST(0xFFFFFFFE006B1DE0 AS DateTime), N'Air Seychelles', 15, N'1', NULL, 140.0000, N'3', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (453, N'EK 007', N'Dubai', N'London (LGW)', CAST(0xFFFFFFFE00251430 AS DateTime), CAST(0xFFFFFFFE0071FBB0 AS DateTime), N'Emirates', 17, N'3', NULL, 170.0000, N'1234567', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (454, N'BI 097', N'Dubai', N'London (LHR)', CAST(0xFFFFFFFE0011DA50 AS DateTime), CAST(0xFFFFFFFE00644010 AS DateTime), N'Royal Brunei', 15, N'1', NULL, 130.0000, N'3', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (455, N'BI 098', N'Dubai', N'London (LHR)', CAST(0xFFFFFFFE001A17B0 AS DateTime), CAST(0xFFFFFFFE006C7D70 AS DateTime), N'Royal Brunei', 15, N'1', NULL, 130.0000, N'7', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (456, N'BA 106', N'Dubai', N'London (LHR)', CAST(0xFFFFFFFE002932E0 AS DateTime), CAST(0xFFFFFFFE00735B40 AS DateTime), N'British Airways', 17, N'1', NULL, 160.0000, N'1234567', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (457, N'BG 001', N'Dubai', N'London (LHR)', CAST(0xFFFFFFFE002932E0 AS DateTime), CAST(0xFFFFFFFE00AD08E0 AS DateTime), N'Biman Bangladesh', 19, N'1', N'1', 140.0000, N'2', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (458, N'BI 095', N'Dubai', N'London (LHR)', CAST(0xFFFFFFFE002A9270 AS DateTime), CAST(0xFFFFFFFE007CF830 AS DateTime), N'Royal Brunei', 15, N'1', NULL, 130.0000, N'5', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (459, N'BI 097', N'Dubai', N'London (LHR)', CAST(0xFFFFFFFE0039ADA0 AS DateTime), CAST(0xFFFFFFFE0083D600 AS DateTime), N'Royal Brunei', 16, N'1', NULL, 130.0000, N'4', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (460, N'BG 007', N'Dubai', N'London (LHR)', CAST(0xFFFFFFFE00476940 AS DateTime), CAST(0xFFFFFFFE00B6A5D0 AS DateTime), N'Biman Bangladesh', 19, N'1', N'1', 140.0000, N'4', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (461, N'BG 005', N'Dubai', N'London (LHR)', CAST(0xFFFFFFFE004CE780 AS DateTime), CAST(0xFFFFFFFE0099CF00 AS DateTime), N'Biman Bangladesh', 19, N'1', NULL, 140.0000, N'7', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (462, N'BG 003', N'Dubai', N'London (LHR)', CAST(0xFFFFFFFE004FA6A0 AS DateTime), CAST(0xFFFFFFFE00C5C100 AS DateTime), N'Biman Bangladesh', 19, N'1', N'1', 140.0000, N'6', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (463, N'EK 001', N'Dubai', N'London (LHR)', CAST(0xFFFFFFFE007FB750 AS DateTime), CAST(0xFFFFFFFE00C9DFB0 AS DateTime), N'Emirates', 17, N'3', NULL, 170.0000, N'1234567', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (464, N'PK 725', N'Dubai', N'London (LHR)', CAST(0xFFFFFFFE0095B050 AS DateTime), CAST(0xFFFFFFFE00DE7920 AS DateTime), N'Pakistan Airlines', 13, N'1', NULL, 140.0000, N'35', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (465, N'BA 108', N'Dubai', N'London (LHR)', CAST(0xFFFFFFFE009C8E20 AS DateTime), CAST(0xFFFFFFFE00E6B680 AS DateTime), N'British Airways', 17, N'1', NULL, 160.0000, N'1234567', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (466, N'PK 725', N'Dubai', N'London (LHR)', CAST(0xFFFFFFFE00CDFE60 AS DateTime), CAST(0xFFFFFFFE0116C730 AS DateTime), N'Pakistan Airlines', 13, N'1', NULL, 140.0000, N'7', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (467, N'EK 003', N'Dubai', N'London (LHR)', CAST(0xFFFFFFFE00F31290 AS DateTime), CAST(0xFFFFFFFE013D3AF0 AS DateTime), N'Emirates', 17, N'3', NULL, 170.0000, N'1234567', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (468, N'EK 005', N'Dubai', N'London (LHR)', CAST(0xFFFFFFFE011DA500 AS DateTime), CAST(0xFFFFFFFE015B7150 AS DateTime), N'Emirates', 2, N'3', NULL, 170.0000, N'1234567', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (469, N'OK 401', N'Dubai', N'Prague', CAST(0xFFFFFFFE00015F90 AS DateTime), CAST(0xFFFFFFFE0062E080 AS DateTime), N'Czech Airlines', 12, N'1', NULL, 130.0000, N'26', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (470, N'OK 385', N'Dubai', N'Prague', CAST(0xFFFFFFFE0036EE80 AS DateTime), CAST(0xFFFFFFFE00869520 AS DateTime), N'Czech Airlines', 2, N'1', N'1', 130.0000, N'6', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (471, N'OK 175', N'Dubai', N'Prague', CAST(0xFFFFFFFE0053C550 AS DateTime), CAST(0xFFFFFFFE008C1360 AS DateTime), N'Czech Airlines', 2, N'1', N'1', 130.0000, N'24', 10000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (472, N'OK 400', N'Prague', N'Dubai', CAST(0xFFFFFFFE00CDFE60 AS DateTime), CAST(0xFFFFFFFE017B0740 AS DateTime), N'Czech Airlines', 12, N'1', N'1', 130.0000, N'15', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (473, N'OK 174', N'Prague', N'Dubai', CAST(0xFFFFFFFE012482D0 AS DateTime), CAST(0xFFFFFFFE002D5190 AS DateTime), N'Czech Airlines', 2, N'1', NULL, 130.0000, N'27', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (474, N'OK 384', N'Prague', N'Dubai', CAST(0xFFFFFFFE013E9A80 AS DateTime), CAST(0xFFFFFFFE002673C0 AS DateTime), N'Czech Airlines', 2, N'1', NULL, 130.0000, N'5', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (475, N'EK 944', N'Beirut', N'Dubai', CAST(0xFFFFFFFE00D21D10 AS DateTime), CAST(0xFFFFFFFE011826C0 AS DateTime), N'Emirates', 2, N'3', NULL, 110.0000, N'57', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (476, N'EK 946', N'Beirut', N'Dubai', CAST(0xFFFFFFFE012A0110 AS DateTime), CAST(0xFFFFFFFE00107AC0 AS DateTime), N'Emirates', 2, N'3', N'1', 110.0000, N'13', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (477, N'ME 428', N'Beirut', N'Dubai', CAST(0xFFFFFFFE004609B0 AS DateTime), CAST(0xFFFFFFFE00903210 AS DateTime), N'MEA', 4, N'1', NULL, 90.0000, N'1234567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (478, N'EK 952', N'Beirut', N'Dubai', CAST(0xFFFFFFFE00A59E70 AS DateTime), CAST(0xFFFFFFFE0116C730 AS DateTime), N'Emirates', 2, N'3', N'1', 110.0000, N'2', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (479, N'EK 954', N'Beirut', N'Dubai', CAST(0xFFFFFFFE014DB5B0 AS DateTime), CAST(0xFFFFFFFE00149970 AS DateTime), N'Emirates', 2, N'3', NULL, 110.0000, N'6', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (480, N'MS 912', N'Cairo', N'Dubai', CAST(0xFFFFFFFE00ABA950 AS DateTime), CAST(0xFFFFFFFE00F73140 AS DateTime), N'Egypt Air', 3, N'1', NULL, 110.0000, N'2', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (481, N'MS 906', N'Cairo', N'Dubai', CAST(0xFFFFFFFE00A5E4C0 AS DateTime), CAST(0xFFFFFFFE00FB4FF0 AS DateTime), N'Egypt Air', 1, N'1', NULL, 110.0000, N'7', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (482, N'EK 402', N'Cairo', N'Dubai', CAST(0xFFFFFFFE013D3AF0 AS DateTime), CAST(0xFFFFFFFE017C66D0 AS DateTime), N'Emirates', 20, N'3', NULL, 130.0000, N'1234567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (483, N'MS 870', N'Cairo', N'Dubai', CAST(0xFFFFFFFE00317040 AS DateTime), CAST(0xFFFFFFFE0084EF40 AS DateTime), N'Egypt Air', 1, N'1', NULL, 110.0000, N'15', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (484, N'MS 918', N'Cairo', N'Dubai', CAST(0xFFFFFFFE007779F0 AS DateTime), CAST(0xFFFFFFFE00FB4FF0 AS DateTime), N'Egypt Air', 3, N'1', N'1', 110.0000, N'3', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (485, N'MS 912', N'Cairo', N'Dubai', CAST(0xFFFFFFFE0095B050 AS DateTime), CAST(0xFFFFFFFE00E78970 AS DateTime), N'Egypt Air', 15, N'1', N'1', 110.0000, N'4', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (486, N'SQ 427', N'Cairo', N'Dubai', CAST(0xFFFFFFFE00E297D0 AS DateTime), CAST(0xFFFFFFFE0129BAC0 AS DateTime), N'Singapore Airlines', 11, N'1', NULL, 105.0000, N'135', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (487, N'EK 951', N'Dubai', N'Beirut', CAST(0xFFFFFFFE00735B40 AS DateTime), CAST(0xFFFFFFFE0094DD60 AS DateTime), N'Emirates', 2, N'3', NULL, 110.0000, N'2', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (488, N'EK 943', N'Dubai', N'Beirut', CAST(0xFFFFFFFE00742E30 AS DateTime), CAST(0xFFFFFFFE00C1A250 AS DateTime), N'Emirates', 2, N'3', N'1', 110.0000, N'57', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (489, N'ME 429', N'Dubai', N'Beirut', CAST(0xFFFFFFFE00A0ACD0 AS DateTime), CAST(0xFFFFFFFE00B6A5D0 AS DateTime), N'MEA', 4, N'1', NULL, 90.0000, N'1234567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (490, N'EK 945', N'Dubai', N'Beirut', CAST(0xFFFFFFFE00F80430 AS DateTime), CAST(0xFFFFFFFE01198650 AS DateTime), N'Emirates', 2, N'3', NULL, 110.0000, N'13', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (491, N'EK 953', N'Dubai', N'Beirut', CAST(0xFFFFFFFE00F80430 AS DateTime), CAST(0xFFFFFFFE0139A8E0 AS DateTime), N'Emirates', 20, N'3', N'1', 110.0000, N'4', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (492, N'EK 953', N'Dubai', N'Beirut', CAST(0xFFFFFFFE011C4570 AS DateTime), CAST(0xFFFFFFFE0142B930 AS DateTime), N'Emirates', 2, N'3', NULL, 110.0000, N'6', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (493, N'EK 401', N'Dubai', N'Cairo', CAST(0xFFFFFFFE00F77790 AS DateTime), CAST(0xFFFFFFFE0128A180 AS DateTime), N'Emirates', 2, N'3', NULL, 130.0000, N'1234567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (494, N'MS 929', N'Dubai', N'Cairo', CAST(0xFFFFFFFE00041EB0 AS DateTime), CAST(0xFFFFFFFE004E4710 AS DateTime), N'Egypt Air', 1, N'1', N'1', 110.0000, N'6', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (495, N'MS 871', N'Dubai', N'Cairo', CAST(0xFFFFFFFE01038D50 AS DateTime), CAST(0xFFFFFFFE01323E70 AS DateTime), N'Egypt Air', 1, N'1', NULL, 110.0000, N'15', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (496, N'MS 913', N'Dubai', N'Cairo', CAST(0xFFFFFFFE0107AC00 AS DateTime), CAST(0xFFFFFFFE012A0110 AS DateTime), N'Egypt Air', 1, N'1', NULL, 110.0000, N'24', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (497, N'MS 919', N'Dubai', N'Cairo', CAST(0xFFFFFFFE0107F250 AS DateTime), CAST(0xFFFFFFFE015A11C0 AS DateTime), N'Egypt Air', 3, N'1', N'1', 110.0000, N'3', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (498, N'MS 907', N'Dubai', N'Cairo', CAST(0xFFFFFFFE010BCAB0 AS DateTime), CAST(0xFFFFFFFE015B7150 AS DateTime), N'Egypt Air', 1, N'1', N'1', 110.0000, N'7', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (499, N'SQ 428', N'Dubai', N'Cairo', CAST(0x000000000063F9C0 AS DateTime), CAST(0xFFFFFFFE0053C550 AS DateTime), N'Singapore Airlines', 17, N'1', NULL, 105.0000, N'135', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (500, N'CY382', N'Dubai', N'Bahrain', CAST(0xFFFFFFFE00B54640 AS DateTime), CAST(0xFFFFFFFE00D63BC0 AS DateTime), N'Cyprus Airways', 3, N'1', NULL, 45.0000, N'4', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (501, N'LZ551', N'Dubai', N'Bahrain', CAST(0xFFFFFFFE00B6A5D0 AS DateTime), CAST(0xFFFFFFFE00342F60 AS DateTime), N'Balkan Bulgarian', 12, N'1', NULL, 35.0000, N'5', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (502, N'LZ557', N'Dubai', N'Bahrain', CAST(0xFFFFFFFE0041EB00 AS DateTime), CAST(0xFFFFFFFE0062E080 AS DateTime), N'Balkan Bulgarian', 24, N'1', NULL, 35.0000, N'7', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (503, N'ET653', N'Dubai', N'Bahrain', CAST(0xFFFFFFFE00568470 AS DateTime), CAST(0xFFFFFFFE007779F0 AS DateTime), N'Ethiopian Airlines', 15, N'1', NULL, 30.0000, N'5', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (504, N'ET673', N'Dubai', N'Bahrain', CAST(0xFFFFFFFE00568470 AS DateTime), CAST(0xFFFFFFFE007779F0 AS DateTime), N'Ethiopian Airlines', 14, N'1', NULL, 30.0000, N'7', 5000)
GO
print 'Processed 500 total records'
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (505, N'GF500', N'Dubai', N'Bahrain', CAST(0xFFFFFFFE00735B40 AS DateTime), CAST(0xFFFFFFFE00970FE0 AS DateTime), N'Gulf Air', 3, N'1', NULL, 40.0000, N'1234567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (506, N'GF502', N'Dubai', N'Bahrain', CAST(0xFFFFFFFE0084A8F0 AS DateTime), CAST(0xFFFFFFFE00C46170 AS DateTime), N'Gulf Air', 3, N'1', N'1', 40.0000, N'1234567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (507, N'GF504', N'Dubai', N'Bahrain', CAST(0xFFFFFFFE00E297D0 AS DateTime), CAST(0xFFFFFFFE0121C3B0 AS DateTime), N'Gulf Air', 3, N'1', N'1', 40.0000, N'1234567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (508, N'GF506', N'Dubai', N'Bahrain', CAST(0xFFFFFFFE01391C40 AS DateTime), CAST(0xFFFFFFFE015CD0E0 AS DateTime), N'Gulf Air', 3, N'1', NULL, 40.0000, N'1234567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (509, N'GF508', N'Dubai', N'Bahrain', CAST(0xFFFFFFFE0151D460 AS DateTime), CAST(0xFFFFFFFE01758900 AS DateTime), N'Gulf Air', 3, N'1', NULL, 40.0000, N'1234567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (510, N'CX733', N'Dubai', N'Bahrain', CAST(0xFFFFFFFE016D4BA0 AS DateTime), CAST(0xFFFFFFFE0181E510 AS DateTime), N'Cathay Pacific', 17, N'1', NULL, 45.0000, N'27', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (511, N'GF351', N'Dubai', N'Bahrain', CAST(0xFFFFFFFE010E89D0 AS DateTime), CAST(0xFFFFFFFE011148F0 AS DateTime), N'Gulf Air', 3, N'1', NULL, 40.0000, N'6', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (512, N'ET662', N'Dubai', N'Bahrain', CAST(0xFFFFFFFE0134FD90 AS DateTime), CAST(0xFFFFFFFE01457850 AS DateTime), N'Ethiopian Airlines', 9, N'1', NULL, 30.0000, N'6', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (513, N'GF531', N'Dubai', N'Bahrain', CAST(0xFFFFFFFE01624F20 AS DateTime), CAST(0xFFFFFFFE01650E40 AS DateTime), N'Gulf Air', 3, N'1', NULL, 40.0000, N'13', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (514, N'CX730', N'Dubai', N'Bahrain', CAST(0xFFFFFFFE01650E40 AS DateTime), CAST(0xFFFFFFFE01666DD0 AS DateTime), N'Cathay Pacific', 17, N'1', NULL, 45.0000, N'145', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (515, N'CY392', N'Dubai', N'Bahrain', CAST(0xFFFFFFFE01758900 AS DateTime), CAST(0xFFFFFFFE018603C0 AS DateTime), N'Cyprus Airways', 3, N'1', NULL, 45.0000, N'6', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (516, N'LZ578', N'Dubai', N'Bahrain', CAST(0xFFFFFFFE018344A0 AS DateTime), CAST(0xFFFFFFFE018344A0 AS DateTime), N'Balkan Bulgarian', 24, N'1', NULL, 35.0000, N'7', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (517, N'KM833', N'Dubai', N'Bahrain', CAST(0xFFFFFFFE001339E0 AS DateTime), CAST(0xFFFFFFFE001339E0 AS DateTime), N'Air Malta', 3, N'1', NULL, 35.0000, N'24', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (518, N'OK385', N'Dubai', N'Bahrain', CAST(0xFFFFFFFE0036EE80 AS DateTime), CAST(0xFFFFFFFE0036EE80 AS DateTime), N'Czech Airlines', 2, N'1', N'1', 56.7000, N'6', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (519, N'GF501', N'Dubai', N'Bahrain', CAST(0xFFFFFFFE0087F4B0 AS DateTime), CAST(0xFFFFFFFE00A0ACD0 AS DateTime), N'Gulf Air', 3, N'1', NULL, 40.0000, N'1234567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (520, N'KM835', N'Dubai', N'Bahrain', CAST(0xFFFFFFFE009C8E20 AS DateTime), CAST(0xFFFFFFFE009C8E20 AS DateTime), N'Air Malta', 3, N'1', NULL, 35.0000, N'1', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (521, N'GF503', N'Dubai', N'Bahrain', CAST(0xFFFFFFFE00A4CB80 AS DateTime), CAST(0xFFFFFFFE00A78AA0 AS DateTime), N'Gulf Air', 3, N'1', NULL, 40.0000, N'1234567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (522, N'GF531', N'Dubai', N'Bahrain', CAST(0xFFFFFFFE00E3F760 AS DateTime), CAST(0xFFFFFFFE00E6B680 AS DateTime), N'Gulf Air', 3, N'1', NULL, 40.0000, N'4', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (523, N'ET642', N'Dubai', N'Bahrain', CAST(0xFFFFFFFE00EEF3E0 AS DateTime), CAST(0xFFFFFFFE00EEF3E0 AS DateTime), N'Ethiopian Airlines', 15, N'1', NULL, 30.0000, N'4', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (524, N'GF505', N'Dubai', N'Bahrain', CAST(0xFFFFFFFE01365D20 AS DateTime), CAST(0xFFFFFFFE01391C40 AS DateTime), N'Gulf Air', 15, N'1', NULL, 40.0000, N'1234567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (525, N'GF507', N'Dubai', N'Bahrain', CAST(0xFFFFFFFE016A8C80 AS DateTime), CAST(0xFFFFFFFE0181E510 AS DateTime), N'Gulf Air', 3, N'1', N'1', 40.0000, N'1234567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (526, N'EK 026', N'Munich', N'Dubai', CAST(0xFFFFFFFE00F31290 AS DateTime), CAST(0xFFFFFFFE018603C0 AS DateTime), N'Emirates', 17, N'3', NULL, 140.0000, N'123456', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (527, N'WY 115', N'Muscat', N'Dubai', CAST(0xFFFFFFFE00B964F0 AS DateTime), CAST(0xFFFFFFFE00EAD530 AS DateTime), N'Oman Air', 7, N'1', N'1', 90.0000, N'1234567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (528, N'WY 113', N'Muscat', N'Dubai', CAST(0xFFFFFFFE00EEF3E0 AS DateTime), CAST(0xFFFFFFFE00FF6EA0 AS DateTime), N'Oman Air', 7, N'1', NULL, 90.0000, N'12467', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (529, N'GF 531', N'Muscat', N'Dubai', CAST(0xFFFFFFFE00F31290 AS DateTime), CAST(0xFFFFFFFE01038D50 AS DateTime), N'Gulf Air', 3, N'1', NULL, 80.0000, N'6', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (530, N'WY 123', N'Muscat', N'Dubai', CAST(0xFFFFFFFE0128A180 AS DateTime), CAST(0xFFFFFFFE01391C40 AS DateTime), N'Oman Air', 7, N'1', NULL, 90.0000, N'12467', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (531, N'GF 531', N'Muscat', N'Dubai', CAST(0xFFFFFFFE01457850 AS DateTime), CAST(0xFFFFFFFE0155F310 AS DateTime), N'Gulf Air', 3, N'1', NULL, 80.0000, N'13', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (532, N'GF 509', N'Muscat', N'Dubai', CAST(0xFFFFFFFE00041EB0 AS DateTime), CAST(0xFFFFFFFE00149970 AS DateTime), N'Gulf Air', 3, N'1', NULL, 80.0000, N'3567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (533, N'EK 207', N'Muscat', N'Dubai', CAST(0xFFFFFFFE00083D60 AS DateTime), CAST(0xFFFFFFFE0013C680 AS DateTime), N'Emirates', 2, N'3', NULL, 100.0000, N'34567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (534, N'SR 399', N'Muscat', N'Dubai', CAST(0xFFFFFFFE000C5C10 AS DateTime), CAST(0xFFFFFFFE001CD6D0 AS DateTime), N'Swissair', 5, N'1', NULL, 90.0000, N'24', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (535, N'RB 526', N'Muscat', N'Dubai', CAST(0xFFFFFFFE00251430 AS DateTime), CAST(0xFFFFFFFE00358EF0 AS DateTime), N'Syrian Arab Airlines', 11, N'1', NULL, 70.0000, N'3', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (536, N'ET 623', N'Muscat', N'Dubai', CAST(0xFFFFFFFE005265C0 AS DateTime), CAST(0xFFFFFFFE005EC1D0 AS DateTime), N'Ethiopian Airlines', 15, N'1', NULL, 65.0000, N'2', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (537, N'KU 670', N'Muscat', N'Dubai', CAST(0xFFFFFFFE0062E080 AS DateTime), CAST(0xFFFFFFFE006F3C90 AS DateTime), N'Kuwait Airways', 3, N'1', NULL, 80.0000, N'1346', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (538, N'RB 526', N'Muscat', N'Dubai', CAST(0xFFFFFFFE0062E080 AS DateTime), CAST(0xFFFFFFFE0071FBB0 AS DateTime), N'SYrian Arab Airlines', 11, N'1', NULL, 80.0000, N'6', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (539, N'ET 633', N'Muscat', N'Dubai', CAST(0xFFFFFFFE006B1DE0 AS DateTime), CAST(0xFFFFFFFE007779F0 AS DateTime), N'Ethiopian Airlines', 14, N'1', NULL, 65.0000, N'3', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (540, N'RJ 601', N'Muscat', N'Dubai', CAST(0xFFFFFFFE00735B40 AS DateTime), CAST(0xFFFFFFFE00827670 AS DateTime), N'Royal Jordanian', 3, N'1', NULL, 80.0000, N'4', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (541, N'GF 501', N'Muscat', N'Dubai', CAST(0xFFFFFFFE0078D980 AS DateTime), CAST(0xFFFFFFFE00895440 AS DateTime), N'Gulf Air', 3, N'1', NULL, 80.0000, N'2', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (542, N'WY 111', N'Muscat', N'Dubai', CAST(0xFFFFFFFE0083D600 AS DateTime), CAST(0xFFFFFFFE009450C0 AS DateTime), N'Oman Air', 7, N'1', NULL, 90.0000, N'1234567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (543, N'EK 203', N'Muscat', N'Dubai', CAST(0xFFFFFFFE00B54640 AS DateTime), CAST(0xFFFFFFFE00C301E0 AS DateTime), N'Emirates', 2, N'3', NULL, 100.0000, N'134567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (544, N'WY 413', N'Muscat', N'Dubai', CAST(0xFFFFFFFE00C5C100 AS DateTime), CAST(0xFFFFFFFE00D37CA0 AS DateTime), N'Oman Air', 3, N'1', NULL, 90.0000, N'14', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (545, N'WY 411', N'Muscat', N'Dubai', CAST(0xFFFFFFFE015A11C0 AS DateTime), CAST(0xFFFFFFFE0167CD60 AS DateTime), N'Oman Air', 3, N'1', NULL, 90.0000, N'1234567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (546, N'EK 025', N'Dubai', N'Munich', CAST(0xFFFFFFFE00853590 AS DateTime), CAST(0xFFFFFFFE00BD83A0 AS DateTime), N'Emirates', 17, N'3', NULL, 140.0000, N'123456', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (547, N'WY 114', N'Dubai', N'Muscat', CAST(0xFFFFFFFE0107AC00 AS DateTime), CAST(0xFFFFFFFE011AE5E0 AS DateTime), N'Oman Air', 7, N'1', NULL, 90.0000, N'1234567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (548, N'WY 414', N'Dubai', N'Muscat', CAST(0xFFFFFFFE013BDB60 AS DateTime), CAST(0xFFFFFFFE014C5620 AS DateTime), N'Oman Air', 2, N'1', NULL, 90.0000, N'14', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (549, N'WY 124', N'Dubai', N'Muscat', CAST(0xFFFFFFFE014159A0 AS DateTime), CAST(0xFFFFFFFE0142B930 AS DateTime), N'Oman Air', 8, N'1', NULL, 90.0000, N'1234567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (550, N'RB 525', N'Dubai', N'Muscat', CAST(0xFFFFFFFE018B3BB0 AS DateTime), CAST(0xFFFFFFFE00107AC0 AS DateTime), N'SYrian Arab Airlines', 11, N'1', NULL, 70.0000, N'2', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (551, N'KU 669', N'Dubai', N'Muscat', CAST(0xFFFFFFFE00163F50 AS DateTime), CAST(0xFFFFFFFE0023B4A0 AS DateTime), N'Kuwait Airways', 3, N'1', NULL, 76.0000, N'1346', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (552, N'RJ 600', N'Dubai', N'Muscat', CAST(0xFFFFFFFE00317040 AS DateTime), CAST(0xFFFFFFFE0041EB00 AS DateTime), N'Royal Jordanian', 3, N'1', NULL, 70.0000, N'4', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (553, N'RB 525', N'Dubai', N'Muscat', CAST(0xFFFFFFFE003DCC50 AS DateTime), CAST(0xFFFFFFFE004A2860 AS DateTime), N'SYrian Arab Airlines', 11, N'1', NULL, 70.0000, N'6', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (554, N'GF 534', N'Dubai', N'Muscat', CAST(0xFFFFFFFE007FB750 AS DateTime), CAST(0xFFFFFFFE008ED280 AS DateTime), N'Gulf Air', 3, N'1', NULL, 80.0000, N'6', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (555, N'EK 202', N'Dubai', N'Muscat', CAST(0xFFFFFFFE0083D600 AS DateTime), CAST(0xFFFFFFFE0092F130 AS DateTime), N'Emirates', 20, N'3', NULL, 100.0000, N'134567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (556, N'WY 112', N'Dubai', N'Muscat', CAST(0xFFFFFFFE009C8E20 AS DateTime), CAST(0xFFFFFFFE00AFC800 AS DateTime), N'Oman Air', 7, N'1', NULL, 90.0000, N'1234567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (557, N'GF 502', N'Dubai', N'Muscat', CAST(0xFFFFFFFE00CF5DF0 AS DateTime), CAST(0xFFFFFFFE00DE7920 AS DateTime), N'Gulf Air', 3, N'1', NULL, 80.0000, N'1234567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (558, N'GF 552', N'Dubai', N'Muscat', CAST(0xFFFFFFFE01090B90 AS DateTime), CAST(0xFFFFFFFE011826C0 AS DateTime), N'Gulf Air', 3, N'1', NULL, 80.0000, N'3', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (559, N'ET 612', N'Dubai', N'Muscat', CAST(0xFFFFFFFE010FE960 AS DateTime), CAST(0xFFFFFFFE011C4570 AS DateTime), N'Ethiopian Airlines', 15, N'1', NULL, 65.0000, N'1', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (560, N'ET 622', N'Dubai', N'Muscat', CAST(0xFFFFFFFE0134FD90 AS DateTime), CAST(0xFFFFFFFE014159A0 AS DateTime), N'Ethiopian Airlines', 14, N'1', NULL, 65.0000, N'2', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (561, N'EK 206', N'Dubai', N'Muscat', CAST(0xFFFFFFFE0172C9E0 AS DateTime), CAST(0xFFFFFFFE0181E510 AS DateTime), N'Emirates', 20, N'3', NULL, 100.0000, N'23456', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (562, N'SR 398', N'Dubai', N'Muscat', CAST(0xFFFFFFFE0172C9E0 AS DateTime), CAST(0xFFFFFFFE0181E510 AS DateTime), N'Swissair', 5, N'1', NULL, 90.0000, N'13', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (563, N'GF 508', N'Dubai', N'Muscat', CAST(0xFFFFFFFE01808580 AS DateTime), CAST(0xFFFFFFFE0002BF20 AS DateTime), N'Gulf Air', 3, N'1', NULL, 80.0000, N'123467', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (564, N'GF 508', N'Dubai', N'Muscat', CAST(0xFFFFFFFE0184A430 AS DateTime), CAST(0xFFFFFFFE00099CF0 AS DateTime), N'Gulf Air', 6, N'1', NULL, 80.0000, N'5', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (565, N'WY 412', N'Dubai', N'Muscat', CAST(0xFFFFFFFE0184A430 AS DateTime), CAST(0xFFFFFFFE0006DDD0 AS DateTime), N'Oman Air', 3, N'1', NULL, 90.0000, N'1234567', 5000)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (578, N'GF0506', N'Bahrain', N'Dubai', CAST(0x0000000000E6B680 AS DateTime), CAST(0x00000000010A6B20 AS DateTime), N'', 3, N'1', N'0', 37.8000, N'1234567', 500)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (579, N'GF0508', N'Bahrain', N'Dubai', CAST(0x000000000107AC00 AS DateTime), CAST(0x00000000012B60A0 AS DateTime), N'', 3, N'1', N'0', 40.8000, N'1234567', 500)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (580, N'GF0514', N'Bahrain', N'Dubai', CAST(0x00000000011AE5E0 AS DateTime), CAST(0x00000000013E9A80 AS DateTime), N'', 5, N'1', N'0', 40.8000, N'1234567', 500)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (584, N'GF0503', N'Dubai', N'Bahrain', CAST(0x0000000000A8EA30 AS DateTime), CAST(0x0000000000AD08E0 AS DateTime), N'', 4, N'1', N'0', 37.1000, N'1234567', 500)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (585, N'GF0505', N'Dubai', N'Bahrain', CAST(0x0000000000D63BC0 AS DateTime), CAST(0x0000000000DA5A70 AS DateTime), N'', 3, N'1', N'0', 37.1000, N'1234567', 500)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (586, N'GF0507', N'Dubai', N'Bahrain', CAST(0x00000000011826C0 AS DateTime), CAST(0x00000000011C4570 AS DateTime), N'', 3, N'1', N'0', 42.1000, N'1234567', 500)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (590, N'GF0513', N'Dubai', N'Bahrain', CAST(0x000000000184A430 AS DateTime), CAST(0x000000000188C2E0 AS DateTime), N'', 3, N'1', N'0', 42.1000, N'1234567', 500)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (575, N'GF0500', N'Bahrain', N'Dubai', CAST(0x00000000001F95F0 AS DateTime), CAST(0x0000000000434A90 AS DateTime), N'', 3, N'1', N'0', 32.8000, N'1234567', 500)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (576, N'GF0502', N'Bahrain', N'Dubai', CAST(0x000000000078D980 AS DateTime), CAST(0x00000000009C8E20 AS DateTime), N'', 4, N'1', N'0', 32.8000, N'1234567', 500)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (577, N'GF0504', N'Bahrain', N'Dubai', CAST(0x0000000000A36BF0 AS DateTime), CAST(0x0000000000C72090 AS DateTime), N'', 3, N'1', N'0', 37.8000, N'1234567', 500)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (582, N'GF0512', N'Bahrain', N'Dubai', CAST(0x00000000015074D0 AS DateTime), CAST(0x0000000001742970 AS DateTime), N'', 3, N'1', N'0', 40.8000, N'1234567', 500)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (587, N'GF0509', N'Dubai', N'Bahrain', CAST(0x00000000013BDB60 AS DateTime), CAST(0x00000000013FFA10 AS DateTime), N'', 3, N'1', N'0', 42.1000, N'1234567', 500)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (588, N'GF0515', N'Dubai', N'Bahrain', CAST(0x00000000014DB5B0 AS DateTime), CAST(0x000000000151D460 AS DateTime), N'', 5, N'1', N'0', 37.1000, N'1234567', 500)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (589, N'GF0511', N'Dubai', N'Bahrain', CAST(0x00000000015A11C0 AS DateTime), CAST(0x00000000015E3070 AS DateTime), N'', 4, N'1', N'0', 42.1000, N'1234567', 500)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (581, N'GF0510', N'Bahrain', N'Dubai', CAST(0x00000000012A0110 AS DateTime), CAST(0x00000000014DB5B0 AS DateTime), N'', 4, N'1', N'0', 40.8000, N'1234567', 500)
INSERT [dbo].[Flight] ([FlightID], [FlightNumber], [Origin], [Destination], [Departure], [Arrival], [Airline], [AircraftID], [Terminal], [Stops], [Fare], [Days], [Miles]) VALUES (583, N'GF0501', N'Dubai', N'Bahrain', CAST(0x000000000083D600 AS DateTime), CAST(0x000000000087F4B0 AS DateTime), N'', 3, N'1', N'0', 37.1000, N'1234567', 500)
SET IDENTITY_INSERT [dbo].[Flight] OFF
/****** Object:  Table [dbo].[Reservation]    Script Date: 04/25/2017 13:13:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reservation](
	[ReservationID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NULL,
	[EmployeeID] [int] NULL,
	[Paid] [bit] NULL,
	[ReservationDate] [datetime] NULL,
	[Price] [money] NULL,
 CONSTRAINT [aaaaaReservation_PK] PRIMARY KEY NONCLUSTERED 
(
	[ReservationID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'ReservationID'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'ReservationID'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'ReservationID'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'17' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'ReservationID'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'ReservationID'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'ReservationID'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'ReservationID'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'1905' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'ReservationID'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'ReservationID'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'섌ꖘ뤥䦱ﾛ豿⊯㛯' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'ReservationID'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'ReservationID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'ReservationID'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'ReservationID'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'ReservationID'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'ReservationID'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'ReservationID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'ReservationID'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Reservation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'ReservationID'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'ReservationID'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'ReservationID'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'CustomerID'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'CustomerID'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'CustomerID'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'CustomerID'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'CustomerID'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'CustomerID'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'CustomerID'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'CustomerID'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'CustomerID'
GO
EXEC sys.sp_addextendedproperty @name=N'DefaultValue', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'CustomerID'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'㪈孖仙驻⤓㏀' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'CustomerID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'CustomerID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'CustomerID'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'CustomerID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'CustomerID'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'CustomerID'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'CustomerID'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'CustomerID'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'CustomerID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'CustomerID'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Reservation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'CustomerID'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'CustomerID'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'CustomerID'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'EmployeeID'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'EmployeeID'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'EmployeeID'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'EmployeeID'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'EmployeeID'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'EmployeeID'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'EmployeeID'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'EmployeeID'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'EmployeeID'
GO
EXEC sys.sp_addextendedproperty @name=N'DefaultValue', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'EmployeeID'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'錺ﯡ割䵣같켢똞' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'EmployeeID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'EmployeeID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'EmployeeID'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'EmployeeID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'EmployeeID'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'EmployeeID'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'EmployeeID'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'EmployeeID'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'EmployeeID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'EmployeeID'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Reservation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'EmployeeID'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'EmployeeID'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'EmployeeID'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'Paid'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'Paid'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'Paid'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'Paid'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'Paid'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'Paid'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'Paid'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'Paid'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'Paid'
GO
EXEC sys.sp_addextendedproperty @name=N'DefaultValue', @value=N'No' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'Paid'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'�⻊氡䫤㲰뺀裸ᑁ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'Paid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'106' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'Paid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=N'Yes/No' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'Paid'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Paid' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'Paid'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'Paid'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'Paid'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'Paid'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Paid' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'Paid'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Reservation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'Paid'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'Paid'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'Paid'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'ReservationDate'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'ReservationDate'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'ReservationDate'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'ReservationDate'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'ReservationDate'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'ReservationDate'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'ReservationDate'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'ReservationDate'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'ReservationDate'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'輨ル⃜䏐ꦮ榘㓣귾' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'ReservationDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'ReservationDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'ReservationDate'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'ReservationDate' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'ReservationDate'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'ReservationDate'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'ReservationDate'
GO
EXEC sys.sp_addextendedproperty @name=N'ShowDatePicker', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'ReservationDate'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'ReservationDate'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'ReservationDate' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'ReservationDate'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Reservation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'ReservationDate'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'ReservationDate'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'ReservationDate'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'Price'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'Price'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'Price'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'Price'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'Price'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'Price'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'Price'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'Price'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'Price'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'텕衟腲仧疲֙걼틣' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'Price'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'Price'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=N'$#,##0.00;-$#,##0.00' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'Price'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Price' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'Price'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'5' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'Price'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'Price'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'Price'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Price' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'Price'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Reservation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'Price'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'Price'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'5' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation', @level2type=N'COLUMN',@level2name=N'Price'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation'
GO
EXEC sys.sp_addextendedproperty @name=N'DateCreated', @value=N'16/02/2014 10:02:34 a.m.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation'
GO
EXEC sys.sp_addextendedproperty @name=N'DisplayViewsOnSharePointSite', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation'
GO
EXEC sys.sp_addextendedproperty @name=N'FilterOnLoad', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation'
GO
EXEC sys.sp_addextendedproperty @name=N'HideNewField', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation'
GO
EXEC sys.sp_addextendedproperty @name=N'LastUpdated', @value=N'7/05/2014 8:06:30 a.m.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Reservation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation'
GO
EXEC sys.sp_addextendedproperty @name=N'OrderByOnLoad', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation'
GO
EXEC sys.sp_addextendedproperty @name=N'RecordCount', @value=N'60' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation'
GO
EXEC sys.sp_addextendedproperty @name=N'TotalsRow', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation'
GO
EXEC sys.sp_addextendedproperty @name=N'Updatable', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation'
GO
SET IDENTITY_INSERT [dbo].[Reservation] ON
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (1, 1, 4, 1, CAST(0x0000A6CF00000000 AS DateTime), 840.0000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (2, 2, 3, 1, CAST(0x0000A70A00000000 AS DateTime), 220.0000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (3, 3, 1, 1, CAST(0x0000A77800000000 AS DateTime), 260.0000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (4, 4, 5, 1, CAST(0x0000A77900000000 AS DateTime), 1280.0000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (5, 5, 3, 1, CAST(0x0000A77E00000000 AS DateTime), 520.0000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (6, 6, 3, 1, CAST(0x0000A76F00000000 AS DateTime), 200.0000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (7, 7, 2, 0, CAST(0x0000A6D000000000 AS DateTime), 400.0000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (8, 8, 1, 1, CAST(0x0000A77E00000000 AS DateTime), 1920.0000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (9, 9, 6, 1, CAST(0x0000A7DF00000000 AS DateTime), 400.0000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (10, 5, 3, 1, CAST(0x0000A6CF00000000 AS DateTime), 260.0000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (11, 10, 3, 1, CAST(0x0000A73100000000 AS DateTime), 420.0000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (12, 11, 2, 1, CAST(0x0000A78300000000 AS DateTime), 360.0000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (13, 12, 1, 1, CAST(0x0000A77F00000000 AS DateTime), 560.0000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (14, 13, 4, 1, CAST(0x0000A7C100000000 AS DateTime), 560.0000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (15, 14, 5, 1, CAST(0x0000A70900000000 AS DateTime), 140.0000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (16, 14, 5, 1, CAST(0x0000A77C00000000 AS DateTime), 680.0000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (17, 15, 2, 0, CAST(0x0000A70B00000000 AS DateTime), 200.0000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (18, 16, 3, 1, CAST(0x0000A70A00000000 AS DateTime), 690.0000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (19, 17, 5, 0, CAST(0x0000A6D000000000 AS DateTime), 560.0000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (20, 18, 2, 1, CAST(0x0000A80700000000 AS DateTime), 240.0000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (21, 18, 2, 1, CAST(0x0000A77D00000000 AS DateTime), 1040.0000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (22, 19, 1, 1, CAST(0x0000A6F700000000 AS DateTime), 360.0000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (23, 20, 2, 1, CAST(0x0000A6D100000000 AS DateTime), 400.0000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (24, 21, 4, 1, CAST(0x0000A77900000000 AS DateTime), 2100.0000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (25, 22, 6, 1, CAST(0x0000A77800000000 AS DateTime), 240.0000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (26, 23, 7, 1, CAST(0x0000A78200000000 AS DateTime), 600.0000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (27, 24, 2, 1, CAST(0x0000A77F00000000 AS DateTime), 248.0000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (28, 25, 3, 1, CAST(0x0000A77900000000 AS DateTime), 520.0000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (29, 26, 1, 0, CAST(0x0000A81C00000000 AS DateTime), 180.0000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (30, 27, 3, 1, CAST(0x0000A72700000000 AS DateTime), 520.0000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (31, 28, 3, 1, CAST(0x0000A77D00000000 AS DateTime), 840.0000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (32, 29, 5, 1, CAST(0x0000A70C00000000 AS DateTime), 200.0000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (33, 29, 5, 1, CAST(0x0000A77800000000 AS DateTime), 1280.0000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (34, 30, 2, 1, CAST(0x0000A77100000000 AS DateTime), 360.0000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (35, 31, 5, 1, CAST(0x0000A7EA00000000 AS DateTime), 520.0000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (36, 32, 2, 1, CAST(0x0000A77800000000 AS DateTime), 390.0000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (37, 33, 4, 1, CAST(0x0000A70C00000000 AS DateTime), 560.0000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (38, 34, 2, 1, CAST(0x0000A78F00000000 AS DateTime), 400.0000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (39, 35, 3, 1, CAST(0x0000A6EF00000000 AS DateTime), 320.0000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (40, 35, 3, 1, CAST(0x0000A72800000000 AS DateTime), 320.0000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (41, 35, 3, 1, CAST(0x0000A78300000000 AS DateTime), 320.0000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (42, 36, 3, 1, CAST(0x0000A76600000000 AS DateTime), 560.0000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (43, 37, 5, 1, CAST(0x0000A77A00000000 AS DateTime), 440.0000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (44, 38, 7, 1, CAST(0x0000A71700000000 AS DateTime), 140.0000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (45, 38, 7, 1, CAST(0x0000A77F00000000 AS DateTime), 340.0000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (46, 39, 4, 0, CAST(0x0000A77900000000 AS DateTime), 400.0000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (47, 40, 6, 1, CAST(0x0000A76E00000000 AS DateTime), 1920.0000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (48, 41, 4, 1, CAST(0x0000A77900000000 AS DateTime), 200.0000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (49, 42, 2, 1, CAST(0x0000A77700000000 AS DateTime), 180.0000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (50, 43, 3, 1, CAST(0x0000A78D00000000 AS DateTime), 360.0000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (51, 44, 1, 1, CAST(0x0000A6D100000000 AS DateTime), 300.0000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (52, 44, 1, 1, CAST(0x0000A77600000000 AS DateTime), 560.0000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (53, 45, 8, 1, CAST(0x0000A76B00000000 AS DateTime), 240.0000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (54, 46, 3, 1, CAST(0x0000A70900000000 AS DateTime), 220.0000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (55, 47, 2, 1, CAST(0x0000A7E700000000 AS DateTime), 280.0000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (56, 48, 5, 1, CAST(0x0000A76E00000000 AS DateTime), 220.0000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (57, 49, 1, 0, CAST(0x0000A72900000000 AS DateTime), 180.0000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (58, 50, 2, 1, CAST(0x0000A6F000000000 AS DateTime), 45.0000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (63, 3, 1, 0, CAST(0x0000A72800000000 AS DateTime), 37.8000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (64, 3, 1, 0, CAST(0x0000A72800000000 AS DateTime), 40.8000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (65, 4, 1, 0, CAST(0x0000A72800000000 AS DateTime), 32.8000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (67, 4, 1, 0, CAST(0x0000A72800000000 AS DateTime), 40.8000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (68, 4, 1, 0, CAST(0x0000A72800000000 AS DateTime), 40.8000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (69, 4, 1, 0, CAST(0x0000A72800000000 AS DateTime), 40.8000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (70, 5, 1, 0, CAST(0x0000A72800000000 AS DateTime), 40.8000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (71, 5, 1, 0, CAST(0x0000A72800000000 AS DateTime), 40.8000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (75, 7, 1, 0, CAST(0x0000A72800000000 AS DateTime), 37.8000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (78, 7, 1, 0, CAST(0x0000A72D00000000 AS DateTime), 74.9000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (66, 4, 1, 0, CAST(0x0000A72800000000 AS DateTime), 32.8000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (72, 5, 1, 0, CAST(0x0000A72800000000 AS DateTime), 40.8000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (73, 6, 1, 0, CAST(0x0000A72800000000 AS DateTime), 40.8000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (74, 6, 1, 0, CAST(0x0000A72800000000 AS DateTime), 37.8000)
INSERT [dbo].[Reservation] ([ReservationID], [CustomerID], [EmployeeID], [Paid], [ReservationDate], [Price]) VALUES (76, 7, 1, 0, CAST(0x0000A72800000000 AS DateTime), 40.8000)
SET IDENTITY_INSERT [dbo].[Reservation] OFF
/****** Object:  Table [dbo].[Passenger]    Script Date: 04/25/2017 13:13:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Passenger](
	[PassengerID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](255) NULL,
	[LastName] [nvarchar](255) NULL,
	[ReservationID] [int] NULL,
 CONSTRAINT [aaaaaPassenger_PK] PRIMARY KEY NONCLUSTERED 
(
	[PassengerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'PassengerID'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'PassengerID'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'PassengerID'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'17' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'PassengerID'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'PassengerID'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'PassengerID'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'PassengerID'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'1560' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'PassengerID'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'PassengerID'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'ୠ吲ڷ䯦ﶤ꫼檭蝆' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'PassengerID'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'PassengerID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'PassengerID'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'PassengerID'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'PassengerID'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'PassengerID'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'PassengerID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'PassengerID'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Passenger' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'PassengerID'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'PassengerID'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'PassengerID'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'FirstName'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'FirstName'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'FirstName'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'FirstName'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'FirstName'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'FirstName'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'FirstName'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'FirstName'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'FirstName'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'㲍琶䱋䶗⫷嵎' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'FirstName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'FirstName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'FirstName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'FirstName'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'FirstName' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'FirstName'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'FirstName'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'FirstName'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'FirstName'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'FirstName' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'FirstName'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Passenger' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'FirstName'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'FirstName'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'FirstName'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'FirstName'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'LastName'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'LastName'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'LastName'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'LastName'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'LastName'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'LastName'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'LastName'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'LastName'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'LastName'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'謱䄢૒䛘늾䃉둓' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'LastName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'LastName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'LastName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'LastName'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'LastName' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'LastName'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'LastName'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'LastName'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'LastName'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'LastName' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'LastName'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Passenger' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'LastName'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'LastName'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'LastName'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'LastName'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'ReservationID'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'ReservationID'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'ReservationID'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'ReservationID'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'ReservationID'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'ReservationID'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'ReservationID'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'1950' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'ReservationID'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'ReservationID'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'✬뜬䳵삜ꐲ且' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'ReservationID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'ReservationID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'ReservationID'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'ReservationID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'ReservationID'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'ReservationID'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'ReservationID'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'ReservationID'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'ReservationID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'ReservationID'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Passenger' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'ReservationID'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'ReservationID'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger', @level2type=N'COLUMN',@level2name=N'ReservationID'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger'
GO
EXEC sys.sp_addextendedproperty @name=N'DateCreated', @value=N'16/02/2014 10:02:34 a.m.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger'
GO
EXEC sys.sp_addextendedproperty @name=N'DisplayViewsOnSharePointSite', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger'
GO
EXEC sys.sp_addextendedproperty @name=N'FilterOnLoad', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger'
GO
EXEC sys.sp_addextendedproperty @name=N'HideNewField', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger'
GO
EXEC sys.sp_addextendedproperty @name=N'LastUpdated', @value=N'7/05/2014 8:06:30 a.m.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Passenger' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger'
GO
EXEC sys.sp_addextendedproperty @name=N'OrderByOnLoad', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger'
GO
EXEC sys.sp_addextendedproperty @name=N'RecordCount', @value=N'113' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger'
GO
EXEC sys.sp_addextendedproperty @name=N'TotalsRow', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger'
GO
EXEC sys.sp_addextendedproperty @name=N'Updatable', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Passenger'
GO
SET IDENTITY_INSERT [dbo].[Passenger] ON
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (1, N'John', N'Hanson', 1)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (2, N'Martin', N'Hanson', 1)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (3, N'Mary', N'Hanson', 1)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (4, N'Rita', N'Hanson', 1)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (5, N'Ali', N'Zahoor', 2)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (6, N'Jeremy', N'Minsk', 3)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (7, N'Cecille', N'Lockwood', 4)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (8, N'Francis', N'Lockwood', 4)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (9, N'Jack', N'Lockwood', 4)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (10, N'Jane', N'Lockwood', 4)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (11, N'Gerard', N'Peterson', 5)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (12, N'Helen', N'Peterson', 5)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (13, N'Jamie', N'Yorres', 6)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (14, N'Ahmed', N'Rahmatullah', 7)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (15, N'Sharifa', N'Rahmatullah', 7)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (16, N'Amanda', N'Stearn', 8)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (17, N'Amelia', N'Stearn', 8)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (18, N'Andrew', N'Stearn', 8)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (19, N'Robert', N'Stearn', 8)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (20, N'Hassan', N'Al Kamil', 9)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (21, N'Saeed', N'Al Kamil', 9)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (22, N'Helen', N'Peterson', 10)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (23, N'Joseph', N'Smith', 11)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (24, N'Rebecca', N'Smith', 11)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (25, N'Margaret', N'Gallanagh', 12)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (26, N'Anna', N'Rodas', 13)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (27, N'Mario', N'Rodas', 13)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (28, N'Maria', N'Morales', 14)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (29, N'Martin', N'Morales', 14)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (30, N'Bruce', N'Lindsay', 15)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (31, N'Bruce', N'Lindsay', 16)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (32, N'Doreen', N'Lindsay', 16)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (33, N'Ahmed', N'Amin', 17)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (34, N'Maryam', N'Al Kousi', 18)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (35, N'Muhammad', N'Al Kousi', 18)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (36, N'Sharifa', N'Al Kousi', 18)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (37, N'Annabella', N'Dodsworth', 19)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (38, N'Frederick', N'Dodsworth', 19)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (39, N'Tom', N'Herron', 20)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (40, N'Jill', N'Herron', 21)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (41, N'Nora', N'Herron', 21)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (42, N'Robert', N'Herron', 21)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (43, N'Tom', N'Herron', 21)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (44, N'James', N'MacIntyre', 22)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (45, N'Roberta', N'MacIntyre', 22)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (46, N'Ahmed', N'Al Houssaini', 23)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (47, N'Noura', N'Al Houssaini', 23)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (48, N'Alice', N'Carter', 24)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (49, N'Dale', N'Carter', 24)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (50, N'Jack', N'Carter', 24)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (51, N'Joseph', N'Carter', 24)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (52, N'William', N'Carter', 24)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (53, N'John', N'LeClair', 25)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (54, N'Hanifa', N'Karam', 26)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (55, N'Masood', N'Karam', 26)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (56, N'Sameera', N'Karam', 26)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (57, N'Mary', N'Foster', 27)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (58, N'Michael', N'Foster', 27)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (59, N'Jim', N'Hernandez', 28)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (60, N'Maria', N'Hernandez', 28)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (61, N'Hana', N'AlNuaimi', 29)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (62, N'Naila', N'AlNuaimi', 29)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (63, N'Anne', N'Novak', 30)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (64, N'Carol', N'Novak', 30)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (65, N'Connie', N'Novak', 30)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (66, N'James', N'Novak', 30)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (67, N'Mario', N'Pisa', 31)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (68, N'Matteo', N'Pisa', 31)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (69, N'Terri', N'Pisa', 31)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (70, N'Harvey', N'Tarrant', 32)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (71, N'Amelia', N'Tarrant', 33)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (72, N'Barbara', N'Tarrant', 33)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (73, N'Harvey', N'Tarrant', 33)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (74, N'Tom', N'Tarrant', 33)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (75, N'Jyothi', N'Kumar', 34)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (76, N'Rajesh', N'Kumar', 34)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (77, N'Ghanima', N'Al Hamour', 35)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (78, N'Hassan', N'Al Hamour', 35)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (79, N'Barbara', N'Gordon-Miller', 36)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (80, N'Jim', N'Gordon-Miller', 36)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (81, N'Natalie', N'Gordon-Miller', 36)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (82, N'Maria', N'Valerio', 37)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (83, N'Nina', N'Valerio', 37)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (84, N'Raj', N'Rajagopalan', 38)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (85, N'Vanitha', N'Rajagopalan', 38)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (86, N'Henry', N'Malone', 39)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (87, N'Henry', N'Malone', 40)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (88, N'Henry', N'Malone', 41)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (89, N'Barry', N'Kurtz', 42)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (90, N'Ulrike', N'Kurtz', 42)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (91, N'Michael', N'Dolan', 43)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (92, N'Tamarra', N'Dolan', 43)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (93, N'Janice', N'Leverling', 44)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (94, N'Janice', N'Leverling', 45)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (95, N'Hana', N'Al Hussaini', 46)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (96, N'Hassan', N'Al Hussaini', 46)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (97, N'Amanda', N'Wright', 47)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (98, N'John', N'Wright', 47)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (99, N'Mary', N'Wright', 47)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (100, N'Nigel', N'Wright', 47)
GO
print 'Processed 100 total records'
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (101, N'Paula', N'Davidson', 48)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (102, N'Darukhan', N'Mahesh', 49)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (103, N'Connie', N'Seifferd', 50)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (104, N'Beverly', N'Bernstein', 51)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (105, N'Robert', N'Bernstein', 51)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (106, N'Beverly', N'Bernstein', 52)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (107, N'Robert', N'Bernstein', 52)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (108, N'Joseph', N'Albert', 53)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (109, N'Nileshwa', N'Rajendran', 54)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (110, N'Jennifer', N'Ting', 55)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (111, N'Bruce', N'Sprouter', 56)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (112, N'Reem', N'Al Rumaithi', 57)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (113, N'Khalifa', N'Al Omaira', 58)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (114, N'Jeremy', N'Minsk', 58)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (115, N'Jeremy', N'Minsk', 58)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (116, N'Jeremy', N'Minsk', 63)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (117, N'Jeremy', N'Minsk', 64)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (120, N'Francis', N'Lockwood', 67)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (124, N'Helen', N'Peterson', 71)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (125, N'Helen', N'Peterson', 72)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (128, N'Ahmed', N'Rahmatullah', 75)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (130, N'Ahmed', N'Rahmatullah', 76)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (131, N'Ahmed', N'Rahmatullah', 78)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (118, N'Francis', N'Lockwood', 65)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (119, N'Francis', N'Lockwood', 66)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (121, N'Francis', N'Lockwood', 68)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (122, N'Francis', N'Lockwood', 69)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (123, N'Helen', N'Peterson', 70)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (127, N'Jamie', N'Yorres', 74)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (129, N'Ahmed', N'Rahmatullah', 76)
INSERT [dbo].[Passenger] ([PassengerID], [FirstName], [LastName], [ReservationID]) VALUES (126, N'Jamie', N'Yorres', 73)
SET IDENTITY_INSERT [dbo].[Passenger] OFF
/****** Object:  Table [dbo].[ScheduledFlight]    Script Date: 04/25/2017 13:13:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ScheduledFlight](
	[ScheduledFlightID] [int] IDENTITY(1,1) NOT NULL,
	[FlightID] [int] NULL,
	[FlightDate] [datetime] NULL,
 CONSTRAINT [aaaaaScheduledFlight_PK] PRIMARY KEY NONCLUSTERED 
(
	[ScheduledFlightID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight', @level2type=N'COLUMN',@level2name=N'ScheduledFlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight', @level2type=N'COLUMN',@level2name=N'ScheduledFlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight', @level2type=N'COLUMN',@level2name=N'ScheduledFlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'17' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight', @level2type=N'COLUMN',@level2name=N'ScheduledFlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight', @level2type=N'COLUMN',@level2name=N'ScheduledFlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight', @level2type=N'COLUMN',@level2name=N'ScheduledFlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight', @level2type=N'COLUMN',@level2name=N'ScheduledFlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight', @level2type=N'COLUMN',@level2name=N'ScheduledFlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight', @level2type=N'COLUMN',@level2name=N'ScheduledFlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'㪺ᄳ䫯嚣㸹脓ऴ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight', @level2type=N'COLUMN',@level2name=N'ScheduledFlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'ScheduledFlightID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight', @level2type=N'COLUMN',@level2name=N'ScheduledFlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight', @level2type=N'COLUMN',@level2name=N'ScheduledFlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight', @level2type=N'COLUMN',@level2name=N'ScheduledFlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight', @level2type=N'COLUMN',@level2name=N'ScheduledFlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'ScheduledFlightID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight', @level2type=N'COLUMN',@level2name=N'ScheduledFlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'ScheduledFlight' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight', @level2type=N'COLUMN',@level2name=N'ScheduledFlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight', @level2type=N'COLUMN',@level2name=N'ScheduledFlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight', @level2type=N'COLUMN',@level2name=N'ScheduledFlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight', @level2type=N'COLUMN',@level2name=N'FlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight', @level2type=N'COLUMN',@level2name=N'FlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight', @level2type=N'COLUMN',@level2name=N'FlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight', @level2type=N'COLUMN',@level2name=N'FlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight', @level2type=N'COLUMN',@level2name=N'FlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight', @level2type=N'COLUMN',@level2name=N'FlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight', @level2type=N'COLUMN',@level2name=N'FlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight', @level2type=N'COLUMN',@level2name=N'FlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight', @level2type=N'COLUMN',@level2name=N'FlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N' �䠗閑瘛䏗囌' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight', @level2type=N'COLUMN',@level2name=N'FlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight', @level2type=N'COLUMN',@level2name=N'FlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight', @level2type=N'COLUMN',@level2name=N'FlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'FlightID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight', @level2type=N'COLUMN',@level2name=N'FlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight', @level2type=N'COLUMN',@level2name=N'FlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight', @level2type=N'COLUMN',@level2name=N'FlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight', @level2type=N'COLUMN',@level2name=N'FlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'FlightID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight', @level2type=N'COLUMN',@level2name=N'FlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'ScheduledFlight' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight', @level2type=N'COLUMN',@level2name=N'FlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight', @level2type=N'COLUMN',@level2name=N'FlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight', @level2type=N'COLUMN',@level2name=N'FlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight', @level2type=N'COLUMN',@level2name=N'FlightDate'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight', @level2type=N'COLUMN',@level2name=N'FlightDate'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight', @level2type=N'COLUMN',@level2name=N'FlightDate'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight', @level2type=N'COLUMN',@level2name=N'FlightDate'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight', @level2type=N'COLUMN',@level2name=N'FlightDate'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight', @level2type=N'COLUMN',@level2name=N'FlightDate'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight', @level2type=N'COLUMN',@level2name=N'FlightDate'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'2325' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight', @level2type=N'COLUMN',@level2name=N'FlightDate'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight', @level2type=N'COLUMN',@level2name=N'FlightDate'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'䩻若䒭䛖ﺙ氥렫㗧' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight', @level2type=N'COLUMN',@level2name=N'FlightDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight', @level2type=N'COLUMN',@level2name=N'FlightDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight', @level2type=N'COLUMN',@level2name=N'FlightDate'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'FlightDate' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight', @level2type=N'COLUMN',@level2name=N'FlightDate'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight', @level2type=N'COLUMN',@level2name=N'FlightDate'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight', @level2type=N'COLUMN',@level2name=N'FlightDate'
GO
EXEC sys.sp_addextendedproperty @name=N'ShowDatePicker', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight', @level2type=N'COLUMN',@level2name=N'FlightDate'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight', @level2type=N'COLUMN',@level2name=N'FlightDate'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'FlightDate' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight', @level2type=N'COLUMN',@level2name=N'FlightDate'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'ScheduledFlight' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight', @level2type=N'COLUMN',@level2name=N'FlightDate'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight', @level2type=N'COLUMN',@level2name=N'FlightDate'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight', @level2type=N'COLUMN',@level2name=N'FlightDate'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight'
GO
EXEC sys.sp_addextendedproperty @name=N'DateCreated', @value=N'16/02/2014 10:02:34 a.m.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight'
GO
EXEC sys.sp_addextendedproperty @name=N'DisplayViewsOnSharePointSite', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight'
GO
EXEC sys.sp_addextendedproperty @name=N'FilterOnLoad', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight'
GO
EXEC sys.sp_addextendedproperty @name=N'HideNewField', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight'
GO
EXEC sys.sp_addextendedproperty @name=N'LastUpdated', @value=N'7/05/2014 8:06:30 a.m.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'ScheduledFlight' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight'
GO
EXEC sys.sp_addextendedproperty @name=N'OrderByOnLoad', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight'
GO
EXEC sys.sp_addextendedproperty @name=N'RecordCount', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight'
GO
EXEC sys.sp_addextendedproperty @name=N'TotalsRow', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight'
GO
EXEC sys.sp_addextendedproperty @name=N'Updatable', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ScheduledFlight'
GO
SET IDENTITY_INSERT [dbo].[ScheduledFlight] ON
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (2, 398, CAST(0x0000A6ED00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (6, 475, CAST(0x0000A72F00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (7, 487, CAST(0x0000A72800000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (8, 443, CAST(0x0000A7C900000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (9, 454, CAST(0x0000A79600000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (10, 450, CAST(0x0000A7CA00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (11, 456, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (18, 13, CAST(0x0000A7CC00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (19, 33, CAST(0x0000A79C00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (22, 74, CAST(0x0000A79400000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (23, 76, CAST(0x0000A78D00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (24, 310, CAST(0x0000A6FD00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (25, 326, CAST(0x0000A6EE00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (28, 49, CAST(0x0000A7D100000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (29, 65, CAST(0x0000A79C00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (36, 156, CAST(0x0000A81200000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (37, 169, CAST(0x0000A7FD00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (40, 442, CAST(0x0000A6FC00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (41, 459, CAST(0x0000A6ED00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (42, 398, CAST(0x0000A74F00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (44, 44, CAST(0x0000A7BB00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (45, 59, CAST(0x0000A7A100000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (46, 400, CAST(0x0000A7CC00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (47, 403, CAST(0x0000A79D00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (50, 83, CAST(0x0000A7E600000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (51, 90, CAST(0x0000A7DF00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (54, 197, CAST(0x0000A72B00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (55, 210, CAST(0x0000A72700000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (56, 441, CAST(0x0000A7D600000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (57, 451, CAST(0x0000A79A00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (60, 310, CAST(0x0000A73700000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (61, 326, CAST(0x0000A72900000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (62, 284, CAST(0x0000A73600000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (63, 300, CAST(0x0000A72800000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (68, 141, CAST(0x0000A6FD00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (69, 147, CAST(0x0000A6EE00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (72, 415, CAST(0x0000A82C00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (73, 432, CAST(0x0000A82500000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (74, 442, CAST(0x0000A7C900000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (75, 454, CAST(0x0000A79B00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (82, 527, CAST(0x0000A71C00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (83, 547, CAST(0x0000A71500000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (86, 365, CAST(0x0000A6FD00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (87, 373, CAST(0x0000A6EF00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (90, 398, CAST(0x0000A7CC00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (91, 399, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (100, 104, CAST(0x0000A7CA00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (101, 116, CAST(0x0000A79600000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (102, 310, CAST(0x0000A7D100000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (103, 326, CAST(0x0000A7A000000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (108, 98, CAST(0x0000A79D00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (110, 262, CAST(0x0000A79E00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (111, 268, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (114, 7, CAST(0x0000A84500000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (115, 18, CAST(0x0000A83A00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (118, 469, CAST(0x0000A74500000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (122, 400, CAST(0x0000A7C700000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (123, 404, CAST(0x0000A79B00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (128, 248, CAST(0x0000A73100000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (129, 255, CAST(0x0000A72A00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (130, 450, CAST(0x0000A7C800000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (131, 456, CAST(0x0000A79600000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (138, 164, CAST(0x0000A7BC00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (139, 168, CAST(0x0000A78F00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (142, 482, CAST(0x0000A81E00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (143, 493, CAST(0x0000A80800000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (151, 400, CAST(0x0000A74D00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (152, 403, CAST(0x0000A72A00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (153, 310, CAST(0x0000A7D400000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (154, 326, CAST(0x0000A7AD00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (157, 450, CAST(0x0000A71700000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (158, 456, CAST(0x0000A70D00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (159, 450, CAST(0x0000A74D00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (160, 456, CAST(0x0000A74600000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (161, 450, CAST(0x0000A7C600000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (162, 456, CAST(0x0000A7A100000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (163, 39, CAST(0x0000A7DF00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (164, 57, CAST(0x0000A78400000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (167, 407, CAST(0x0000A79F00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (168, 420, CAST(0x0000A79800000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (171, 197, CAST(0x0000A73C00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (172, 210, CAST(0x0000A73500000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (173, 438, CAST(0x0000A7A400000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (174, 453, CAST(0x0000A79D00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (175, 280, CAST(0x0000A7E100000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (176, 290, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (179, 49, CAST(0x0000A7DD00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (180, 64, CAST(0x0000A78C00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (187, 74, CAST(0x0000A7EB00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (188, 76, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (189, 350, CAST(0x0000A7C600000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (190, 375, CAST(0x0000A79500000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (191, 44, CAST(0x0000A7F100000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (192, 59, CAST(0x0000A7AB00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (193, 233, CAST(0x0000A6FD00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (194, 239, CAST(0x0000A6EF00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (197, 439, CAST(0x0000A7DF00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (198, 452, CAST(0x0000A79400000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (201, 104, CAST(0x0000A78900000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (202, 116, CAST(0x0000A79500000000 AS DateTime))
GO
print 'Processed 100 total records'
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (203, 307, CAST(0x0000A75100000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (204, 327, CAST(0x0000A72700000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (205, 83, CAST(0x0000A80500000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (206, 90, CAST(0x0000A83A00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (207, 103, CAST(0x0000A7C100000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (208, 112, CAST(0x0000A78C00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (209, 527, CAST(0x0000A76600000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (210, 548, CAST(0x0000A74700000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (211, 500, CAST(0x0000A70E00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (216, 575, CAST(0x0000A78500000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (217, 575, CAST(0x0000A78600000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (218, 575, CAST(0x0000A78700000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (220, 575, CAST(0x0000A78900000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (222, 575, CAST(0x0000A78B00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (231, 576, CAST(0x0000A78600000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (234, 576, CAST(0x0000A78900000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (236, 576, CAST(0x0000A78B00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (237, 577, CAST(0x0000A78500000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (238, 577, CAST(0x0000A78600000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (239, 577, CAST(0x0000A78700000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (241, 577, CAST(0x0000A78900000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (243, 577, CAST(0x0000A78B00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (245, 578, CAST(0x0000A78600000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (247, 578, CAST(0x0000A78800000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (249, 578, CAST(0x0000A78A00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (254, 579, CAST(0x0000A78800000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (258, 581, CAST(0x0000A78500000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (259, 581, CAST(0x0000A78600000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (261, 581, CAST(0x0000A78800000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (262, 581, CAST(0x0000A78900000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (264, 581, CAST(0x0000A78B00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (267, 582, CAST(0x0000A78700000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (270, 582, CAST(0x0000A78A00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (271, 582, CAST(0x0000A78B00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (275, 580, CAST(0x0000A78800000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (277, 580, CAST(0x0000A78A00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (281, 583, CAST(0x0000A78E00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (282, 583, CAST(0x0000A78F00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (284, 583, CAST(0x0000A79100000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (288, 584, CAST(0x0000A78E00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (290, 584, CAST(0x0000A79000000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (292, 584, CAST(0x0000A79200000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (295, 585, CAST(0x0000A78E00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (297, 585, CAST(0x0000A79000000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (301, 586, CAST(0x0000A78D00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (303, 586, CAST(0x0000A78F00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (305, 586, CAST(0x0000A79100000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (306, 586, CAST(0x0000A79200000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (308, 587, CAST(0x0000A78D00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (310, 587, CAST(0x0000A78F00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (312, 587, CAST(0x0000A79100000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (316, 588, CAST(0x0000A78E00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (317, 588, CAST(0x0000A78F00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (319, 588, CAST(0x0000A79100000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (321, 589, CAST(0x0000A78C00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (322, 589, CAST(0x0000A78D00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (324, 589, CAST(0x0000A78F00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (326, 589, CAST(0x0000A79100000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (328, 590, CAST(0x0000A78C00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (329, 590, CAST(0x0000A78D00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (331, 590, CAST(0x0000A78F00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (333, 590, CAST(0x0000A79100000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (334, 590, CAST(0x0000A79200000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (219, 575, CAST(0x0000A78800000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (221, 575, CAST(0x0000A78A00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (230, 576, CAST(0x0000A78500000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (232, 576, CAST(0x0000A78700000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (233, 576, CAST(0x0000A78800000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (235, 576, CAST(0x0000A78A00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (242, 577, CAST(0x0000A78A00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (246, 578, CAST(0x0000A78700000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (251, 579, CAST(0x0000A78500000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (252, 579, CAST(0x0000A78600000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (255, 579, CAST(0x0000A78900000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (256, 579, CAST(0x0000A78A00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (257, 579, CAST(0x0000A78B00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (263, 581, CAST(0x0000A78A00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (265, 582, CAST(0x0000A78500000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (269, 582, CAST(0x0000A78900000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (272, 580, CAST(0x0000A78500000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (273, 580, CAST(0x0000A78600000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (274, 580, CAST(0x0000A78700000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (276, 580, CAST(0x0000A78900000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (279, 583, CAST(0x0000A78C00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (280, 583, CAST(0x0000A78D00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (285, 583, CAST(0x0000A79200000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (286, 584, CAST(0x0000A78C00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (291, 584, CAST(0x0000A79100000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (294, 585, CAST(0x0000A78D00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (296, 585, CAST(0x0000A78F00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (298, 585, CAST(0x0000A79100000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (300, 586, CAST(0x0000A78C00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (302, 586, CAST(0x0000A78E00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (309, 587, CAST(0x0000A78E00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (311, 587, CAST(0x0000A79000000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (314, 588, CAST(0x0000A78C00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (318, 588, CAST(0x0000A79000000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (320, 588, CAST(0x0000A79200000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (323, 589, CAST(0x0000A78E00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (325, 589, CAST(0x0000A79000000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (330, 590, CAST(0x0000A78E00000000 AS DateTime))
GO
print 'Processed 200 total records'
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (332, 590, CAST(0x0000A79000000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (240, 577, CAST(0x0000A78800000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (244, 578, CAST(0x0000A78500000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (248, 578, CAST(0x0000A78900000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (253, 579, CAST(0x0000A78700000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (260, 581, CAST(0x0000A78700000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (266, 582, CAST(0x0000A78600000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (278, 580, CAST(0x0000A78B00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (283, 583, CAST(0x0000A79000000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (289, 584, CAST(0x0000A78F00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (293, 585, CAST(0x0000A78C00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (304, 586, CAST(0x0000A79000000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (313, 587, CAST(0x0000A79200000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (315, 588, CAST(0x0000A78D00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (327, 589, CAST(0x0000A79200000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (250, 578, CAST(0x0000A78B00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (268, 582, CAST(0x0000A78800000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (287, 584, CAST(0x0000A78D00000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (299, 585, CAST(0x0000A79200000000 AS DateTime))
INSERT [dbo].[ScheduledFlight] ([ScheduledFlightID], [FlightID], [FlightDate]) VALUES (307, 587, CAST(0x0000A78C00000000 AS DateTime))
SET IDENTITY_INSERT [dbo].[ScheduledFlight] OFF
/****** Object:  Table [dbo].[ReservedSeat]    Script Date: 04/25/2017 13:13:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReservedSeat](
	[PassengerID] [int] NOT NULL,
	[ScheduledFlightID] [int] NOT NULL,
	[Class] [nvarchar](10) NULL,
	[Status] [nvarchar](10) NULL,
	[Sector] [nvarchar](50) NULL,
 CONSTRAINT [aaaaaReservedSeat_PK] PRIMARY KEY NONCLUSTERED 
(
	[PassengerID] ASC,
	[ScheduledFlightID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'PassengerID'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'PassengerID'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'PassengerID'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'PassengerID'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'PassengerID'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'PassengerID'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'PassengerID'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'PassengerID'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'PassengerID'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'悊�窳䒌碥잃ꉧ頵' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'PassengerID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'PassengerID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'PassengerID'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'PassengerID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'PassengerID'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'PassengerID'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'PassengerID'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'PassengerID'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'PassengerID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'PassengerID'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'ReservedSeat' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'PassengerID'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'PassengerID'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'PassengerID'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'ScheduledFlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'ScheduledFlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'ScheduledFlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'ScheduledFlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'ScheduledFlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'ScheduledFlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'ScheduledFlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'540' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'ScheduledFlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'ScheduledFlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'ﭮ�㕠䴕螃巙ꭜⲏ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'ScheduledFlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'ScheduledFlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'ScheduledFlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'ScheduledFlightID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'ScheduledFlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'ScheduledFlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'ScheduledFlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'ScheduledFlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'ScheduledFlightID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'ScheduledFlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'ReservedSeat' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'ScheduledFlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'ScheduledFlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'ScheduledFlightID'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Class'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Class'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Class'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Class'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Class'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Class'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Class'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Class'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Class'
GO
EXEC sys.sp_addextendedproperty @name=N'DefaultValue', @value=N'"Economy"' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Class'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'䯫驞庝亓ֶ䦃풟戫' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Class'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Class'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Class'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Class'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Class' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Class'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Class'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Class'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Class'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Class' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Class'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'ReservedSeat' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Class'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Class'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Class'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Class'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'DefaultValue', @value=N'"Waitlisted"' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'ꉰ쇒㎒乪쎽홠ʵ䢈' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Status' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Status' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'ReservedSeat' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Sector'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Sector'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Sector'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Sector'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Sector'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Sector'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Sector'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Sector'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Sector'
GO
EXEC sys.sp_addextendedproperty @name=N'DefaultValue', @value=N'"Outward"' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Sector'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'敲廞壾䖷ᒾ࣮澪' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Sector'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Sector'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Sector'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Sector'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Sector' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Sector'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Sector'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Sector'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'50' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Sector'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Sector' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Sector'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'ReservedSeat' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Sector'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Sector'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Sector'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat', @level2type=N'COLUMN',@level2name=N'Sector'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat'
GO
EXEC sys.sp_addextendedproperty @name=N'DateCreated', @value=N'16/02/2014 10:02:34 a.m.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat'
GO
EXEC sys.sp_addextendedproperty @name=N'DisplayViewsOnSharePointSite', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat'
GO
EXEC sys.sp_addextendedproperty @name=N'FilterOnLoad', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat'
GO
EXEC sys.sp_addextendedproperty @name=N'HideNewField', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat'
GO
EXEC sys.sp_addextendedproperty @name=N'LastUpdated', @value=N'7/05/2014 8:06:30 a.m.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'ReservedSeat' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat'
GO
EXEC sys.sp_addextendedproperty @name=N'OrderByOnLoad', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat'
GO
EXEC sys.sp_addextendedproperty @name=N'RecordCount', @value=N'210' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat'
GO
EXEC sys.sp_addextendedproperty @name=N'TotalsRow', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat'
GO
EXEC sys.sp_addextendedproperty @name=N'Updatable', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ReservedSeat'
GO
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (1, 2, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (2, 2, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (3, 2, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (4, 2, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (5, 6, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (5, 7, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (6, 8, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (6, 9, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (7, 10, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (7, 11, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (8, 10, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (8, 11, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (9, 10, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (9, 11, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (10, 10, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (10, 11, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (11, 18, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (11, 19, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (12, 18, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (12, 19, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (13, 22, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (13, 23, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (14, 24, N'Business', N'Waitlisted', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (14, 25, N'Business', N'Waitlisted', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (15, 24, N'Business', N'Waitlisted', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (15, 25, N'Business', N'Waitlisted', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (16, 28, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (16, 29, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (17, 28, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (17, 29, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (18, 28, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (18, 29, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (19, 28, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (19, 29, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (20, 36, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (20, 37, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (21, 36, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (21, 37, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (22, 40, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (22, 41, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (23, 42, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (24, 42, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (25, 44, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (25, 45, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (26, 46, N'Business', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (26, 47, N'Business', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (27, 46, N'Business', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (27, 47, N'Business', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (28, 50, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (28, 51, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (29, 50, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (29, 51, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (30, 54, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (30, 55, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (31, 56, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (31, 57, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (32, 56, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (32, 57, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (33, 60, N'Economy', N'Waitlisted', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (33, 61, N'Economy', N'Waitlisted', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (34, 62, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (34, 63, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (35, 62, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (35, 63, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (36, 62, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (36, 63, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (37, 68, N'Economy', N'Waitlisted', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (37, 69, N'Economy', N'Waitlisted', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (38, 68, N'Economy', N'Waitlisted', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (38, 69, N'Economy', N'Waitlisted', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (39, 72, N'Business', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (39, 73, N'Business', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (40, 74, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (40, 75, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (41, 74, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (41, 75, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (42, 74, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (42, 75, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (43, 74, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (43, 75, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (44, 82, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (44, 83, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (45, 82, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (45, 83, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (46, 86, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (46, 87, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (47, 86, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (47, 87, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (48, 90, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (48, 91, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (49, 90, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (49, 91, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (50, 90, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (50, 91, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (51, 90, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (51, 91, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (52, 90, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (52, 91, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (53, 100, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (53, 101, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (54, 102, N'Economy', N'Confirmed', N'Return')
GO
print 'Processed 100 total records'
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (54, 103, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (55, 102, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (55, 103, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (56, 102, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (56, 103, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (57, 108, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (58, 108, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (59, 110, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (59, 111, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (60, 110, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (60, 111, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (61, 114, N'Economy', N'Waitlisted', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (61, 115, N'Economy', N'Waitlisted', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (62, 114, N'Economy', N'Waitlisted', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (62, 115, N'Economy', N'Waitlisted', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (63, 118, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (64, 118, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (65, 118, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (66, 118, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (67, 122, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (67, 123, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (68, 122, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (68, 123, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (69, 122, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (69, 123, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (70, 128, N'Business', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (70, 129, N'Business', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (71, 130, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (71, 131, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (72, 130, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (72, 131, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (73, 130, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (73, 131, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (74, 130, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (74, 131, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (75, 138, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (75, 139, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (76, 138, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (76, 139, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (77, 142, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (77, 143, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (78, 142, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (78, 143, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (79, 9, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (80, 9, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (81, 9, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (82, 151, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (82, 152, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (83, 151, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (83, 152, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (84, 153, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (84, 154, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (85, 153, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (85, 154, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (86, 157, N'Business', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (86, 158, N'Business', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (87, 159, N'Business', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (87, 160, N'Business', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (88, 161, N'Business', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (88, 162, N'Business', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (89, 163, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (89, 164, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (90, 163, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (90, 164, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (91, 167, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (91, 168, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (92, 167, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (92, 168, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (93, 171, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (93, 172, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (94, 173, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (94, 174, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (95, 175, N'Economy', N'Waitlisted', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (95, 176, N'Economy', N'Waitlisted', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (96, 175, N'Economy', N'Waitlisted', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (96, 176, N'Economy', N'Waitlisted', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (97, 179, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (97, 180, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (98, 179, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (98, 180, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (99, 179, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (99, 180, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (100, 179, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (100, 180, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (101, 187, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (101, 188, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (102, 189, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (102, 190, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (103, 191, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (103, 192, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (104, 193, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (104, 194, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (105, 193, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (105, 194, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (106, 197, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (106, 198, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (107, 197, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (107, 198, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (108, 201, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (108, 202, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (109, 203, N'Economy', N'Confirmed', N'Return')
GO
print 'Processed 200 total records'
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (109, 204, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (110, 205, N'Business', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (110, 206, N'Business', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (111, 207, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (111, 208, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (112, 209, N'Economy', N'Waitlisted', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (112, 210, N'Economy', N'Waitlisted', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (113, 211, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (127, 245, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (128, 246, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (130, 245, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (130, 294, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (131, 246, N'Economy', N'Confirmed', N'Outward')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (131, 295, N'Economy', N'Confirmed', N'Return')
INSERT [dbo].[ReservedSeat] ([PassengerID], [ScheduledFlightID], [Class], [Status], [Sector]) VALUES (129, 261, N'Economy', N'Confirmed', N'Outward')
/****** Object:  Default [DF__Reservatio__Paid__060DEAE8]    Script Date: 04/25/2017 13:13:39 ******/
ALTER TABLE [dbo].[Reservation] ADD  DEFAULT ((0)) FOR [Paid]
GO
/****** Object:  ForeignKey [Flight_FK00]    Script Date: 04/25/2017 13:13:39 ******/
ALTER TABLE [dbo].[Flight]  WITH CHECK ADD  CONSTRAINT [Flight_FK00] FOREIGN KEY([AircraftID])
REFERENCES [dbo].[Aircraft] ([AircraftID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Flight] CHECK CONSTRAINT [Flight_FK00]
GO
/****** Object:  ForeignKey [Reservation_FK00]    Script Date: 04/25/2017 13:13:39 ******/
ALTER TABLE [dbo].[Reservation]  WITH CHECK ADD  CONSTRAINT [Reservation_FK00] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employee] ([EmployeeID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Reservation] CHECK CONSTRAINT [Reservation_FK00]
GO
/****** Object:  ForeignKey [Reservation_FK01]    Script Date: 04/25/2017 13:13:39 ******/
ALTER TABLE [dbo].[Reservation]  WITH CHECK ADD  CONSTRAINT [Reservation_FK01] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customer] ([CustomerID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Reservation] CHECK CONSTRAINT [Reservation_FK01]
GO
/****** Object:  ForeignKey [Passenger_FK00]    Script Date: 04/25/2017 13:13:39 ******/
ALTER TABLE [dbo].[Passenger]  WITH CHECK ADD  CONSTRAINT [Passenger_FK00] FOREIGN KEY([ReservationID])
REFERENCES [dbo].[Reservation] ([ReservationID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Passenger] CHECK CONSTRAINT [Passenger_FK00]
GO
/****** Object:  ForeignKey [ScheduledFlight_FK00]    Script Date: 04/25/2017 13:13:39 ******/
ALTER TABLE [dbo].[ScheduledFlight]  WITH CHECK ADD  CONSTRAINT [ScheduledFlight_FK00] FOREIGN KEY([FlightID])
REFERENCES [dbo].[Flight] ([FlightID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ScheduledFlight] CHECK CONSTRAINT [ScheduledFlight_FK00]
GO
/****** Object:  ForeignKey [ReservedSeat_FK00]    Script Date: 04/25/2017 13:13:40 ******/
ALTER TABLE [dbo].[ReservedSeat]  WITH CHECK ADD  CONSTRAINT [ReservedSeat_FK00] FOREIGN KEY([PassengerID])
REFERENCES [dbo].[Passenger] ([PassengerID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ReservedSeat] CHECK CONSTRAINT [ReservedSeat_FK00]
GO
/****** Object:  ForeignKey [ReservedSeat_FK01]    Script Date: 04/25/2017 13:13:40 ******/
ALTER TABLE [dbo].[ReservedSeat]  WITH CHECK ADD  CONSTRAINT [ReservedSeat_FK01] FOREIGN KEY([ScheduledFlightID])
REFERENCES [dbo].[ScheduledFlight] ([ScheduledFlightID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ReservedSeat] CHECK CONSTRAINT [ReservedSeat_FK01]
GO
