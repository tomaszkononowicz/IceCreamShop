CREATE DATABASE [IceCreamShop]
GO
USE [IceCreamShop]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 13.09.2018 21:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Product](
	[Id] [int] NOT NULL,
	[Name] [varchar](25) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SemiFinishedGood]    Script Date: 13.09.2018 21:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SemiFinishedGood](
	[Id] [int] NOT NULL,
	[Name] [varchar](256) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[Product] ([Id], [Name]) VALUES (1, N'Lody czekoladowe')
GO
INSERT [dbo].[Product] ([Id], [Name]) VALUES (2, N'Lody waniliowe')
GO
INSERT [dbo].[Product] ([Id], [Name]) VALUES (3, N'Lody truskawkowe')
GO
INSERT [dbo].[Product] ([Id], [Name]) VALUES (4, N'Lody malinowe')
GO
INSERT [dbo].[Product] ([Id], [Name]) VALUES (5, N'Lody bananowe')
GO
INSERT [dbo].[Product] ([Id], [Name]) VALUES (6, N'Lody śmietankowe')
GO
INSERT [dbo].[SemiFinishedGood] ([Id], [Name]) VALUES (1, N'Mleko UHT 2% tł. WYPASIONE 1 L')
GO
INSERT [dbo].[SemiFinishedGood] ([Id], [Name]) VALUES (2, N'Mleko UHT 3,2% tł. WYPASIONE 1 L')
GO
INSERT [dbo].[SemiFinishedGood] ([Id], [Name]) VALUES (3, N'Mleko Wypasione od szczęśliwych krów BEZ GMO 3,2% 1 L')
GO
INSERT [dbo].[SemiFinishedGood] ([Id], [Name]) VALUES (4, N'Wydojone bez laktozy 1 L UHT 1,5% tł.')
GO
INSERT [dbo].[SemiFinishedGood] ([Id], [Name]) VALUES (5, N'Mleko UHT Twój Kubek 0,5% tł. 1 L z zakrętką')
GO
INSERT [dbo].[SemiFinishedGood] ([Id], [Name]) VALUES (6, N'Żółtka jaj')
GO
INSERT [dbo].[SemiFinishedGood] ([Id], [Name]) VALUES (7, N'Śmietana POLSKA gęsta 12% 200 g Mlekovita')
GO
INSERT [dbo].[SemiFinishedGood] ([Id], [Name]) VALUES (8, N'Śmietana Polska 18% bez laktozy 200 g Mlekovita')
GO
INSERT [dbo].[SemiFinishedGood] ([Id], [Name]) VALUES (9, N'Śmietana POLSKA gęsta 18% 400 g Mlekovita')
GO
INSERT [dbo].[SemiFinishedGood] ([Id], [Name]) VALUES (10, N'Śmietanka POLSKA 30% 200 ml Mlekovita')
GO
INSERT [dbo].[SemiFinishedGood] ([Id], [Name]) VALUES (11, N'Śmietanka UHT Polska 36% tłuszczu 1 L Mlekovita')
GO
INSERT [dbo].[SemiFinishedGood] ([Id], [Name]) VALUES (12, N'Cukier biały Diamant 1 kg')
GO
INSERT [dbo].[SemiFinishedGood] ([Id], [Name]) VALUES (13, N'Tabliczka czekolady Wedel')
GO
INSERT [dbo].[SemiFinishedGood] ([Id], [Name]) VALUES (14, N'Truskawki 1 kg')
GO
INSERT [dbo].[SemiFinishedGood] ([Id], [Name]) VALUES (15, N'Maliny 400 g')
GO
INSERT [dbo].[SemiFinishedGood] ([Id], [Name]) VALUES (16, N'Wanilia 1 laska')
GO
INSERT [dbo].[SemiFinishedGood] ([Id], [Name]) VALUES (17, N'Wafelek mały')
GO
INSERT [dbo].[SemiFinishedGood] ([Id], [Name]) VALUES (18, N'Wafelek duży')
GO
INSERT [dbo].[SemiFinishedGood] ([Id], [Name]) VALUES (19, N'Polewa toffi')
GO
INSERT [dbo].[SemiFinishedGood] ([Id], [Name]) VALUES (20, N'Polewa czekoladowa')
GO
INSERT [dbo].[SemiFinishedGood] ([Id], [Name]) VALUES (21, N'Banany 1 kiść')
GO
