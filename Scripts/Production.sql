CREATE DATABASE [IceCreamShop_Production]
GO
USE [IceCreamShop_Production]
GO
/****** Object:  Table [dbo].[ProduceSagaDataDb]    Script Date: 13.09.2018 21:58:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProduceSagaDataDb](
	[ProductionId] [uniqueidentifier] NOT NULL,
	[ProductId] [int] NULL,
	[ProductName] [nvarchar](256) NULL,
	[ProductAmount] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Production]    Script Date: 13.09.2018 21:58:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Production](
	[Id] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[ProductName] [nvarchar](100) NOT NULL,
	[Amount] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Queue]    Script Date: 13.09.2018 21:58:51 ******/
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
/****** Object:  Table [dbo].[Recipe]    Script Date: 13.09.2018 21:58:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Recipe](
	[ProductId] [int] NOT NULL,
	[SemiFinishedGoodName] [nvarchar](100) NOT NULL,
	[Amount] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[SemiFinishedGoodName] ASC,
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[Product]    Script Date: 13.09.2018 21:58:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Product] AS
SELECT *
FROM IceCreamShop.dbo.Product;
GO
/****** Object:  View [dbo].[SemiFinishedGood]    Script Date: 13.09.2018 21:58:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SemiFinishedGood] AS
SELECT *
FROM IceCreamShop.dbo.SemiFinishedGood;
GO
INSERT [dbo].[ProduceSagaDataDb] ([ProductionId], [ProductId], [ProductName], [ProductAmount]) VALUES (N'00000000-0000-0000-0000-000000000000', 1, N'Lody czekoladowe', CAST(4.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[ProduceSagaDataDb] ([ProductionId], [ProductId], [ProductName], [ProductAmount]) VALUES (N'59a19199-7628-4eba-a794-09d8ed87dbb4', 2, N'Lody waniliowe', CAST(2.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[ProduceSagaDataDb] ([ProductionId], [ProductId], [ProductName], [ProductAmount]) VALUES (N'582ad612-781c-4089-ab64-1b90189cc12c', 1, N'Lody czekoladowe', CAST(10.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[ProduceSagaDataDb] ([ProductionId], [ProductId], [ProductName], [ProductAmount]) VALUES (N'f9fdfbe1-cc65-4276-95ab-205355974690', 4, N'Lody malinowe', CAST(21.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[ProduceSagaDataDb] ([ProductionId], [ProductId], [ProductName], [ProductAmount]) VALUES (N'e9f5e0b5-ef5f-4de4-bbae-24a62bf77e43', 4, N'Lody malinowe', CAST(1.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[ProduceSagaDataDb] ([ProductionId], [ProductId], [ProductName], [ProductAmount]) VALUES (N'c2a48047-1b2d-4c82-b023-25f917cb1673', 1, N'Lody czekoladowe', CAST(10.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[ProduceSagaDataDb] ([ProductionId], [ProductId], [ProductName], [ProductAmount]) VALUES (N'3767d0a8-8357-4299-86e4-26a44465d74e', 4, N'Lody malinowe', CAST(2.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[ProduceSagaDataDb] ([ProductionId], [ProductId], [ProductName], [ProductAmount]) VALUES (N'598d0c2e-fff3-461a-a818-3618e21bc8ae', 1, N'Lody czekoladowe', CAST(3.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[ProduceSagaDataDb] ([ProductionId], [ProductId], [ProductName], [ProductAmount]) VALUES (N'7d1623d8-1a6d-4856-bbbe-39fd88048d82', 35, N'Lody malinowe', CAST(1.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[ProduceSagaDataDb] ([ProductionId], [ProductId], [ProductName], [ProductAmount]) VALUES (N'299720b0-6f63-4fbd-bef5-4144c00c9a8f', 6, N'Lody śmietankowe', CAST(5.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[ProduceSagaDataDb] ([ProductionId], [ProductId], [ProductName], [ProductAmount]) VALUES (N'd90cbe28-5946-4987-9fc3-4b2c61fb075f', 6, N'Lody śmietankowe', CAST(2.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[ProduceSagaDataDb] ([ProductionId], [ProductId], [ProductName], [ProductAmount]) VALUES (N'ab20d7a1-dd8d-4f46-a4bc-4cd91bebebab', 4, N'Lody malinowe', CAST(4.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[ProduceSagaDataDb] ([ProductionId], [ProductId], [ProductName], [ProductAmount]) VALUES (N'b27623e9-53fd-4f83-ab40-52589ce376bd', 4, N'Lody malinowe', CAST(2.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[ProduceSagaDataDb] ([ProductionId], [ProductId], [ProductName], [ProductAmount]) VALUES (N'9d1fe650-552f-4686-805f-5785ae038303', 33, N'Lody śmietankowe', CAST(2.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[ProduceSagaDataDb] ([ProductionId], [ProductId], [ProductName], [ProductAmount]) VALUES (N'eb34c684-8354-49ce-a7ad-680f2c512e58', 1, N'Lody czekoladowe', CAST(2.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[ProduceSagaDataDb] ([ProductionId], [ProductId], [ProductName], [ProductAmount]) VALUES (N'ac8dd9ee-3522-47d7-be1e-6fb17bbf8443', 1, N'Lody czekoladowe', CAST(2.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[ProduceSagaDataDb] ([ProductionId], [ProductId], [ProductName], [ProductAmount]) VALUES (N'b7a9837d-a119-42dc-9cfe-75fa0b35af49', 3, N'Lody truskawkowe', CAST(5.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[ProduceSagaDataDb] ([ProductionId], [ProductId], [ProductName], [ProductAmount]) VALUES (N'5807ea9e-8de6-4cec-9acf-7d6e742dcc98', 1, N'Lody czekoladowe', CAST(5.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[ProduceSagaDataDb] ([ProductionId], [ProductId], [ProductName], [ProductAmount]) VALUES (N'fd603178-1768-4e0f-8e62-8c184c630d00', 5, N'Lody bananowe', CAST(3.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[ProduceSagaDataDb] ([ProductionId], [ProductId], [ProductName], [ProductAmount]) VALUES (N'65a9f499-7299-49c5-a8c3-90925dce1a10', 1, N'Lody czekoladowe', CAST(7.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[ProduceSagaDataDb] ([ProductionId], [ProductId], [ProductName], [ProductAmount]) VALUES (N'fa1aa92e-702b-4c46-a488-9163bd3c30fc', 4, N'Lody malinowe', CAST(1.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[ProduceSagaDataDb] ([ProductionId], [ProductId], [ProductName], [ProductAmount]) VALUES (N'91c21d0b-d4bf-4b9d-9ad5-91a1671b4490', 4, N'Lody malinowe', CAST(2.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[ProduceSagaDataDb] ([ProductionId], [ProductId], [ProductName], [ProductAmount]) VALUES (N'fb519e44-5c3b-4ca7-b27c-966f7caa7b1b', 2, N'Lody waniliowe', CAST(2.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[ProduceSagaDataDb] ([ProductionId], [ProductId], [ProductName], [ProductAmount]) VALUES (N'f869e9fd-f852-4336-bdd7-9ac98a51dd5a', 6, N'Lody śmietankowe', CAST(4.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[ProduceSagaDataDb] ([ProductionId], [ProductId], [ProductName], [ProductAmount]) VALUES (N'7847664f-6da2-4294-afa7-a4e2cfd4d124', 4, N'Lody malinowe', CAST(3.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[ProduceSagaDataDb] ([ProductionId], [ProductId], [ProductName], [ProductAmount]) VALUES (N'7e18218a-d949-4507-a439-a8793b5d49ee', 6, N'Lody śmietankowe', CAST(4.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[ProduceSagaDataDb] ([ProductionId], [ProductId], [ProductName], [ProductAmount]) VALUES (N'0899fb9f-d6a1-4627-8a48-aa223f00d824', 2, N'Lody waniliowe', CAST(10.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[ProduceSagaDataDb] ([ProductionId], [ProductId], [ProductName], [ProductAmount]) VALUES (N'81b9e99e-20a1-43c1-af4a-bdc2aac4a6f8', 6, N'Lody śmietankowe', CAST(12.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[ProduceSagaDataDb] ([ProductionId], [ProductId], [ProductName], [ProductAmount]) VALUES (N'f55bf9a8-f043-411c-961e-c206f5ca1dfa', 6, N'Lody śmietankowe', CAST(4.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[ProduceSagaDataDb] ([ProductionId], [ProductId], [ProductName], [ProductAmount]) VALUES (N'70a81b5e-ae02-453b-913e-cba762e84d16', 30, N'Lody malinowe', CAST(2.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[ProduceSagaDataDb] ([ProductionId], [ProductId], [ProductName], [ProductAmount]) VALUES (N'cae85f3e-fd10-4ee5-aff4-cf59a477b732', 1, N'Lody czekoladowe', CAST(5.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[ProduceSagaDataDb] ([ProductionId], [ProductId], [ProductName], [ProductAmount]) VALUES (N'8dcf89b6-00e3-4144-9c35-d361dc8f224d', 6, N'Lody śmietankowe', CAST(4.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[ProduceSagaDataDb] ([ProductionId], [ProductId], [ProductName], [ProductAmount]) VALUES (N'909a707e-1223-4f86-94e8-ebd7bcfaf779', 4, N'Lody malinowe', CAST(2.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[ProduceSagaDataDb] ([ProductionId], [ProductId], [ProductName], [ProductAmount]) VALUES (N'88a4e2f5-b9fa-4b8d-a7c2-ec1742d95b85', 1, N'Lody czekoladowe', CAST(7.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[ProduceSagaDataDb] ([ProductionId], [ProductId], [ProductName], [ProductAmount]) VALUES (N'd4afd8fb-736d-46fd-819e-f1af2cfa2f2b', 3, N'Lody truskawkowe', CAST(6.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[ProduceSagaDataDb] ([ProductionId], [ProductId], [ProductName], [ProductAmount]) VALUES (N'70f23509-910e-42ce-8545-f5a123c2a51c', 6, N'Lody śmietankowe', CAST(2.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[ProduceSagaDataDb] ([ProductionId], [ProductId], [ProductName], [ProductAmount]) VALUES (N'7185120e-cd53-4ee8-8e11-f83cd097a6e6', 3, N'Lody truskawkowe', CAST(2.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (0, CAST(N'2018-09-01 00:00:00.000' AS DateTime), N'Lody czekoladowe', CAST(1.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (2, CAST(N'2018-09-01 22:41:40.493' AS DateTime), N'Lody czekoladowe', CAST(1.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (3, CAST(N'2018-09-01 22:48:55.540' AS DateTime), N'Lody śmietankowe', CAST(5.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (4, CAST(N'2018-09-09 22:23:52.020' AS DateTime), N'Lody czekoladowe', CAST(1.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (5, CAST(N'2018-09-09 22:30:52.063' AS DateTime), N'Lody czekoladowe', CAST(1.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (6, CAST(N'2018-09-09 22:52:51.270' AS DateTime), N'Lody czekoladowe', CAST(1.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (7, CAST(N'2018-09-09 23:22:26.497' AS DateTime), N'Lody czekoladowe', CAST(4.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (8, CAST(N'2018-09-09 23:39:22.000' AS DateTime), N'Lody malinowe', CAST(4.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (9, CAST(N'2018-09-09 23:39:43.260' AS DateTime), N'Lody śmietankowe', CAST(1.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (10, CAST(N'2018-09-09 23:40:26.280' AS DateTime), N'Lody truskawkowe', CAST(2.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (11, CAST(N'2018-09-10 18:52:15.350' AS DateTime), N'Lody czekoladowe', CAST(1.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (12, CAST(N'2018-09-10 18:58:20.837' AS DateTime), N'Lody czekoladowe', CAST(1.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (13, CAST(N'2018-09-10 19:02:17.827' AS DateTime), N'Lody czekoladowe', CAST(1.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (14, CAST(N'2018-09-10 19:20:16.607' AS DateTime), N'Lody czekoladowe', CAST(1.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (15, CAST(N'2018-09-10 19:23:17.407' AS DateTime), N'Lody czekoladowe', CAST(1.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (16, CAST(N'2018-09-10 19:25:57.000' AS DateTime), N'Lody czekoladowe', CAST(1.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (17, CAST(N'2018-09-10 19:37:30.573' AS DateTime), N'Lody czekoladowe', CAST(1.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (18, CAST(N'2018-09-10 19:52:47.313' AS DateTime), N'Lody czekoladowe', CAST(1.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (19, CAST(N'2018-09-10 20:02:59.530' AS DateTime), N'Lody czekoladowe', CAST(1.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (20, CAST(N'2018-09-10 20:04:29.583' AS DateTime), N'Lody czekoladowe', CAST(5.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (21, CAST(N'2018-09-10 20:04:47.120' AS DateTime), N'Lody czekoladowe', CAST(2.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (22, CAST(N'2018-09-10 20:04:49.973' AS DateTime), N'Lody waniliowe', CAST(3.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (23, CAST(N'2018-09-10 20:05:11.297' AS DateTime), N'Lody czekoladowe', CAST(5.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (24, CAST(N'2018-09-10 20:06:21.573' AS DateTime), N'Lody czekoladowe', CAST(5.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (25, CAST(N'2018-09-10 20:12:58.560' AS DateTime), N'Lody czekoladowe', CAST(2.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (26, CAST(N'2018-09-10 20:13:38.520' AS DateTime), N'Lody czekoladowe', CAST(3.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (27, CAST(N'2018-09-11 21:52:23.003' AS DateTime), N'Lody czekoladowe', CAST(5.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (28, CAST(N'2018-09-11 21:53:10.047' AS DateTime), N'Lody bananowe', CAST(10.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (29, CAST(N'2018-09-11 21:53:31.580' AS DateTime), N'Lody malinowe', CAST(5.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (30, CAST(N'2018-09-11 21:54:16.270' AS DateTime), N'Lody waniliowe', CAST(20.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (31, CAST(N'2018-09-11 21:54:18.557' AS DateTime), N'Lody śmietankowe', CAST(5.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (32, CAST(N'2018-09-11 21:59:37.980' AS DateTime), N'Lody truskawkowe', CAST(2.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (33, CAST(N'2018-09-11 22:06:51.113' AS DateTime), N'Lody czekoladowe', CAST(3.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (34, CAST(N'2018-09-11 22:18:36.593' AS DateTime), N'Lody truskawkowe', CAST(1.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (35, CAST(N'2018-09-11 23:22:47.007' AS DateTime), N'Lody śmietankowe', CAST(3.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (36, CAST(N'2018-09-11 23:23:17.937' AS DateTime), N'Lody truskawkowe', CAST(2.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (37, CAST(N'2018-09-11 23:34:46.980' AS DateTime), N'Lody czekoladowe', CAST(20.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (38, CAST(N'2018-09-12 22:51:52.290' AS DateTime), N'Lody czekoladowe', CAST(4.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (39, CAST(N'2018-09-12 23:07:58.283' AS DateTime), N'Lody czekoladowe', CAST(2.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (40, CAST(N'2018-09-12 23:14:11.837' AS DateTime), N'Lody truskawkowe', CAST(2.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (41, CAST(N'2018-09-12 23:15:57.073' AS DateTime), N'Lody truskawkowe', CAST(2.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (42, CAST(N'2018-09-12 23:18:03.883' AS DateTime), N'Lody truskawkowe', CAST(2.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (43, CAST(N'2018-09-13 18:03:44.277' AS DateTime), N'Lody czekoladowe', CAST(10.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (44, CAST(N'2018-09-13 18:04:41.540' AS DateTime), N'Lody czekoladowe', CAST(5.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (45, CAST(N'2018-09-13 18:20:19.283' AS DateTime), N'Lody truskawkowe', CAST(5.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (46, CAST(N'2018-09-13 18:24:30.363' AS DateTime), N'Lody truskawkowe', CAST(6.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (47, CAST(N'2018-09-13 19:02:22.180' AS DateTime), N'Lody waniliowe', CAST(10.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (48, CAST(N'2018-09-13 19:03:57.330' AS DateTime), N'Lody waniliowe', CAST(2.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (49, CAST(N'2018-09-13 19:04:04.433' AS DateTime), N'Lody czekoladowe', CAST(2.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (50, CAST(N'2018-09-13 19:04:06.577' AS DateTime), N'Lody malinowe', CAST(2.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (51, CAST(N'2018-09-13 19:04:22.423' AS DateTime), N'Lody śmietankowe', CAST(2.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (52, CAST(N'2018-09-13 19:04:22.973' AS DateTime), N'Lody malinowe', CAST(2.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (53, CAST(N'2018-09-13 19:04:23.880' AS DateTime), N'Lody malinowe', CAST(1.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (54, CAST(N'2018-09-13 19:04:24.660' AS DateTime), N'Lody malinowe', CAST(1.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (55, CAST(N'2018-09-13 19:04:46.210' AS DateTime), N'Lody śmietankowe', CAST(4.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (56, CAST(N'2018-09-13 19:04:46.807' AS DateTime), N'Lody śmietankowe', CAST(4.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (57, CAST(N'2018-09-13 19:04:47.363' AS DateTime), N'Lody śmietankowe', CAST(4.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (58, CAST(N'2018-09-13 19:05:01.430' AS DateTime), N'Lody śmietankowe', CAST(4.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (59, CAST(N'2018-09-13 19:34:04.343' AS DateTime), N'Lody bananowe', CAST(3.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (60, CAST(N'2018-09-13 19:34:05.023' AS DateTime), N'Lody waniliowe', CAST(2.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (61, CAST(N'2018-09-13 19:34:05.933' AS DateTime), N'Lody śmietankowe', CAST(5.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (62, CAST(N'2018-09-13 19:34:06.683' AS DateTime), N'Lody czekoladowe', CAST(10.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (63, CAST(N'2018-09-13 19:34:39.783' AS DateTime), N'Lody malinowe', CAST(2.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (64, CAST(N'2018-09-13 19:40:52.277' AS DateTime), N'Lody malinowe', CAST(2.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (65, CAST(N'2018-09-13 19:40:52.997' AS DateTime), N'Lody malinowe', CAST(3.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (66, CAST(N'2018-09-13 19:41:23.253' AS DateTime), N'Lody śmietankowe', CAST(2.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (67, CAST(N'2018-09-13 19:41:54.120' AS DateTime), N'Lody czekoladowe', CAST(3.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (68, CAST(N'2018-09-13 19:42:19.837' AS DateTime), N'Lody śmietankowe', CAST(12.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Production] ([Id], [Date], [ProductName], [Amount]) VALUES (69, CAST(N'2018-09-13 19:57:42.203' AS DateTime), N'Lody malinowe', CAST(21.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Recipe] ([ProductId], [SemiFinishedGoodName], [Amount]) VALUES (5, N'Banany 1 kiść', CAST(3.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Recipe] ([ProductId], [SemiFinishedGoodName], [Amount]) VALUES (1, N'Cukier biały Diamant 1 kg', CAST(1.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Recipe] ([ProductId], [SemiFinishedGoodName], [Amount]) VALUES (2, N'Cukier biały Diamant 1 kg', CAST(1.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Recipe] ([ProductId], [SemiFinishedGoodName], [Amount]) VALUES (3, N'Cukier biały Diamant 1 kg', CAST(1.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Recipe] ([ProductId], [SemiFinishedGoodName], [Amount]) VALUES (4, N'Cukier biały Diamant 1 kg', CAST(1.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Recipe] ([ProductId], [SemiFinishedGoodName], [Amount]) VALUES (5, N'Cukier biały Diamant 1 kg', CAST(1.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Recipe] ([ProductId], [SemiFinishedGoodName], [Amount]) VALUES (6, N'Cukier biały Diamant 1 kg', CAST(1.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Recipe] ([ProductId], [SemiFinishedGoodName], [Amount]) VALUES (4, N'Maliny 400 g', CAST(3.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Recipe] ([ProductId], [SemiFinishedGoodName], [Amount]) VALUES (1, N'Mleko UHT 2% tł. WYPASIONE 1 L', CAST(1.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Recipe] ([ProductId], [SemiFinishedGoodName], [Amount]) VALUES (2, N'Mleko UHT 2% tł. WYPASIONE 1 L', CAST(1.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Recipe] ([ProductId], [SemiFinishedGoodName], [Amount]) VALUES (5, N'Mleko UHT 2% tł. WYPASIONE 1 L', CAST(1.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Recipe] ([ProductId], [SemiFinishedGoodName], [Amount]) VALUES (6, N'Mleko UHT 3,2% tł. WYPASIONE 1 L', CAST(1.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Recipe] ([ProductId], [SemiFinishedGoodName], [Amount]) VALUES (3, N'Mleko UHT Twój Kubek 0,5% tł. 1 L z zakrętką', CAST(1.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Recipe] ([ProductId], [SemiFinishedGoodName], [Amount]) VALUES (2, N'Mleko Wypasione od szczęśliwych krów BEZ GMO 3,2% 1 L', CAST(1.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Recipe] ([ProductId], [SemiFinishedGoodName], [Amount]) VALUES (1, N'Śmietana POLSKA gęsta 12% 200 g Mlekovita', CAST(1.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Recipe] ([ProductId], [SemiFinishedGoodName], [Amount]) VALUES (4, N'Śmietana POLSKA gęsta 12% 200 g Mlekovita', CAST(1.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Recipe] ([ProductId], [SemiFinishedGoodName], [Amount]) VALUES (2, N'Śmietana POLSKA gęsta 18% 400 g Mlekovita', CAST(1.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Recipe] ([ProductId], [SemiFinishedGoodName], [Amount]) VALUES (5, N'Śmietana POLSKA gęsta 18% 400 g Mlekovita', CAST(1.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Recipe] ([ProductId], [SemiFinishedGoodName], [Amount]) VALUES (3, N'Śmietanka POLSKA 30% 200 ml Mlekovita', CAST(1.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Recipe] ([ProductId], [SemiFinishedGoodName], [Amount]) VALUES (6, N'Śmietanka UHT Polska 36% tłuszczu 1 L Mlekovita', CAST(2.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Recipe] ([ProductId], [SemiFinishedGoodName], [Amount]) VALUES (1, N'Tabliczka czekolady Wedel', CAST(10.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Recipe] ([ProductId], [SemiFinishedGoodName], [Amount]) VALUES (3, N'Truskawki 1 kg', CAST(2.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Recipe] ([ProductId], [SemiFinishedGoodName], [Amount]) VALUES (2, N'Wanilia 1 laska', CAST(15.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Recipe] ([ProductId], [SemiFinishedGoodName], [Amount]) VALUES (4, N'Wydojone bez laktozy 1 L UHT 1,5% tł.', CAST(1.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Recipe] ([ProductId], [SemiFinishedGoodName], [Amount]) VALUES (1, N'Żółtka jaj', CAST(5.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Recipe] ([ProductId], [SemiFinishedGoodName], [Amount]) VALUES (2, N'Żółtka jaj', CAST(3.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Recipe] ([ProductId], [SemiFinishedGoodName], [Amount]) VALUES (4, N'Żółtka jaj', CAST(5.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Recipe] ([ProductId], [SemiFinishedGoodName], [Amount]) VALUES (5, N'Żółtka jaj', CAST(3.00 AS Decimal(10, 2)))
GO
