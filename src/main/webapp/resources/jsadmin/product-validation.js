
function validateProductForm() {
    var form = document.forms["productForm"];
    var tenSP = form["tenSP"].value;
    var maDanhMuc = form["maDanhMuc"].value;
    var tinhTrang = form["tinhTrang"].value;
    var gia = form["gia"].value;
    var soLuong = form["soLuong"].value;

    if (!tenSP || tenSP.trim() === "") {
        alert("Tên sản phẩm không được để trống");
        return false;
    }
    if (!maDanhMuc || maDanhMuc.trim() === "" || isNaN(maDanhMuc) || parseInt(maDanhMuc) <= 0) {
        alert("Mã danh mục phải là số nguyên lớn hơn 0");
        return false;
    }
    if (!tinhTrang || !["Moi", "Cu"].includes(tinhTrang)) {
        alert("Tình trạng phải là 'Mới' hoặc 'Cũ'");
        return false;
    }
    if (!gia || gia.trim() === "" || isNaN(gia) || parseFloat(gia) <= 0) {
        alert("Giá phải là số lớn hơn 0");
        return false;
    }
    if (!soLuong || soLuong.trim() === "" || isNaN(soLuong) || parseInt(soLuong) < 0) {
        alert("Số lượng phải là số không âm");
        return false;
    }
    return true;
}
