class ProductModel {
  final String? idProduk;
  final String? namaproduk;
  final String? jenisproduk;
  final String? namaPenjual;
  final String? imageUrl;
  final String? idUser;
  final String? price;
  final String? tanggal;
  final String? statusBarang;
  final String? keterangan;
  final String? stok;
  final String? namaa;
  final String? lokasi;
  final String? keranjang;

  ProductModel({
    this.tanggal,
    this.idProduk,
    this.namaproduk,
    this.keranjang,
    this.idUser,
    this.namaa,
    this.lokasi,
    this.jenisproduk,
    this.namaPenjual,
    this.imageUrl,
    this.price,
    this.statusBarang,
    this.keterangan,
    this.stok,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      idProduk: json['id'],
      idUser: json['idUser'],
      tanggal: json['tanggal'],
      lokasi: json['lokasi'],
      namaPenjual: json['name'],
      namaa: json['namaa'],
      namaproduk: json['namaProduk'],
      jenisproduk: json['jenisproduk'],
      imageUrl: json['imageUrl'],
      price: json['price'],
      statusBarang: json['statusBarang'],
      keterangan: json['keterangan'],
      keranjang: json['keranjang'],
      stok: json['stok'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['idProduk'] = this.idProduk;
    data['idUser'] = this.idUser;
    data['tanggal'] = this.tanggal;
    data['name'] = this.namaPenjual;
    data['namaProduk'] = this.namaproduk;
    data['jenisproduk'] = this.jenisproduk;
    data['imageUrl'] = this.imageUrl;
    data['price'] = this.price;
    data['statusBarang'] = this.statusBarang;
    data['keranjang'] = this.keranjang;
    data['keterangan'] = this.keterangan;
    data['stok'] = this.stok;
    data['lokasi'] = this.lokasi;
    return data;
  }
}
