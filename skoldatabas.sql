USE [master]
GO
/****** Object:  Database [LABB2 SKOLA]    Script Date: 2024-01-07 21:26:06 ******/
CREATE DATABASE [LABB2 SKOLA]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'LABB2 SKOLA', FILENAME = N'C:\Users\Adder\LABB2 SKOLA.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'LABB2 SKOLA_log', FILENAME = N'C:\Users\Adder\LABB2 SKOLA_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [LABB2 SKOLA] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [LABB2 SKOLA].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [LABB2 SKOLA] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [LABB2 SKOLA] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [LABB2 SKOLA] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [LABB2 SKOLA] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [LABB2 SKOLA] SET ARITHABORT OFF 
GO
ALTER DATABASE [LABB2 SKOLA] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [LABB2 SKOLA] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [LABB2 SKOLA] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [LABB2 SKOLA] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [LABB2 SKOLA] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [LABB2 SKOLA] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [LABB2 SKOLA] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [LABB2 SKOLA] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [LABB2 SKOLA] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [LABB2 SKOLA] SET  DISABLE_BROKER 
GO
ALTER DATABASE [LABB2 SKOLA] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [LABB2 SKOLA] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [LABB2 SKOLA] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [LABB2 SKOLA] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [LABB2 SKOLA] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [LABB2 SKOLA] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [LABB2 SKOLA] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [LABB2 SKOLA] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [LABB2 SKOLA] SET  MULTI_USER 
GO
ALTER DATABASE [LABB2 SKOLA] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [LABB2 SKOLA] SET DB_CHAINING OFF 
GO
ALTER DATABASE [LABB2 SKOLA] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [LABB2 SKOLA] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [LABB2 SKOLA] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [LABB2 SKOLA] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [LABB2 SKOLA] SET QUERY_STORE = OFF
GO
USE [LABB2 SKOLA]
GO
/****** Object:  Table [dbo].[BetygTabell]    Script Date: 2024-01-07 21:26:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BetygTabell](
	[BetygIdPK] [int] NOT NULL,
	[StudentIdFK] [int] NULL,
	[KursIdFK] [int] NULL,
	[LärareIdFK] [int] NULL,
	[Betyg] [nvarchar](5) NULL,
	[BetygDatum] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[BetygIdPK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KlassTabell]    Script Date: 2024-01-07 21:26:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KlassTabell](
	[KlassIdPK] [int] NOT NULL,
	[KlassNamn] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[KlassIdPK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KursTabell]    Script Date: 2024-01-07 21:26:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KursTabell](
	[KursIdPK] [int] NOT NULL,
	[KursNamn] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[KursIdPK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Lärare]    Script Date: 2024-01-07 21:26:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lärare](
	[LärareIdPK] [int] NOT NULL,
	[Lärare] [nvarchar](50) NULL,
 CONSTRAINT [PK_Lärare] PRIMARY KEY CLUSTERED 
(
	[LärareIdPK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LönTabell]    Script Date: 2024-01-07 21:26:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LönTabell](
	[Lön] [int] NOT NULL,
	[FörNamn] [nvarchar](50) NULL,
	[EfterNamn] [nvarchar](50) NULL,
	[Personnummer] [nvarchar](50) NULL,
	[AnställningsDatum] [date] NULL,
	[Befattning] [nvarchar](50) NULL,
	[PersonIdFK] [int] NOT NULL,
 CONSTRAINT [PK_LönTabell] PRIMARY KEY CLUSTERED 
(
	[Lön] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PersonalTabell]    Script Date: 2024-01-07 21:26:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PersonalTabell](
	[PersonIdPK] [int] IDENTITY(1,1) NOT NULL,
	[FörNamn] [nvarchar](50) NULL,
	[EfterNamn] [nvarchar](50) NULL,
	[Personnummer] [nvarchar](20) NULL,
	[AnställningsDatum] [date] NULL,
	[Befattning] [nvarchar](50) NULL,
	[LärareIdFK] [int] NULL,
 CONSTRAINT [PK__Personal__AA2FFB858259B802] PRIMARY KEY CLUSTERED 
(
	[PersonIdPK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StudentTabell]    Script Date: 2024-01-07 21:26:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudentTabell](
	[StudentIdPK] [int] NOT NULL,
	[FörNamn] [nvarchar](50) NULL,
	[EfterNamn] [nvarchar](50) NULL,
	[Personnummer] [varchar](12) NULL,
	[KlassIdFK] [int] NULL,
	[Kön] [nchar](10) NULL,
 CONSTRAINT [PK__StudentT__32C52A798EE2D681] PRIMARY KEY CLUSTERED 
(
	[StudentIdPK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[BetygTabell] ([BetygIdPK], [StudentIdFK], [KursIdFK], [LärareIdFK], [Betyg], [BetygDatum]) VALUES (0, 1000, 504, NULL, N'A', CAST(N'2024-01-05' AS Date))
INSERT [dbo].[BetygTabell] ([BetygIdPK], [StudentIdFK], [KursIdFK], [LärareIdFK], [Betyg], [BetygDatum]) VALUES (123, 1000, 504, NULL, N'A', CAST(N'2024-01-07' AS Date))
INSERT [dbo].[BetygTabell] ([BetygIdPK], [StudentIdFK], [KursIdFK], [LärareIdFK], [Betyg], [BetygDatum]) VALUES (331, 1001, 502, NULL, N'E', CAST(N'2024-01-07' AS Date))
INSERT [dbo].[BetygTabell] ([BetygIdPK], [StudentIdFK], [KursIdFK], [LärareIdFK], [Betyg], [BetygDatum]) VALUES (2001, 1001, 501, 1, N'B', CAST(N'2023-01-15' AS Date))
INSERT [dbo].[BetygTabell] ([BetygIdPK], [StudentIdFK], [KursIdFK], [LärareIdFK], [Betyg], [BetygDatum]) VALUES (2002, 1001, 502, 2, N'A', CAST(N'2023-02-20' AS Date))
INSERT [dbo].[BetygTabell] ([BetygIdPK], [StudentIdFK], [KursIdFK], [LärareIdFK], [Betyg], [BetygDatum]) VALUES (2003, 1002, 501, 3, N'C', CAST(N'2023-01-20' AS Date))
INSERT [dbo].[BetygTabell] ([BetygIdPK], [StudentIdFK], [KursIdFK], [LärareIdFK], [Betyg], [BetygDatum]) VALUES (2004, 1002, 502, 4, N'A', CAST(N'2023-02-25' AS Date))
INSERT [dbo].[BetygTabell] ([BetygIdPK], [StudentIdFK], [KursIdFK], [LärareIdFK], [Betyg], [BetygDatum]) VALUES (2005, 1003, 503, 5, N'B', CAST(N'2023-03-01' AS Date))
INSERT [dbo].[BetygTabell] ([BetygIdPK], [StudentIdFK], [KursIdFK], [LärareIdFK], [Betyg], [BetygDatum]) VALUES (2006, 1001, 501, 2, N'A', CAST(N'2023-11-16' AS Date))
INSERT [dbo].[BetygTabell] ([BetygIdPK], [StudentIdFK], [KursIdFK], [LärareIdFK], [Betyg], [BetygDatum]) VALUES (2007, 1003, 502, 1, N'D', CAST(N'2023-11-20' AS Date))
GO
INSERT [dbo].[KlassTabell] ([KlassIdPK], [KlassNamn]) VALUES (101, N'Naturvetenskap A')
INSERT [dbo].[KlassTabell] ([KlassIdPK], [KlassNamn]) VALUES (102, N'Samhällsvetenskap B')
INSERT [dbo].[KlassTabell] ([KlassIdPK], [KlassNamn]) VALUES (103, N'Ekonomi C')
INSERT [dbo].[KlassTabell] ([KlassIdPK], [KlassNamn]) VALUES (104, N'Teknik D')
INSERT [dbo].[KlassTabell] ([KlassIdPK], [KlassNamn]) VALUES (105, N'Språk E')
GO
INSERT [dbo].[KursTabell] ([KursIdPK], [KursNamn]) VALUES (501, N'Matematik 1')
INSERT [dbo].[KursTabell] ([KursIdPK], [KursNamn]) VALUES (502, N'Svenska A')
INSERT [dbo].[KursTabell] ([KursIdPK], [KursNamn]) VALUES (503, N'Engelska B')
INSERT [dbo].[KursTabell] ([KursIdPK], [KursNamn]) VALUES (504, N'Fysik 1')
INSERT [dbo].[KursTabell] ([KursIdPK], [KursNamn]) VALUES (505, N'Samhällskunskap A')
GO
INSERT [dbo].[Lärare] ([LärareIdPK], [Lärare]) VALUES (1001, N'Svenska')
INSERT [dbo].[Lärare] ([LärareIdPK], [Lärare]) VALUES (1002, N'Engelska')
INSERT [dbo].[Lärare] ([LärareIdPK], [Lärare]) VALUES (1003, N'Historia')
INSERT [dbo].[Lärare] ([LärareIdPK], [Lärare]) VALUES (1004, N'Idrott')
INSERT [dbo].[Lärare] ([LärareIdPK], [Lärare]) VALUES (1005, N'Programmering')
GO
INSERT [dbo].[LönTabell] ([Lön], [FörNamn], [EfterNamn], [Personnummer], [AnställningsDatum], [Befattning], [PersonIdFK]) VALUES (10000, NULL, NULL, NULL, NULL, NULL, 6)
INSERT [dbo].[LönTabell] ([Lön], [FörNamn], [EfterNamn], [Personnummer], [AnställningsDatum], [Befattning], [PersonIdFK]) VALUES (16000, NULL, NULL, NULL, NULL, NULL, 7)
INSERT [dbo].[LönTabell] ([Lön], [FörNamn], [EfterNamn], [Personnummer], [AnställningsDatum], [Befattning], [PersonIdFK]) VALUES (21500, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[LönTabell] ([Lön], [FörNamn], [EfterNamn], [Personnummer], [AnställningsDatum], [Befattning], [PersonIdFK]) VALUES (25000, NULL, NULL, NULL, NULL, NULL, 9)
INSERT [dbo].[LönTabell] ([Lön], [FörNamn], [EfterNamn], [Personnummer], [AnställningsDatum], [Befattning], [PersonIdFK]) VALUES (26000, NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[LönTabell] ([Lön], [FörNamn], [EfterNamn], [Personnummer], [AnställningsDatum], [Befattning], [PersonIdFK]) VALUES (29000, NULL, NULL, NULL, NULL, NULL, 3)
INSERT [dbo].[LönTabell] ([Lön], [FörNamn], [EfterNamn], [Personnummer], [AnställningsDatum], [Befattning], [PersonIdFK]) VALUES (32000, NULL, NULL, NULL, NULL, NULL, 4)
INSERT [dbo].[LönTabell] ([Lön], [FörNamn], [EfterNamn], [Personnummer], [AnställningsDatum], [Befattning], [PersonIdFK]) VALUES (42000, NULL, NULL, NULL, NULL, NULL, 5)
INSERT [dbo].[LönTabell] ([Lön], [FörNamn], [EfterNamn], [Personnummer], [AnställningsDatum], [Befattning], [PersonIdFK]) VALUES (100000000, NULL, NULL, NULL, NULL, NULL, 8)
GO
SET IDENTITY_INSERT [dbo].[PersonalTabell] ON 

INSERT [dbo].[PersonalTabell] ([PersonIdPK], [FörNamn], [EfterNamn], [Personnummer], [AnställningsDatum], [Befattning], [LärareIdFK]) VALUES (1, N'Anna ', N'Andersson', N'850112-3456', CAST(N'2015-05-06' AS Date), N'Lärare', 1001)
INSERT [dbo].[PersonalTabell] ([PersonIdPK], [FörNamn], [EfterNamn], [Personnummer], [AnställningsDatum], [Befattning], [LärareIdFK]) VALUES (2, N'Erik ', N'Engström', N'761015-6789', CAST(N'2013-04-06' AS Date), N'Rektor', 1005)
INSERT [dbo].[PersonalTabell] ([PersonIdPK], [FörNamn], [EfterNamn], [Personnummer], [AnställningsDatum], [Befattning], [LärareIdFK]) VALUES (3, N'Maria ', N'Svensson', N'900530-1234', CAST(N'2018-12-01' AS Date), N'Administratör', 1003)
INSERT [dbo].[PersonalTabell] ([PersonIdPK], [FörNamn], [EfterNamn], [Personnummer], [AnställningsDatum], [Befattning], [LärareIdFK]) VALUES (4, N'Johan ', N'Jonsson', N'820304-5678', CAST(N'2014-07-03' AS Date), N'Lärare', 1005)
INSERT [dbo].[PersonalTabell] ([PersonIdPK], [FörNamn], [EfterNamn], [Personnummer], [AnställningsDatum], [Befattning], [LärareIdFK]) VALUES (5, N'Camilla ', N'Carlsson', N'910702-8901', CAST(N'2011-02-08' AS Date), N'Lärare', 1002)
INSERT [dbo].[PersonalTabell] ([PersonIdPK], [FörNamn], [EfterNamn], [Personnummer], [AnställningsDatum], [Befattning], [LärareIdFK]) VALUES (6, N'Håkan ', N'Stålgren', N'680506-2563', CAST(N'2017-03-08' AS Date), N'Vaktmästare', NULL)
INSERT [dbo].[PersonalTabell] ([PersonIdPK], [FörNamn], [EfterNamn], [Personnummer], [AnställningsDatum], [Befattning], [LärareIdFK]) VALUES (7, N'Agnes ', N'Myrberg', N'020228-6555', CAST(N'2018-02-01' AS Date), N'Städare', NULL)
INSERT [dbo].[PersonalTabell] ([PersonIdPK], [FörNamn], [EfterNamn], [Personnummer], [AnställningsDatum], [Befattning], [LärareIdFK]) VALUES (8, N'Adrian ', N'Moreno', N'020902-2730', CAST(N'2022-02-02' AS Date), N'Ägare', 1004)
INSERT [dbo].[PersonalTabell] ([PersonIdPK], [FörNamn], [EfterNamn], [Personnummer], [AnställningsDatum], [Befattning], [LärareIdFK]) VALUES (9, N'Andreas ', N'Lindblom', N'000506-5298', CAST(N'2023-01-07' AS Date), N'Kioskansvarig', NULL)
INSERT [dbo].[PersonalTabell] ([PersonIdPK], [FörNamn], [EfterNamn], [Personnummer], [AnställningsDatum], [Befattning], [LärareIdFK]) VALUES (11, N'Magdalena', N'Andersson', N'020205-6596', CAST(N'2024-01-01' AS Date), N'Rektor', NULL)
INSERT [dbo].[PersonalTabell] ([PersonIdPK], [FörNamn], [EfterNamn], [Personnummer], [AnställningsDatum], [Befattning], [LärareIdFK]) VALUES (1011, N'Moussa', N'Dembele', N'942565-9652', CAST(N'2021-03-02' AS Date), N'Vaktmästare', NULL)
INSERT [dbo].[PersonalTabell] ([PersonIdPK], [FörNamn], [EfterNamn], [Personnummer], [AnställningsDatum], [Befattning], [LärareIdFK]) VALUES (1012, N'Klas', N'Larsson', N'840307-6537', CAST(N'2023-09-02' AS Date), N'Lärare', 1005)
SET IDENTITY_INSERT [dbo].[PersonalTabell] OFF
GO
INSERT [dbo].[StudentTabell] ([StudentIdPK], [FörNamn], [EfterNamn], [Personnummer], [KlassIdFK], [Kön]) VALUES (1000, N'Stig', N'Helmer', N'970604-1436', 102, NULL)
INSERT [dbo].[StudentTabell] ([StudentIdPK], [FörNamn], [EfterNamn], [Personnummer], [KlassIdFK], [Kön]) VALUES (1001, N'David ', N'Broberg', N'960225-1111', 101, NULL)
INSERT [dbo].[StudentTabell] ([StudentIdPK], [FörNamn], [EfterNamn], [Personnummer], [KlassIdFK], [Kön]) VALUES (1002, N'Sara ', N'Andersson', N'980712-2222', 101, NULL)
INSERT [dbo].[StudentTabell] ([StudentIdPK], [FörNamn], [EfterNamn], [Personnummer], [KlassIdFK], [Kön]) VALUES (1003, N'Oscar ', N'Linström', N'970503-3333', 102, NULL)
INSERT [dbo].[StudentTabell] ([StudentIdPK], [FörNamn], [EfterNamn], [Personnummer], [KlassIdFK], [Kön]) VALUES (1004, N'Elin ', N'Axelsson', N'940621-4444', 103, NULL)
INSERT [dbo].[StudentTabell] ([StudentIdPK], [FörNamn], [EfterNamn], [Personnummer], [KlassIdFK], [Kön]) VALUES (1005, N'Liam ', N'Klasson', N'990813-5555', 104, NULL)
INSERT [dbo].[StudentTabell] ([StudentIdPK], [FörNamn], [EfterNamn], [Personnummer], [KlassIdFK], [Kön]) VALUES (1006, N'Adrian', N'Moreno', N'020902-2730', 105, N'Man       ')
INSERT [dbo].[StudentTabell] ([StudentIdPK], [FörNamn], [EfterNamn], [Personnummer], [KlassIdFK], [Kön]) VALUES (1007, N'Jocke', N'Nilsson', N'020902-5560', 102, N'Man       ')
INSERT [dbo].[StudentTabell] ([StudentIdPK], [FörNamn], [EfterNamn], [Personnummer], [KlassIdFK], [Kön]) VALUES (1123, N'Agnes', N'Myrberg', N'020228-5060', 101, N'Man       ')
INSERT [dbo].[StudentTabell] ([StudentIdPK], [FörNamn], [EfterNamn], [Personnummer], [KlassIdFK], [Kön]) VALUES (1203, N'Reidun', N'Poulsen', N'320502-9632', 105, N'Man       ')
INSERT [dbo].[StudentTabell] ([StudentIdPK], [FörNamn], [EfterNamn], [Personnummer], [KlassIdFK], [Kön]) VALUES (1256, N'Joakim', N'Von ANka', N'020228-9698', 102, N'Man       ')
GO
ALTER TABLE [dbo].[BetygTabell]  WITH CHECK ADD FOREIGN KEY([KursIdFK])
REFERENCES [dbo].[KursTabell] ([KursIdPK])
GO
ALTER TABLE [dbo].[BetygTabell]  WITH CHECK ADD  CONSTRAINT [FK__BetygTabe__Lärar__3B75D760] FOREIGN KEY([LärareIdFK])
REFERENCES [dbo].[PersonalTabell] ([PersonIdPK])
GO
ALTER TABLE [dbo].[BetygTabell] CHECK CONSTRAINT [FK__BetygTabe__Lärar__3B75D760]
GO
ALTER TABLE [dbo].[BetygTabell]  WITH CHECK ADD  CONSTRAINT [FK__BetygTabe__Stude__398D8EEE] FOREIGN KEY([StudentIdFK])
REFERENCES [dbo].[StudentTabell] ([StudentIdPK])
GO
ALTER TABLE [dbo].[BetygTabell] CHECK CONSTRAINT [FK__BetygTabe__Stude__398D8EEE]
GO
ALTER TABLE [dbo].[LönTabell]  WITH CHECK ADD  CONSTRAINT [FK_LönTabell_PersonalTabell] FOREIGN KEY([PersonIdFK])
REFERENCES [dbo].[PersonalTabell] ([PersonIdPK])
GO
ALTER TABLE [dbo].[LönTabell] CHECK CONSTRAINT [FK_LönTabell_PersonalTabell]
GO
ALTER TABLE [dbo].[PersonalTabell]  WITH CHECK ADD  CONSTRAINT [FK_PersonalTabell_Lärare] FOREIGN KEY([LärareIdFK])
REFERENCES [dbo].[Lärare] ([LärareIdPK])
GO
ALTER TABLE [dbo].[PersonalTabell] CHECK CONSTRAINT [FK_PersonalTabell_Lärare]
GO
ALTER TABLE [dbo].[StudentTabell]  WITH CHECK ADD  CONSTRAINT [FK__StudentTa__Klass__34C8D9D1] FOREIGN KEY([KlassIdFK])
REFERENCES [dbo].[KlassTabell] ([KlassIdPK])
GO
ALTER TABLE [dbo].[StudentTabell] CHECK CONSTRAINT [FK__StudentTa__Klass__34C8D9D1]
GO
/****** Object:  StoredProcedure [dbo].[GetStudentById]    Script Date: 2024-01-07 21:26:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetStudentById]
	@StudentId INT
AS
BEGIN
	SELECT 
	StudentIdPK,
	FörNamn,
	EfterNamn,
	Personnummer
	FROM StudentTabell WHERE StudentIdPK = @StudentId;
END;

--För att köra proceduren.
--EXEC GetStudentById @StudentId = 1005;
GO
USE [master]
GO
ALTER DATABASE [LABB2 SKOLA] SET  READ_WRITE 
GO
