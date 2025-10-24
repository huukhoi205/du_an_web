# Sửa lỗi số lượng sản phẩm trong giỏ hàng

## 🐛 Vấn đề
Khi người dùng tăng số lượng sản phẩm trong giỏ hàng và chuyển sang trang đặt hàng, số lượng không được cập nhật đúng (luôn hiển thị = 1).

## 🔍 Nguyên nhân
1. **OrderServlet.java**: Có đoạn code test tạo sản phẩm mẫu với số lượng = 1 khi giỏ hàng trống
2. **CartServlet.java**: Logic merge giữa session cart và database cart có thể ghi đè session cart
3. **Session không được cập nhật**: Các hàm update/add/remove không cập nhật session sau khi thay đổi

## ✅ Giải pháp đã áp dụng

### 1. Xóa code test trong OrderServlet.java
```java
// TRƯỚC: Tạo sản phẩm mẫu khi giỏ hàng trống
if (cartItems.isEmpty()) {
    // Tạo sample item với quantity = 1
}

// SAU: Redirect về cart page khi giỏ hàng trống
if (cartItems.isEmpty()) {
    response.sendRedirect(request.getContextPath() + "/cart");
    return;
}
```

### 2. Sửa logic merge cart trong CartServlet.java
```java
// TRƯỚC: Merge session cart với database cart
if (!dbCartItems.isEmpty()) {
    // Có thể ghi đè session cart
}

// SAU: Ưu tiên session cart
if (cartItems == null || cartItems.isEmpty()) {
    cartItems = dbCartItems; // Chỉ load từ DB khi session trống
} else {
    // Giữ nguyên session cart
}
```

### 3. Đảm bảo session được cập nhật
```java
// Thêm vào tất cả các hàm modify cart:
session.setAttribute("cartItems", cartItems);
```

## 🧪 Cách test
1. Đăng nhập vào hệ thống
2. Thêm sản phẩm vào giỏ hàng
3. Tăng số lượng sản phẩm lên 2 hoặc 3
4. Click "Đặt hàng"
5. Kiểm tra trang đặt hàng có hiển thị đúng số lượng không

## 📝 Debug logging
Đã thêm debug logging để theo dõi:
- Số lượng items trong cart
- Chi tiết từng item với quantity và price
- Quá trình update quantity

## 🎯 Kết quả mong đợi
- Số lượng sản phẩm trong trang đặt hàng phải khớp với số lượng đã cập nhật trong giỏ hàng
- Không còn hiện tượng reset về 1
- Session cart được bảo toàn qua các lần chuyển trang
