USE [master]
GO
/****** Object:  Database [WebBanHang]    Script Date: 11/01/2025 6:38:04 SA ******/
CREATE DATABASE [WebBanHang]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'WebBanHang', FILENAME = N'D:\DAIHOCNAMTU\MSSQL16.MSSQLSERVER01\MSSQL\DATA\WebBanHang.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'WebBanHang_log', FILENAME = N'D:\DAIHOCNAMTU\MSSQL16.MSSQLSERVER01\MSSQL\DATA\WebBanHang_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [WebBanHang] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [WebBanHang].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [WebBanHang] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [WebBanHang] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [WebBanHang] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [WebBanHang] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [WebBanHang] SET ARITHABORT OFF 
GO
ALTER DATABASE [WebBanHang] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [WebBanHang] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [WebBanHang] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [WebBanHang] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [WebBanHang] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [WebBanHang] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [WebBanHang] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [WebBanHang] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [WebBanHang] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [WebBanHang] SET  ENABLE_BROKER 
GO
ALTER DATABASE [WebBanHang] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [WebBanHang] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [WebBanHang] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [WebBanHang] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [WebBanHang] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [WebBanHang] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [WebBanHang] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [WebBanHang] SET RECOVERY FULL 
GO
ALTER DATABASE [WebBanHang] SET  MULTI_USER 
GO
ALTER DATABASE [WebBanHang] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [WebBanHang] SET DB_CHAINING OFF 
GO
ALTER DATABASE [WebBanHang] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [WebBanHang] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [WebBanHang] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [WebBanHang] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'WebBanHang', N'ON'
GO
ALTER DATABASE [WebBanHang] SET QUERY_STORE = ON
GO
ALTER DATABASE [WebBanHang] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [WebBanHang]
GO
/****** Object:  Table [dbo].[BangGia]    Script Date: 11/01/2025 6:38:05 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BangGia](
	[MaGia] [int] IDENTITY(1,1) NOT NULL,
	[MaSanPham] [int] NOT NULL,
	[Gia] [bigint] NOT NULL,
	[NgayApDung] [datetime] NULL,
 CONSTRAINT [PK__BangGia__3CD3DE5ED9CB4BA7] PRIMARY KEY CLUSTERED 
(
	[MaGia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SanPham]    Script Date: 11/01/2025 6:38:05 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SanPham](
	[MaSanPham] [int] IDENTITY(1,1) NOT NULL,
	[TenSanPham] [nvarchar](100) NOT NULL,
	[MaDanhMuc] [int] NOT NULL,
	[MoTa] [nvarchar](max) NULL,
	[HinhAnh] [nvarchar](max) NULL,
	[TrangThai] [tinyint] NULL,
	[NgayTao] [datetime] NULL,
	[SoLuong] [bigint] NULL,
 CONSTRAINT [PK__SanPham__FAC7442D07861BE3] PRIMARY KEY CLUSTERED 
(
	[MaSanPham] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_SanPhamGia]    Script Date: 11/01/2025 6:38:05 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* Lấy giá gần nhất*/
CREATE VIEW [dbo].[vw_SanPhamGia]
AS
SELECT    sp.MaSanPham, sp.TenSanPham, sp.HinhAnh, sp.MoTa, sp.TrangThai, sp.SoLuong, bg.Gia, sp.MaDanhMuc
FROM         dbo.SanPham AS sp INNER JOIN
                      dbo.BangGia AS bg ON sp.MaSanPham = bg.MaSanPham
WHERE     (bg.NgayApDung =
                          (SELECT    MAX(NgayApDung) AS Expr1
                            FROM         dbo.BangGia
                            WHERE      (MaSanPham = sp.MaSanPham)))
