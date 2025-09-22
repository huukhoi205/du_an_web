<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.admin.ProductDAO" %>
<%@ page import="model.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>

<%
    ProductDAO productDAO = new ProductDAO();
    NumberFormat formatter = NumberFormat.getInstance(new Locale("vi", "VN"));
    
    // Lấy các tham số lọc từ request
    String brandName = request.getParameter("brand");
    String priceRange = request.getParameter("price");
    String sortBy = request.getParameter("sort");
    
    // Convert brand name to ID
    Integer brandId = null;
    if (brandName != null && !brandName.isEmpty()) {
        brandId = productDAO.getBrandIdByName(brandName);
    }
    
    // Phân trang
    int page = 1;
    int limit = 12;
    try {
        page = Integer.parseInt(request.getParameter("page") != null ? request.getParameter("page") : "1");
    } catch (NumberFormatException e) {
        page = 1;
    }
    int offset = (page - 1) * limit;
    
    // Lấy danh sách sản phẩm
    List<Product> usedPhones = productDAO.getUsedPhonesByFilters(brandId, priceRange, sortBy, limit, offset);
    
    // Lấy tổng số sản phẩm để tính phân trang
    int totalProducts = productDAO.getTotalUsedPhonesCount();
    int totalPages = (int) Math.ceil((double) totalProducts / limit);
    
    // Lấy danh sách hãng
    List<String> brands = productDAO.getAllBrands();
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Điện Thoại Cũ - KT Store</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="resources/css/used-phones.css">
    <style>
        .product-item {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 15px;
            margin: 10px;
            background: white;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            cursor: pointer;
            transition: transform 0.2s;
            text-align: center;
        }
        .product-item:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }
        .product-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 5px;
            margin-bottom: 10px;
        }
        .condition-badge {
            position: absolute;
            top: 10px;
            right: 10px;
            background: #27ae60;
            color: white;
            padding: 2px 6px;
            border-radius: 3px;
            font-size: 11px;
            font-weight: bold;
        }
        .price {
            color: #e74c3c;
            font-weight: bold;
            font-size: 18px;
            margin: 10px 0;
        }
        .original-price {
            text-decoration: line-through;
            color: #999;
            font-size: 14px;
            margin-left: 10px;
        }
        .promo-tag {
            background: #f39c12;
            color: white;
            padding: 3px 8px;
            border-radius: 3px;
            font-size: 11px;
            margin-top: 5px;
            display: inline-block;
        }
        .pagination {
            text-align: center;
            margin: 20px 0;
        }
        .pagination a, .pagination .current {
            display: inline-block;
            padding: 8px 16px;
            margin: 0 4px;
            border: 1px solid #ddd;
            color: #333;
            text-decoration: none;
            border-radius: 4px;
        }
        .pagination .current {
            background-color: #3498db;
            color: white;
            border-color: #3498db;
        }
        .pagination a:hover {
            background-color: #f5f5f5;
        }
        .filter-active {
            background-color: #3498db !important;
            color: white !important;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header>
        <div class="header-left">
            <i class="fa-solid fa-bars menu-icon"></i>
            <div class="logo">KT</div>
        </div>
        <div class="header-center">
            <div class="search-container">
                <form action="search.jsp" method="get">
                    <input type="text" name="q" placeholder="Tìm kiếm sản phẩm..." class="search-bar">
                    <button type="submit" class="search-button"><i class="fa-solid fa-magnifying-glass"></i></button>
                </form>
            </div>
        </div>
        <div class="header-right">
            <a href="cart.jsp" class="icon-link"><i class="fa-solid fa-cart-shopping"></i><span>Giỏ hàng</span></a>
            <a href="wishlist.jsp" class="icon-link"><i class="fa-solid fa-heart"></i><span>Yêu thích</span></a>
            <a href="login.jsp" class="icon-link"><i class="fa-solid fa-user"></i><span>USER 1</span></a>
        </div>
    </header>

    <!-- Navigation -->
    <nav>
        <div class="nav-container">
            <button class="menu-toggle">
                ☰ DANH<br>MỤC
            </button>
            <ul class="nav-links">
                <li><a href="new-phones.jsp">ĐIỆN THOẠI MỚI ▼</a></li>
                <li><a href="used-phones.jsp" class="active">ĐIỆN THOẠI CŨ ▼</a></li>
                <li><a href="repair.jsp">THU ĐIỆN THOẠI</a></li>
                <li><a href="appointment.jsp">SỬA CHỮA</a></li>
            </ul>
        </div>
    </nav>

    <!-- Breadcrumb -->
    <div class="breadcrumb">
        <a href="index.jsp">Trang chủ</a>
        <span> › Điện thoại cũ</span>
    </div>

    <div class="main-container">
        <!-- Sidebar Filters -->
        <aside class="sidebar">
            <form method="get" action="used-phones.jsp" id="filterForm">
                <div class="filter-group">
                    <h4>Lựa chọn hãng</h4>
                    <div class="brand-logos">
                        <%
                            for (String brandName : brands) {
                                String logoFile = brandName.toLowerCase() + "-logo.png";
                        %>
                        <img src="resources/images/<%= logoFile %>" alt="<%= brandName %>" 
                             onclick="filterByBrand('<%= brandName %>')"
                             style="cursor: pointer; <%= brandName.equals(brand) ? "border: 2px solid #3498db;" : "" %>"
                             title="<%= brandName %>">
                        <%
                            }
                        %>
                    </div>
                </div>

                <div class="filter-group">
                    <h4>Mức giá</h4>
                    <label class="custom-radio">
                        <input type="radio" name="price" value="2-4" <%= "2-4".equals(priceRange) ? "checked" : "" %> onchange="this.form.submit()"> Từ 2 - 4 triệu
                        <span></span>
                    </label>
                    <label class="custom-radio">
                        <input type="radio" name="price" value="4-7" <%= "4-7".equals(priceRange) ? "checked" : "" %> onchange="this.form.submit()"> Từ 4 - 7 triệu
                        <span></span>
                    </label>
                    <label class="custom-radio">
                        <input type="radio" name="price" value="7-13" <%= "7-13".equals(priceRange) ? "checked" : "" %> onchange="this.form.submit()"> Từ 7 - 13 triệu
                        <span></span>
                    </label>
                    <label class="custom-radio">
                        <input type="radio" name="price" value="13-20" <%= "13-20".equals(priceRange) ? "checked" : "" %> onchange="this.form.submit()"> Từ 13 - 20 triệu
                        <span></span>
                    </label>
                    <label class="custom-radio">
                        <input type="radio" name="price" value="20+" <%= "20+".equals(priceRange) ? "checked" : "" %> onchange="this.form.submit()"> Trên 20 triệu
                        <span></span>
                    </label>
                </div>

                <div class="filter-group">
                    <h4>Tình trạng (máy cũ)</h4>
                    <label class="custom-checkbox">
                        <input type="checkbox" name="condition" value="99" <%= conditionList != null && conditionList.contains("99") ? "checked" : "" %> onchange="this.form.submit()"> 99% (Như mới)
                        <span></span>
                    </label>
                    <label class="custom-checkbox">
                        <input type="checkbox" name="condition" value="98" <%= conditionList != null && conditionList.contains("98") ? "checked" : "" %> onchange="this.form.submit()"> 98% (Trầy xước nhẹ)
                        <span></span>
                    </label>
                    <label class="custom-checkbox">
                        <input type="checkbox" name="condition" value="95" <%= conditionList != null && conditionList.contains("95") ? "checked" : "" %> onchange="this.form.submit()"> 95% (Trầy xước vừa)
                        <span></span>
                    </label>
                    <label class="custom-checkbox">
                        <input type="checkbox" name="condition" value="90" <%= conditionList != null && conditionList.contains("90") ? "checked" : "" %> onchange="this.form.submit()"> 90% (Trầy xước nhiều)
                        <span></span>
                    </label>
                </div>

                <div class="filter-group">
                    <h4>Bộ nhớ trong</h4>
                    <label class="custom-checkbox">
                        <input type="checkbox" name="storage" value="64GB" <%= storageList != null && storageList.contains("64GB") ? "checked" : "" %> onchange="this.form.submit()"> 64GB
                        <span></span>
                    </label>
                    <label class="custom-checkbox">
                        <input type="checkbox" name="storage" value="128GB" <%= storageList != null && storageList.contains("128GB") ? "checked" : "" %> onchange="this.form.submit()"> 128GB
                        <span></span>
                    </label>
                    <label class="custom-checkbox">
                        <input type="checkbox" name="storage" value="256GB" <%= storageList != null && storageList.contains("256GB") ? "checked" : "" %> onchange="this.form.submit()"> 256GB
                        <span></span>
                    </label>
                    <label class="custom-checkbox">
                        <input type="checkbox" name="storage" value="512GB" <%= storageList != null && storageList.contains("512GB") ? "checked" : "" %> onchange="this.form.submit()"> 512GB
                        <span></span>
                    </label>
                    <label class="custom-checkbox">
                        <input type="checkbox" name="storage" value="1TB" <%= storageList != null && storageList.contains("1TB") ? "checked" : "" %> onchange="this.form.submit()"> 1TB
                        <span></span>
                    </label>
                </div>
                
                <!-- Hidden fields để giữ giá trị brand và sort -->
                <% if (brand != null) { %>
                <input type="hidden" name="brand" value="<%= brand %>">
                <% } %>
                <% if (sortBy != null) { %>
                <input type="hidden" name="sort" value="<%= sortBy %>">
                <% } %>
                
                <div class="filter-actions" style="margin-top: 20px;">
                    <button type="button" onclick="clearFilters()" class="btn btn-secondary">Xóa bộ lọc</button>
                </div>
            </form>
        </aside>

        <!-- Products Grid -->
        <main class="product-grid-container">
            <h1 class="page-title">Điện thoại cũ</h1>
            
            <div class="sorting-options">
                <span>Sắp xếp theo:</span>
                <select name="sort" id="sort" onchange="changeSorting()">
                    <option value="popular" <%= "popular".equals(sortBy) || sortBy == null ? "selected" : "" %>>Phổ biến</option>
                    <option value="price-asc" <%= "price-asc".equals(sortBy) ? "selected" : "" %>>Giá thấp đến cao</option>
                    <option value="price-desc" <%= "price-desc".equals(sortBy) ? "selected" : "" %>>Giá cao đến thấp</option>
                    <option value="newest" <%= "newest".equals(sortBy) ? "selected" : "" %>>Mới nhất</option>
                    <option value="discount" <%= "discount".equals(sortBy) ? "selected" : "" %>>% Giảm</option>
                </select>
            </div>

            <div class="products">
                <%
                    if (usedPhones != null && !usedPhones.isEmpty()) {
                        for (Product product : usedPhones) {
                %>
                <div class="product-item" onclick="window.location.href='product-detail.jsp?id=<%= product.getMaSP() %>'">
                    <% if (product.getTinhTrangCu() != null) { %>
                    <div class="condition-badge"><%= product.getTinhTrangCu() %>%</div>
                    <% } %>
                    
                    <img src="resources/images/<%= product.getHinhAnh() != null ? product.getHinhAnh() : "default-phone.jpg" %>" 
                         alt="<%= product.getTenSP() %>" class="product-image">
                    
                    <h3><%= product.getTenSP() %> <%= product.getConditionText() %></h3>
                    
                    <div class="price-container">
                        <p class="price"><%= formatter.format(product.getGia()) %>₫</p>
                        <% if (product.getGiaGoc() != null && product.getGiaGoc().compareTo(product.getGia()) > 0) { %>
                        <span class="original-price"><%= formatter.format(product.getGiaGoc()) %>₫</span>
                        <% } %>
                    </div>
                    
                    <% if (product.getTextKhuyenMai() != null) { %>
                    <span class="promo-tag"><%= product.getTextKhuyenMai() %></span>
                    <% } %>
                    
                    <!-- Thông tin cấu hình -->
                    <div class="product-specs" style="font-size: 12px; color: #666; margin-top: 5px; text-align: left;">
                        <% if (product.getRam() != null || product.getBoNhoTrong() != null) { %>
                        <div>
                            <% if (product.getRam() != null) { %>
                            RAM: <%= product.getRam() %>
                            <% } %>
                            <% if (product.getBoNhoTrong() != null) { %>
                            | Bộ nhớ: <%= product.getBoNhoTrong() %>
                            <% } %>
                        </div>
                        <% } %>
                        <% if (product.getDungLuongPin() != null) { %>
                        <div>Pin: <%= product.getDungLuongPin() %></div>
                        <% } %>
                    </div>
                    
                    <div class="compare">
                        <label class="custom-checkbox-small">
                            <input type="checkbox" onclick="event.stopPropagation()" data-product-id="<%= product.getMaSP() %>"> So sánh
                            <span></span>
                        </label>
                    </div>
                </div>
                <%
                        }
                    } else {
                %>
                <div class="no-products" style="grid-column: 1/-1; text-align: center; padding: 50px;">
                    <h3>Không tìm thấy sản phẩm nào phù hợp với bộ lọc của bạn</h3>
                    <p>Vui lòng thử lại với các tiêu chí khác</p>
                </div>
                <%
                    }
                %>
            </div>
            
            <!-- Pagination -->
            <% if (totalPages > 1) { %>
            <div class="pagination">
                <% if (page > 1) { %>
                <a href="?page=<%= page - 1 %><%= getQueryString(request, "page") %>">&laquo; Trước</a>
                <% } %>
                
                <% 
                    int startPage = Math.max(1, page - 2);
                    int endPage = Math.min(totalPages, page + 2);
                    
                    if (startPage > 1) {
                %>
                <a href="?page=1<%= getQueryString(request, "page") %>">1</a>
                <% if (startPage > 2) { %>
                <span>...</span>
                <% } %>
                <% } %>
                
                <% for (int i = startPage; i <= endPage; i++) { %>
                <% if (i == page) { %>
                <span class="current"><%= i %></span>
                <% } else { %>
                <a href="?page=<%= i %><%= getQueryString(request, "page") %>"><%= i %></a>
                <% } %>
                <% } %>
                
                <% 
                    if (endPage < totalPages) {
                        if (endPage < totalPages - 1) {
                %>
                <span>...</span>
                <% } %>
                <a href="?page=<%= totalPages %><%= getQueryString(request, "page") %>"><%= totalPages %></a>
                <% } %>
                
                <% if (page < totalPages) { %>
                <a href="?page=<%= page + 1 %><%= getQueryString(request, "page") %>">Sau &raquo;</a>
                <% } %>
            </div>
            <% } %>
            
            <!-- Load More Button (Alternative to pagination) -->
            <div class="load-more-container" style="text-align: center; margin-top: 20px;">
                <p>Hiển thị <%= Math.min((page * limit), totalProducts) %> trong <%= totalProducts %> sản phẩm</p>
            </div>
        </main>
    </div>

    <!-- Footer -->
    <footer>
        <div class="footer-content">
            <div class="footer-section">
                <div class="footer-logo">KT</div>
                <p>GIỚI THIỆU VỀ CÔNG TY</p>
                <p>CÂU HỎI THƯỜNG GẶP</p>
                <p>CHÍNH SÁCH BẢO MẬT</p>
                <p>QUY CHẾ HOẠT ĐỘNG</p>
            </div>
            
            <div class="footer-section">
                <h3>KIỂM TRA HÓA ĐƠN ĐIỆN TỬ</h3>
                <a href="#">TRA CỨU THÔNG TIN BẢO HÀNH</a>
                <a href="#">TIN TUYỂN DỤNG</a>
                <a href="#">TIN KHUYẾN MÃI</a>
                <a href="#">HƯỚNG DẪN ONLINE</a>
            </div>
            
            <div class="footer-section">
                <h3>HỆ THỐNG CỬA HÀNG</h3>
                <a href="#">HỆ THỐNG BẢO HÀNH</a>
                <a href="#">KIỂM TRA HÀNG APPLE CHÍNH HÃNG</a>
                <a href="#">GIỚI THIỆU ĐỔI MÁY</a>
                <a href="#">CHÍNH SÁCH ĐỔI TRẢ</a>
            </div>
            
            <div class="footer-section social-media">
                <h3>SOCIAL MEDIA</h3>
                <div class="social-icons">
                    <a href="#">f</a>
                    <a href="#">G</a>
                </div>
            </div>
        </div>
    </footer>

    <%!
        // Helper method để tạo query string cho pagination
        public String getQueryString(HttpServletRequest request, String excludeParam) {
            StringBuilder queryString = new StringBuilder();
            java.util.Enumeration<String> paramNames = request.getParameterNames();
            
            while (paramNames.hasMoreElements()) {
                String paramName = paramNames.nextElement();
                if (!paramName.equals(excludeParam)) {
                    String[] paramValues = request.getParameterValues(paramName);
                    for (String paramValue : paramValues) {
                        queryString.append("&").append(paramName).append("=").append(paramValue);
                    }
                }
            }
            
            return queryString.toString();
        }
    %>

    <script>
        function filterByBrand(brandName) {
            const form = document.getElementById('filterForm');
            let brandInput = form.querySelector('input[name="brand"]');
            
            if (!brandInput) {
                brandInput = document.createElement('input');
                brandInput.type = 'hidden';
                brandInput.name = 'brand';
                form.appendChild(brandInput);
            }
            
            brandInput.value = brandName;
            form.submit();
        }
        
        function changeSorting() {
            const sortSelect = document.getElementById('sort');
            const form = document.getElementById('filterForm');
            let sortInput = form.querySelector('input[name="sort"]');
            
            if (!sortInput) {
                sortInput = document.createElement('input');
                sortInput.type = 'hidden';
                sortInput.name = 'sort';
                form.appendChild(sortInput);
            }
            
            sortInput.value = sortSelect.value;
            form.submit();
        }
        
        function clearFilters() {
            window.location.href = 'used-phones.jsp';
        }
        
        // Compare functionality
        let compareList = [];
        
        document.addEventListener('change', function(e) {
            if (e.target.type === 'checkbox' && e.target.dataset.productId) {
                const productId = e.target.dataset.productId;
                
                if (e.target.checked) {
                    if (compareList.length < 3) {
                        compareList.push(productId);
                    } else {
                        alert('Chỉ có thể so sánh tối đa 3 sản phẩm');
                        e.target.checked = false;
                    }
                } else {
                    compareList = compareList.filter(id => id !== productId);
                }
                
                updateCompareButton();
            }
        });
        
        function updateCompareButton() {
            let compareButton = document.querySelector('.compare-button');
            
            if (compareList.length > 0) {
                if (!compareButton) {
                    compareButton = document.createElement('div');
                    compareButton.className = 'compare-button';
                    compareButton.innerHTML = `
                        <button onclick="goToCompare()" style="position: fixed; bottom: 20px; right: 20px; background: #3498db; color: white; padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer; z-index: 1000;">
                            So sánh (${compareList.length})
                        </button>
                    `;
                    document.body.appendChild(compareButton);
                } else {
                    compareButton.querySelector('button').innerHTML = `So sánh (${compareList.length})`;
                }
            } else if (compareButton) {
                compareButton.remove();
            }
        }
        
        function goToCompare() {
            if (compareList.length >= 2) {
                window.location.href = `compare.jsp?products=${compareList.join(',')}`;
            } else {
                alert('Vui lòng chọn ít nhất 2 sản phẩm để so sánh');
            }
        }
    </script>
    
    <script src="resources/js/script.js"></script>
</body>
</html>
<!-- Sidebar Filters -->
        <aside class="sidebar">
            <form method="get" action="used-phones.jsp" id="filterForm">
                <div class="filter-group">
                    <h4>Lựa chọn hãng</h4>
                    <div class="brand-logos">
                        <%
                            for (String brand : brands) {
                                String logoFile = brand.toLowerCase() + "-logo.png";
                        %>
                        <img src="resources/images/<%= logoFile %>" alt="<%= brand %>" 
                             onclick="filterByBrand('<%= brand %>')"
                             style="cursor: pointer; <%= brand.equals(brandName) ? "border: 2px solid #3498db;" : "" %>"
                             title="<%= brand %>">
                        <%
                            }
                        %>
                    </div>
                </div>

                <div class="filter-group">
                    <h4>Mức giá</h4>
                    <label class="custom-radio">
                        <input type="radio" name="price" value="2-4" <%= "2-4".equals(priceRange) ? "checked" : "" %> onchange="this.form.submit()"> Từ 2 - 4 triệu
                        <span></span>
                    </label>
                    <label class="custom-radio">
                        <input type="radio" name="price" value="4-7" <%= "4-7".equals(priceRange) ? "checked" : "" %> onchange="this.form.submit()"> Từ 4 - 7 triệu
                        <span></span>
                    </label>
                    <label class="custom-radio">
                        <input type="radio" name="price" value="7-13" <%= "7-13".equals(priceRange) ? "checked" : "" %> onchange="this.form.submit()"> Từ 7 - 13 triệu
                        <span></span>
                    </label>
                    <label class="custom-radio">
                        <input type="radio" name="price" value="13-20" <%= "13-20".equals(priceRange) ? "checked" : "" %> onchange="this.form.submit()"> Từ 13 - 20 triệu
                        <span></span>
                    </label>
                    <label class="custom-radio">
                        <input type="radio" name="price" value="20+" <%= "20+".equals(priceRange) ? "checked" : "" %> onchange="this.form.submit()"> Trên 20 triệu
                        <span></span>
                    </label>
                </div>

                <!-- Hidden fields để giữ giá trị brand và sort -->
                <% if (brandName != null) { %>
                <input type="hidden" name="brand" value="<%= brandName %>">
                <% } %>
                <% if (sortBy != null) { %>
                <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.ProductDAO" %>
<%@ page import="model.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>

<%
    ProductDAO productDAO = new ProductDAO();
    NumberFormat formatter = NumberFormat.getInstance(new Locale("vi", "VN"));
    
    // Lấy các tham số lọc từ request
    String brandName = request.getParameter("brand");
    String priceRange = request.getParameter("price");
    String sortBy = request.getParameter("sort");
    
    // Convert brand name to ID
    Integer brandId = null;
    if (brandName != null && !brandName.isEmpty()) {
        brandId = productDAO.getBrandIdByName(brandName);
    }
    
    // Phân trang
    int page = 1;
    int limit = 12;
    try {
        page = Integer.parseInt(request.getParameter("page") != null ? request.getParameter("page") : "1");
    } catch (NumberFormatException e) {
        page = 1;
    }
    int offset = (page - 1) * limit;
    
    // Lấy danh sách sản phẩm
    List<Product> usedPhones = productDAO.getUsedPhonesByFilters(brandId, priceRange, sortBy, limit, offset);
    
    // Lấy tổng số sản phẩm để tính phân trang
    int totalProducts = productDAO.getTotalUsedPhonesCount();
    int totalPages = (int) Math.ceil((double) totalProducts / limit);
    
    // Lấy danh sách hãng
    List<String> brands = productDAO.getAllBrands();
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Điện Thoại Cũ - KT Store</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="resources/css/used-phones.css">
    <style>
        .product-item {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 15px;
            margin: 10px;
            background: white;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            cursor: pointer;
            transition: transform 0.2s;
            text-align: center;
        }
        .product-item:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }
        .product-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 5px;
            margin-bottom: 10px;
        }
        .condition-badge {
            position: absolute;
            top: 10px;
            right: 10px;
            background: #27ae60;
            color: white;
            padding: 2px 6px;
            border-radius: 3px;
            font-size: 11px;
            font-weight: bold;
        }
        .price {
            color: #e74c3c;
            font-weight: bold;
            font-size: 18px;
            margin: 10px 0;
        }
        .original-price {
            text-decoration: line-through;
            color: #999;
            font-size: 14px;
            margin-left: 10px;
        }
        .promo-tag {
            background: #f39c12;
            color: white;
            padding: 3px 8px;
            border-radius: 3px;
            font-size: 11px;
            margin-top: 5px;
            display: inline-block;
        }
        .pagination {
            text-align: center;
            margin: 20px 0;
        }
        .pagination a, .pagination .current {
            display: inline-block;
            padding: 8px 16px;
            margin: 0 4px;
            border: 1px solid #ddd;
            color: #333;
            text-decoration: none;
            border-radius: 4px;
        }
        .pagination .current {
            background-color: #3498db;
            color: white;
            border-color: #3498db;
        }
        .pagination a:hover {
            background-color: #f5f5f5;
        }
        .filter-active {
            background-color: #3498db !important;
            color: white !important;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header>
        <div class="header-left">
            <i class="fa-solid fa-bars menu-icon"></i>
            <div class="logo">KT</div>
        </div>
        <div class="header-center">
            <div class="search-container">
                <form action="search.jsp" method="get">
                    <input type="text" name="q" placeholder="Tìm kiếm sản phẩm..." class="search-bar">
                    <button type="submit" class="search-button"><i class="fa-solid fa-magnifying-glass"></i></button>
                </form>
            </div>
        </div>
        <div class="header-right">
            <a href="cart.jsp" class="icon-link"><i class="fa-solid fa-cart-shopping"></i><span>Giỏ hàng</span></a>
            <a href="wishlist.jsp" class="icon-link"><i class="fa-solid fa-heart"></i><span>Yêu thích</span></a>
            <a href="login.jsp" class="icon-link"><i class="fa-solid fa-user"></i><span>USER 1</span></a>
        </div>
    </header>

    <!-- Navigation -->
    <nav>
        <div class="nav-container">
            <button class="menu-toggle">
                ☰ DANH<br>MỤC
            </button>
            <ul class="nav-links">
                <li><a href="new-phones.jsp">ĐIỆN THOẠI MỚI ▼</a></li>
                <li><a href="used-phones.jsp" class="active">ĐIỆN THOẠI CŨ ▼</a></li>
                <li><a href="repair.jsp">THU ĐIỆN THOẠI</a></li>
                <li><a href="appointment.jsp">SỬA CHỮA</a></li>
            </ul>
        </div>
    </nav>

    <!-- Breadcrumb -->
    <div class="breadcrumb">
        <a href="index.jsp">Trang chủ</a>
        <span> › Điện thoại cũ</span>
    </div>

    <div class="main-container">
        <!-- Sidebar Filters -->
        <aside class="sidebar">
            <form method="get" action="used-phones.jsp" id="filterForm">
                <div class="filter-group">
                    <h4>Lựa chọn hãng</h4>
                    <div class="brand-logos">
                        <%
                            for (String brandName : brands) {
                                String logoFile = brandName.toLowerCase() + "-logo.png";
                        %>
                        <img src="resources/images/<%= logoFile %>" alt="<%= brandName %>" 
                             onclick="filterByBrand('<%= brandName %>')"
                             style="cursor: pointer; <%= brandName.equals(brand) ? "border: 2px solid #3498db;" : "" %>"
                             title="<%= brandName %>">
                        <%
                            }
                        %>
                    </div>
                </div>

                <div class="filter-group">
                    <h4>Mức giá</h4>
                    <label class="custom-radio">
                        <input type="radio" name="price" value="2-4" <%= "2-4".equals(priceRange) ? "checked" : "" %> onchange="this.form.submit()"> Từ 2 - 4 triệu
                        <span></span>
                    </label>
                    <label class="custom-radio">
                        <input type="radio" name="price" value="4-7" <%= "4-7".equals(priceRange) ? "checked" : "" %> onchange="this.form.submit()"> Từ 4 - 7 triệu
                        <span></span>
                    </label>
                    <label class="custom-radio">
                        <input type="radio" name="price" value="7-13" <%= "7-13".equals(priceRange) ? "checked" : "" %> onchange="this.form.submit()"> Từ 7 - 13 triệu
                        <span></span>
                    </label>
                    <label class="custom-radio">
                        <input type="radio" name="price" value="13-20" <%= "13-20".equals(priceRange) ? "checked" : "" %> onchange="this.form.submit()"> Từ 13 - 20 triệu
                        <span></span>
                    </label>
                    <label class="custom-radio">
                        <input type="radio" name="price" value="20+" <%= "20+".equals(priceRange) ? "checked" : "" %> onchange="this.form.submit()"> Trên 20 triệu
                        <span></span>
                    </label>
                </div>

                <div class="filter-group">
                    <h4>Tình trạng (máy cũ)</h4>
                    <label class="custom-checkbox">
                        <input type="checkbox" name="condition" value="99" <%= conditionList != null && conditionList.contains("99") ? "checked" : "" %> onchange="this.form.submit()"> 99% (Như mới)
                        <span></span>
                    </label>
                    <label class="custom-checkbox">
                        <input type="checkbox" name="condition" value="98" <%= conditionList != null && conditionList.contains("98") ? "checked" : "" %> onchange="this.form.submit()"> 98% (Trầy xước nhẹ)
                        <span></span>
                    </label>
                    <label class="custom-checkbox">
                        <input type="checkbox" name="condition" value="95" <%= conditionList != null && conditionList.contains("95") ? "checked" : "" %> onchange="this.form.submit()"> 95% (Trầy xước vừa)
                        <span></span>
                    </label>
                    <label class="custom-checkbox">
                        <input type="checkbox" name="condition" value="90" <%= conditionList != null && conditionList.contains("90") ? "checked" : "" %> onchange="this.form.submit()"> 90% (Trầy xước nhiều)
                        <span></span>
                    </label>
                </div>

                <div class="filter-group">
                    <h4>Bộ nhớ trong</h4>
                    <label class="custom-checkbox">
                        <input type="checkbox" name="storage" value="64GB" <%= storageList != null && storageList.contains("64GB") ? "checked" : "" %> onchange="this.form.submit()"> 64GB
                        <span></span>
                    </label>
                    <label class="custom-checkbox">
                        <input type="checkbox" name="storage" value="128GB" <%= storageList != null && storageList.contains("128GB") ? "checked" : "" %> onchange="this.form.submit()"> 128GB
                        <span></span>
                    </label>
                    <label class="custom-checkbox">
                        <input type="checkbox" name="storage" value="256GB" <%= storageList != null && storageList.contains("256GB") ? "checked" : "" %> onchange="this.form.submit()"> 256GB
                        <span></span>
                    </label>
                    <label class="custom-checkbox">
                        <input type="checkbox" name="storage" value="512GB" <%= storageList != null && storageList.contains("512GB") ? "checked" : "" %> onchange="this.form.submit()"> 512GB
                        <span></span>
                    </label>
                    <label class="custom-checkbox">
                        <input type="checkbox" name="storage" value="1TB" <%= storageList != null && storageList.contains("1TB") ? "checked" : "" %> onchange="this.form.submit()"> 1TB
                        <span></span>
                    </label>
                </div>
                
                <!-- Hidden fields để giữ giá trị brand và sort -->
                <% if (brand != null) { %>
                <input type="hidden" name="brand" value="<%= brand %>">
                <% } %>
                <% if (sortBy != null) { %>
                <input type="hidden" name="sort" value="<%= sortBy %>">
                <% } %>
                
                <div class="filter-actions" style="margin-top: 20px;">
                    <button type="button" onclick="clearFilters()" class="btn btn-secondary">Xóa bộ lọc</button>
                </div>
            </form>
        </aside>

        <!-- Products Grid -->
        <main class="product-grid-container">
            <h1 class="page-title">Điện thoại cũ</h1>
            
            <div class="sorting-options">
                <span>Sắp xếp theo:</span>
                <select name="sort" id="sort" onchange="changeSorting()">
                    <option value="popular" <%= "popular".equals(sortBy) || sortBy == null ? "selected" : "" %>>Phổ biến</option>
                    <option value="price-asc" <%= "price-asc".equals(sortBy) ? "selected" : "" %>>Giá thấp đến cao</option>
                    <option value="price-desc" <%= "price-desc".equals(sortBy) ? "selected" : "" %>>Giá cao đến thấp</option>
                    <option value="newest" <%= "newest".equals(sortBy) ? "selected" : "" %>>Mới nhất</option>
                    <option value="discount" <%= "discount".equals(sortBy) ? "selected" : "" %>>% Giảm</option>
                </select>
            </div>

            <div class="products">
                <%
                    if (usedPhones != null && !usedPhones.isEmpty()) {
                        for (Product product : usedPhones) {
                %>
                <div class="product-item" onclick="window.location.href='product-detail.jsp?id=<%= product.getMaSP() %>'">
                    <% if (product.getTinhTrangCu() != null) { %>
                    <div class="condition-badge"><%= product.getTinhTrangCu() %>%</div>
                    <% } %>
                    
                    <img src="resources/images/<%= product.getHinhAnh() != null ? product.getHinhAnh() : "default-phone.jpg" %>" 
                         alt="<%= product.getTenSP() %>" class="product-image">
                    
                    <h3><%= product.getTenSP() %> <%= product.getConditionText() %></h3>
                    
                    <div class="price-container">
                        <p class="price"><%= formatter.format(product.getGia()) %>₫</p>
                        <% if (product.getGiaGoc() != null && product.getGiaGoc().compareTo(product.getGia()) > 0) { %>
                        <span class="original-price"><%= formatter.format(product.getGiaGoc()) %>₫</span>
                        <% } %>
                    </div>
                    
                    <% if (product.getTextKhuyenMai() != null) { %>
                    <span class="promo-tag"><%= product.getTextKhuyenMai() %></span>
                    <% } %>
                    
                    <!-- Thông tin cấu hình -->
                    <div class="product-specs" style="font-size: 12px; color: #666; margin-top: 5px; text-align: left;">
                        <% if (product.getRam() != null || product.getBoNhoTrong() != null) { %>
                        <div>
                            <% if (product.getRam() != null) { %>
                            RAM: <%= product.getRam() %>
                            <% } %>
                            <% if (product.getBoNhoTrong() != null) { %>
                            | Bộ nhớ: <%= product.getBoNhoTrong() %>
                            <% } %>
                        </div>
                        <% } %>
                        <% if (product.getDungLuongPin() != null) { %>
                        <div>Pin: <%= product.getDungLuongPin() %></div>
                        <% } %>
                    </div>
                    
                    <div class="compare">
                        <label class="custom-checkbox-small">
                            <input type="checkbox" onclick="event.stopPropagation()" data-product-id="<%= product.getMaSP() %>"> So sánh
                            <span></span>
                        </label>
                    </div>
                </div>
                <%
                        }
                    } else {
                %>
                <div class="no-products" style="grid-column: 1/-1; text-align: center; padding: 50px;">
                    <h3>Không tìm thấy sản phẩm nào phù hợp với bộ lọc của bạn</h3>
                    <p>Vui lòng thử lại với các tiêu chí khác</p>
                </div>
                <%
                    }
                %>
            </div>
            
            <!-- Pagination -->
            <% if (totalPages > 1) { %>
            <div class="pagination">
                <% if (page > 1) { %>
                <a href="?page=<%= page - 1 %><%= getQueryString(request, "page") %>">&laquo; Trước</a>
                <% } %>
                
                <% 
                    int startPage = Math.max(1, page - 2);
                    int endPage = Math.min(totalPages, page + 2);
                    
                    if (startPage > 1) {
                %>
                <a href="?page=1<%= getQueryString(request, "page") %>">1</a>
                <% if (startPage > 2) { %>
                <span>...</span>
                <% } %>
                <% } %>
                
                <% for (int i = startPage; i <= endPage; i++) { %>
                <% if (i == page) { %>
                <span class="current"><%= i %></span>
                <% } else { %>
                <a href="?page=<%= i %><%= getQueryString(request, "page") %>"><%= i %></a>
                <% } %>
                <% } %>
                
                <% 
                    if (endPage < totalPages) {
                        if (endPage < totalPages - 1) {
                %>
                <span>...</span>
                <% } %>
                <a href="?page=<%= totalPages %><%= getQueryString(request, "page") %>"><%= totalPages %></a>
                <% } %>
                
                <% if (page < totalPages) { %>
                <a href="?page=<%= page + 1 %><%= getQueryString(request, "page") %>">Sau &raquo;</a>
                <% } %>
            </div>
            <% } %>
            
            <!-- Load More Button (Alternative to pagination) -->
            <div class="load-more-container" style="text-align: center; margin-top: 20px;">
                <p>Hiển thị <%= Math.min((page * limit), totalProducts) %> trong <%= totalProducts %> sản phẩm</p>
            </div>
        </main>
    </div>

    <!-- Footer -->
    <footer>
        <div class="footer-content">
            <div class="footer-section">
                <div class="footer-logo">KT</div>
                <p>GIỚI THIỆU VỀ CÔNG TY</p>
                <p>CÂU HỎI THƯỜNG GẶP</p>
                <p>CHÍNH SÁCH BẢO MẬT</p>
                <p>QUY CHẾ HOẠT ĐỘNG</p>
            </div>
            
            <div class="footer-section">
                <h3>KIỂM TRA HÓA ĐƠN ĐIỆN TỬ</h3>
                <a href="#">TRA CỨU THÔNG TIN BẢO HÀNH</a>
                <a href="#">TIN TUYỂN DỤNG</a>
                <a href="#">TIN KHUYẾN MÃI</a>
                <a href="#">HƯỚNG DẪN ONLINE</a>
            </div>
            
            <div class="footer-section">
                <h3>HỆ THỐNG CỬA HÀNG</h3>
                <a href="#">HỆ THỐNG BẢO HÀNH</a>
                <a href="#">KIỂM TRA HÀNG APPLE CHÍNH HÃNG</a>
                <a href="#">GIỚI THIỆU ĐỔI MÁY</a>
                <a href="#">CHÍNH SÁCH ĐỔI TRẢ</a>
            </div>
            
            <div class="footer-section social-media">
                <h3>SOCIAL MEDIA</h3>
                <div class="social-icons">
                    <a href="#">f</a>
                    <a href="#">G</a>
                </div>
            </div>
        </div>
    </footer>

    <%!
        // Helper method để tạo query string cho pagination
        public String getQueryString(HttpServletRequest request, String excludeParam) {
            StringBuilder queryString = new StringBuilder();
            java.util.Enumeration<String> paramNames = request.getParameterNames();
            
            while (paramNames.hasMoreElements()) {
                String paramName = paramNames.nextElement();
                if (!paramName.equals(excludeParam)) {
                    String[] paramValues = request.getParameterValues(paramName);
                    for (String paramValue : paramValues) {
                        queryString.append("&").append(paramName).append("=").append(paramValue);
                    }
                }
            }
            
            return queryString.toString();
        }
    %>

    <script>
        function filterByBrand(brandName) {
            const form = document.getElementById('filterForm');
            let brandInput = form.querySelector('input[name="brand"]');
            
            if (!brandInput) {
                brandInput = document.createElement('input');
                brandInput.type = 'hidden';
                brandInput.name = 'brand';
                form.appendChild(brandInput);
            }
            
            brandInput.value = brandName;
            form.submit();
        }
        
        function changeSorting() {
            const sortSelect = document.getElementById('sort');
            const form = document.getElementById('filterForm');
            let sortInput = form.querySelector('input[name="sort"]');
            
            if (!sortInput) {
                sortInput = document.createElement('input');
                sortInput.type = 'hidden';
                sortInput.name = 'sort';
                form.appendChild(sortInput);
            }
            
            sortInput.value = sortSelect.value;
            form.submit();
        }
        
        function clearFilters() {
            window.location.href = 'used-phones.jsp';
        }
        
        // Compare functionality
        let compareList = [];
        
        document.addEventListener('change', function(e) {
            if (e.target.type === 'checkbox' && e.target.dataset.productId) {
                const productId = e.target.dataset.productId;
                
                if (e.target.checked) {
                    if (compareList.length < 3) {
                        compareList.push(productId);
                    } else {
                        alert('Chỉ có thể so sánh tối đa 3 sản phẩm');
                        e.target.checked = false;
                    }
                } else {
                    compareList = compareList.filter(id => id !== productId);
                }
                
                updateCompareButton();
            }
        });
        
        function updateCompareButton() {
            let compareButton = document.querySelector('.compare-button');
            
            if (compareList.length > 0) {
                if (!compareButton) {
                    compareButton = document.createElement('div');
                    compareButton.className = 'compare-button';
                    compareButton.innerHTML = `
                        <button onclick="goToCompare()" style="position: fixed; bottom: 20px; right: 20px; background: #3498db; color: white; padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer; z-index: 1000;">
                            So sánh (${compareList.length})
                        </button>
                    `;
                    document.body.appendChild(compareButton);
                } else {
                    compareButton.querySelector('button').innerHTML = `So sánh (${compareList.length})`;
                }
            } else if (compareButton) {
                compareButton.remove();
            }
        }
        
        function goToCompare() {
            if (compareList.length >= 2) {
                window.location.href = `compare.jsp?products=${compareList.join(',')}`;
            } else {
                alert('Vui lòng chọn ít nhất 2 sản phẩm để so sánh');
            }
        }
    </script>
    
    <script src="resources/js/script.js"></script>
</body>
</html>