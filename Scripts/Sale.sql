CREATE DATABASE [IceCreamShop_Sale]
GO
USE [IceCreamShop_Sale]
GO
/****** Object:  Table [dbo].[Sale]    Script Date: 13.09.2018 21:59:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sale](
	[Id] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[SumPrice] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SalePosition]    Script Date: 13.09.2018 21:59:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SalePosition](
	[SaleId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[Amount] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[SaleId] ASC,
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SaleSagaDataDb]    Script Date: 13.09.2018 21:59:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SaleSagaDataDb](
	[SaleId] [uniqueidentifier] NOT NULL,
	[Products] [nvarchar](1000) NULL,
PRIMARY KEY CLUSTERED 
(
	[SaleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[Product]    Script Date: 13.09.2018 21:59:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Product] AS
SELECT *
FROM IceCreamShop.dbo.Product;
GO
/****** Object:  View [dbo].[SemiFinishedGood]    Script Date: 13.09.2018 21:59:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SemiFinishedGood] AS
SELECT *
FROM IceCreamShop.dbo.SemiFinishedGood;
GO
INSERT [dbo].[Sale] ([Id], [Date], [SumPrice]) VALUES (1, CAST(N'2018-09-11 00:00:00.000' AS DateTime), 15)
GO
INSERT [dbo].[Sale] ([Id], [Date], [SumPrice]) VALUES (2, CAST(N'2018-09-11 00:00:00.000' AS DateTime), 6)
GO
INSERT [dbo].[Sale] ([Id], [Date], [SumPrice]) VALUES (3, CAST(N'2018-09-11 00:00:00.000' AS DateTime), 21)
GO
INSERT [dbo].[Sale] ([Id], [Date], [SumPrice]) VALUES (4, CAST(N'2018-09-11 23:35:06.020' AS DateTime), 12)
GO
INSERT [dbo].[Sale] ([Id], [Date], [SumPrice]) VALUES (5, CAST(N'2018-09-13 18:25:58.340' AS DateTime), 15)
GO
INSERT [dbo].[Sale] ([Id], [Date], [SumPrice]) VALUES (6, CAST(N'2018-09-13 19:04:11.670' AS DateTime), 6)
GO
INSERT [dbo].[Sale] ([Id], [Date], [SumPrice]) VALUES (7, CAST(N'2018-09-13 19:04:35.603' AS DateTime), 3)
GO
INSERT [dbo].[Sale] ([Id], [Date], [SumPrice]) VALUES (8, CAST(N'2018-09-13 19:04:36.683' AS DateTime), 15)
GO
INSERT [dbo].[Sale] ([Id], [Date], [SumPrice]) VALUES (9, CAST(N'2018-09-13 19:04:37.567' AS DateTime), 6)
GO
INSERT [dbo].[Sale] ([Id], [Date], [SumPrice]) VALUES (10, CAST(N'2018-09-13 19:04:53.117' AS DateTime), 18)
GO
INSERT [dbo].[Sale] ([Id], [Date], [SumPrice]) VALUES (11, CAST(N'2018-09-13 19:41:01.150' AS DateTime), 21)
GO
INSERT [dbo].[Sale] ([Id], [Date], [SumPrice]) VALUES (12, CAST(N'2018-09-13 19:58:00.497' AS DateTime), 84)
GO
INSERT [dbo].[Sale] ([Id], [Date], [SumPrice]) VALUES (13, CAST(N'2018-09-13 19:58:01.617' AS DateTime), 3)
GO
INSERT [dbo].[SalePosition] ([SaleId], [ProductId], [Amount]) VALUES (1, 1, CAST(2.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[SalePosition] ([SaleId], [ProductId], [Amount]) VALUES (1, 2, CAST(3.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[SalePosition] ([SaleId], [ProductId], [Amount]) VALUES (2, 1, CAST(1.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[SalePosition] ([SaleId], [ProductId], [Amount]) VALUES (2, 2, CAST(1.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[SalePosition] ([SaleId], [ProductId], [Amount]) VALUES (3, 3, CAST(2.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[SalePosition] ([SaleId], [ProductId], [Amount]) VALUES (3, 6, CAST(5.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[SalePosition] ([SaleId], [ProductId], [Amount]) VALUES (4, 1, CAST(4.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[SalePosition] ([SaleId], [ProductId], [Amount]) VALUES (5, 1, CAST(2.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[SalePosition] ([SaleId], [ProductId], [Amount]) VALUES (5, 3, CAST(3.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[SalePosition] ([SaleId], [ProductId], [Amount]) VALUES (6, 1, CAST(2.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[SalePosition] ([SaleId], [ProductId], [Amount]) VALUES (7, 1, CAST(1.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[SalePosition] ([SaleId], [ProductId], [Amount]) VALUES (8, 4, CAST(2.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[SalePosition] ([SaleId], [ProductId], [Amount]) VALUES (8, 5, CAST(3.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[SalePosition] ([SaleId], [ProductId], [Amount]) VALUES (9, 3, CAST(1.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[SalePosition] ([SaleId], [ProductId], [Amount]) VALUES (9, 4, CAST(1.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[SalePosition] ([SaleId], [ProductId], [Amount]) VALUES (10, 6, CAST(6.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[SalePosition] ([SaleId], [ProductId], [Amount]) VALUES (11, 1, CAST(2.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[SalePosition] ([SaleId], [ProductId], [Amount]) VALUES (11, 2, CAST(2.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[SalePosition] ([SaleId], [ProductId], [Amount]) VALUES (11, 4, CAST(3.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[SalePosition] ([SaleId], [ProductId], [Amount]) VALUES (12, 1, CAST(1.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[SalePosition] ([SaleId], [ProductId], [Amount]) VALUES (12, 2, CAST(1.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[SalePosition] ([SaleId], [ProductId], [Amount]) VALUES (12, 3, CAST(1.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[SalePosition] ([SaleId], [ProductId], [Amount]) VALUES (12, 4, CAST(23.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[SalePosition] ([SaleId], [ProductId], [Amount]) VALUES (12, 5, CAST(1.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[SalePosition] ([SaleId], [ProductId], [Amount]) VALUES (12, 6, CAST(1.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[SalePosition] ([SaleId], [ProductId], [Amount]) VALUES (13, 1, CAST(1.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[SaleSagaDataDb] ([SaleId], [Products]) VALUES (N'00000000-0000-0000-0000-000000000000', N'{"Lody waniliowe":1.0,"Lody truskawkowe":1.0,"Lody malinowe":5.0}')
GO
INSERT [dbo].[SaleSagaDataDb] ([SaleId], [Products]) VALUES (N'2ca4ab0d-6fcf-40b1-b31b-17dd61ccd7ca', N'{"Lody czekoladowe":1.0,"Lody waniliowe":1.0,"Lody truskawkowe":1.0,"Lody malinowe":23.0,"Lody bananowe":1.0,"Lody śmietankowe":1.0}')
GO
INSERT [dbo].[SaleSagaDataDb] ([SaleId], [Products]) VALUES (N'848ac40a-712e-4d3a-88cd-37ca07f2c785', N'{"Lody czekoladowe":2.0,"Lody waniliowe":2.0,"Lody malinowe":3.0}')
GO
INSERT [dbo].[SaleSagaDataDb] ([SaleId], [Products]) VALUES (N'75b96ed8-0bd5-4f8e-a463-f13ae582926e', N'{"Lody czekoladowe":1.0}')
GO
ALTER TABLE [dbo].[SalePosition]  WITH CHECK ADD FOREIGN KEY([SaleId])
REFERENCES [dbo].[Sale] ([Id])
GO
