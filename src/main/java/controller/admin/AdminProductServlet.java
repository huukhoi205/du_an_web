package controller.admin;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.nio.file.Paths;
import java.util.List;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import model.admin.Product;
import service.admin.ProductService;
import service.admin.BrandService;

@WebServlet(name = "AdminProductServlet", urlPatterns = "/admin/product/*")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,
    maxFileSize = 1024 * 1024 * 10,
    maxRequestSize = 1024 * 1024 * 50
)
public class AdminProductServlet extends HttpServlet {
    private ProductService productService = new ProductService();
    private BrandService brandService = new BrandService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        String action = request.getPathInfo();
        if (action == null) action = "/list";

        try {
            switch (action) {
                case "/list":
                    listProducts(request, response);
                    break;
                case "/add":
                    showAddForm(request, response);
                    break;
                case "/edit":
                    showEditForm(request, response);
                    break;
                case "/delete":
                    deleteProduct(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            handleError(request, response, e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        String action = request.getPathInfo();
        if (action == null) action = "/list";

        try {
            switch (action) {
                case "/add":
                    addProduct(request, response);
                    break;
                case "/edit":
                    updateProduct(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            handleError(request, response, e);
        }
    }
    private void listProducts(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        // Lấy tham số tìm kiếm
        String keyword = request.getParameter("keyword");
        String maHangStr = request.getParameter("maHang");
        String tinhTrang = request.getParameter("tinhTrang");
        
        Integer maHang = null;
        if (maHangStr != null && !maHangStr.trim().isEmpty()) {
            try {
                maHang = Integer.parseInt(maHangStr.trim());
            } catch (NumberFormatException e) {
                // Bỏ qua nếu không phải số hợp lệ
            }
        }

        // Phân trang
        int pageSize = 10;
        int page = 1;
        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
                if (page < 1) page = 1;
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        int offset = (page - 1) * pageSize;

        // Đếm tổng số sản phẩm phù hợp
        int totalProducts = productService.countProducts(keyword, maHang, tinhTrang);
        int totalPages = (int) Math.ceil(totalProducts / (double) pageSize);
        if (page > totalPages && totalPages > 0) {
            page = totalPages;
            offset = (page - 1) * pageSize;
        }

        // Lấy danh sách sản phẩm theo trang
        List<Product> productList = productService.searchProducts(keyword, maHang, tinhTrang, pageSize, offset, null);

        request.setAttribute("productList", productList);
        request.setAttribute("brands", brandService.getAllBrands());
        request.setAttribute("keyword", keyword);
        request.setAttribute("selectedMaHang", maHang);
        request.setAttribute("selectedTinhTrang", tinhTrang);
        request.setAttribute("page", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalProducts", totalProducts);

        request.getRequestDispatcher("/admin/admin-product-list.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        request.setAttribute("brands", brandService.getAllBrands());
        request.getRequestDispatcher("/admin/admin-product-add.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String maSPStr = request.getParameter("maSP");
        if (maSPStr == null || maSPStr.trim().isEmpty()) {
            setErrorMessage(request, "Mã sản phẩm không được để trống");
            response.sendRedirect(request.getContextPath() + "/admin/product/list");
            return;
        }
        try {
            int maSP = Integer.parseInt(maSPStr.trim());
            Product product = productService.getProductById(maSP);
            if (product == null) {
                setErrorMessage(request, "Sản phẩm không tồn tại");
                response.sendRedirect(request.getContextPath() + "/admin/product/list");
                return;
            }
            request.setAttribute("product", product);
            request.setAttribute("brands", brandService.getAllBrands());
            request.getRequestDispatcher("/admin/admin-product-edit.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            setErrorMessage(request, "Mã sản phẩm không hợp lệ: " + maSPStr);
            response.sendRedirect(request.getContextPath() + "/admin/product/list");
        }
    }

    private void addProduct(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        Product product = extractPartialProductFromRequest(request, null, 0);
        productService.addProduct(product);
        setSuccessMessage(request, "Thêm sản phẩm thành công");
        response.sendRedirect(request.getContextPath() + "/admin/product/list");
    }

    private void updateProduct(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String maSPStr = request.getParameter("maSP");
        
        if (maSPStr == null || maSPStr.trim().isEmpty()) {
            setErrorMessage(request, "Mã sản phẩm không được để trống");
            response.sendRedirect(request.getContextPath() + "/admin/product/list");
            return;
        }
        
        try {
            int maSP = Integer.parseInt(maSPStr.trim());
            Product existing = productService.getProductById(maSP);
            if (existing == null) {
                setErrorMessage(request, "Sản phẩm không tồn tại để cập nhật");
                response.sendRedirect(request.getContextPath() + "/admin/product/list");
                return;
            }
            Product product = extractPartialProductFromRequest(request, existing, maSP);
            productService.updateProduct(product);
            setSuccessMessage(request, "Cập nhật sản phẩm thành công");
            response.sendRedirect(request.getContextPath() + "/admin/product/list");
        } catch (NumberFormatException e) {
            setErrorMessage(request, "Mã sản phẩm không hợp lệ: " + maSPStr);
            response.sendRedirect(request.getContextPath() + "/admin/product/list");
        }
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String maSPStr = request.getParameter("maSP");
        if (maSPStr == null || maSPStr.trim().isEmpty()) {
            setErrorMessage(request, "Mã sản phẩm không được để trống");
            response.sendRedirect(request.getContextPath() + "/admin/product/list");
            return;
        }
        try {
            int maSP = Integer.parseInt(maSPStr.trim());
            productService.deleteProduct(maSP);
            setSuccessMessage(request, "Xóa sản phẩm thành công");
            response.sendRedirect(request.getContextPath() + "/admin/product/list");
        } catch (NumberFormatException e) {
            setErrorMessage(request, "Mã sản phẩm không hợp lệ: " + maSPStr);
            response.sendRedirect(request.getContextPath() + "/admin/product/list");
        }
    }

    private Product extractPartialProductFromRequest(HttpServletRequest request, Product existing, int maSP)
            throws Exception {
        Product product = (existing != null) ? existing : new Product();
        if (maSP > 0) {
            product.setMaSP(maSP);
        }

        String tenSP = request.getParameter("tenSP");
        if (tenSP != null && !tenSP.trim().isEmpty()) {
            product.setTenSP(tenSP.trim());
        } else if (existing == null) {
            throw new IllegalArgumentException("Tên sản phẩm không được để trống");
        }

        String maHangStr = request.getParameter("maHang");
        if (maHangStr != null && !maHangStr.trim().isEmpty()) {
            try {
                int maHang = Integer.parseInt(maHangStr.trim());
                product.setMaHang(maHang);
            } catch (NumberFormatException e) {
                throw new IllegalArgumentException("Hãng sản xuất không hợp lệ: " + maHangStr);
            }
        } else if (existing == null) {
            throw new IllegalArgumentException("Hãng sản xuất không được để trống");
        }

        String tinhTrang = request.getParameter("tinhTrang");
        if (tinhTrang != null && !tinhTrang.trim().isEmpty()) {
            product.setTinhTrang(tinhTrang.trim());
        } else if (existing == null) {
            throw new IllegalArgumentException("Tình trạng không được để trống");
        }

        String giaStr = request.getParameter("gia");
        if (giaStr != null && !giaStr.trim().isEmpty()) {
            try {
                BigDecimal gia = new BigDecimal(giaStr.trim());
                product.setGia(gia);
            } catch (NumberFormatException e) {
                throw new IllegalArgumentException("Giá sản phẩm không hợp lệ: " + giaStr);
            }
        } else if (existing == null) {
            throw new IllegalArgumentException("Giá sản phẩm không được để trống");
        }

        String soLuongStr = request.getParameter("soLuong");
        if (soLuongStr != null && !soLuongStr.trim().isEmpty()) {
            try {
                int soLuong = Integer.parseInt(soLuongStr.trim());
                if (soLuong < 0) {
                    throw new IllegalArgumentException("Số lượng không được âm");
                }
                product.setSoLuong(soLuong);
            } catch (NumberFormatException e) {
                throw new IllegalArgumentException("Số lượng không hợp lệ: " + soLuongStr);
            }
        } else if (existing == null) {
            throw new IllegalArgumentException("Số lượng không được để trống");
        }

        Part filePart = request.getPart("hinhAnhFile");
        if (filePart != null && filePart.getSize() > 0) {
            String originalFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            
            String extension = "";
            int lastDot = originalFileName.lastIndexOf('.');
            if (lastDot > 0) {
                extension = originalFileName.substring(lastDot).toLowerCase();
            }
            
            if (!extension.matches("\\.(jpg|jpeg|png|gif|webp)")) {
                throw new IllegalArgumentException("Chỉ chấp nhận file ảnh (jpg, jpeg, png, gif, webp)");
            }
            
            String fileName = System.currentTimeMillis() + "_" + originalFileName;
            
            String uploadDir = getServletContext().getRealPath("/image");
            File uploadFolder = new File(uploadDir);
            if (!uploadFolder.exists()) uploadFolder.mkdirs();
            
            String uploadPath = uploadDir + File.separator + fileName;
            filePart.write(uploadPath);
            product.setHinhAnh(fileName);
        } else if (existing != null) {
            product.setHinhAnh(existing.getHinhAnh());
        }

        String moTa = request.getParameter("moTa");
        if (moTa != null && !moTa.trim().isEmpty()) product.setMoTa(moTa.trim());

        String manHinh = request.getParameter("manHinh");
        if (manHinh != null && !manHinh.trim().isEmpty()) product.setManHinh(manHinh.trim());

        String cpu = request.getParameter("cpu");
        if (cpu != null && !cpu.trim().isEmpty()) product.setCpu(cpu.trim());

        String gpu = request.getParameter("gpu");
        if (gpu != null && !gpu.trim().isEmpty()) product.setGpu(gpu.trim());

        String ram = request.getParameter("ram");
        if (ram != null && !ram.trim().isEmpty()) product.setRam(ram.trim());

        String boNhoTrong = request.getParameter("boNhoTrong");
        if (boNhoTrong != null && !boNhoTrong.trim().isEmpty()) product.setBoNhoTrong(boNhoTrong.trim());

        String heDieuHanh = request.getParameter("heDieuHanh");
        if (heDieuHanh != null && !heDieuHanh.trim().isEmpty()) product.setHeDieuHanh(heDieuHanh.trim());

        String cameraTruoc = request.getParameter("cameraTruoc");
        if (cameraTruoc != null && !cameraTruoc.trim().isEmpty()) product.setCameraTruoc(cameraTruoc.trim());

        String cameraSau = request.getParameter("cameraSau");
        if (cameraSau != null && !cameraSau.trim().isEmpty()) product.setCameraSau(cameraSau.trim());

        String quayVideo = request.getParameter("quayVideo");
        if (quayVideo != null && !quayVideo.trim().isEmpty()) product.setQuayVideo(quayVideo.trim());

        String dungLuongPin = request.getParameter("dungLuongPin");
        if (dungLuongPin != null && !dungLuongPin.trim().isEmpty()) product.setDungLuongPin(dungLuongPin.trim());

        String sacNhanh = request.getParameter("sacNhanh");
        if (sacNhanh != null && !sacNhanh.trim().isEmpty()) product.setSacNhanh(sacNhanh.trim());

        String sacKhongDay = request.getParameter("sacKhongDay");
        if (sacKhongDay != null && !sacKhongDay.trim().isEmpty()) product.setSacKhongDay(sacKhongDay.trim());

        String sim = request.getParameter("sim");
        if (sim != null && !sim.trim().isEmpty()) product.setSim(sim.trim());

        String wifi = request.getParameter("wifi");
        if (wifi != null && !wifi.trim().isEmpty()) product.setWifi(wifi.trim());

        String bluetooth = request.getParameter("bluetooth");
        if (bluetooth != null && !bluetooth.trim().isEmpty()) product.setBluetooth(bluetooth.trim());

        String gps = request.getParameter("gps");
        if (gps != null && !gps.trim().isEmpty()) product.setGps(gps.trim());

        String chatLieu = request.getParameter("chatLieu");
        if (chatLieu != null && !chatLieu.trim().isEmpty()) product.setChatLieu(chatLieu.trim());

        String kichThuoc = request.getParameter("kichThuoc");
        if (kichThuoc != null && !kichThuoc.trim().isEmpty()) product.setKichThuoc(kichThuoc.trim());

        String trongLuong = request.getParameter("trongLuong");
        if (trongLuong != null && !trongLuong.trim().isEmpty()) product.setTrongLuong(trongLuong.trim());

        String mauSac = request.getParameter("mauSac");
        if (mauSac != null && !mauSac.trim().isEmpty()) product.setMauSac(mauSac.trim());

        return product;
    }

    private void handleError(HttpServletRequest request, HttpServletResponse response, Exception e)
            throws IOException {
        e.printStackTrace();
        System.err.println("Lỗi trong AdminProductServlet: " + e.getMessage());
        setErrorMessage(request, e.getMessage());
        response.sendRedirect(request.getContextPath() + "/admin/product/list");
    }

    private void setSuccessMessage(HttpServletRequest request, String message) {
        HttpSession session = request.getSession();
        session.setAttribute("success", message);
    }

    private void setErrorMessage(HttpServletRequest request, String message) {
        HttpSession session = request.getSession();
        session.setAttribute("error", message);
    }
}
