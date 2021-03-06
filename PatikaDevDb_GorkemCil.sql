USE [master]
GO
/****** Object:  Database [PatikaDevDB]    Script Date: 30.01.2022 20:16:03 ******/
CREATE DATABASE [PatikaDevDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PatikaDevDB', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\PatikaDevDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'PatikaDevDB_log', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\PatikaDevDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [PatikaDevDB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PatikaDevDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PatikaDevDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PatikaDevDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PatikaDevDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PatikaDevDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PatikaDevDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [PatikaDevDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PatikaDevDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PatikaDevDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PatikaDevDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PatikaDevDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PatikaDevDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PatikaDevDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PatikaDevDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PatikaDevDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PatikaDevDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [PatikaDevDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PatikaDevDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PatikaDevDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PatikaDevDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PatikaDevDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PatikaDevDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PatikaDevDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PatikaDevDB] SET RECOVERY FULL 
GO
ALTER DATABASE [PatikaDevDB] SET  MULTI_USER 
GO
ALTER DATABASE [PatikaDevDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PatikaDevDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PatikaDevDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PatikaDevDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [PatikaDevDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [PatikaDevDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'PatikaDevDB', N'ON'
GO
ALTER DATABASE [PatikaDevDB] SET QUERY_STORE = OFF
GO
USE [PatikaDevDB]
GO
/****** Object:  Table [dbo].[Students]    Script Date: 30.01.2022 20:16:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Students](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](255) NOT NULL,
	[LastName] [varchar](255) NULL,
	[Age] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Lessons]    Script Date: 30.01.2022 20:16:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lessons](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LessonName] [varchar](255) NOT NULL,
	[BeginDate] [datetime2](7) NULL,
	[EndDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Participants]    Script Date: 30.01.2022 20:16:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Participants](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LessonId] [int] NOT NULL,
	[StudentId] [int] NOT NULL,
	[TeacherId] [int] NULL,
	[AssistantId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Attendances]    Script Date: 30.01.2022 20:16:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Attendances](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StudentId] [int] NOT NULL,
	[LessonId] [int] NULL,
	[TotalAttedance] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[StudentList_Lessons]    Script Date: 30.01.2022 20:16:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[StudentList_Lessons] 
AS 
SELECT S.FirstName,S.LastName,L.LessonName FROM Students AS S 
JOIN Attendances AS A
ON A.StudentId=S.Id 
JOIN Participants AS P
ON P.StudentId=S.Id
JOIN Lessons AS L
ON L.Id=P.LessonId
GO
/****** Object:  Table [dbo].[Assistans]    Script Date: 30.01.2022 20:16:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Assistans](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](255) NOT NULL,
	[LastName] [varchar](255) NULL,
	[Age] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Scores]    Script Date: 30.01.2022 20:16:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Scores](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StudentId] [int] NOT NULL,
	[Score] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Teachers]    Script Date: 30.01.2022 20:16:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Teachers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](255) NOT NULL,
	[LastName] [varchar](255) NULL,
	[Age] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Attendances]  WITH CHECK ADD  CONSTRAINT [FK_Attendances_Students] FOREIGN KEY([StudentId])
REFERENCES [dbo].[Students] ([Id])
GO
ALTER TABLE [dbo].[Attendances] CHECK CONSTRAINT [FK_Attendances_Students]
GO
ALTER TABLE [dbo].[Participants]  WITH CHECK ADD  CONSTRAINT [FK_Participants_Assistans] FOREIGN KEY([AssistantId])
REFERENCES [dbo].[Assistans] ([Id])
GO
ALTER TABLE [dbo].[Participants] CHECK CONSTRAINT [FK_Participants_Assistans]
GO
ALTER TABLE [dbo].[Participants]  WITH CHECK ADD  CONSTRAINT [FK_Participants_Lessons] FOREIGN KEY([LessonId])
REFERENCES [dbo].[Lessons] ([Id])
GO
ALTER TABLE [dbo].[Participants] CHECK CONSTRAINT [FK_Participants_Lessons]
GO
ALTER TABLE [dbo].[Participants]  WITH CHECK ADD  CONSTRAINT [FK_Participants_Students] FOREIGN KEY([StudentId])
REFERENCES [dbo].[Students] ([Id])
GO
ALTER TABLE [dbo].[Participants] CHECK CONSTRAINT [FK_Participants_Students]
GO
ALTER TABLE [dbo].[Participants]  WITH CHECK ADD  CONSTRAINT [FK_Participants_Teachers] FOREIGN KEY([TeacherId])
REFERENCES [dbo].[Teachers] ([Id])
GO
ALTER TABLE [dbo].[Participants] CHECK CONSTRAINT [FK_Participants_Teachers]
GO
ALTER TABLE [dbo].[Scores]  WITH CHECK ADD  CONSTRAINT [FK_Scores_Students] FOREIGN KEY([StudentId])
REFERENCES [dbo].[Students] ([Id])
GO
ALTER TABLE [dbo].[Scores] CHECK CONSTRAINT [FK_Scores_Students]
GO
/****** Object:  StoredProcedure [dbo].[Add_Student_Lesson]    Script Date: 30.01.2022 20:16:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Add_Student_Lesson]
@studentid nvarchar(20),
@lessonid nvarchar(25),
@totalattedance int
AS
IF NOT EXISTS(SELECT TOP 1* FROM Attendances where StudentId=@studentid)
INSERT INTO Attendances Values(@studentid,@lessonid,@totalattedance)
ELSE
SELECT BeginDate,EndDate FROM Lessons where Id=@lessonid
DECLARE @Bdate datetime 
DECLARE @Edate datetime 
SET @Bdate=(SELECT BeginDate FROM Lessons where Id=@lessonid)
SET @Edate=(SELECT EndDate FROM Lessons where Id=@lessonid)
IF EXISTS(SELECT * FROM Lessons WHERE Id IN(SELECT LessonId FROM Attendances where StudentId=@studentid) AND BeginDate BETWEEN @Bdate AND @Edate)
raiserror('Aynı tarihlerde başka bir derse kayıtlı!',1,1)
ELSE
INSERT INTO Attendances Values(@studentid,@lessonid,@totalattedance)
GO
USE [master]
GO
ALTER DATABASE [PatikaDevDB] SET  READ_WRITE 
GO