GO
/****** Object:  Table [dbo].[KhachHang]    Script Date: 11/01/2025 6:38:05 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KhachHang](
	[MaKhachHang] [int] IDENTITY(1,1) NOT NULL,
	[TenKhachHang] [nvarchar](100) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[MatKhau] [nvarchar](255) NOT NULL,
	[SoDienThoai] [nvarchar](13) NULL,
	[DiaChi] [nvarchar](255) NULL,
	[NgayDangKy] [datetime] NULL,
	[TrangThai] [tinyint] NULL,
	[TenDangNhap] [nvarchar](50) NULL,
 CONSTRAINT [PK__KhachHan__88D2F0E59B8B7DCA] PRIMARY KEY CLUSTERED 
(
	[MaKhachHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChiTietDonHang]    Script Date: 11/01/2025 6:38:05 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietDonHang](
	[MaChiTiet] [int] IDENTITY(1,1) NOT NULL,
	[MaDonHang] [int] NOT NULL,
	[MaSanPham] [int] NOT NULL,
	[SoLuong] [int] NOT NULL,
	[Gia] [bigint] NOT NULL,
	[ThanhTien]  AS ([SoLuong]*[Gia]) PERSISTED,
 CONSTRAINT [PK__ChiTietD__CDF0A1147023A744] PRIMARY KEY CLUSTERED 
(
	[MaChiTiet] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DonHang]    Script Date: 11/01/2025 6:38:05 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DonHang](
	[MaDonHang] [int] IDENTITY(1,1) NOT NULL,
	[MaKhachHang] [int] NOT NULL,
	[NgayDatHang] [datetime] NULL,
	[TongTien] [bigint] NOT NULL,
	[TrangThai] [tinyint] NULL,
 CONSTRAINT [PK__DonHang__129584ADCEA19A96] PRIMARY KEY CLUSTERED 
(
	[MaDonHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_LichSuMuaHang]    Script Date: 11/01/2025 6:38:05 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_LichSuMuaHang]
AS
SELECT    sp.MaSanPham, sp.TenSanPham, ct.Gia AS GiaSanPham, ct.SoLuong AS SoLuongMua, ct.SoLuong * ct.Gia AS ThanhTien, dh.NgayDatHang AS NgayMua, kh.MaKhachHang, dh.TrangThai AS TrangThaiDonHang
FROM         dbo.ChiTietDonHang AS ct INNER JOIN
                      dbo.DonHang AS dh ON ct.MaDonHang = dh.MaDonHang INNER JOIN
                      dbo.SanPham AS sp ON ct.MaSanPham = sp.MaSanPham INNER JOIN
                      dbo.KhachHang AS kh ON dh.MaKhachHang = kh.MaKhachHang
GO
/****** Object:  View [dbo].[vw_xacnhan]    Script Date: 11/01/2025 6:38:05 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_xacnhan]
AS
SELECT    dbo.KhachHang.TenKhachHang, SUM(dbo.ChiTietDonHang.SoLuong) AS SoLuongMua, dbo.DonHang.NgayDatHang, dbo.DonHang.TongTien, SUM(dbo.ChiTietDonHang.Gia) AS TongGia, 
                      dbo.DonHang.MaDonHang
FROM         dbo.ChiTietDonHang INNER JOIN
                      dbo.DonHang ON dbo.ChiTietDonHang.MaDonHang = dbo.DonHang.MaDonHang INNER JOIN
                      dbo.KhachHang ON dbo.DonHang.MaKhachHang = dbo.KhachHang.MaKhachHang
WHERE     (dbo.DonHang.TrangThai = 0)
GROUP BY dbo.KhachHang.TenKhachHang, dbo.DonHang.NgayDatHang, dbo.DonHang.MaDonHang, dbo.DonHang.TongTien
GO
/****** Object:  Table [dbo].[DangNhap]    Script Date: 11/01/2025 6:38:05 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DangNhap](
	[Username] [varchar](50) NOT NULL,
	[Password] [varchar](255) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DanhGia]    Script Date: 11/01/2025 6:38:05 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DanhGia](
	[MaDanhGia] [int] IDENTITY(1,1) NOT NULL,
	[MaSanPham] [int] NOT NULL,
	[MaKhachHang] [int] NOT NULL,
	[SoSao] [tinyint] NOT NULL,
	[NoiDung] [nvarchar](1000) NULL,
	[NgayDanhGia] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaDanhGia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DanhMucSanPham]    Script Date: 11/01/2025 6:38:05 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DanhMucSanPham](
	[MaDanhMuc] [int] IDENTITY(1,1) NOT NULL,
	[TenDanhMuc] [nvarchar](100) NOT NULL,
	[MoTa] [nvarchar](255) NULL,
	[TrangThai] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaDanhMuc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PhieuNhap]    Script Date: 11/01/2025 6:38:05 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhieuNhap](
	[MaPhieuNhap] [int] IDENTITY(1,1) NOT NULL,
	[MaSanPham] [int] NOT NULL,
	[SoLuongNhap] [int] NOT NULL,
	[NgayNhap] [datetime] NULL,
	[GiaNhap] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaPhieuNhap] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[BangGia] ON 

INSERT [dbo].[BangGia] ([MaGia], [MaSanPham], [Gia], [NgayApDung]) VALUES (5, 2, 4321, CAST(N'2025-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[BangGia] ([MaGia], [MaSanPham], [Gia], [NgayApDung]) VALUES (6, 4, 300000, CAST(N'2025-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[BangGia] ([MaGia], [MaSanPham], [Gia], [NgayApDung]) VALUES (7, 3, 300000, CAST(N'2025-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[BangGia] ([MaGia], [MaSanPham], [Gia], [NgayApDung]) VALUES (8, 6, 749000, CAST(N'2025-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[BangGia] ([MaGia], [MaSanPham], [Gia], [NgayApDung]) VALUES (9, 7, 300000, CAST(N'2025-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[BangGia] ([MaGia], [MaSanPham], [Gia], [NgayApDung]) VALUES (10, 8, 1559000, CAST(N'2025-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[BangGia] ([MaGia], [MaSanPham], [Gia], [NgayApDung]) VALUES (11, 9, 490000, CAST(N'2025-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[BangGia] ([MaGia], [MaSanPham], [Gia], [NgayApDung]) VALUES (12, 10, 330000, CAST(N'2025-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[BangGia] ([MaGia], [MaSanPham], [Gia], [NgayApDung]) VALUES (13, 11, 1988888, CAST(N'2025-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[BangGia] ([MaGia], [MaSanPham], [Gia], [NgayApDung]) VALUES (14, 12, 779000, CAST(N'2025-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[BangGia] ([MaGia], [MaSanPham], [Gia], [NgayApDung]) VALUES (15, 13, 135000, CAST(N'2025-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[BangGia] ([MaGia], [MaSanPham], [Gia], [NgayApDung]) VALUES (16, 14, 729000, CAST(N'2025-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[BangGia] ([MaGia], [MaSanPham], [Gia], [NgayApDung]) VALUES (17, 1, 200000, CAST(N'2025-01-10T00:00:00.000' AS DateTime))
INSERT [dbo].[BangGia] ([MaGia], [MaSanPham], [Gia], [NgayApDung]) VALUES (18, 16, 1209000, CAST(N'2025-01-10T00:00:00.000' AS DateTime))
INSERT [dbo].[BangGia] ([MaGia], [MaSanPham], [Gia], [NgayApDung]) VALUES (19, 18, 56688, CAST(N'2025-01-10T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[BangGia] OFF
GO
SET IDENTITY_INSERT [dbo].[ChiTietDonHang] ON 

INSERT [dbo].[ChiTietDonHang] ([MaChiTiet], [MaDonHang], [MaSanPham], [SoLuong], [Gia]) VALUES (20, 26, 1, 1, 200000)
INSERT [dbo].[ChiTietDonHang] ([MaChiTiet], [MaDonHang], [MaSanPham], [SoLuong], [Gia]) VALUES (21, 27, 1, 1, 200000)
INSERT [dbo].[ChiTietDonHang] ([MaChiTiet], [MaDonHang], [MaSanPham], [SoLuong], [Gia]) VALUES (22, 27, 2, 1, 4321)
INSERT [dbo].[ChiTietDonHang] ([MaChiTiet], [MaDonHang], [MaSanPham], [SoLuong], [Gia]) VALUES (26, 29, 4, 6, 300000)
INSERT [dbo].[ChiTietDonHang] ([MaChiTiet], [MaDonHang], [MaSanPham], [SoLuong], [Gia]) VALUES (27, 29, 6, 1, 749000)
INSERT [dbo].[ChiTietDonHang] ([MaChiTiet], [MaDonHang], [MaSanPham], [SoLuong], [Gia]) VALUES (28, 30, 11, 1, 1988888)
INSERT [dbo].[ChiTietDonHang] ([MaChiTiet], [MaDonHang], [MaSanPham], [SoLuong], [Gia]) VALUES (29, 31, 2, 1, 4321)
INSERT [dbo].[ChiTietDonHang] ([MaChiTiet], [MaDonHang], [MaSanPham], [SoLuong], [Gia]) VALUES (30, 31, 4, 1, 300000)
INSERT [dbo].[ChiTietDonHang] ([MaChiTiet], [MaDonHang], [MaSanPham], [SoLuong], [Gia]) VALUES (31, 32, 2, 2, 4321)
INSERT [dbo].[ChiTietDonHang] ([MaChiTiet], [MaDonHang], [MaSanPham], [SoLuong], [Gia]) VALUES (32, 33, 2, 1, 4321)
INSERT [dbo].[ChiTietDonHang] ([MaChiTiet], [MaDonHang], [MaSanPham], [SoLuong], [Gia]) VALUES (33, 34, 2, 7, 4321)
INSERT [dbo].[ChiTietDonHang] ([MaChiTiet], [MaDonHang], [MaSanPham], [SoLuong], [Gia]) VALUES (34, 34, 16, 1, 1209000)
INSERT [dbo].[ChiTietDonHang] ([MaChiTiet], [MaDonHang], [MaSanPham], [SoLuong], [Gia]) VALUES (35, 34, 7, 1, 300000)
SET IDENTITY_INSERT [dbo].[ChiTietDonHang] OFF
GO
INSERT [dbo].[DangNhap] ([Username], [Password]) VALUES (N'admin', N'admin123')
GO
SET IDENTITY_INSERT [dbo].[DanhMucSanPham] ON 

INSERT [dbo].[DanhMucSanPham] ([MaDanhMuc], [TenDanhMuc], [MoTa], [TrangThai]) VALUES (1, N'Xe Mô Hình', N'Đồ chơi cho các bé trai', 1)
INSERT [dbo].[DanhMucSanPham] ([MaDanhMuc], [TenDanhMuc], [MoTa], [TrangThai]) VALUES (3, N'Xe Điều Khiển', N'Đồ chơi công nghệ', 1)
INSERT [dbo].[DanhMucSanPham] ([MaDanhMuc], [TenDanhMuc], [MoTa], [TrangThai]) VALUES (4, N' xa', N'hus', 0)
INSERT [dbo].[DanhMucSanPham] ([MaDanhMuc], [TenDanhMuc], [MoTa], [TrangThai]) VALUES (5, N'Xe Lắp Ráp', N'đồ chơi trí tuệ', 1)
INSERT [dbo].[DanhMucSanPham] ([MaDanhMuc], [TenDanhMuc], [MoTa], [TrangThai]) VALUES (6, N'Trực Thăng', N'đồ chơi công nghệ ', 1)
SET IDENTITY_INSERT [dbo].[DanhMucSanPham] OFF
GO
SET IDENTITY_INSERT [dbo].[DonHang] ON 

INSERT [dbo].[DonHang] ([MaDonHang], [MaKhachHang], [NgayDatHang], [TongTien], [TrangThai]) VALUES (26, 11, CAST(N'2025-01-01T00:00:00.000' AS DateTime), 200000, 1)
INSERT [dbo].[DonHang] ([MaDonHang], [MaKhachHang], [NgayDatHang], [TongTien], [TrangThai]) VALUES (27, 7, CAST(N'2025-01-10T00:00:00.000' AS DateTime), 204321, 1)
INSERT [dbo].[DonHang] ([MaDonHang], [MaKhachHang], [NgayDatHang], [TongTien], [TrangThai]) VALUES (29, 11, CAST(N'2025-01-10T00:00:00.000' AS DateTime), 2549000, 1)
INSERT [dbo].[DonHang] ([MaDonHang], [MaKhachHang], [NgayDatHang], [TongTien], [TrangThai]) VALUES (30, 11, CAST(N'2025-01-10T00:00:00.000' AS DateTime), 1988888, 1)
INSERT [dbo].[DonHang] ([MaDonHang], [MaKhachHang], [NgayDatHang], [TongTien], [TrangThai]) VALUES (31, 11, CAST(N'2025-01-10T15:12:12.340' AS DateTime), 304321, 1)
INSERT [dbo].[DonHang] ([MaDonHang], [MaKhachHang], [NgayDatHang], [TongTien], [TrangThai]) VALUES (32, 12, CAST(N'2025-01-10T16:14:19.823' AS DateTime), 8642, 1)
INSERT [dbo].[DonHang] ([MaDonHang], [MaKhachHang], [NgayDatHang], [TongTien], [TrangThai]) VALUES (33, 12, CAST(N'2025-01-10T18:28:49.873' AS DateTime), 4321, 1)
INSERT [dbo].[DonHang] ([MaDonHang], [MaKhachHang], [NgayDatHang], [TongTien], [TrangThai]) VALUES (34, 12, CAST(N'2025-01-10T18:30:31.893' AS DateTime), 1539247, 1)
SET IDENTITY_INSERT [dbo].[DonHang] OFF
GO
SET IDENTITY_INSERT [dbo].[KhachHang] ON 

INSERT [dbo].[KhachHang] ([MaKhachHang], [TenKhachHang], [Email], [MatKhau], [SoDienThoai], [DiaChi], [NgayDangKy], [TrangThai], [TenDangNhap]) VALUES (1, N'Dư Ngọc Hùng', N'21t108004@husc.edu.vn', N'123', N'0394033071', N'Thừa Thiên Huế', CAST(N'2025-01-08T00:00:00.000' AS DateTime), 1, N'aaas')
INSERT [dbo].[KhachHang] ([MaKhachHang], [TenKhachHang], [Email], [MatKhau], [SoDienThoai], [DiaChi], [NgayDangKy], [TrangThai], [TenDangNhap]) VALUES (7, N'Nguyễn Thắng', N'21t1080011@husc.edu.vn', N'123', N'3019201999', N'Thừa Thiên Huế', CAST(N'2025-01-10T00:00:00.000' AS DateTime), 1, N'aaa')
INSERT [dbo].[KhachHang] ([MaKhachHang], [TenKhachHang], [Email], [MatKhau], [SoDienThoai], [DiaChi], [NgayDangKy], [TrangThai], [TenDangNhap]) VALUES (8, N'Nguyễn Thắng Bùi', N'21t1080041@husc.edu.vn', N'123', N'3019201992', N'Thừa Thiên Huế', CAST(N'2025-01-10T00:00:00.000' AS DateTime), 1, N'aaa1')
INSERT [dbo].[KhachHang] ([MaKhachHang], [TenKhachHang], [Email], [MatKhau], [SoDienThoai], [DiaChi], [NgayDangKy], [TrangThai], [TenDangNhap]) VALUES (11, N'Nguyễn Thắng Bùi hương', N'21t1080141@husc.edu.vn', N'123', N'3019201992', N'Thừa Thiên Huế', CAST(N'2025-01-10T00:00:00.000' AS DateTime), 1, N'aaaz')
INSERT [dbo].[KhachHang] ([MaKhachHang], [TenKhachHang], [Email], [MatKhau], [SoDienThoai], [DiaChi], [NgayDangKy], [TrangThai], [TenDangNhap]) VALUES (12, N'Thùy Linh ', N'21t1010141@husc.edu.vn', N'123', N'0986543231', N'Thừa Thiên Huế', CAST(N'2025-01-10T00:00:00.000' AS DateTime), 1, N'sss')
SET IDENTITY_INSERT [dbo].[KhachHang] OFF
GO
SET IDENTITY_INSERT [dbo].[PhieuNhap] ON 

INSERT [dbo].[PhieuNhap] ([MaPhieuNhap], [MaSanPham], [SoLuongNhap], [NgayNhap], [GiaNhap]) VALUES (10, 2, 500, CAST(N'2025-01-09T00:00:00.000' AS DateTime), 100000)
INSERT [dbo].[PhieuNhap] ([MaPhieuNhap], [MaSanPham], [SoLuongNhap], [NgayNhap], [GiaNhap]) VALUES (11, 3, 200, CAST(N'2025-01-09T00:00:00.000' AS DateTime), 100000)
INSERT [dbo].[PhieuNhap] ([MaPhieuNhap], [MaSanPham], [SoLuongNhap], [NgayNhap], [GiaNhap]) VALUES (12, 6, 200, CAST(N'2025-01-09T00:00:00.000' AS DateTime), 100000)
INSERT [dbo].[PhieuNhap] ([MaPhieuNhap], [MaSanPham], [SoLuongNhap], [NgayNhap], [GiaNhap]) VALUES (13, 8, 200, CAST(N'2025-01-09T00:00:00.000' AS DateTime), 100000)
INSERT [dbo].[PhieuNhap] ([MaPhieuNhap], [MaSanPham], [SoLuongNhap], [NgayNhap], [GiaNhap]) VALUES (14, 9, 200, CAST(N'2025-01-09T00:00:00.000' AS DateTime), 100000)
INSERT [dbo].[PhieuNhap] ([MaPhieuNhap], [MaSanPham], [SoLuongNhap], [NgayNhap], [GiaNhap]) VALUES (15, 11, 200, CAST(N'2025-01-09T00:00:00.000' AS DateTime), 10000)
INSERT [dbo].[PhieuNhap] ([MaPhieuNhap], [MaSanPham], [SoLuongNhap], [NgayNhap], [GiaNhap]) VALUES (16, 1, 100, CAST(N'2025-01-09T00:00:00.000' AS DateTime), 10000)
INSERT [dbo].[PhieuNhap] ([MaPhieuNhap], [MaSanPham], [SoLuongNhap], [NgayNhap], [GiaNhap]) VALUES (17, 1, 111, CAST(N'2025-01-10T00:00:00.000' AS DateTime), 222)
INSERT [dbo].[PhieuNhap] ([MaPhieuNhap], [MaSanPham], [SoLuongNhap], [NgayNhap], [GiaNhap]) VALUES (18, 16, 5555, CAST(N'2025-01-10T00:00:00.000' AS DateTime), 111)
SET IDENTITY_INSERT [dbo].[PhieuNhap] OFF
GO
SET IDENTITY_INSERT [dbo].[SanPham] ON 

INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MaDanhMuc], [MoTa], [HinhAnh], [TrangThai], [NgayTao], [SoLuong]) VALUES (1, N'Xe điều khiển BMW i8 Bạc RASTAR R48400-2', 3, N'Xe điều khiển BMW i8 Bạc RASTAR R48400-2 là sản phẩm đồ chơi được thiết kế theo tỉ lệ 1:24, nhỏ hơn 24 lần so với thực tế. Tuy nhiên các chi tiết đều đầy đủ từ nội thất cho đến bên ngoài, mang lại cảm giác như thật cho người chơi.

Mô hình có trục bánh xe trước, có thể xoay tròn 360 độ, bé có thể điều khiển xe một cách mượt mà đầy ấn tượng. Bé dễ dàng điều khiển thông qua tay cầm một cách dễ dàng, xe tiến lùi, sang trái sang phải tùy ý thích của bé. Từ đó, sản phẩm giúp bé rèn luyện khả năng k', N'uploads/xe-dieu-khien-bmw-i8-bac-r48400-2_1.webp', 1, CAST(N'2025-01-09T00:00:00.000' AS DateTime), 212)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MaDanhMuc], [MoTa], [HinhAnh], [TrangThai], [NgayTao], [SoLuong]) VALUES (2, N'Xe cần cẩu điều khiển từ xa VECTO VT2801-3', 1, N'Bộ sưu tập xe điều khiển chủ đề xe công trình - Xe cẩu

Là dòng xe cẩu điều khiển từ xa được thiết kế mô phỏng dựa trên xe cẩu ngoài đời thật. Chưa dừng lại ở đó xe còn tích hợp tính năng:

- Nâng/hạ cần cẩu bằng remote điều khiển vô cùng ấn tượng

- Hệ thống đèn Led phát sáng cực kỳ độc đáo mỗi khi xe di chuyển hay khi thực hiện hành động nâng cần cẩu.

Hứa hẹn sẽ là một món đồ chơi không thể thiếu cho bộ sưu tập xe của các bé trai năng động.', N'uploads/vt2801-3_2_df36e0ab-4fd0-419b-92d0-2124070e1252.webp', 1, CAST(N'2025-01-09T00:00:00.000' AS DateTime), 200)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MaDanhMuc], [MoTa], [HinhAnh], [TrangThai], [NgayTao], [SoLuong]) VALUES (3, N'Xe tải nhiều ngăn - Cứu hỏa (nhỏ) VECTO 666-03K', 1, N'Xe tải nhiều ngăn chủ đề cứu hỏa bao gồm 5 xe cứu hỏa và 1 trực thăng, 4 chi tiết trang trí giao thông Bé còn có thể thả các xe con vào đường phóng được tích hợp trên đầu xe tải lớn để tăng cường tốc độ cho các xe con nữa đó. Bộ đồ chơi hứa hẹn sẽ là một món đồ không thể thiếu trong bộ sưu tập xe của các bé trai yêu thích xe mô hình.', N'uploads/666-03k_1.webp', 1, CAST(N'2025-01-09T00:00:00.000' AS DateTime), 311)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MaDanhMuc], [MoTa], [HinhAnh], [TrangThai], [NgayTao], [SoLuong]) VALUES (4, N'Đồ chơi lắp ráp Vecto DIY - Xe cứu hỏa thang xoay VECTO VT1062', 5, N'Bộ đồ chơi lắp ráp xe giúp bé phát triển kỹ năng vận động tinh thông qua các thao tác vặn, mở ốc khi chơi. Ngoài ra, bé còn rèn luyện được tư duy logic, kỹ năng khéo léo khi mày mò lắp ráp hơn 25 mảnh ghép thành 1 chiếc xe hoàn chỉnh. Bộ sản phẩm bao gồm cả vít vặn rất vừa tay cho bé ở độ tuổi preschool, nhựa chơi được trong nhà và ngoài trời.
Với nhiều chủ đề và chức năng khác nhau, hãy sưu tập đủ bộ để có thể giáo dục bé về các phương tiện có thật trong cuộc sống', N'uploads/vt1062_1.webp', 1, CAST(N'2025-01-09T00:00:00.000' AS DateTime), 111)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MaDanhMuc], [MoTa], [HinhAnh], [TrangThai], [NgayTao], [SoLuong]) VALUES (6, N'Đồ Chơi Xe Cứu Hỏa Điều Khiển Từ Xa VETCO VT253B', 3, N'VECTO là thương hiệu đồ chơi dành riêng cho các bé trai, với các dòng đồ chơi trải dài từ điều khiển từ xa đến lắp ráp. Với mong muốn giúp các bé trai có sự phát triển toàn diện từ trí não đến thể chất, Vecto đã phát triển đa dạng các loại đồ chơi nhằm mang đến cho bé nhiều lựa chọn nhất có thể, một số dòng đồ chơi nổi bật:
- ROBOT ĐIỀU KHIỂN – PHÁT TRIỂN TƯ DUY SÁNG TẠO
- XE ĐIỀU KHIỂN – PHÁT TRIỂN TƯ DUY PHƯƠNG HƯỚNG
- ĐỒ CHƠI BAY – PHÁT TRIỂN TƯ DUY LOGIC
- ĐỒ CHƠI LẮP RÁP DIY – PHÁT TRIỂN KỸ NĂNG VẬN ĐỘNG TINH
Và còn nhiều dòng đồ chơi khác từ VECTO đang đợi bé khám phá', N'uploads/do-choi-xe-cuu-hoa-dieu-khien-tu-xa-vecto-VT253B_1.webp', 1, CAST(N'2025-01-09T00:00:00.000' AS DateTime), 200)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MaDanhMuc], [MoTa], [HinhAnh], [TrangThai], [NgayTao], [SoLuong]) VALUES (7, N'Đồ chơi lắp ráp Vecto DIY - Xe tăng VECTO VT1073', 5, N'VECTO DIY - TĂNG
Lấy cảm hứng từ các dòng xe ngoài đời thật, VECTO DIY có chủ để trải dài từ hệ thống xe công trình, xe rác, xe quân đội, cứu hỏa,… giúp bé tha hồ lựa chọn chủ đề mà mình yêu thích.
Các chiếc xe của VECTO DIY không chỉ là mô hình bình thường, xe có khả năng tháo rời và lắp ráp trở lại vô cùng độc đáo.
Bằng việc tự mình tháo lắp các chi tiết của xe thành các bộ phận riêng lẽ sẽ giúp bé học được cách ghi nhớ các mảnh ghép, phân tích các chi tiết của xe sao cho có thể lắp ráp xe trở lại hình dạng ban đầu.
VECTO DIY không chỉ giúp bé có những phút vui chơi hào hứng mà còn giúp bé rèn luyên tư duy phân tích lên đáng kể.', N'uploads/vt1073_1.webp', 1, CAST(N'2025-01-09T00:00:00.000' AS DateTime), 111)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MaDanhMuc], [MoTa], [HinhAnh], [TrangThai], [NgayTao], [SoLuong]) VALUES (8, N'MAN TGA BRUDER BRU02744', 1, N'Đồ chơi dạng mô hình theo tỷ lệ thu nhỏ 1:16 xe trộn xi măng BRUDER BRU02744 là sự kết hợp giữa cabin MAN mới và thân máy trộn xe tải. Chiếc xe với hai tông màu này có thể mở được tất cả các cửa, bên trong là một nơi làm việc hiện đại. Cabin được trang bị giao diện để có thể lắp thêm đèn và còi báo hiệu (không đi kèm sản phẩm). Xoay khoan trộn của xe tải bằng cách sử dụng một tay quay được lắp đặt trên bể nước. Bên trong khoan có một băng tải xoắn ốc và bộ trộn giống như bản gốc, có thể đảo ngược hướng quay của nó. Các vòng xoắn ở bên trong khoan giúp đẩy nguyên liệu cho máng xả ở phía sau. Bao gồm hai máng lắp thêm. Đây quả thật là món đồ chơi thú vị và độc đáo phải không nào!', N'uploads/bru02744-nentrang.webp', 1, CAST(N'2025-01-09T00:00:00.000' AS DateTime), 200)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MaDanhMuc], [MoTa], [HinhAnh], [TrangThai], [NgayTao], [SoLuong]) VALUES (9, N'Xe điều khiển 1:24 Lamborghini Aventador SVJ màu Vàng RASTAR R96100', 3, N'1. Xe đồ chơi điều khiển Rastar được mua bản quyền sử dụng từ chính hãng xe Lamborghini danh tiếng thế giới

2. Là phiên bản thu nhỏ tỉ lệ 1:24 từ siêu xe Lamborghini Aventador SVJ với các đường nét và chi tiết sắc sảo nhất
3. Được sản xuất với công nghệ tiên tiến dưới sự giám sát của đội ngũ kỹ thuật viên từ chính hãng xe Lamborghini cử đến
4. Tay cầm điều khiển vừa tay, dễ thao tác
5. Chức năng: tiến, lùi, trái, phải. Cảm nhận độ chạy êm mượt của 1 con xe điều khiển có chất lượng
6. Đồ chơi điều khiển bảo đảm an toàn cho trẻ hoặc là món quà tuyệt vời với bao bì sang trọng
7. Hàng chính hãng có phiếu bảo hành 30 ngày', N'uploads/xe-dieu-khien-1-24-lamborghini-aventador-svj-mau-vang-r96100-yel.webp', 1, CAST(N'2025-01-09T00:00:00.000' AS DateTime), 200)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MaDanhMuc], [MoTa], [HinhAnh], [TrangThai], [NgayTao], [SoLuong]) VALUES (10, N'Xe điều khiển 1:24 Ferrari FXXK Evo RASTAR R79300', 3, N'Xe điều khiển Ferrari FXXK Evo R79300 của thương hiệu RASTAR, được mua bản quyền và mô phỏng lại chính xác với tỷ lệ thu nhỏ 1:24. Sở hữu thiết kế chân thực như một chiếc xe ngoài đời thật, sản phẩm không chỉ là món đồ chơi giải trí sau những giờ học tập mệt mỏi mà còn giúp bé có thêm kiến thức về các loại phương tiện giao thông.

Siêu xe điều khiển RASTAR R79300 với các chức năng mạnh mẽ, hình dáng lôi cuốn, là một người bạn tuyệt vời không thể thiếu trong bộ sưu tập “xế hộp” của bé. Sản phẩm có các đặc điểm nổi bật sau:

Mô hình xe điều khiển được sản xuất theo quy trình chất lượng cao, tuân thủ các tiêu chuẩn nghiêm ngặt của châu Âu, hoàn toàn không chứa chất gây hại. 
Xe có màu sắc nổi bật, hình dáng sang trọng, mạnh mẽ, giúp kích thích thị giác của bé.
Thiết kế an toàn, không góc cạnh, không làm trầy xước da bé.
Xe có thể tiến, lùi, rẽ trái, rẽ phải dễ dàng bằng điều khiển từ xa, tự tay điều khiển chiếc xe mình yêu thích sẽ làm cho các bạn nhỏ vô cùng thích thú.
Lốp xe làm', N'uploads/R79300_1.webp', 1, CAST(N'2025-01-09T00:00:00.000' AS DateTime), 11)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MaDanhMuc], [MoTa], [HinhAnh], [TrangThai], [NgayTao], [SoLuong]) VALUES (11, N'Xe điều khiển 1:18 Porsche 911 GT3 CUP RASTAR R59400', 3, N'Xe điều khiển Porsche 911 GT3 CUP RASTAR được RASTAR mua bản quyền từ chính hãng xe và mô phỏng chính xác 100% với tỷ lệ 1:18, nhìn như một chiếc xe ngoài đời thật phiên bản nhỏ. Đây là món đồ chơi bổ ích mang niềm vui, sự hiểu biết và ước mơ đến cho trẻ thơ, ngoài ra còn giúp bé rèn luyện kĩ năng vận động linh hoạt khi điều khiển xe.', N'uploads/R59400.webp', 1, CAST(N'2025-01-09T00:00:00.000' AS DateTime), 200)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MaDanhMuc], [MoTa], [HinhAnh], [TrangThai], [NgayTao], [SoLuong]) VALUES (12, N'Xe Lamborghini Sesto Elemento RASTAR R53700', 3, N'+ Xe Rastar có bản quyền chính hãng thương hiệu xe Lamborghini nổi tiếng thế giới
+ Tỷ lệ 1:18 (Mỗi kích thước: Dài Rộng Cao nhỏ hơn 18 lần so với xe thật)
+ Mô phỏng tinh xảo, tỉ mỉ từng chi tiết so với xe Lamborghini Sesto Elemento thật
+ Xe điều khiển tiến, lùi, rẽ trái, rẽ phải
+ Được làm từ nhựa và kim loại cao cấp, đảm bảo cho sự chắc chắn và độ bền của xe
+ Bánh xe bằng cao su giúp tăng độ bám với bề mặt, giúp xe chạy đầm và êm hơn
+ Bảo hành 30 ngày tại Mykingdom nếu có lỗi từ nhà sản xuất
+ Sản phẩm không kèm pin', N'uploads/xe-lamborghini-sesto-elemento-r53700.webp', 1, CAST(N'2025-01-09T00:00:00.000' AS DateTime), 2)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MaDanhMuc], [MoTa], [HinhAnh], [TrangThai], [NgayTao], [SoLuong]) VALUES (13, N'Xe điều khiển địa hình nhảy múa (đỏ mạnh mẽ) VECTO VT95562', 3, N'Xe điều khiển Porsche 911 GT3 CUP RASTAR được RASTAR mua bản quyền từ chính hãng xe và mô phỏng chính xác 100% với tỷ lệ 1:18, nhìn như một chiếc xe ngoài đời thật phiên bản nhỏ. Đây là món đồ chơi bổ ích mang niềm vui, sự hiểu biết và ước mơ đến cho trẻ thơ, ngoài ra còn giúp bé rèn luyện kĩ năng vận động linh hoạt khi điều khiển xe.', N'uploads/vt95562red.webp', 1, CAST(N'2025-01-09T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MaDanhMuc], [MoTa], [HinhAnh], [TrangThai], [NgayTao], [SoLuong]) VALUES (14, N'Đồ chơi mô hình tỷ lệ 1:16 xe cảnh sát Jeep và người BRUDER BRU02526', 1, N'là mẫu xe bán chạy nhất trong dòng xe mô hình của Bruder. Danh mục sản phẩm của Bruder rất phong phú với nhiều phương tiện xây dựng, dịch vụ khẩn cấp, xe thương mại, giải trí, nông nghiệp và lâm nghiệp được yêu thích trên toàn thế giới nhờ các chức năng để khám phá đầy thú vị.', N'uploads/BRU02526_1.webp', 1, CAST(N'2025-01-09T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MaDanhMuc], [MoTa], [HinhAnh], [TrangThai], [NgayTao], [SoLuong]) VALUES (15, N'Mô hình mô tô 1:12 dòng Kawasaki Ninja H2TM R MAISTO MT31101', 1, N'Mô hình mô tô 1:12 dòng Kawasaki Ninja H2TM R MAISTO 16880/MT31101 nhỏ hơn 12 lần so với xe ngoài đời thực. Tuy nhiên, tất cả các chi tiết từ trong ra ngoài đều được mô phỏng chính xác một cách tỉ mỉ. Đây là mô hình thu nhỏ nhỏ hoàn hảo của dòng xe cao cấp này!   Với kiểu dáng thể thao mạnh mẽ đầy cá tính, đây có thể là vật trưng bày không thể thiếu trên bàn làm việc, trong phòng khách hay góc học tập của bất cứ ai yêu thích xe mô hình.', N'uploads/MT31101_16880_1.webp', 1, CAST(N'2025-01-09T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MaDanhMuc], [MoTa], [HinhAnh], [TrangThai], [NgayTao], [SoLuong]) VALUES (16, N'Trực thăng điều khiển từ xa WOLF FORCE (cam) VECTO VTF8', 6, N'CHINH PHỤC BẦU TRỜI CÙNG TRỰC THĂNG WOLF FORCE VECTO  Dòng trực thăng với pin sạc thế hệ mới cho thời gian chơi lên đến 22 phút hứa hẹn sẽ là mang đến những giờ bay đầy hào hứng cho các bé.', N'uploads/vtf8_3__1_552e6057-707b-415c-9b35-d0de6edbcfb6.webp', 1, CAST(N'2025-01-10T00:00:00.000' AS DateTime), 5556)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MaDanhMuc], [MoTa], [HinhAnh], [TrangThai], [NgayTao], [SoLuong]) VALUES (17, N'DepTrai', 1, N'Đẹp trai nhất là tôi Dư Ngọc Hùng', N'uploads/WIN_20230720_20_28_09_Pro.jpg', 0, CAST(N'2025-01-10T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MaDanhMuc], [MoTa], [HinhAnh], [TrangThai], [NgayTao], [SoLuong]) VALUES (18, N'húngadoad', 1, N'hjkl;', N'uploads/WIN_20241012_07_49_27_Pro.jpg', 1, CAST(N'2025-01-10T00:00:00.000' AS DateTime), 988)
SET IDENTITY_INSERT [dbo].[SanPham] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__DangNhap__536C85E4202818E9]    Script Date: 11/01/2025 6:38:06 SA ******/
ALTER TABLE [dbo].[DangNhap] ADD UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__KhachHan__A9D105344AE93E30]    Script Date: 11/01/2025 6:38:06 SA ******/
ALTER TABLE [dbo].[KhachHang] ADD  CONSTRAINT [UQ__KhachHan__A9D105344AE93E30] UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BangGia] ADD  CONSTRAINT [DF__BangGia__NgayApD__6FE99F9F]  DEFAULT (getdate()) FOR [NgayApDung]
GO
ALTER TABLE [dbo].[DanhGia] ADD  DEFAULT (getdate()) FOR [NgayDanhGia]
GO
ALTER TABLE [dbo].[DanhMucSanPham] ADD  DEFAULT ((1)) FOR [TrangThai]
GO
ALTER TABLE [dbo].[DonHang] ADD  CONSTRAINT [DF__DonHang__NgayDat__44FF419A]  DEFAULT (getdate()) FOR [NgayDatHang]
GO
ALTER TABLE [dbo].[DonHang] ADD  CONSTRAINT [DF__DonHang__TrangTh__45F365D3]  DEFAULT ((0)) FOR [TrangThai]
GO
ALTER TABLE [dbo].[KhachHang] ADD  CONSTRAINT [DF__KhachHang__NgayD__38996AB5]  DEFAULT (getdate()) FOR [NgayDangKy]
GO
ALTER TABLE [dbo].[KhachHang] ADD  CONSTRAINT [DF__KhachHang__Trang__398D8EEE]  DEFAULT ((1)) FOR [TrangThai]
GO
ALTER TABLE [dbo].[PhieuNhap] ADD  DEFAULT (getdate()) FOR [NgayNhap]
GO
ALTER TABLE [dbo].[SanPham] ADD  CONSTRAINT [DF__SanPham__TrangTh__403A8C7D]  DEFAULT ((1)) FOR [TrangThai]
GO
ALTER TABLE [dbo].[SanPham] ADD  CONSTRAINT [DF__SanPham__NgayTao__412EB0B6]  DEFAULT (getdate()) FOR [NgayTao]
GO
ALTER TABLE [dbo].[BangGia]  WITH CHECK ADD  CONSTRAINT [FK__BangGia__MaSanPh__70DDC3D8] FOREIGN KEY([MaSanPham])
REFERENCES [dbo].[SanPham] ([MaSanPham])
GO
ALTER TABLE [dbo].[BangGia] CHECK CONSTRAINT [FK__BangGia__MaSanPh__70DDC3D8]
GO
ALTER TABLE [dbo].[ChiTietDonHang]  WITH CHECK ADD  CONSTRAINT [FK__ChiTietDo__MaDon__49C3F6B7] FOREIGN KEY([MaDonHang])
REFERENCES [dbo].[DonHang] ([MaDonHang])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ChiTietDonHang] CHECK CONSTRAINT [FK__ChiTietDo__MaDon__49C3F6B7]
GO
ALTER TABLE [dbo].[ChiTietDonHang]  WITH CHECK ADD  CONSTRAINT [FK__ChiTietDo__MaSan__4AB81AF0] FOREIGN KEY([MaSanPham])
REFERENCES [dbo].[SanPham] ([MaSanPham])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ChiTietDonHang] CHECK CONSTRAINT [FK__ChiTietDo__MaSan__4AB81AF0]
GO
ALTER TABLE [dbo].[DanhGia]  WITH CHECK ADD  CONSTRAINT [FK__DanhGia__MaKhach__5070F446] FOREIGN KEY([MaKhachHang])
REFERENCES [dbo].[KhachHang] ([MaKhachHang])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DanhGia] CHECK CONSTRAINT [FK__DanhGia__MaKhach__5070F446]
GO
ALTER TABLE [dbo].[DanhGia]  WITH CHECK ADD  CONSTRAINT [FK__DanhGia__MaSanPh__4F7CD00D] FOREIGN KEY([MaSanPham])
REFERENCES [dbo].[SanPham] ([MaSanPham])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DanhGia] CHECK CONSTRAINT [FK__DanhGia__MaSanPh__4F7CD00D]
GO
ALTER TABLE [dbo].[DonHang]  WITH CHECK ADD  CONSTRAINT [FK__DonHang__MaKhach__46E78A0C] FOREIGN KEY([MaKhachHang])
REFERENCES [dbo].[KhachHang] ([MaKhachHang])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DonHang] CHECK CONSTRAINT [FK__DonHang__MaKhach__46E78A0C]
GO
ALTER TABLE [dbo].[PhieuNhap]  WITH CHECK ADD  CONSTRAINT [FK__PhieuNhap__MaSan__74AE54BC] FOREIGN KEY([MaSanPham])
REFERENCES [dbo].[SanPham] ([MaSanPham])
GO
ALTER TABLE [dbo].[PhieuNhap] CHECK CONSTRAINT [FK__PhieuNhap__MaSan__74AE54BC]
GO
ALTER TABLE [dbo].[SanPham]  WITH CHECK ADD  CONSTRAINT [FK__SanPham__MaDanhM__4222D4EF] FOREIGN KEY([MaDanhMuc])
REFERENCES [dbo].[DanhMucSanPham] ([MaDanhMuc])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SanPham] CHECK CONSTRAINT [FK__SanPham__MaDanhM__4222D4EF]
GO
ALTER TABLE [dbo].[DanhGia]  WITH CHECK ADD CHECK  (([SoSao]>=(1) AND [SoSao]<=(5)))
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[51] 4[7] 2[23] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "kh"
            Begin Extent = 
               Top = 511
               Left = 48
               Bottom = 674
               Right = 243
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "sp"
            Begin Extent = 
               Top = 343
               Left = 48
               Bottom = 506
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "dh"
            Begin Extent = 
               Top = 175
               Left = 48
               Bottom = 338
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "ct"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 170
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 2
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 10
         Width = 284
         Width = 1200
         Width = 4620
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2460
         Alias = 2700
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_LichSuMuaHang'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_LichSuMuaHang'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_LichSuMuaHang'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "sp"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 170
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "bg"
            Begin Extent = 
               Top = 44
               Left = 475
               Bottom = 207
               Right = 669
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_SanPhamGia'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_SanPhamGia'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "ChiTietDonHang"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 170
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "DonHang"
            Begin Extent = 
               Top = 7
               Left = 532
               Bottom = 170
               Right = 726
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "KhachHang"
            Begin Extent = 
               Top = 39
               Left = 832
               Bottom = 202
               Right = 1027
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 1524
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1356
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_xacnhan'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_xacnhan'
GO
USE [master]
GO
ALTER DATABASE [WebBanHang] SET  READ_WRITE 
GO
