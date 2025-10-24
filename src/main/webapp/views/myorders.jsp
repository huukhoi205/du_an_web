<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.ExchangeRequest" %>
<%@ page import="model.RepairRequest" %>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    response.setContentType("text/html; charset=UTF-8");
    
    // Lấy thông tin user từ session
    String userName = (String) session.getAttribute("userName");
    Integer userId = (Integer) session.getAttribute("userId");
    String userRole = (String) session.getAttribute("userRole");
    
    // Kiểm tra đăng nhập
    if (userName == null) {
        response.sendRedirect(request.getContextPath() + "/views/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đơn Thu Mua - Sửa Chữa - KT Store</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/index.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .my-orders-page {
            background: #f5f5f5;
            padding: 30px 0 60px;
        }
        
        .page-header {
            text-align: center;
            margin-bottom: 40px;
        }
        
        .page-title {
            font-size: 32px;
            font-weight: 700;
            color: #333;
            margin-bottom: 10px;
        }
        
        .page-subtitle {
            font-size: 16px;
            color: #666;
        }
        
        .orders-container {
            max-width: 1000px;
            margin: 0 auto;
        }
        
        .orders-tabs {
            display: flex;
            margin-bottom: 30px;
            background: white;
            border-radius: 10px;
            padding: 5px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .tab-button {
            flex: 1;
            padding: 15px 20px;
            border: none;
            background: transparent;
            font-size: 16px;
            font-weight: 600;
            color: #666;
            cursor: pointer;
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        
        .tab-button.active {
            background: #007bff;
            color: white;
        }
        
        .tab-button:hover {
            background: #f8f9fa;
        }
        
        .tab-button.active:hover {
            background: #0056b3;
        }
        
        .orders-content {
            background: white;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .orders-list {
            display: none;
        }
        
        .orders-list.active {
            display: block;
        }
        
        .order-item {
            display: flex;
            align-items: center;
            padding: 20px;
            border: 1px solid #e1e8ed;
            border-radius: 8px;
            margin-bottom: 15px;
            transition: all 0.3s ease;
            cursor: pointer;
        }
        
        .order-item:hover {
            border-color: #007bff;
            box-shadow: 0 4px 12px rgba(0,123,255,0.15);
            transform: translateY(-2px);
        }
        
        .order-icon {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            margin-right: 20px;
            flex-shrink: 0;
        }
        
        .order-icon.exchange {
            background: #e8f5e8;
            color: #28a745;
        }
        
        .order-icon.repair {
            background: #fff3cd;
            color: #ffc107;
        }
        
        .order-info {
            flex: 1;
        }
        
        .order-type {
            font-size: 18px;
            font-weight: 600;
            color: #333;
            margin-bottom: 5px;
        }
        
        .order-id {
            font-size: 14px;
            color: #666;
            margin-bottom: 5px;
        }
        
        .order-date {
            font-size: 12px;
            color: #999;
        }
        
        .order-status {
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .status-pending {
            background: #fff3cd;
            color: #856404;
        }
        
        .status-completed {
            background: #d4edda;
            color: #155724;
        }
        
        .status-processing {
            background: #cce5ff;
            color: #004085;
        }
        
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #666;
        }
        
        .empty-state i {
            font-size: 64px;
            color: #ddd;
            margin-bottom: 20px;
        }
        
        .empty-state h3 {
            font-size: 24px;
            margin-bottom: 10px;
            color: #999;
        }
        
        .empty-state p {
            font-size: 16px;
            margin-bottom: 30px;
        }
        
        .btn-primary {
            background: #007bff;
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 6px;
            text-decoration: none;
            font-weight: 600;
            transition: background 0.3s ease;
        }
        
        .btn-primary:hover {
            background: #0056b3;
            color: white;
        }
        
        @media (max-width: 768px) {
            .order-item {
                flex-direction: column;
                text-align: center;
            }
            
            .order-icon {
                margin-right: 0;
                margin-bottom: 15px;
            }
            
            .orders-tabs {
                flex-direction: column;
            }
            
            .tab-button {
                margin-bottom: 5px;
            }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="container">
            <div class="header-content">
                <div class="logo">
                    <a href="${pageContext.request.contextPath}/views/index.jsp">
                        <img src="${pageContext.request.contextPath}/image/ca6a32d5a48f3e706cefc42bf7073f0751fc03f2.jpg" alt="KT Store" style="height: 70px;">
                    </a>
                </div>
                
                <div class="search-box">
                    <i class="fas fa-search"></i>
                    <input type="text" placeholder="Tìm kiếm sản phẩm...">
                </div>
                
                <div class="header-actions">
                    <a href="${pageContext.request.contextPath}/views/cart.jsp" class="icon-btn"><i class="fas fa-shopping-cart"></i></a>
                    <a href="#" class="icon-btn"><i class="fas fa-heart"></i></a>
                    <% if (userName != null) { %>
                        <div class="user-menu">
                            <div class="user-btn" onclick="toggleUserMenu()">
                                <i class="fas fa-user"></i>
                                <span><%= userName %></span>
                                <i class="fas fa-chevron-down"></i>
                            </div>
                            <div class="user-dropdown" id="userDropdown">
                                <a href="${pageContext.request.contextPath}/profile"><i class="far fa-user"></i> Trang cá nhân</a>
                                <a href="${pageContext.request.contextPath}/views/orders.jsp"><i class="fas fa-box"></i> Đơn hàng</a>
                                <a href="${pageContext.request.contextPath}/myorders"><i class="fas fa-exchange-alt"></i> Thu mua-Sửa chữa</a>
                                <hr>
                                <a href="${pageContext.request.contextPath}/views/logout.jsp" class="logout-link"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a>
                            </div>
                        </div>
                    <% } else { %>
                        <a href="${pageContext.request.contextPath}/views/login.jsp" class="btn-login">ĐĂNG NHẬP</a>
                        <span class="separator">|</span>
                        <a href="${pageContext.request.contextPath}/views/register.jsp" class="btn-register">ĐĂNG KÝ</a>
                    <% } %>
                </div>
            </div>
        </div>
    </header>

    <!-- Navbar -->
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
                        <a href="${pageContext.request.contextPath}/repair" class="nav-link">SỬA CHỮA</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <main class="my-orders-page">
        <div class="container">
            <div class="page-header">
                <h1 class="page-title">Đơn Thu Mua - Sửa Chữa</h1>
                <p class="page-subtitle">Quản lý tất cả đơn thu mua điện thoại và sửa chữa của bạn</p>
            </div>
            
            <div class="orders-container">
                <div class="orders-tabs">
                    <button class="tab-button active" onclick="showTab('all')">
                        <i class="fas fa-list"></i> Tất cả
                    </button>
                    <button class="tab-button" onclick="showTab('exchange')">
                        <i class="fas fa-exchange-alt"></i> Thu mua
                    </button>
                    <button class="tab-button" onclick="showTab('repair')">
                        <i class="fas fa-tools"></i> Sửa chữa
                    </button>
                </div>
                
                <div class="orders-content">
                    <!-- Tất cả đơn -->
                    <div id="all-orders" class="orders-list active">
                        <%
                            List<Object> allOrders = (List<Object>) request.getAttribute("allOrders");
                            if (allOrders != null && !allOrders.isEmpty()) {
                                for (Object order : allOrders) {
                                    if (order instanceof model.ExchangeRequest) {
                                        model.ExchangeRequest exchangeOrder = (model.ExchangeRequest) order;
                        %>
                        <div class="order-item" onclick="viewOrder('exchange', '<%= exchangeOrder.getMaTMC() %>')">
                            <div class="order-icon exchange">
                                <i class="fas fa-exchange-alt"></i>
                            </div>
                            <div class="order-info">
                                <div class="order-type">Thu mua điện thoại</div>
                                <div class="order-id">Mã đơn: TMC<%= String.format("%03d", exchangeOrder.getMaTMC()) %></div>
                                <div class="order-date">Ngày tạo: <%= exchangeOrder.getNgayTao() != null ? new java.text.SimpleDateFormat("dd/MM/yyyy").format(exchangeOrder.getNgayTao()) : "N/A" %></div>
                            </div>
                            <div class="order-status status-<%= exchangeOrder.getTrangThai().equals("ChoDuyet") ? "pending" : exchangeOrder.getTrangThai().equals("HoanThanh") ? "completed" : "processing" %>">
                                <%= exchangeOrder.getTrangThai().equals("ChoDuyet") ? "Chờ duyệt" : exchangeOrder.getTrangThai().equals("HoanThanh") ? "Hoàn thành" : "Đang xử lý" %>
                            </div>
                        </div>
                        <%
                                    } else if (order instanceof model.RepairRequest) {
                                        model.RepairRequest repairOrder = (model.RepairRequest) order;
                        %>
                        <div class="order-item" onclick="viewOrder('repair', '<%= repairOrder.getMaSC() %>')">
                            <div class="order-icon repair">
                                <i class="fas fa-tools"></i>
                            </div>
                            <div class="order-info">
                                <div class="order-type">Sửa chữa bảo hành</div>
                                <div class="order-id">Mã đơn: SC<%= String.format("%03d", repairOrder.getMaSC()) %></div>
                                <div class="order-date">Ngày tạo: <%= repairOrder.getNgayTao() != null ? new java.text.SimpleDateFormat("dd/MM/yyyy").format(repairOrder.getNgayTao()) : "N/A" %></div>
                            </div>
                            <div class="order-status status-<%= repairOrder.getTrangThai().equals("TiepNhan") ? "pending" : repairOrder.getTrangThai().equals("HoanThanh") ? "completed" : "processing" %>">
                                <%= repairOrder.getTrangThai().equals("TiepNhan") ? "Chờ duyệt" : repairOrder.getTrangThai().equals("HoanThanh") ? "Hoàn thành" : "Đang xử lý" %>
                            </div>
                        </div>
                        <%
                                    }
                                }
                            } else {
                        %>
                        <div class="empty-state">
                            <i class="fas fa-inbox"></i>
                            <h3>Chưa có đơn hàng nào</h3>
                            <p>Bạn chưa có đơn thu mua hoặc sửa chữa nào. Hãy tạo đơn mới!</p>
                            <a href="${pageContext.request.contextPath}/views/exchange.jsp" class="btn-primary">Thu mua điện thoại</a>
                            <a href="${pageContext.request.contextPath}/repair" class="btn-primary">Sửa chữa</a>
                        </div>
                        <%
                            }
                        %>
                    </div>
                    
                    <!-- Đơn thu mua -->
                    <div id="exchange-orders" class="orders-list">
                        <%
                            List<model.ExchangeRequest> exchangeOrders = (List<model.ExchangeRequest>) request.getAttribute("exchangeOrders");
                            if (exchangeOrders != null && !exchangeOrders.isEmpty()) {
                                for (model.ExchangeRequest exchangeOrder : exchangeOrders) {
                        %>
                        <div class="order-item" onclick="viewOrder('exchange', '<%= exchangeOrder.getMaTMC() %>')">
                            <div class="order-icon exchange">
                                <i class="fas fa-exchange-alt"></i>
                            </div>
                            <div class="order-info">
                                <div class="order-type">Thu mua điện thoại</div>
                                <div class="order-id">Mã đơn: TMC<%= String.format("%03d", exchangeOrder.getMaTMC()) %></div>
                                <div class="order-date">Ngày tạo: <%= exchangeOrder.getNgayTao() != null ? new java.text.SimpleDateFormat("dd/MM/yyyy").format(exchangeOrder.getNgayTao()) : "N/A" %></div>
                            </div>
                            <div class="order-status status-<%= exchangeOrder.getTrangThai().equals("ChoDuyet") ? "pending" : exchangeOrder.getTrangThai().equals("HoanThanh") ? "completed" : "processing" %>">
                                <%= exchangeOrder.getTrangThai().equals("ChoDuyet") ? "Chờ duyệt" : exchangeOrder.getTrangThai().equals("HoanThanh") ? "Hoàn thành" : "Đang xử lý" %>
                            </div>
                        </div>
                        <%
                                }
                            } else {
                        %>
                        <div class="empty-state">
                            <i class="fas fa-exchange-alt"></i>
                            <h3>Chưa có đơn thu mua nào</h3>
                            <p>Bạn chưa có đơn thu mua điện thoại nào. Hãy tạo đơn mới!</p>
                            <a href="${pageContext.request.contextPath}/views/exchange.jsp" class="btn-primary">Thu mua điện thoại</a>
                        </div>
                        <%
                            }
                        %>
                    </div>
                    
                    <!-- Đơn sửa chữa -->
                    <div id="repair-orders" class="orders-list">
                        <%
                            List<model.RepairRequest> repairOrders = (List<model.RepairRequest>) request.getAttribute("repairOrders");
                            if (repairOrders != null && !repairOrders.isEmpty()) {
                                for (model.RepairRequest repairOrder : repairOrders) {
                        %>
                        <div class="order-item" onclick="viewOrder('repair', '<%= repairOrder.getMaSC() %>')">
                            <div class="order-icon repair">
                                <i class="fas fa-tools"></i>
                            </div>
                            <div class="order-info">
                                <div class="order-type">Sửa chữa bảo hành</div>
                                <div class="order-id">Mã đơn: SC<%= String.format("%03d", repairOrder.getMaSC()) %></div>
                                <div class="order-date">Ngày tạo: <%= repairOrder.getNgayTao() != null ? new java.text.SimpleDateFormat("dd/MM/yyyy").format(repairOrder.getNgayTao()) : "N/A" %></div>
                            </div>
                            <div class="order-status status-<%= repairOrder.getTrangThai().equals("TiepNhan") ? "pending" : repairOrder.getTrangThai().equals("HoanThanh") ? "completed" : "processing" %>">
                                <%= repairOrder.getTrangThai().equals("TiepNhan") ? "Chờ duyệt" : repairOrder.getTrangThai().equals("HoanThanh") ? "Hoàn thành" : "Đang xử lý" %>
                            </div>
                        </div>
                        <%
                                }
                            } else {
                        %>
                        <div class="empty-state">
                            <i class="fas fa-tools"></i>
                            <h3>Chưa có đơn sửa chữa nào</h3>
                            <p>Bạn chưa có đơn sửa chữa nào. Hãy tạo đơn mới!</p>
                            <a href="${pageContext.request.contextPath}/repair" class="btn-primary">Sửa chữa</a>
                        </div>
                        <%
                            }
                        %>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="footer-grid">
                <div class="footer-col">
                    <div class="footer-logo">KT</div>
                </div>
                <div class="footer-col">
                    <h3>GIỚI THIỆU VỀ CÔNG TY</h3>
                    <div class="footer-links">
                        <a href="#">CÂU HỎI THƯỜNG GẶP</a>
                        <a href="#">CHÍNH SÁCH BẢO MẬT</a>
                        <a href="#">QUY CHẾ HOẠT ĐỘNG</a>
                    </div>
                </div>
                <div class="footer-col">
                    <h3>KIỂM TRA HÓA ĐƠN ĐIỆN TỬ</h3>
                    <div class="footer-links">
                        <a href="#">TRA CỨU THÔNG TIN BẢO HÀNH</a>
                        <a href="#">TIN TUYỂN DỤNG</a>
                        <a href="#">TIN KHUYẾN MÃI</a>
                        <a href="#">HƯỚNG DẪN ONLINE</a>
                    </div>
                </div>
                <div class="footer-col">
                    <h3>HỆ THỐNG CỬA HÀNG</h3>
                    <div class="footer-links">
                        <a href="#">HỆ THỐNG BẢO HÀNH</a>
                        <a href="#">KIỂM TRA HÀNG APPLE CHÍNH HÃNG</a>
                        <a href="#">GIỚI THIỆU ĐỔI MÁY</a>
                        <a href="#">CHÍNH SÁCH ĐỔI TRẢ</a>
                    </div>
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

    <script>
        function toggleUserMenu() {
            document.getElementById('userDropdown').classList.toggle('show');
        }
        
        function showTab(tabName) {
            // Ẩn tất cả tab content
            const allTabs = document.querySelectorAll('.orders-list');
            allTabs.forEach(tab => tab.classList.remove('active'));
            
            // Ẩn tất cả tab buttons
            const allButtons = document.querySelectorAll('.tab-button');
            allButtons.forEach(button => button.classList.remove('active'));
            
            // Hiển thị tab được chọn
            document.getElementById(tabName + '-orders').classList.add('active');
            event.target.classList.add('active');
        }
        
        function viewOrder(type, orderId) {
            if (type === 'exchange') {
                window.location.href = '${pageContext.request.contextPath}/views/exchange-success.jsp?orderId=' + orderId;
            } else if (type === 'repair') {
                window.location.href = '${pageContext.request.contextPath}/views/repair-success.jsp?orderId=' + orderId;
            }
        }
    </script>
</body>
</html>
