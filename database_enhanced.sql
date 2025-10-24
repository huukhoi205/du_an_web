-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: quanlybandienthoai
-- ------------------------------------------------------
-- Server version	8.0.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cauhinhchitiet`
--

DROP TABLE IF EXISTS `cauhinhchitiet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cauhinhchitiet` (
  `MaCHCT` int NOT NULL AUTO_INCREMENT,
  `MaSP` int DEFAULT NULL,
  `ManHinh` varchar(200) DEFAULT NULL,
  `CPU` varchar(200) DEFAULT NULL,
  `GPU` varchar(200) DEFAULT NULL,
  `RAM` varchar(50) DEFAULT NULL,
  `BoNhoTrong` varchar(50) DEFAULT NULL,
  `HeDieuHanh` varchar(100) DEFAULT NULL,
  `CameraTruoc` varchar(100) DEFAULT NULL,
  `CameraSau` varchar(200) DEFAULT NULL,
  `QuayVideo` varchar(100) DEFAULT NULL,
  `DungLuongPin` varchar(50) DEFAULT NULL,
  `SacNhanh` varchar(50) DEFAULT NULL,
  `SacKhongDay` varchar(50) DEFAULT NULL,
  `SIM` varchar(50) DEFAULT NULL,
  `WiFi` varchar(50) DEFAULT NULL,
  `Bluetooth` varchar(50) DEFAULT NULL,
  `GPS` varchar(50) DEFAULT NULL,
  `ChatLieu` varchar(100) DEFAULT NULL,
  `KichThuoc` varchar(100) DEFAULT NULL,
  `TrongLuong` varchar(50) DEFAULT NULL,
  `MauSac` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`MaCHCT`),
  KEY `MaSP` (`MaSP`),
  CONSTRAINT `cauhinhchitiet_ibfk_1` FOREIGN KEY (`MaSP`) REFERENCES `sanpham` (`MaSP`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cauhinhchitiet`
--

