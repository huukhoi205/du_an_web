package util;

public class ShippingCalculator {
    
    // Phí vận chuyển cho Bình Định (miễn phí)
    public static final double BINH_DINH_SHIPPING_FEE = 0.0;
    
    // Phí vận chuyển cho ngoài tỉnh
    public static final double OUTSIDE_PROVINCE_SHIPPING_FEE = 98990.0;
    
    /**
     * Tính phí vận chuyển dựa trên địa chỉ giao hàng
     * @param deliveryAddress Địa chỉ giao hàng
     * @return Phí vận chuyển
     */
    public static double calculateShippingFee(String deliveryAddress) {
        if (deliveryAddress == null || deliveryAddress.trim().isEmpty()) {
            return 0.0; // Chưa nhập địa chỉ thì phí vận chuyển = 0₫
        }
        
        // Chuyển địa chỉ về chữ thường để so sánh
        String address = deliveryAddress.toLowerCase().trim();
        
        // Kiểm tra các từ khóa liên quan đến Bình Định
        if (address.contains("bình định") || 
            address.contains("binh dinh") ||
            address.contains("quy nhơn") ||
            address.contains("quy nhon") ||
            address.contains("an nhơn") ||
            address.contains("an nhon") ||
            address.contains("hoài nhơn") ||
            address.contains("hoai nhon") ||
            address.contains("phù cát") ||
            address.contains("phu cat") ||
            address.contains("phù mỹ") ||
            address.contains("phu my") ||
            address.contains("tây sơn") ||
            address.contains("tay son") ||
            address.contains("vân canh") ||
            address.contains("van canh") ||
            address.contains("vĩnh thạnh") ||
            address.contains("vinh thanh") ||
            address.contains("tuy phước") ||
            address.contains("tuy phuoc")) {
            return BINH_DINH_SHIPPING_FEE;
        }
        
        // Nếu không phải Bình Định thì tính phí
        return OUTSIDE_PROVINCE_SHIPPING_FEE;
    }
    
    /**
     * Kiểm tra xem địa chỉ có phải Bình Định không
     * @param deliveryAddress Địa chỉ giao hàng
     * @return true nếu là Bình Định, false nếu không
     */
    public static boolean isBinhDinh(String deliveryAddress) {
        return calculateShippingFee(deliveryAddress) == BINH_DINH_SHIPPING_FEE;
    }
    
    /**
     * Lấy thông báo phí vận chuyển
     * @param deliveryAddress Địa chỉ giao hàng
     * @return Thông báo phí vận chuyển
     */
    public static String getShippingMessage(String deliveryAddress) {
        if (deliveryAddress == null || deliveryAddress.trim().isEmpty()) {
            return "Vui lòng nhập địa chỉ để tính phí vận chuyển";
        } else if (isBinhDinh(deliveryAddress)) {
            return "Miễn phí vận chuyển trong tỉnh Bình Định";
        } else {
            return "Phí vận chuyển ngoài tỉnh";
        }
    }
}
