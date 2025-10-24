<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.ExchangeRequest" %>
<%@ page import="model.RepairRequest" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>

<%
    // Lấy thông tin từ request attributes
    String userName = (String) request.getAttribute("userName");
    String userRole = (String) request.getAttribute("userRole");
    List<ExchangeRequest> exchangeHistory = (List<ExchangeRequest>) request.getAttribute("exchangeHistory");
    List<RepairRequest> repairHistory = (List<RepairRequest>) request.getAttribute("repairHistory");
    
    NumberFormat formatter = NumberFormat.getInstance(new Locale("vi", "VN"));
    
    // Set default values if null
    if (exchangeHistory == null) exchangeHistory = new java.util.ArrayList<>();
    if (repairHistory == null) repairHistory = new java.util.ArrayList<>();
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thu mua - Sửa chữa - KT Store</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/index.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .services-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .page-header {
            text-align: center;
            margin-bottom: 40px;
            padding: 30px 0;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 15px;
        }
        
        .page-header h1 {
            font-size: 2.5rem;
            margin-bottom: 10px;
            font-weight: bold;
        }
        
        .page-header p {
            font-size: 1.1rem;
            opacity: 0.9;
        }
        
        .services-tabs {
            display: flex;
            justify-content: center;
            margin-bottom: 30px;
            background: #f8f9fa;
            border-radius: 10px;
            padding: 5px;
        }
        
        .tab-button {
            flex: 1;
            padding: 15px 20px;
            border: none;
            background: transparent;
            color: #666;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        
        .tab-button.active {
            background: #007bff;
            color: white;
            box-shadow: 0 2px 10px rgba(0,123,255,0.3);
        }
        
        .tab-content {
            display: none;
        }
        
        .tab-content.active {
            display: block;
        }
        
        .service-section {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }
        
        .section-title {
            font-size: 1.8rem;
            color: #333;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .section-title i {
            color: #007bff;
        }
        
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #666;
        }
        
        .empty-state i {
            font-size: 4rem;
            color: #ddd;
            margin-bottom: 20px;
        }
        
        .empty-state h3 {
            font-size: 1.5rem;
            margin-bottom: 10px;
            color: #999;
        }
        
        .empty-state p {
            font-size: 1rem;
            margin-bottom: 30px;
        }
        
        .btn-primary {
            background: #007bff;
            color: white;
            padding: 12px 30px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s ease;
        }
        
        .btn-primary:hover {
            background: #0056b3;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,123,255,0.3);
        }
        
        .service-card {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 20px;
            border-left: 4px solid #007bff;
            transition: all 0.3s ease;
        }
        
        .service-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }
        
        .service-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }
        
        .service-id {
            font-weight: bold;
            color: #007bff;
            font-size: 1.1rem;
        }
        
        .service-status {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
            text-transform: uppercase;
        }
        
        .status-choduyet, .status-tiepnhan {
            background: #fff3cd;
            color: #856404;
        }
        
        .status-dangdinhgia, .status-dangsua {
            background: #d1ecf1;
            color: #0c5460;
        }
        
        .status-hoantat {
            background: #d4edda;
            color: #155724;
        }
        
        .service-details {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
            margin-bottom: 15px;
        }
        
        .detail-item {
            display: flex;
            flex-direction: column;
        }
        
        .detail-label {
            font-size: 12px;
            color: #666;
            margin-bottom: 5px;
            text-transform: uppercase;
            font-weight: 600;
        }
        
        .detail-value {
            font-size: 14px;
            color: #333;
            font-weight: 500;
        }
        
        .service-date {
            font-size: 12px;
            color: #999;
            text-align: right;
        }
        
        .service-actions {
            margin-top: 15px;
            text-align: right;
        }
        
        .btn-detail {
            background: #007bff;
            color: white;
            padding: 8px 16px;
            border-radius: 5px;
            text-decoration: none;
            font-size: 0.9rem;
            display: inline-flex;
            align-items: center;
            gap: 5px;
            transition: all 0.3s ease;
        }
        
        .btn-detail:hover {
            background: #0056b3;
            color: white;
            text-decoration: none;
            transform: translateY(-1px);
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .stat-card {
            background: white;
            border-radius: 12px;
            padding: 25px;
            text-align: center;
            box-shadow: 0 3px 15px rgba(0,0,0,0.1);
            border-top: 4px solid #007bff;
        }
        
        .stat-number {
            font-size: 2.5rem;
            font-weight: bold;
            color: #007bff;
            margin-bottom: 10px;
        }
        
        .stat-label {
            font-size: 1rem;
            color: #666;
            font-weight: 600;
        }
    </style>
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
                    <form action="${pageContext.request.contextPath}/views/search.jsp" method="get">
                        <input type="text" name="q" placeholder="Tìm Kiếm Sản phẩm" id="searchInput">
                    </form>
                </div>

                <!-- Header Actions -->
                <div class="header-actions">
                    <a href="${pageContext.request.contextPath}/cart" class="icon-btn" title="Giỏ hàng">
                        <i class="fas fa-shopping-cart"></i>
                    </a>
                    <a href="${pageContext.request.contextPath}/views/wishlist.jsp" class="icon-btn" title="Yêu thích">
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
                                <a href="${pageContext.request.contextPath}/views/order-success.jsp"><i class="fas fa-box"></i> Đơn hàng</a>
                                <a href="${pageContext.request.contextPath}/user-services"><i class="fas fa-tools"></i> Thu mua - Sửa chữa</a>
                                <% if ("Admin".equals(userRole)) { %>
                                <a href="${pageContext.request.contextPath}/admin/index.jsp"><i class="fas fa-cog"></i> Quản trị</a>
                                <% } %>
                                <hr>
                                <a href="${pageContext.request.contextPath}/logout" class="logout-link"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a>
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
                        <a href="${pageContext.request.contextPath}/repair" class="nav-link">SỬA CHỮA</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <main class="main-content">
        <div class="services-container">
            <!-- Page Header -->
            <div class="page-header">
                <h1><i class="fas fa-tools"></i> Thu mua - Sửa chữa</h1>
                <p>Quản lý tất cả các yêu cầu thu mua và sửa chữa của bạn</p>
            </div>

            <!-- Statistics -->
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-number"><%= exchangeHistory.size() %></div>
                    <div class="stat-label">Yêu cầu thu mua</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number"><%= repairHistory.size() %></div>
                    <div class="stat-label">Yêu cầu sửa chữa</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number"><%= exchangeHistory.size() + repairHistory.size() %></div>
                    <div class="stat-label">Tổng yêu cầu</div>
                </div>
            </div>

            <!-- Service Tabs -->
            <div class="services-tabs">
                <button class="tab-button active" onclick="showTab('all')">
                    <i class="fas fa-list"></i> Tất cả
                </button>
                <button class="tab-button" onclick="showTab('exchange')">
                    <i class="fas fa-exchange-alt"></i> Thu mua
                </button>
                <button class="tab-button" onclick="showTab('repair')">
                    <i class="fas fa-wrench"></i> Sửa chữa
                </button>
            </div>

            <!-- All Services Tab -->
            <div id="all-tab" class="tab-content active">
                <div class="service-section">
                    <h2 class="section-title">
                        <i class="fas fa-list"></i> Tất cả yêu cầu
                    </h2>
                    
                    <% if (exchangeHistory.isEmpty() && repairHistory.isEmpty()) { %>
                        <div class="empty-state">
                            <i class="fas fa-inbox"></i>
                            <h3>Chưa có yêu cầu nào</h3>
                            <p>Bạn chưa có yêu cầu thu mua hoặc sửa chữa nào. Hãy tạo yêu cầu đầu tiên!</p>
                            <a href="${pageContext.request.contextPath}/views/exchange.jsp" class="btn-primary">
                                <i class="fas fa-exchange-alt"></i> Thu mua điện thoại
                            </a>
                            <a href="${pageContext.request.contextPath}/repair" class="btn-primary" style="margin-left: 10px;">
                                <i class="fas fa-wrench"></i> Đặt lịch sửa chữa
                            </a>
                        </div>
                    <% } else { %>
                        <!-- Exchange Requests -->
                        <% if (!exchangeHistory.isEmpty()) { %>
                            <h3 style="color: #007bff; margin-bottom: 15px; font-size: 1.3rem;">
                                <i class="fas fa-exchange-alt"></i> Yêu cầu thu mua (<%= exchangeHistory.size() %>)
                            </h3>
                            <% for (ExchangeRequest exchangeRequest : exchangeHistory) { %>
                                <div class="service-card">
                                    <div class="service-header">
                                        <span class="service-id">#<%= exchangeRequest.getMaTMC() %></span>
                                        <span class="service-status status-<%= exchangeRequest.getTrangThai().toLowerCase() %>">
                                            <%= exchangeRequest.getTrangThai() %>
                                        </span>
                                    </div>
                                    <div class="service-details">
                                        <div class="detail-item">
                                            <span class="detail-label">Thiết bị</span>
                                            <span class="detail-value"><%= exchangeRequest.getTenMay() %></span>
                                        </div>
                                        <div class="detail-item">
                                            <span class="detail-label">Hãng</span>
                                            <span class="detail-value"><%= exchangeRequest.getHangSX() %></span>
                                        </div>
                                        <div class="detail-item">
                                            <span class="detail-label">Tình trạng</span>
                                            <span class="detail-value"><%= exchangeRequest.getTinhTrang() %></span>
                                        </div>
                                        <div class="detail-item">
                                            <span class="detail-label">Giá đề xuất</span>
                                            <span class="detail-value">
                                                <% if (exchangeRequest.getGiaDeXuat() != null && exchangeRequest.getGiaDeXuat().compareTo(java.math.BigDecimal.ZERO) > 0) { %>
                                                    <%= formatter.format(exchangeRequest.getGiaDeXuat()) %> ₫
                                                <% } else { %>
                                                    Chưa có
                                                <% } %>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="service-date">
                                        Tạo lúc: <%= new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm").format(exchangeRequest.getNgayTao()) %>
                                    </div>
                                    <div class="service-actions">
                                        <a href="${pageContext.request.contextPath}/exchange-detail?maTMC=<%= exchangeRequest.getMaTMC() %>" 
                                           class="btn-detail">
                                            <i class="fas fa-eye"></i> Xem chi tiết
                                        </a>
                                    </div>
                                </div>
                            <% } %>
                        <% } %>

                        <!-- Repair Requests -->
                        <% if (!repairHistory.isEmpty()) { %>
                            <h3 style="color: #28a745; margin-bottom: 15px; font-size: 1.3rem; margin-top: 30px;">
                                <i class="fas fa-wrench"></i> Yêu cầu sửa chữa (<%= repairHistory.size() %>)
                            </h3>
                            <% for (RepairRequest repairRequest : repairHistory) { %>
                                <div class="service-card">
                                    <div class="service-header">
                                        <span class="service-id">#<%= repairRequest.getMaSC() %></span>
                                        <span class="service-status status-<%= repairRequest.getTrangThai().toLowerCase() %>">
                                            <%= repairRequest.getTrangThai() %>
                                        </span>
                                    </div>
                                    <div class="service-details">
                                        <div class="detail-item">
                                            <span class="detail-label">Thiết bị</span>
                                            <span class="detail-value"><%= repairRequest.getTenThietBi() %></span>
                                        </div>
                                        <div class="detail-item">
                                            <span class="detail-label">Lỗi</span>
                                            <span class="detail-value"><%= repairRequest.getMoTaLoi() %></span>
                                        </div>
                                        <div class="detail-item">
                                            <span class="detail-label">Chi phí dự kiến</span>
                                            <span class="detail-value">
                                                <% if (repairRequest.getChiPhiDuKien() > 0) { %>
                                                    <%= formatter.format(repairRequest.getChiPhiDuKien()) %> ₫
                                                <% } else { %>
                                                    Chưa có
                                                <% } %>
                                            </span>
                                        </div>
                                        <div class="detail-item">
                                            <span class="detail-label">Chi phí thực tế</span>
                                            <span class="detail-value">
                                                <% if (repairRequest.getChiPhiThucTe() != null && repairRequest.getChiPhiThucTe() > 0) { %>
                                                    <%= formatter.format(repairRequest.getChiPhiThucTe()) %> ₫
                                                <% } else { %>
                                                    Chưa có
                                                <% } %>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="service-date">
                                        Tạo lúc: <%= new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm").format(repairRequest.getNgayTiepNhan()) %>
                                    </div>
                                    <div class="service-actions">
                                        <a href="${pageContext.request.contextPath}/repair-detail?maSC=<%= repairRequest.getMaSC() %>" 
                                           class="btn-detail">
                                            <i class="fas fa-eye"></i> Xem chi tiết
                                        </a>
                                    </div>
                                </div>
                            <% } %>
                        <% } %>
                    <% } %>
                </div>
            </div>

            <!-- Exchange Tab -->
            <div id="exchange-tab" class="tab-content">
                <div class="service-section">
                    <h2 class="section-title">
                        <i class="fas fa-exchange-alt"></i> Yêu cầu thu mua
                    </h2>
                    
                    <% if (exchangeHistory.isEmpty()) { %>
                        <div class="empty-state">
                            <i class="fas fa-exchange-alt"></i>
                            <h3>Chưa có yêu cầu thu mua</h3>
                            <p>Bạn chưa có yêu cầu thu mua điện thoại nào. Hãy tạo yêu cầu đầu tiên!</p>
                            <a href="${pageContext.request.contextPath}/views/exchange.jsp" class="btn-primary">
                                <i class="fas fa-plus"></i> Thu mua điện thoại
                            </a>
                        </div>
                    <% } else { %>
                        <% for (ExchangeRequest exchangeRequest : exchangeHistory) { %>
                            <div class="service-card">
                                <div class="service-header">
                                    <span class="service-id">#<%= exchangeRequest.getMaTMC() %></span>
                                    <span class="service-status status-<%= exchangeRequest.getTrangThai().toLowerCase() %>">
                                        <%= exchangeRequest.getTrangThai() %>
                                    </span>
                                </div>
                                <div class="service-details">
                                    <div class="detail-item">
                                        <span class="detail-label">Thiết bị</span>
                                        <span class="detail-value"><%= exchangeRequest.getTenMay() %></span>
                                    </div>
                                    <div class="detail-item">
                                        <span class="detail-label">Hãng</span>
                                        <span class="detail-value"><%= exchangeRequest.getHangSX() %></span>
                                    </div>
                                    <div class="detail-item">
                                        <span class="detail-label">Tình trạng</span>
                                        <span class="detail-value"><%= exchangeRequest.getTinhTrang() %></span>
                                    </div>
                                    <div class="detail-item">
                                        <span class="detail-label">Giá đề xuất</span>
                                        <span class="detail-value">
                                            <% if (exchangeRequest.getGiaDeXuat() != null && exchangeRequest.getGiaDeXuat().compareTo(java.math.BigDecimal.ZERO) > 0) { %>
                                                <%= formatter.format(exchangeRequest.getGiaDeXuat()) %> ₫
                                            <% } else { %>
                                                Chưa có
                                            <% } %>
                                        </span>
                                    </div>
                                </div>
                                <div class="service-date">
                                    Tạo lúc: <%= new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm").format(exchangeRequest.getNgayTao()) %>
                                </div>
                                <div class="service-actions">
                                    <a href="${pageContext.request.contextPath}/exchange-detail?maTMC=<%= exchangeRequest.getMaTMC() %>" 
                                       class="btn-detail">
                                        <i class="fas fa-eye"></i> Xem chi tiết
                                    </a>
                                </div>
                            </div>
                        <% } %>
                    <% } %>
                </div>
            </div>

            <!-- Repair Tab -->
            <div id="repair-tab" class="tab-content">
                <div class="service-section">
                    <h2 class="section-title">
                        <i class="fas fa-wrench"></i> Yêu cầu sửa chữa
                    </h2>
                    
                    <% if (repairHistory.isEmpty()) { %>
                        <div class="empty-state">
                            <i class="fas fa-wrench"></i>
                            <h3>Chưa có yêu cầu sửa chữa</h3>
                            <p>Bạn chưa có yêu cầu sửa chữa nào. Hãy đặt lịch sửa chữa đầu tiên!</p>
                            <a href="${pageContext.request.contextPath}/repair" class="btn-primary">
                                <i class="fas fa-plus"></i> Đặt lịch sửa chữa
                            </a>
                        </div>
                    <% } else { %>
                        <% for (RepairRequest repairRequest : repairHistory) { %>
                            <div class="service-card">
                                <div class="service-header">
                                    <span class="service-id">#<%= repairRequest.getMaSC() %></span>
                                    <span class="service-status status-<%= repairRequest.getTrangThai().toLowerCase() %>">
                                        <%= repairRequest.getTrangThai() %>
                                    </span>
                                </div>
                                <div class="service-details">
                                    <div class="detail-item">
                                        <span class="detail-label">Thiết bị</span>
                                        <span class="detail-value"><%= repairRequest.getTenThietBi() %></span>
                                    </div>
                                    <div class="detail-item">
                                        <span class="detail-label">Lỗi</span>
                                        <span class="detail-value"><%= repairRequest.getMoTaLoi() %></span>
                                    </div>
                                    <div class="detail-item">
                                        <span class="detail-label">Chi phí dự kiến</span>
                                        <span class="detail-value">
                                            <% if (repairRequest.getChiPhiDuKien() > 0) { %>
                                                <%= formatter.format(repairRequest.getChiPhiDuKien()) %> ₫
                                            <% } else { %>
                                                Chưa có
                                            <% } %>
                                        </span>
                                    </div>
                                    <div class="detail-item">
                                        <span class="detail-label">Chi phí thực tế</span>
                                        <span class="detail-value">
                                            <% if (repairRequest.getChiPhiThucTe() != null && repairRequest.getChiPhiThucTe() > 0) { %>
                                                <%= formatter.format(repairRequest.getChiPhiThucTe()) %> ₫
                                            <% } else { %>
                                                Chưa có
                                            <% } %>
                                        </span>
                                    </div>
                                </div>
                                <div class="service-date">
                                    Tạo lúc: <%= new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm").format(repairRequest.getNgayTiepNhan()) %>
                                </div>
                                <div class="service-actions">
                                    <a href="${pageContext.request.contextPath}/repair-detail?maSC=<%= repairRequest.getMaSC() %>" 
                                       class="btn-detail">
                                        <i class="fas fa-eye"></i> Xem chi tiết
                                    </a>
                                </div>
                            </div>
                        <% } %>
                    <% } %>
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
    <script>
        // Tab functionality
        function showTab(tabName) {
            // Hide all tabs
            const tabs = document.querySelectorAll('.tab-content');
            tabs.forEach(tab => tab.classList.remove('active'));
            
            // Remove active class from all buttons
            const buttons = document.querySelectorAll('.tab-button');
            buttons.forEach(button => button.classList.remove('active'));
            
            // Show selected tab
            document.getElementById(tabName + '-tab').classList.add('active');
            
            // Add active class to clicked button
            event.target.classList.add('active');
        }

        // User dropdown functionality
        function toggleUserDropdown() {
            const dropdown = document.getElementById('userDropdown');
            dropdown.classList.toggle('show');
        }

        // Close dropdown when clicking outside
        window.onclick = function(event) {
            if (!event.target.matches('.user-btn') && !event.target.matches('.user-btn *')) {
                const dropdowns = document.getElementsByClassName("user-dropdown");
                for (let i = 0; i < dropdowns.length; i++) {
                    const openDropdown = dropdowns[i];
                    if (openDropdown.classList.contains('show')) {
                        openDropdown.classList.remove('show');
                    }
                }
            }
        }
    </script>
</body>
</html>
