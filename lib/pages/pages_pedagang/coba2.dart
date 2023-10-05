// import 'package:aplikasi/pages/pages_pedagang/detail_produk.dart';
// import 'package:aplikasi/pages/pages_pedagang/edit_produk.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class EditProduk extends StatefulWidget {
//   DocumentSnapshot docid;

//   EditProduk({required this.docid});

//   @override
//   _EditProdukState createState() => _EditProdukState(docid: docid);
// }

// class _EditProdukState extends State<EditProduk> {
//   DocumentSnapshot docid;
//   _EditProdukState({required this.docid});
//   TextEditingController jenisProduk = TextEditingController();
//   TextEditingController username = TextEditingController();
//   TextEditingController namaproduk = TextEditingController();
//   TextEditingController hargaproduk = TextEditingController();

//   @override
//   void initState() {
//     jenisProduk = TextEditingController(text: widget.docid.get('jenisproduk'));
//     username = TextEditingController(text: widget.docid.get('name'));
//     namaproduk = TextEditingController(text: widget.docid.get('namaProduk'));
//     hargaproduk = TextEditingController(text: widget.docid.get('price'));
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.teal,
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         backgroundColor: Colors.teal,
//         actions: [
//           MaterialButton(
//             onPressed: () {
//               widget.docid.reference.update({
//                 'name': username.text,
//                 'jenisproduk': jenisProduk.text,
//                 'namaProduk': namaproduk.text,
//                 'price': hargaproduk.text,
//                 // 'bukti': subject6.text,
//               }).whenComplete(() {
//                 Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                         builder: (_) => DetailProduk(docuid: docid)));
//               });
//             },
//             child: Text(
//               "save",
//               style: TextStyle(
//                 fontSize: 20,
//                 color: Color.fromARGB(255, 251, 251, 251),
//               ),
//             ),
//           ),
//           MaterialButton(
//             onPressed: () {
//               widget.docid.reference.delete().whenComplete(() {
//                 Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                         builder: (_) => DetailProduk(docuid: docid)));
//               });
//             },
//             child: Text(
//               "delete",
//               style: TextStyle(
//                 fontSize: 20,
//                 color: Color.fromARGB(255, 251, 251, 251),
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 7.0),
//           child: Container(
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Container(
//                   decoration: BoxDecoration(border: Border.all()),
//                   child: TextField(
//                     controller: username,
//                     maxLines: null,
//                     decoration: InputDecoration(
//                       hintText: 'Nama',
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Container(
//                   decoration: BoxDecoration(border: Border.all()),
//                   child: TextField(
//                     controller: jenisProduk,
//                     maxLines: 3,
//                     // maxLength: 30,
//                     decoration: InputDecoration(
//                       hintText: 'Jenis Produk',
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Container(
//                   decoration: BoxDecoration(border: Border.all()),
//                   child: TextField(
//                     controller: namaproduk,
//                     maxLines: null,
//                     decoration: InputDecoration(
//                       hintText: 'Nama Produk',
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Container(
//                   decoration: BoxDecoration(border: Border.all()),
//                   child: TextField(
//                     controller: hargaproduk,
//                     maxLines: null,
//                     decoration: InputDecoration(
//                       hintText: 'Harga Produk',
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';

// Fungsi untuk mengurangi stok barang
Future<void> updateStock(String productId, int quantity) async {
  // Dapatkan referensi dokumen barang berdasarkan ID produk
  final DocumentReference productRef =
      FirebaseFirestore.instance.collection('products').doc(productId);

  // Ambil data barang dari Firestore
  final DocumentSnapshot productSnapshot = await productRef.get();

  // Periksa jika data barang tersedia
  if (productSnapshot.exists) {
    // Dapatkan jumlah stok yang tersedia saat ini
    int currentStock = productSnapshot['stock'];

    // Periksa jika stok cukup untuk memenuhi pembelian
    if (currentStock >= quantity) {
      // Kurangi stok dengan jumlah yang dibeli
      currentStock -= quantity;

      // Perbarui data stok barang di Firestore
      await productRef.update({'stock': currentStock});

      // Stok berhasil diperbarui
      print('Stok barang berhasil diperbarui');
    } else {
      // Stok tidak mencukupi
      print('Stok barang tidak mencukupi');
    }
  } else {
    // Barang tidak ditemukan
    print('Barang tidak ditemukan');
  }
}

// Contoh pemanggilan fungsi untuk mengurangi stok barang
void main() {
  // ID produk yang ingin diupdate stoknya
  final productId = 'abc123';

  // Jumlah barang yang dibeli oleh pembeli
  final quantity = 3;

  // Panggil fungsi updateStock
  updateStock(productId, quantity);
}
