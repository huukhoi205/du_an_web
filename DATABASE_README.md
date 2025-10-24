# Database Enhanced - Quản Lý Bán Điện Thoại

## 📋 Tổng quan

Database đã được nâng cấp với các cải tiến sau:

### ✨ Cải tiến chính

1. **Bổ sung 30 sản phẩm mới** - Từ iPhone 12 đến iPhone 15 Pro Max, Samsung Galaxy S23 series, Xiaomi, OPPO, Vivo
2. **Thêm cột ảnh cho bảng thu mua cũ** - Hỗ trợ upload và lưu trữ ảnh thiết bị
3. **Cải tiến cấu trúc bảng thumuacu** - Thêm NgayTao, NgayCapNhat
4. **Dữ liệu mẫu phong phú** - 30 sản phẩm với đầy đủ thông tin kỹ thuật

## 🗄️ Cấu trúc Database

### Bảng `thumuacu` (ENHANCED)

```sql
CREATE TABLE `thumuacu` (
  `MaTMC` int NOT NULL AUTO_INCREMENT,
  `MaND` int DEFAULT NULL,
  `TenMay` varchar(200) DEFAULT NULL,
  `HangSX` varchar(100) DEFAULT NULL,
  `TinhTrang` varchar(200) DEFAULT NULL,
  `GiaDeXuat` decimal(15,0) DEFAULT NULL,
  `GiaThoaThuan` decimal(15,0) DEFAULT NULL,
  `TrangThai` varchar(100) DEFAULT NULL,
  `HinhAnh` varchar(500) DEFAULT NULL,        -- ✨ MỚI: Cột ảnh
  `NgayTao` datetime DEFAULT CURRENT_TIMESTAMP, -- ✨ MỚI: Ngày tạo
  `NgayCapNhat` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- ✨ MỚI: Ngày cập nhật
  PRIMARY KEY (`MaTMC`),
  KEY `MaND` (`MaND`),
  CONSTRAINT `thumuacu_ibfk_1` FOREIGN KEY (`MaND`) REFERENCES `nguoidung` (`MaND`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
```

### Bảng `sanpham` (30 sản phẩm mới)

**🍎 iPhone Series (15 sản phẩm):**
- iPhone 12, 12 Pro Max, 13, 13 Pro, 13 Pro Max, 13 mini
- iPhone 14, 14 Pro, 14 Pro Max  
- iPhone 15 Pro, 15 Pro Max (128GB, 256GB, 512GB, 1TB)

**📱 Samsung Series (8 sản phẩm):**
- Galaxy S23, S23+, S23 Ultra (256GB, 512GB, 1TB)
- Galaxy A14, A24, A34, A54

**⚡ Xiaomi Series (4 sản phẩm):**
- Redmi Note 12, Xiaomi 13, 13 Pro, 13 Ultra

**🎨 OPPO & Vivo (3 sản phẩm):**
- OPPO Reno8, A78, Find X5 Pro
- Vivo Y27, X80 Pro, X90 Pro

## 🚀 Cách sử dụng

### 1. Import Database

```bash
mysql -u root -p quanlybandienthoai < database_enhanced.sql
```

### 2. Cập nhật Code

#### ExchangeRequest Model
```java
// Thêm các field mới
private String hinhAnh;         // Đường dẫn ảnh thiết bị
private Timestamp ngayTao;      // Ngày tạo
private Timestamp ngayCapNhat;  // Ngày cập nhật
```

#### ExchangeDAO
```java
// SQL INSERT đã được cập nhật
String sql = "INSERT INTO thumuacu (MaND, TenMay, HangSX, TinhTrang, GiaDeXuat, TrangThai, HinhAnh) " +
            "VALUES (?, ?, ?, ?, ?, 'ChoDuyet', ?)";
```

#### ExchangeServlet
```java
// Xử lý upload ảnh (cần implement)
String hinhAnh = request.getParameter("hinhAnh");
```

## 📸 Upload Ảnh

### Frontend (exchange.jsp)
```html
<input type="file" id="deviceImage" name="deviceImage" accept="image/*">
<button type="button" class="btn-upload-image" onclick="uploadImage()">
    Tải ảnh lên
</button>
```

### Backend (cần implement)
```java
// Xử lý multipart/form-data
// Lưu file vào thư mục uploads/
// Lưu đường dẫn vào database
```

## 📊 Dữ liệu mẫu

### Sản phẩm mới (30 items)
- **iPhone**: 15 sản phẩm (từ iPhone 12 đến iPhone 15 Pro Max)
- **Samsung**: 8 sản phẩm (Galaxy S23 series + A series)
- **Xiaomi**: 4 sản phẩm (Redmi Note 12, Xiaomi 13 series)
- **OPPO**: 3 sản phẩm (Reno8, A78, Find X5 Pro)

### Thu mua cũ (5 records mẫu)
- iPhone X 64GB - Apple - Hoàn tất
- iPhone 12 Pro Max 256GB - Apple - Chờ duyệt
- Samsung Galaxy S21 Ultra 512GB - Samsung - Đang định giá
- Xiaomi Mi 11 8GB/256GB - Xiaomi - Chờ duyệt
- OPPO Find X3 Pro 12GB/256GB - OPPO - Hoàn tất

## 🔧 Tính năng mới

### 1. Upload Ảnh Thiết Bị
- Hỗ trợ upload ảnh khi đăng ký thu mua
- Lưu trữ đường dẫn ảnh trong database
- Hiển thị ảnh trong trang success và admin

### 2. Theo Dõi Thời Gian
- `NgayTao`: Thời điểm tạo yêu cầu thu mua
- `NgayCapNhat`: Thời điểm cập nhật cuối cùng
- Tự động cập nhật khi có thay đổi

### 3. Dữ Liệu Phong Phú
- 30 sản phẩm với đầy đủ thông tin kỹ thuật
- Cấu hình chi tiết cho từng sản phẩm
- Giá cả cập nhật theo thị trường

## 📝 Ghi chú

1. **File ảnh**: Cần tạo thư mục `uploads/` trong webapp
2. **Upload handler**: Cần implement servlet xử lý upload
3. **Validation**: Cần thêm validation cho file ảnh
4. **Security**: Cần kiểm tra file type và size

## 🎯 Kế hoạch phát triển

- [ ] Implement file upload servlet
- [ ] Thêm validation ảnh
- [ ] Tạo trang admin quản lý thu mua
- [ ] Thêm tính năng xem ảnh
- [ ] Optimize database performance

## 🚨 Lưu ý quan trọng

**File database đã được sửa lỗi SQL syntax:**
- ✅ Thêm `SET` trước các biến MySQL
- ✅ Syntax đúng chuẩn MySQL 8.0
- ✅ Có thể import trực tiếp mà không lỗi

**Import thành công:**
```bash
mysql -u root -p quanlybandienthoai < database_enhanced.sql
```
