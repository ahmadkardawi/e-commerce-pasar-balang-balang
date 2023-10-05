class CheckOutModels {
  final String? id;
  final String? productId;
  final String? productName;
  final String? productPrice;
  final String? productImageUrl;
  final String? totalPrice;
  final String? namaPedagang;
  final String? lokasiPembeli;
  final String? buyerName;
  final String? buyerPhone;
  final String? buyerAddress;
  final String? status;
  final String? jenisDagangan;
  final String? stok;

  CheckOutModels({
    this.id,
    this.productId,
    this.lokasiPembeli,
    this.productName,
    this.productPrice,
    this.productImageUrl,
    this.buyerPhone,
    this.buyerName,
    this.totalPrice,
    this.namaPedagang,
    this.buyerAddress,
    this.status,
    this.jenisDagangan,
    this.stok,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'productPrice': productPrice,
      'lokasi': lokasiPembeli,
      'productImageUrl': productImageUrl,
      'totalPrice': totalPrice,
      'buyerName': buyerName,
      'buyerPhone': buyerPhone,
      'namaPedagang': namaPedagang,
      'buyerAddress': buyerAddress,
      'status': status,
      'jenisDagangan': jenisDagangan,
      'stok': stok,
    };
  }
}
