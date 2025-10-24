<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.UserProfile, model.RepairRequest, java.util.List" %>

<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    response.setContentType("text/html; charset=UTF-8");
    
    // Lấy thông tin user từ session
    String userName = (String) session.getAttribute("userName");
    Integer userId = (Integer) session.getAttribute("userId");
    String userRole = (String) session.getAttribute("userRole");
    
    // Lấy thông tin user từ request attribute (được set bởi RepairServlet)
    UserProfile userProfile = (UserProfile) request.getAttribute("userProfile");
    List<RepairRequest> repairHistory = (List<RepairRequest>) request.getAttribute("repairHistory");
    
    // Debug: Hiển thị thông tin user
    System.out.println("repair.jsp - userProfile: " + (userProfile != null ? userProfile.toString() : "null"));
    if (userProfile != null) {
        System.out.println("repair.jsp - HoTen: " + userProfile.getHoTen());
        System.out.println("repair.jsp - Email: " + userProfile.getEmail());
        System.out.println("repair.jsp - SoDT: " + userProfile.getSoDT());
        System.out.println("repair.jsp - MaND: " + userProfile.getMaND());
    }
    
    // Lấy thông báo
    String success = (String) request.getAttribute("success");
    String error = (String) request.getAttribute("error");
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt lịch hẹn bảo hành và sửa chữa - KT Store</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/index.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/repair.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="container">
            <div class="header-content">
                <!-- Logo -->
                <div class="logo">
                    <a href="${pageContext.request.contextPath}/views/index.jsp">
                        <img src="${pageContext.request.contextPath}/image/ca6a32d5a48f3e706cefc42bf7073f0751fc03f2.jpg" alt="KT Store" style="height: 55px;">
                    </a>
                </div>

                <!-- Search Box -->
                <div class="search-box">
                    <i class="fas fa-search"></i>
                    <form action="search.jsp" method="get">
                        <input type="text" name="q" placeholder="Tìm Kiếm Sản phẩm" id="searchInput">
                    </form>
                </div>

                <!-- Header Actions -->
                <div class="header-actions">
                    <a href="${pageContext.request.contextPath}/cart" class="icon-btn" title="Giỏ hàng">
                        <i class="fas fa-shopping-cart"></i>
                    </a>
                    <a href="wishlist.jsp" class="icon-btn" title="Yêu thích">
                        <i class="far fa-heart"></i>
                    </a>
                    
                    <% if (userName != null) { %>
                        <!-- User Menu -->
                        <div class="user-menu">
                            <button class="user-btn" onclick="toggleUserDropdown()">
                                <i class="far fa-user"></i>
                                <span><%= userName %></span>
                                <i class="fas fa-chevron-down"></i>
                            </button>
                            <div class="user-dropdown" id="userDropdown">
                                <a href="${pageContext.request.contextPath}/profile"><i class="far fa-user"></i> Trang cá nhân</a>
                                <a href="orders.jsp"><i class="fas fa-box"></i> Đơn hàng</a>
                                <% if ("Admin".equals(userRole)) { %>
                                <a href="admin/dashboard.jsp"><i class="fas fa-cog"></i> Quản trị</a>
                                <% } %>
                                <hr>
                                <a href="${pageContext.request.contextPath}/views/logout.jsp" class="logout-link"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a>
                            </div>
                        </div>
                    <% } else { %>
                        <a href="login.jsp" class="btn-login">ĐĂNG NHẬP</a>
                        <span class="separator">|</span>
                        <a href="register.jsp" class="btn-register">ĐĂNG KÝ</a>
                    <% } %>
                </div>
            </div>
        </div>
    </header>

    <!-- Navigation -->
    <nav class="navbar">
        <div class="container">
            <div class="nav-content">
                <button class="menu-toggle">
                    <i class="fas fa-bars"></i>
                    <span>DANH MỤC</span>
                </button>

                <ul class="nav-menu">
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/views/index.jsp" class="nav-link">TRANG CHỦ</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a href="${pageContext.request.contextPath}/products" class="nav-link">
                            ĐIỆN THOẠI MỚI
                            <i class="fas fa-chevron-down"></i>
                        </a>
                        <div class="dropdown-menu">
                            <a href="${pageContext.request.contextPath}/products?brand=Apple">iPhone</a>
                            <a href="${pageContext.request.contextPath}/products?brand=Samsung">Samsung</a>
                            <a href="${pageContext.request.contextPath}/products?brand=Xiaomi">Xiaomi</a>
                            <a href="${pageContext.request.contextPath}/products?brand=OPPO">OPPO</a>
                            <a href="${pageContext.request.contextPath}/products?brand=Vivo">Vivo</a>
                        </div>
                    </li>
                    <li class="nav-item dropdown">
                        <a href="${pageContext.request.contextPath}/views/used-phones.jsp" class="nav-link">
                            ĐIỆN THOẠI CŨ
                            <i class="fas fa-chevron-down"></i>
                        </a>
                        <div class="dropdown-menu">
                            <a href="${pageContext.request.contextPath}/views/used-phones.jsp">iPhone Cũ</a>
                            <a href="${pageContext.request.contextPath}/views/used-phones.jsp">Samsung Cũ</a>
                            <a href="${pageContext.request.contextPath}/views/used-phones.jsp">Tất cả điện thoại cũ</a>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/views/exchange.jsp" class="nav-link">THU ĐIỆN THOẠI</a>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/repair" class="nav-link active">SỬA CHỮA</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <main class="main-content">
        <div class="container">
            <div class="repair-form-container">
                <div class="form-header">
                    <h1>ĐẶT LỊCH HẸN BẢO HÀNH VÀ SỬA CHỮA</h1>
                    <p class="voucher-text">(Nhận voucher 10% tối đa 50.000₫ sau khi đặt lịch)</p>
                </div>

                <!-- Thông báo -->
                <% if (success != null) { %>
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i>
                    <%= success %>
                </div>
                <% } %>
                
                <% if (error != null) { %>
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-circle"></i>
                    <%= error %>
                </div>
                <% } %>

                <form class="repair-form" action="${pageContext.request.contextPath}/repair" method="post">
                    <div class="form-row">
                        <div class="form-column">
                            <div class="form-group">
                                <label for="fullName">Họ và tên *</label>
                                <input type="text" id="fullName" name="fullName" 
                                       value="<%= userProfile != null && userProfile.getHoTen() != null ? userProfile.getHoTen() : "" %>" 
                                       placeholder="Nhập họ và tên của bạn" required>
                            </div>
                            
                            <div class="form-group">
                                <label for="email">Email</label>
                                <input type="email" id="email" name="email" 
                                       value="<%= userProfile != null && userProfile.getEmail() != null ? userProfile.getEmail() : "" %>" 
                                       placeholder="Nhập email của bạn">
                            </div>
                            
                            <div class="form-group">
                                <label for="tenThietBi">Tên thiết bị cần sửa chữa *</label>
                                <input type="text" id="tenThietBi" name="tenThietBi" 
                                       placeholder="VD: iPhone 11 Pro Max, Samsung Galaxy S21..." required>
                            </div>
                            
                            <div class="form-group">
                                <label for="loaiLoi">Loại lỗi *</label>
                                <select id="loaiLoi" name="loaiLoi" required onchange="toggleOtherError(); updateEstimatedPrice();">
                                    <option value="">-- Chọn loại lỗi --</option>
                                    <option value="Thay pin">Thay pin</option>
                                    <option value="Thay màn hình">Thay màn hình</option>
                                    <option value="Bảo hành máy lỗi do người bán">Bảo hành máy lỗi do người bán</option>
                                    <option value="Hư main">Hư main</option>
                                    <option value="Ép kính">Ép kính</option>
                                    <option value="Khác">Khác</option>
                                </select>
                            </div>
                            
                            <div class="form-group" id="moTaLoiKhacGroup" style="display: none;">
                                <label for="moTaLoiKhac">Mô tả chi tiết lỗi *</label>
                                <textarea id="moTaLoiKhac" name="moTaLoiKhac" rows="3" 
                                          placeholder="Mô tả chi tiết lỗi của thiết bị..."></textarea>
                            </div>
                        </div>

                        <div class="form-column">
                            <div class="form-group">
                                <label for="phone">Số điện thoại *</label>
                                <input type="tel" id="phone" name="phone" 
                                       value="<%= userProfile != null && userProfile.getSoDT() != null ? userProfile.getSoDT() : "" %>" 
                                       placeholder="Nhập số điện thoại của bạn" 
                                       pattern="[0-9]{10}" 
                                       title="Số điện thoại phải có 10 chữ số" required>
                            </div>
                            
                            <div class="form-group">
                                <label for="chiPhiDuKien">Chi phí dự kiến (VNĐ) *</label>
                                <input type="text" id="chiPhiDuKien" name="chiPhiDuKien" 
                                       placeholder="Chọn loại lỗi để hiển thị giá dự kiến...">
                                <div id="priceNote" class="price-note" style="display: none; margin-top: 5px; font-size: 12px; color: #666; font-style: italic;"></div>
                            </div>
                            
                            <div class="form-group">
                                <label>Lưu ý:</label>
                                <div class="note-box">
                                    <p><i class="fas fa-info-circle"></i> Chúng tôi sẽ liên hệ với bạn trong vòng 24h để xác nhận lịch hẹn.</p>
                                    <p><i class="fas fa-gift"></i> Nhận voucher 10% tối đa 50.000₫ sau khi đặt lịch thành công.</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn-submit">ĐẶT LỊCH SỬA CHỮA</button>
                    </div>
                </form>
                
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="footer-grid">
                <div class="footer-col">
                    <div class="footer-logo">KT</div>
                    <div class="footer-links">
                        <a href="#">GIỚI THIỆU VỀ CÔNG TY</a>
                        <a href="#">CÂU HỎI THƯỜNG GẶP</a>
                        <a href="#">CHÍNH SÁCH BẢO MẬT</a>
                        <a href="#">QUY CHẾ HOẠT ĐỘNG</a>
                    </div>
                </div>

                <div class="footer-col">
                    <h3>KIỂM TRA HÓA ĐƠN ĐIỆN TỬ</h3>
                    <a href="#">TRA CỨU THÔNG TIN BẢO HÀNH</a>
                    <a href="#">TIN TUYỂN DỤNG</a>
                    <a href="#">TIN KHUYẾN MÃI</a>
                    <a href="#">HƯỚNG DẪN ONLINE</a>
                </div>

                <div class="footer-col">
                    <h3>HỆ THỐNG CỬA HÀNG</h3>
                    <a href="#">HỆ THỐNG BẢO HÀNH</a>
                    <a href="#">KIỂM TRA HÀNG APPLE CHÍNH HÃNG</a>
                    <a href="#">GIỚI THIỆU ĐỐI TÁC</a>
                    <a href="#">CHÍNH SÁCH ĐỔI TRẢ</a>
                </div>

                <div class="footer-col">
                    <h3>SOCIAL MEDIA</h3>
                    <div class="social-links">
                        <a href="#" class="social-icon"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" class="social-icon"><i class="fab fa-google"></i></a>
                    </div>
                </div>
            </div>
        </div>
    </footer>
    <script src="${pageContext.request.contextPath}/resources/js/script-new.js"></script>
    
    <style>
        /* Alert styles */
        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 5px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .alert-error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        
        /* Note box styles */
        .note-box {
            background-color: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: 5px;
            padding: 15px;
            margin-top: 10px;
        }
        
        .note-box p {
            margin: 5px 0;
            color: #6c757d;
            font-size: 14px;
        }
        
        .note-box i {
            color: #007bff;
            margin-right: 8px;
        }
        
        
        /* Price note styles */
        .price-note {
            background-color: #e3f2fd;
            border: 1px solid #bbdefb;
            border-radius: 3px;
            padding: 8px;
            margin-top: 5px;
        }
        
        /* Select styles */
        select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            background-color: white;
        }
        
        select:focus {
            outline: none;
            border-color: #007bff;
            box-shadow: 0 0 0 2px rgba(0, 123, 255, 0.25);
        }
        
    </style>
    
    <script>
        // User dropdown function
        function toggleUserDropdown() {
            const dropdown = document.getElementById('userDropdown');
            dropdown.style.display = dropdown.style.display === 'block' ? 'none' : 'block';
        }

        // Close dropdown when clicking outside
        document.addEventListener('click', function(event) {
            const userMenu = document.querySelector('.user-menu');
            const dropdown = document.getElementById('userDropdown');
            
            if (userMenu && !userMenu.contains(event.target)) {
                dropdown.style.display = 'none';
            }
        });
        
        // Hàm định dạng tiền tệ (tương tự như trong cart.jsp)
        function formatCurrency(amount) {
            return new Intl.NumberFormat('vi-VN').format(amount);
        }
        
        // Toggle other error description field
        function toggleOtherError() {
            const loaiLoiSelect = document.getElementById('loaiLoi');
            const moTaLoiKhacGroup = document.getElementById('moTaLoiKhacGroup');
            const moTaLoiKhacTextarea = document.getElementById('moTaLoiKhac');
            
            if (loaiLoiSelect.value === 'Khác') {
                moTaLoiKhacGroup.style.display = 'block';
                moTaLoiKhacTextarea.required = true;
            } else {
                moTaLoiKhacGroup.style.display = 'none';
                moTaLoiKhacTextarea.required = false;
                moTaLoiKhacTextarea.value = '';
            }
        }
        
        // Update estimated price based on error type
        function updateEstimatedPrice() {
            const loaiLoiSelect = document.getElementById('loaiLoi');
            const chiPhiInput = document.getElementById('chiPhiDuKien');
            const priceNote = document.getElementById('priceNote');
            
            const selectedValue = loaiLoiSelect.value;
            
            // Reset
            chiPhiInput.readOnly = false;
            chiPhiInput.value = '';
            priceNote.style.display = 'none';
            priceNote.textContent = '';
            
            switch(selectedValue) {
                case 'Thay pin':
                    chiPhiInput.value = formatCurrency(700000);
                    chiPhiInput.readOnly = true;
                    chiPhiInput.required = true;
                    break;
                case 'Thay màn hình':
                    chiPhiInput.value = formatCurrency(1500000);
                    chiPhiInput.readOnly = true;
                    chiPhiInput.required = true;
                    break;
                case 'Bảo hành máy lỗi do người bán':
                    chiPhiInput.value = formatCurrency(0);
                    chiPhiInput.readOnly = true;
                    chiPhiInput.required = true;
                    break;
                case 'Hư main':
                    chiPhiInput.value = formatCurrency(1000000);
                    chiPhiInput.readOnly = true;
                    chiPhiInput.required = true;
                    break;
                case 'Ép kính':
                    chiPhiInput.value = formatCurrency(500000);
                    chiPhiInput.readOnly = true;
                    chiPhiInput.required = true;
                    break;
                case 'Khác':
                    chiPhiInput.value = '';
                    chiPhiInput.readOnly = false;
                    chiPhiInput.required = false;
                    chiPhiInput.placeholder = 'Cửa hàng sẽ liên hệ với bạn để báo giá chính xác';
                    priceNote.style.display = 'block';
                    priceNote.textContent = 'Cửa hàng sẽ liên hệ với bạn để báo giá chính xác';
                    break;
                default:
                    chiPhiInput.placeholder = 'Chọn loại lỗi để hiển thị giá dự kiến...';
                    chiPhiInput.required = false;
                    break;
            }
        }
    </script>
</body>
</html>