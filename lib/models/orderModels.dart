class OrderModels {
  final String? id;
  final String? productId;
  final String? idDocument;
  final String? productName;
  final String? productPrice;
  final String? productImageUrl;
  final String? entiti;
  final String? namaPedagang;
  bool isSelected;
  final String? buyerName;
  final String? totalBelanja;
  final String? buyerAddress;
  final String? alamat;
  final String? status;
  final String? jenisDagangan;
  final String? noPembeli;
  final String? stok;

  OrderModels({
    this.id,
    this.productId,
    this.idDocument,
    this.isSelected = false,
    this.productName,
    this.productPrice,
    this.noPembeli,
    this.productImageUrl,
    this.alamat,
    this.totalBelanja,
    this.buyerName,
    this.entiti,
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
      'idDocument': idDocument,
      'productName': productName,
      'productPrice': productPrice,
      'isSelected': isSelected,
      'productImageUrl': productImageUrl,
      'noPembeli': noPembeli,
      'alamat': alamat,
      'entiti': entiti,
      'buyerName': buyerName,
      'totalBelanja': totalBelanja,
      'namaPedagang': namaPedagang,
      'buyerAddress': buyerAddress,
      'status': status,
      'jenisDagangan': jenisDagangan,
      'stok': stok,
    };
  }
}
