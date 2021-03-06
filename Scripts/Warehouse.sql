CREATE DATABASE [IceCreamShop_Warehouse]
GO
USE [IceCreamShop_Warehouse]
GO
/****** Object:  Table [dbo].[ProductAmount]    Script Date: 13.09.2018 22:00:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductAmount](
	[ProductId] [int] NOT NULL,
	[Amount] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Queue]    Script Date: 13.09.2018 22:00:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Queue](
	[MsgId] [int] IDENTITY(1,1) NOT NULL,
	[CorrelationId] [uniqueidentifier] NULL,
	[Command] [nvarchar](100) NULL,
	[Msg] [nvarchar](1000) NULL,
PRIMARY KEY CLUSTERED 
(
	[MsgId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SemiFinishedGoodAmount]    Script Date: 13.09.2018 22:00:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SemiFinishedGoodAmount](
	[SemiFinishedGoodId] [int] NOT NULL,
	[Amount] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[SemiFinishedGoodId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[Product]    Script Date: 13.09.2018 22:00:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Product] AS
SELECT *
FROM IceCreamShop.dbo.Product;

GO
/****** Object:  View [dbo].[SemiFinishedGood]    Script Date: 13.09.2018 22:00:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SemiFinishedGood] AS
SELECT *
FROM IceCreamShop.dbo.SemiFinishedGood;

GO
INSERT [dbo].[ProductAmount] ([ProductId], [Amount]) VALUES (1, CAST(28.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[ProductAmount] ([ProductId], [Amount]) VALUES (2, CAST(26.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[ProductAmount] ([ProductId], [Amount]) VALUES (3, CAST(5.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[ProductAmount] ([ProductId], [Amount]) VALUES (4, CAST(0.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[ProductAmount] ([ProductId], [Amount]) VALUES (5, CAST(9.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[ProductAmount] ([ProductId], [Amount]) VALUES (6, CAST(30.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[SemiFinishedGoodAmount] ([SemiFinishedGoodId], [Amount]) VALUES (1, CAST(7.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[SemiFinishedGoodAmount] ([SemiFinishedGoodId], [Amount]) VALUES (2, CAST(52.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[SemiFinishedGoodAmount] ([SemiFinishedGoodId], [Amount]) VALUES (3, CAST(31.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[SemiFinishedGoodAmount] ([SemiFinishedGoodId], [Amount]) VALUES (4, CAST(21.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[SemiFinishedGoodAmount] ([SemiFinishedGoodId], [Amount]) VALUES (5, CAST(31.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[SemiFinishedGoodAmount] ([SemiFinishedGoodId], [Amount]) VALUES (6, CAST(105.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[SemiFinishedGoodAmount] ([SemiFinishedGoodId], [Amount]) VALUES (7, CAST(89.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[SemiFinishedGoodAmount] ([SemiFinishedGoodId], [Amount]) VALUES (8, CAST(100.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[SemiFinishedGoodAmount] ([SemiFinishedGoodId], [Amount]) VALUES (9, CAST(99.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[SemiFinishedGoodAmount] ([SemiFinishedGoodId], [Amount]) VALUES (10, CAST(94.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[SemiFinishedGoodAmount] ([SemiFinishedGoodId], [Amount]) VALUES (11, CAST(4.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[SemiFinishedGoodAmount] ([SemiFinishedGoodId], [Amount]) VALUES (12, CAST(21.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[SemiFinishedGoodAmount] ([SemiFinishedGoodId], [Amount]) VALUES (13, CAST(70.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[SemiFinishedGoodAmount] ([SemiFinishedGoodId], [Amount]) VALUES (14, CAST(12.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[SemiFinishedGoodAmount] ([SemiFinishedGoodId], [Amount]) VALUES (15, CAST(6.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[SemiFinishedGoodAmount] ([SemiFinishedGoodId], [Amount]) VALUES (16, CAST(90.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[SemiFinishedGoodAmount] ([SemiFinishedGoodId], [Amount]) VALUES (17, CAST(0.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[SemiFinishedGoodAmount] ([SemiFinishedGoodId], [Amount]) VALUES (18, CAST(3.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[SemiFinishedGoodAmount] ([SemiFinishedGoodId], [Amount]) VALUES (19, CAST(0.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[SemiFinishedGoodAmount] ([SemiFinishedGoodId], [Amount]) VALUES (20, CAST(0.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[SemiFinishedGoodAmount] ([SemiFinishedGoodId], [Amount]) VALUES (21, CAST(20.00 AS Decimal(10, 2)))
GO