LOCK TABLES `cauhinhchitiet` WRITE;
/*!40000 ALTER TABLE `cauhinhchitiet` DISABLE KEYS */;
INSERT INTO `cauhinhchitiet` VALUES 
(1,1,'6.7 inch OLED','Apple A16 Bionic','Apple GPU','6GB','128GB','iOS 16','12MP','48+12+12MP','4K@60fps','4323mAh','20W','Có','Nano-SIM + eSIM','WiFi 6','BT 5.3','GPS','Thép + kính','160.7x77.6x7.9mm','240g','Tím,Đen,Bạc'),
(2,2,'6.8 inch Dynamic AMOLED 2X','Snapdragon 8 Gen 2','Adreno 740','12GB','256GB','Android 13','12MP','200+10+10+12MP','8K@30fps','5000mAh','45W','Có','Nano-SIM + eSIM','WiFi 6E','BT 5.3','GPS','Thép + kính','163.3x78.1x8.9mm','234g','Xanh,Đen,Bạc'),
(3,3,'6.67 inch AMOLED','Snapdragon 732G','Adreno 618','8GB','128GB','Android 12','16MP','108+8+2+2MP','4K@30fps','5000mAh','33W','Có','Nano-SIM','WiFi 6','BT 5.2','GPS','Nhựa + kính','164.2x76.1x8.0mm','199g','Xanh,Đen,Bạc'),
(4,4,'6.7 inch OLED','Apple A15 Bionic','Apple GPU','6GB','128GB','iOS 15','12MP','12+12+12MP','4K@60fps','4352mAh','20W','Có','Nano-SIM + eSIM','WiFi 6','BT 5.0','GPS','Thép + kính','160.8x78.1x7.7mm','240g','Xanh,Đen,Bạc,Hồng'),
(5,5,'6.1 inch OLED','Apple A14 Bionic','Apple GPU','4GB','64GB','iOS 14','12MP','12+12MP','4K@60fps','2815mAh','20W','Có','Nano-SIM + eSIM','WiFi 6','BT 5.0','GPS','Nhôm + kính','146.7x71.5x7.4mm','162g','Xanh,Đen,Bạc,Đỏ'),
(6,6,'6.6 inch IPS LCD','Snapdragon 680','Adreno 610','6GB','128GB','Android 12','8MP','50+2+2MP','1080p@30fps','5000mAh','18W','Không','Nano-SIM','WiFi 5','BT 5.0','GPS','Nhựa','163.8x75.6x8.9mm','195g','Xanh,Đen,Bạc'),
(7,7,'6.43 inch AMOLED','Snapdragon 778G','Adreno 642L','8GB','128GB','Android 12','32MP','64+8+2+2MP','4K@30fps','4500mAh','65W','Có','Nano-SIM','WiFi 6','BT 5.2','GPS','Nhựa + kính','160.3x73.9x7.9mm','173g','Xanh,Đen,Bạc'),
(8,8,'6.78 inch AMOLED','Snapdragon 8+ Gen 1','Adreno 730','12GB','256GB','Android 12','32MP','50+48+2MP','8K@24fps','4700mAh','80W','Có','Nano-SIM','WiFi 6E','BT 5.3','GPS','Nhựa + kính','163.1x74.2x8.2mm','196g','Xanh,Đen,Bạc'),
(9,9,'6.7 inch OLED','Apple A17 Pro','Apple GPU','8GB','256GB','iOS 17','12MP','48+12+12MP','4K@60fps','4422mAh','20W','Có','Nano-SIM + eSIM','WiFi 6E','BT 5.3','GPS','Titanium + kính','159.9x76.7x8.25mm','221g','Xanh,Đen,Bạc,Tự nhiên'),
(10,10,'6.8 inch Dynamic AMOLED 2X','Snapdragon 8 Gen 2','Adreno 740','12GB','512GB','Android 13','12MP','200+10+10+12MP','8K@30fps','5000mAh','45W','Có','Nano-SIM + eSIM','WiFi 6E','BT 5.3','GPS','Thép + kính','163.3x78.1x8.9mm','234g','Xanh,Đen,Bạc'),
(11,11,'6.67 inch AMOLED','Snapdragon 8+ Gen 1','Adreno 730','8GB','256GB','Android 12','20MP','108+8+2MP','4K@60fps','5000mAh','120W','Có','Nano-SIM','WiFi 6E','BT 5.2','GPS','Nhựa + kính','163.1x74.2x8.2mm','196g','Xanh,Đen,Bạc'),
(12,12,'6.7 inch OLED','Apple A16 Bionic','Apple GPU','6GB','128GB','iOS 16','12MP','48+12+12MP','4K@60fps','4323mAh','20W','Có','Nano-SIM + eSIM','WiFi 6','BT 5.3','GPS','Thép + kính','160.7x77.6x7.9mm','240g','Tím,Đen,Bạc'),
(13,13,'6.1 inch OLED','Apple A15 Bionic','Apple GPU','6GB','128GB','iOS 15','12MP','12+12MP','4K@60fps','3240mAh','20W','Có','Nano-SIM + eSIM','WiFi 6','BT 5.0','GPS','Thép + kính','146.7x71.5x7.8mm','174g','Xanh,Đen,Bạc,Hồng'),
(14,14,'6.6 inch IPS LCD','Snapdragon 680','Adreno 610','4GB','64GB','Android 12','8MP','50+2MP','1080p@30fps','5000mAh','18W','Không','Nano-SIM','WiFi 5','BT 5.0','GPS','Nhựa','163.8x75.6x8.9mm','195g','Xanh,Đen,Bạc'),
(15,15,'6.43 inch AMOLED','Snapdragon 778G','Adreno 642L','6GB','128GB','Android 12','32MP','64+8+2+2MP','4K@30fps','4500mAh','65W','Có','Nano-SIM','WiFi 6','BT 5.2','GPS','Nhựa + kính','160.3x73.9x7.9mm','173g','Xanh,Đen,Bạc'),
(16,16,'6.78 inch AMOLED','Snapdragon 8+ Gen 1','Adreno 730','8GB','128GB','Android 12','32MP','50+48+2MP','8K@24fps','4700mAh','80W','Có','Nano-SIM','WiFi 6E','BT 5.3','GPS','Nhựa + kính','163.1x74.2x8.2mm','196g','Xanh,Đen,Bạc'),
(17,17,'6.7 inch OLED','Apple A17 Pro','Apple GPU','8GB','512GB','iOS 17','12MP','48+12+12MP','4K@60fps','4422mAh','20W','Có','Nano-SIM + eSIM','WiFi 6E','BT 5.3','GPS','Titanium + kính','159.9x76.7x8.25mm','221g','Xanh,Đen,Bạc,Tự nhiên'),
(18,18,'6.8 inch Dynamic AMOLED 2X','Snapdragon 8 Gen 2','Adreno 740','8GB','256GB','Android 13','12MP','200+10+10+12MP','8K@30fps','5000mAh','45W','Có','Nano-SIM + eSIM','WiFi 6E','BT 5.3','GPS','Thép + kính','163.3x78.1x8.9mm','234g','Xanh,Đen,Bạc'),
(19,19,'6.67 inch AMOLED','Snapdragon 8+ Gen 1','Adreno 730','12GB','512GB','Android 12','20MP','108+8+2MP','4K@60fps','5000mAh','120W','Có','Nano-SIM','WiFi 6E','BT 5.2','GPS','Nhựa + kính','163.1x74.2x8.2mm','196g','Xanh,Đen,Bạc'),
(20,20,'6.7 inch OLED','Apple A16 Bionic','Apple GPU','6GB','256GB','iOS 16','12MP','48+12+12MP','4K@60fps','4323mAh','20W','Có','Nano-SIM + eSIM','WiFi 6','BT 5.3','GPS','Thép + kính','160.7x77.6x7.9mm','240g','Tím,Đen,Bạc'),
(21,21,'6.1 inch OLED','Apple A15 Bionic','Apple GPU','6GB','256GB','iOS 15','12MP','12+12MP','4K@60fps','3240mAh','20W','Có','Nano-SIM + eSIM','WiFi 6','BT 5.0','GPS','Thép + kính','146.7x71.5x7.8mm','174g','Xanh,Đen,Bạc,Hồng'),
(22,22,'6.6 inch IPS LCD','Snapdragon 680','Adreno 610','6GB','128GB','Android 12','8MP','50+2MP','1080p@30fps','5000mAh','18W','Không','Nano-SIM','WiFi 5','BT 5.0','GPS','Nhựa','163.8x75.6x8.9mm','195g','Xanh,Đen,Bạc'),
(23,23,'6.43 inch AMOLED','Snapdragon 778G','Adreno 642L','8GB','256GB','Android 12','32MP','64+8+2+2MP','4K@30fps','4500mAh','65W','Có','Nano-SIM','WiFi 6','BT 5.2','GPS','Nhựa + kính','160.3x73.9x7.9mm','173g','Xanh,Đen,Bạc'),
(24,24,'6.78 inch AMOLED','Snapdragon 8+ Gen 1','Adreno 730','12GB','256GB','Android 12','32MP','50+48+2MP','8K@24fps','4700mAh','80W','Có','Nano-SIM','WiFi 6E','BT 5.3','GPS','Nhựa + kính','163.1x74.2x8.2mm','196g','Xanh,Đen,Bạc'),
(25,25,'6.7 inch OLED','Apple A17 Pro','Apple GPU','8GB','1TB','iOS 17','12MP','48+12+12MP','4K@60fps','4422mAh','20W','Có','Nano-SIM + eSIM','WiFi 6E','BT 5.3','GPS','Titanium + kính','159.9x76.7x8.25mm','221g','Xanh,Đen,Bạc,Tự nhiên'),
(26,26,'6.8 inch Dynamic AMOLED 2X','Snapdragon 8 Gen 2','Adreno 740','12GB','1TB','Android 13','12MP','200+10+10+12MP','8K@30fps','5000mAh','45W','Có','Nano-SIM + eSIM','WiFi 6E','BT 5.3','GPS','Thép + kính','163.3x78.1x8.9mm','234g','Xanh,Đen,Bạc'),
(27,27,'6.67 inch AMOLED','Snapdragon 8+ Gen 1','Adreno 730','8GB','128GB','Android 12','20MP','108+8+2MP','4K@60fps','5000mAh','120W','Có','Nano-SIM','WiFi 6E','BT 5.2','GPS','Nhựa + kính','163.1x74.2x8.2mm','196g','Xanh,Đen,Bạc'),
(28,28,'6.7 inch OLED','Apple A16 Bionic','Apple GPU','6GB','512GB','iOS 16','12MP','48+12+12MP','4K@60fps','4323mAh','20W','Có','Nano-SIM + eSIM','WiFi 6','BT 5.3','GPS','Thép + kính','160.7x77.6x7.9mm','240g','Tím,Đen,Bạc'),
(29,29,'6.1 inch OLED','Apple A15 Bionic','Apple GPU','6GB','512GB','iOS 15','12MP','12+12MP','4K@60fps','3240mAh','20W','Có','Nano-SIM + eSIM','WiFi 6','BT 5.0','GPS','Thép + kính','146.7x71.5x7.8mm','174g','Xanh,Đen,Bạc,Hồng'),
(30,30,'6.6 inch IPS LCD','Snapdragon 680','Adreno 610','8GB','256GB','Android 12','8MP','50+2MP','1080p@30fps','5000mAh','18W','Không','Nano-SIM','WiFi 5','BT 5.0','GPS','Nhựa','163.8x75.6x8.9mm','195g','Xanh,Đen,Bạc');
/*!40000 ALTER TABLE `cauhinhchitiet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chitietdh`
--

DROP TABLE IF EXISTS `chitietdh`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chitietdh` (
  `MaCTDH` int NOT NULL AUTO_INCREMENT,
  `MaDH` int DEFAULT NULL,
  `MaSP` int DEFAULT NULL,
  `SoLuong` int DEFAULT NULL,
  `Gia` decimal(15,0) DEFAULT NULL,
  PRIMARY KEY (`MaCTDH`),
  KEY `MaDH` (`MaDH`),
  KEY `MaSP` (`MaSP`),
  CONSTRAINT `chitietdh_ibfk_1` FOREIGN KEY (`MaDH`) REFERENCES `donhang` (`MaDH`) ON DELETE CASCADE,
  CONSTRAINT `chitietdh_ibfk_2` FOREIGN KEY (`MaSP`) REFERENCES `sanpham` (`MaSP`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chitietdh`
--

LOCK TABLES `chitietdh` WRITE;
/*!40000 ALTER TABLE `chitietdh` DISABLE KEYS */;
INSERT INTO `chitietdh` VALUES (1,1,1,1,28990000),(2,1,3,2,5990000);
/*!40000 ALTER TABLE `chitietdh` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `danhgia`
--

DROP TABLE IF EXISTS `danhgia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `danhgia` (
  `MaDG` int NOT NULL AUTO_INCREMENT,
  `MaND` int DEFAULT NULL,
  `MaSP` int DEFAULT NULL,
  `NoiDung` text,
  `SoSao` int DEFAULT NULL,
  PRIMARY KEY (`MaDG`),
  KEY `MaND` (`MaND`),
  KEY `MaSP` (`MaSP`),
  CONSTRAINT `danhgia_ibfk_1` FOREIGN KEY (`MaND`) REFERENCES `nguoidung` (`MaND`) ON DELETE CASCADE,
  CONSTRAINT `danhgia_ibfk_2` FOREIGN KEY (`MaSP`) REFERENCES `sanpham` (`MaSP`) ON DELETE CASCADE,
  CONSTRAINT `danhgia_chk_1` CHECK ((`SoSao` between 1 and 5))
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `danhgia`
--

LOCK TABLES `danhgia` WRITE;
/*!40000 ALTER TABLE `danhgia` DISABLE KEYS */;
INSERT INTO `danhgia` VALUES (1,1,1,'Máy rất mượt, pin ổn.',5),(2,2,3,'Ngon trong tầm giá.',4);
/*!40000 ALTER TABLE `danhgia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `danhmuc`
--

DROP TABLE IF EXISTS `danhmuc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `danhmuc` (
  `MaDM` int NOT NULL AUTO_INCREMENT,
  `TenDM` varchar(100) NOT NULL,
  PRIMARY KEY (`MaDM`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `danhmuc`
--

LOCK TABLES `danhmuc` WRITE;
/*!40000 ALTER TABLE `danhmuc` DISABLE KEYS */;
INSERT INTO `danhmuc` VALUES (1,'Samsung'),(2,'Apple'),(3,'Xiaomi'),(4,'OPPO'),(5,'Vivo'),(6,'Google'),(7,'Huawei'),(8,'Realme'),(9,'OnePlus'),(10,'Sony');
/*!40000 ALTER TABLE `danhmuc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `diachigiaohang`
--

DROP TABLE IF EXISTS `diachigiaohang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `diachigiaohang` (
  `MaDC` int NOT NULL AUTO_INCREMENT,
  `MaND` int DEFAULT NULL,
  `HoTenNguoiNhan` varchar(100) DEFAULT NULL,
  `SoDTNguoiNhan` varchar(15) DEFAULT NULL,
  `DiaChiChiTiet` varchar(255) DEFAULT NULL,
  `MacDinh` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`MaDC`),
  KEY `MaND` (`MaND`),
  CONSTRAINT `diachigiaohang_ibfk_1` FOREIGN KEY (`MaND`) REFERENCES `nguoidung` (`MaND`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `diachigiaohang`
--

LOCK TABLES `diachigiaohang` WRITE;
/*!40000 ALTER TABLE `diachigiaohang` DISABLE KEYS */;
INSERT INTO `diachigiaohang` VALUES (1,1,'Nguyễn Văn A','0901234567','123 Nguyễn Trãi, Hà Nội',1);
/*!40000 ALTER TABLE `diachigiaohang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `donhang`
--

DROP TABLE IF EXISTS `donhang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `donhang` (
  `MaDH` int NOT NULL AUTO_INCREMENT,
  `MaND` int DEFAULT NULL,
  `TrangThai` enum('ChoXacNhan','DaThanhToan','DangGiao','HoanTat','Huy') DEFAULT 'ChoXacNhan',
  `TongTien` decimal(15,0) DEFAULT NULL,
  `NgayDat` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`MaDH`),
  KEY `MaND` (`MaND`),
  CONSTRAINT `donhang_ibfk_1` FOREIGN KEY (`MaND`) REFERENCES `nguoidung` (`MaND`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `donhang`
--

LOCK TABLES `donhang` WRITE;
/*!40000 ALTER TABLE `donhang` DISABLE KEYS */;
INSERT INTO `donhang` VALUES (1,1,'DaThanhToan',4000000,'2025-09-20 20:50:40');
/*!40000 ALTER TABLE `donhang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `donvivanchuyen`
--

DROP TABLE IF EXISTS `donvivanchuyen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `donvivanchuyen` (
  `MaDVVC` int NOT NULL AUTO_INCREMENT,
  `TenDVVC` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`MaDVVC`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `donvivanchuyen`
--

LOCK TABLES `donvivanchuyen` WRITE;
/*!40000 ALTER TABLE `donvivanchuyen` DISABLE KEYS */;
INSERT INTO `donvivanchuyen` VALUES (1,'Giao Hàng Nhanh'),(2,'Viettel Post');
/*!40000 ALTER TABLE `donvivanchuyen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `giaohang`
--

DROP TABLE IF EXISTS `giaohang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `giaohang` (
  `MaGHang` int NOT NULL AUTO_INCREMENT,
  `MaDH` int DEFAULT NULL,
  `MaDVVC` int DEFAULT NULL,
  `MaVanDon` varchar(100) DEFAULT NULL,
  `TrangThai` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`MaGHang`),
  KEY `MaDH` (`MaDH`),
  KEY `MaDVVC` (`MaDVVC`),
  CONSTRAINT `giaohang_ibfk_1` FOREIGN KEY (`MaDH`) REFERENCES `donhang` (`MaDH`) ON DELETE CASCADE,
  CONSTRAINT `giaohang_ibfk_2` FOREIGN KEY (`MaDVVC`) REFERENCES `donvivanchuyen` (`MaDVVC`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `giaohang`
--

LOCK TABLES `giaohang` WRITE;
/*!40000 ALTER TABLE `giaohang` DISABLE KEYS */;
INSERT INTO `giaohang` VALUES (1,1,1,'GHN123456','Đang giao');
/*!40000 ALTER TABLE `giaohang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `giohang`
--

DROP TABLE IF EXISTS `giohang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `giohang` (
  `MaGH` int NOT NULL AUTO_INCREMENT,
  `MaND` int DEFAULT NULL,
  PRIMARY KEY (`MaGH`),
  KEY `MaND` (`MaND`),
  CONSTRAINT `giohang_ibfk_1` FOREIGN KEY (`MaND`) REFERENCES `nguoidung` (`MaND`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `giohang`
--

LOCK TABLES `giohang` WRITE;
/*!40000 ALTER TABLE `giohang` DISABLE KEYS */;
INSERT INTO `giohang` VALUES (1,1),(2,2);
/*!40000 ALTER TABLE `giohang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `giohangct`
--

DROP TABLE IF EXISTS `giohangct`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `giohangct` (
  `MaGHCT` int NOT NULL AUTO_INCREMENT,
  `MaGH` int DEFAULT NULL,
  `MaSP` int DEFAULT NULL,
  `SoLuong` int DEFAULT NULL,
  PRIMARY KEY (`MaGHCT`),
  KEY `MaGH` (`MaGH`),
  KEY `MaSP` (`MaSP`),
  CONSTRAINT `giohangct_ibfk_1` FOREIGN KEY (`MaGH`) REFERENCES `giohang` (`MaGH`) ON DELETE CASCADE,
  CONSTRAINT `giohangct_ibfk_2` FOREIGN KEY (`MaSP`) REFERENCES `sanpham` (`MaSP`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `giohangct`
--

LOCK TABLES `giohangct` WRITE;
/*!40000 ALTER TABLE `giohangct` DISABLE KEYS */;
INSERT INTO `giohangct` VALUES (1,1,1,1),(2,1,3,2),(3,2,2,1);
/*!40000 ALTER TABLE `giohangct` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `khuyenmai`
--

DROP TABLE IF EXISTS `khuyenmai`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `khuyenmai` (
  `MaKM` int NOT NULL AUTO_INCREMENT,
  `TenKM` varchar(200) DEFAULT NULL,
  `MoTa` text,
  `TyLeGiam` int DEFAULT NULL,
  `NgayBatDau` date DEFAULT NULL,
  `NgayKetThuc` date DEFAULT NULL,
  PRIMARY KEY (`MaKM`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `khuyenmai`
--

LOCK TABLES `khuyenmai` WRITE;
/*!40000 ALTER TABLE `khuyenmai` DISABLE KEYS */;
INSERT INTO `khuyenmai` VALUES (1,'Giảm 10% mùa tựu trường','Áp dụng tất cả smartphone',10,'2025-08-01','2025-09-30');
/*!40000 ALTER TABLE `khuyenmai` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lichsuachua`
--

DROP TABLE IF EXISTS `lichsuachua`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lichsuachua` (
  `MaSC` int NOT NULL AUTO_INCREMENT,
  `MaND` int DEFAULT NULL,
  `TenThietBi` varchar(200) NOT NULL,
  `MoTaLoi` text,
  `ChiPhiDuKien` decimal(15,0) DEFAULT NULL,
  `ChiPhiThucTe` decimal(15,0) DEFAULT NULL,
  `TrangThai` enum('TiepNhan','DangSua','HoanTat','Huy') DEFAULT 'TiepNhan',
  `NgayTiepNhan` datetime DEFAULT CURRENT_TIMESTAMP,
  `NgayHoanTat` datetime DEFAULT NULL,
  PRIMARY KEY (`MaSC`),
  KEY `MaND` (`MaND`),
  CONSTRAINT `lichsuachua_ibfk_1` FOREIGN KEY (`MaND`) REFERENCES `nguoidung` (`MaND`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lichsuachua`
--

LOCK TABLES `lichsuachua` WRITE;
/*!40000 ALTER TABLE `lichsuachua` DISABLE KEYS */;
/*!40000 ALTER TABLE `lichsuachua` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nguoidung`
--

DROP TABLE IF EXISTS `nguoidung`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nguoidung` (
  `MaND` int NOT NULL AUTO_INCREMENT,
  `HoTen` varchar(100) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `SoDT` varchar(15) DEFAULT NULL,
  `DiaChi` varchar(255) DEFAULT NULL,
  `NgayTao` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`MaND`),
  UNIQUE KEY `Email` (`Email`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nguoidung`
--

LOCK TABLES `nguoidung` WRITE;
/*!40000 ALTER TABLE `nguoidung` DISABLE KEYS */;
INSERT INTO `nguoidung` VALUES (1,'nguyen van an','vana@example.com',NULL,NULL,'2025-10-01 00:00:00'),(2,'Trần Thị Be','thib@example.com',NULL,NULL,'2025-10-01 00:00:00'),(3,'Admin','admin@example.com','0999999999','Đà Nẵng','2025-10-01 15:55:20');
/*!40000 ALTER TABLE `nguoidung` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sanpham`
--

DROP TABLE IF EXISTS `sanpham`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sanpham` (
  `MaSP` int NOT NULL AUTO_INCREMENT,
  `TenSP` varchar(200) NOT NULL,
  `MaHang` int DEFAULT NULL,
  `TinhTrang` enum('Moi','Cu') DEFAULT 'Moi',
  `Gia` decimal(15,0) NOT NULL,
  `SoLuong` int DEFAULT '0',
  `HinhAnh` varchar(255) DEFAULT NULL,
  `MoTa` text,
  PRIMARY KEY (`MaSP`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sanpham`
--

LOCK TABLES `sanpham` WRITE;
/*!40000 ALTER TABLE `sanpham` DISABLE KEYS */;
INSERT INTO `sanpham` VALUES 
(1,'iPhone 14 Pro Max 128GB',2,'Moi',28990000,20,'iphone14promax.jpg','Điện thoại cao cấp Apple với chip A16 Bionic'),
(2,'Samsung Galaxy S23 Ultra 256GB',1,'Moi',24990000,15,'s23ultra.jpg','Flagship Samsung với camera 200MP'),
(3,'Xiaomi Redmi Note 12 8GB/128GB',3,'Moi',5990000,50,'redmi12.jpg','Điện thoại tầm trung với hiệu năng tốt'),
(4,'iPhone 13 Pro Max 128GB',2,'Moi',22990000,25,'iphone13promax.jpg','iPhone 13 Pro Max với chip A15 Bionic'),
(5,'iPhone 12 64GB',2,'Cu',15990000,2,'iphone12.jpg','iPhone 12 cũ xin net'),
(6,'Samsung Galaxy A14 6GB/128GB',1,'Moi',3990000,30,'galaxya14.jpg','Điện thoại giá rẻ Samsung'),
(7,'OPPO Reno8 8GB/128GB',4,'Moi',8990000,20,'opporeno8.jpg','OPPO Reno8 với camera selfie 32MP'),
(8,'Vivo X80 Pro 12GB/256GB',5,'Moi',19990000,10,'vivox80pro.jpg','Vivo X80 Pro flagship'),
(9,'iPhone 15 Pro Max 256GB',2,'Moi',32990000,15,'iphone15promax.jpg','iPhone 15 Pro Max với chip A17 Pro'),
(10,'Samsung Galaxy S23+ 512GB',1,'Moi',21990000,12,'s23plus.jpg','Samsung Galaxy S23+ với bộ nhớ lớn'),
(11,'Xiaomi 13 Pro 8GB/256GB',3,'Moi',17990000,8,'xiaomi13pro.jpg','Xiaomi 13 Pro flagship'),
(12,'iPhone 14 Pro 128GB',2,'Moi',25990000,18,'iphone14pro.jpg','iPhone 14 Pro với Dynamic Island'),
(13,'iPhone 13 128GB',2,'Moi',18990000,22,'iphone13.jpg','iPhone 13 với chip A15 Bionic'),
(14,'Samsung Galaxy A24 4GB/64GB',1,'Moi',4990000,35,'galaxya24.jpg','Samsung Galaxy A24 giá rẻ'),
(15,'OPPO A78 6GB/128GB',4,'Moi',6990000,25,'oppoa78.jpg','OPPO A78 tầm trung'),
(16,'Vivo Y27 8GB/128GB',5,'Moi',5990000,20,'vivoy27.jpg','Vivo Y27 với camera 50MP'),
(17,'iPhone 15 Pro 512GB',2,'Moi',29990000,10,'iphone15pro.jpg','iPhone 15 Pro với chip A17 Pro'),
(18,'Samsung Galaxy S23 256GB',1,'Moi',18990000,15,'s23.jpg','Samsung Galaxy S23 compact'),
(19,'Xiaomi 13 12GB/512GB',3,'Moi',15990000,12,'xiaomi13.jpg','Xiaomi 13 với bộ nhớ lớn'),
(20,'iPhone 14 256GB',2,'Moi',21990000,20,'iphone14.jpg','iPhone 14 với chip A15 Bionic'),
(21,'iPhone 13 mini 128GB',2,'Moi',15990000,8,'iphone13mini.jpg','iPhone 13 mini compact'),
(22,'Samsung Galaxy A34 8GB/256GB',1,'Moi',7990000,18,'galaxya34.jpg','Samsung Galaxy A34 tầm trung'),
(23,'OPPO Find X5 Pro 8GB/256GB',4,'Moi',16990000,5,'oppofindx5pro.jpg','OPPO Find X5 Pro flagship'),
(24,'Vivo X90 Pro 12GB/256GB',5,'Moi',22990000,8,'vivox90pro.jpg','Vivo X90 Pro với camera 50MP'),
(25,'iPhone 15 Pro Max 1TB',2,'Moi',38990000,5,'iphone15promax1tb.jpg','iPhone 15 Pro Max bộ nhớ tối đa'),
(26,'Samsung Galaxy S23 Ultra 1TB',1,'Moi',29990000,3,'s23ultra1tb.jpg','Samsung Galaxy S23 Ultra bộ nhớ tối đa'),
(27,'Xiaomi 13 Ultra 8GB/128GB',3,'Moi',19990000,6,'xiaomi13ultra.jpg','Xiaomi 13 Ultra flagship'),
(28,'iPhone 14 Pro 512GB',2,'Moi',29990000,12,'iphone14pro512.jpg','iPhone 14 Pro bộ nhớ lớn'),
(29,'iPhone 13 Pro 512GB',2,'Moi',24990000,8,'iphone13pro512.jpg','iPhone 13 Pro bộ nhớ lớn'),
(30,'Samsung Galaxy A54 8GB/256GB',1,'Moi',8990000,20,'galaxya54.jpg','Samsung Galaxy A54 tầm trung cao cấp');
/*!40000 ALTER TABLE `sanpham` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taikhoan`
--

DROP TABLE IF EXISTS `taikhoan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `taikhoan` (
  `MaTK` int NOT NULL AUTO_INCREMENT,
  `MaND` int NOT NULL,
  `TenDangNhap` varchar(50) NOT NULL,
  `MatKhau` varchar(255) NOT NULL,
  `VaiTro` enum('KhachHang','Admin') DEFAULT 'KhachHang',
  `TrangThai` tinyint(1) DEFAULT '1',
  `NgayTao` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`MaTK`),
  UNIQUE KEY `TenDangNhap` (`TenDangNhap`),
  KEY `MaND` (`MaND`),
  CONSTRAINT `taikhoan_ibfk_1` FOREIGN KEY (`MaND`) REFERENCES `nguoidung` (`MaND`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taikhoan`
--

LOCK TABLES `taikhoan` WRITE;
/*!40000 ALTER TABLE `taikhoan` DISABLE KEYS */;
INSERT INTO `taikhoan` VALUES (1,1,'vana','202cb962ac59075b964b07152d234b70','KhachHang',1,'2025-10-01 00:00:00'),(2,2,'thibe','202cb962ac59075b964b07152d234b70','KhachHang',1,'2025-10-01 15:55:20'),(3,3,'admin','123456','Admin',1,'2025-10-01 15:55:20');
/*!40000 ALTER TABLE `taikhoan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `thanhtoan`
--

DROP TABLE IF EXISTS `thanhtoan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `thanhtoan` (
  `MaTT` int NOT NULL AUTO_INCREMENT,
  `MaDH` int DEFAULT NULL,
  `PhuongThuc` enum('The','COD','ViDienTu') DEFAULT 'COD',
  `SoTien` decimal(15,0) DEFAULT NULL,
  `NgayThanhToan` datetime DEFAULT NULL,
  `MaGiaoDich` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`MaTT`),
  KEY `MaDH` (`MaDH`),
  CONSTRAINT `thanhtoan_ibfk_1` FOREIGN KEY (`MaDH`) REFERENCES `donhang` (`MaDH`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thanhtoan`
--

LOCK TABLES `thanhtoan` WRITE;
/*!40000 ALTER TABLE `thanhtoan` DISABLE KEYS */;
INSERT INTO `thanhtoan` VALUES (1,1,'The',40970000,'2025-09-20 20:50:40','GD123456');
/*!40000 ALTER TABLE `thanhtoan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `thumuacu` (ENHANCED WITH IMAGE COLUMN)
--

DROP TABLE IF EXISTS `thumuacu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `thumuacu` (
  `MaTMC` int NOT NULL AUTO_INCREMENT,
  `MaND` int DEFAULT NULL,
  `TenMay` varchar(200) DEFAULT NULL,
  `HangSX` varchar(100) DEFAULT NULL,
  `TinhTrang` varchar(200) DEFAULT NULL,
  `GiaDeXuat` decimal(15,0) DEFAULT NULL,
  `GiaThoaThuan` decimal(15,0) DEFAULT NULL,
  `TrangThai` varchar(100) DEFAULT NULL,
  `HinhAnh` varchar(500) DEFAULT NULL,
  `NgayTao` datetime DEFAULT CURRENT_TIMESTAMP,
  `NgayCapNhat` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`MaTMC`),
  KEY `MaND` (`MaND`),
  CONSTRAINT `thumuacu_ibfk_1` FOREIGN KEY (`MaND`) REFERENCES `nguoidung` (`MaND`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thumuacu`
--

LOCK TABLES `thumuacu` WRITE;
/*!40000 ALTER TABLE `thumuacu` DISABLE KEYS */;
INSERT INTO `thumuacu` VALUES 
(1,1,'iPhone X 64GB','Apple','Trầy nhẹ, pin còn 85%',3000000,4000000,'HoanTat','iphone_x_64gb.jpg','2025-10-01 10:00:00','2025-10-15 14:30:00'),
(2,2,'iPhone 12 Pro Max 256GB','Apple','Màn hình có vết trầy nhẹ, máy hoạt động bình thường',8000000,8500000,'ChoDuyet','iphone_12_pro_max.jpg','2025-10-02 15:20:00','2025-10-02 15:20:00'),
(3,1,'Samsung Galaxy S21 Ultra 512GB','Samsung','Máy còn bảo hành, pin 90%',12000000,13000000,'DangDinhGia','samsung_s21_ultra.jpg','2025-10-03 09:15:00','2025-10-10 11:45:00'),
(4,2,'Xiaomi Mi 11 8GB/256GB','Xiaomi','Máy mới 99%, còn hộp sách',6000000,6500000,'ChoDuyet','xiaomi_mi11.jpg','2025-10-04 16:30:00','2025-10-04 16:30:00'),
(5,1,'OPPO Find X3 Pro 12GB/256GB','OPPO','Màn hình OLED đẹp, camera chụp tốt',7000000,7500000,'HoanTat','oppo_find_x3_pro.jpg','2025-10-05 11:00:00','2025-10-12 09:20:00');
/*!40000 ALTER TABLE `thumuacu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `yeuthich`
--

DROP TABLE IF EXISTS `yeuthich`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `yeuthich` (
  `MaYT` int NOT NULL AUTO_INCREMENT,
  `MaND` int DEFAULT NULL,
  `MaSP` int DEFAULT NULL,
  PRIMARY KEY (`MaYT`),
  KEY `MaND` (`MaND`),
  KEY `MaSP` (`MaSP`),
  CONSTRAINT `yeuthich_ibfk_1` FOREIGN KEY (`MaND`) REFERENCES `nguoidung` (`MaND`) ON DELETE CASCADE,
  CONSTRAINT `yeuthich_ibfk_2` FOREIGN KEY (`MaSP`) REFERENCES `sanpham` (`MaSP`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `yeuthich`
--

LOCK TABLES `yeuthich` WRITE;
/*!40000 ALTER TABLE `yeuthich` DISABLE KEYS */;
INSERT INTO `yeuthich` VALUES (1,1,2),(2,1,1),(3,2,3);
/*!40000 ALTER TABLE `yeuthich` ENABLE KEYS */;
UNLOCK TABLES;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-10-17 15:30:00
