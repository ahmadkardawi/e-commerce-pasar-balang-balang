// import 'package:aplikasi/models/orderModels.dart';
// import 'package:aplikasi/models/produkModels.dart';
// import 'package:aplikasi/pages/pages_pedagang/coba2.dart';
// import 'package:aplikasi/pages/pages_pedagang/edit_produk.dart';
// import 'package:aplikasi/pages/pages_pembeli/chechkout.dart';
// import 'package:aplikasi/service/Firebase_service.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:quickalert/models/quickalert_type.dart';
// import 'package:quickalert/widgets/quickalert_dialog.dart';
// import 'package:uuid/uuid.dart';

// class DetailPembelianProduk extends StatefulWidget {
//   DocumentSnapshot docuid;

//   DetailPembelianProduk({required this.docuid});

//   @override
//   _DetailPembelianProdukState createState() =>
//       _DetailPembelianProdukState(docuid: docuid);
// }

// class _DetailPembelianProdukState extends State<DetailPembelianProduk> {
//   DocumentSnapshot docuid;
//   _DetailPembelianProdukState({required this.docuid});
//   int _counterr = 1;
//   void _tambah() {
//     int stk = int.parse(stok);
//     if (_counterr == stk) {
//       showDialog(
//           context: context,
//           builder: (context) {
//             return AlertDialog(
//               title: Text('Stok Habis'),
//               content: Text('Stok Barang Sudah Habis'),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: Text('Ok'),
//                 ),
//               ],
//             );
//           });
//     } else {
//       setState(() {
//         _counterr++;
//       });
//     }
//   }

//   void _kurang() {
//     if (_counterr == 1) {
//       print('tidak dapat ditambah');
//     } else {
//       setState(() {
//         _counterr--;
//         // conterStok--;
//       });
//     }
//   }

//   // final Stream<QuerySnapshot> _usersStream =
//   //     FirebaseFirestore.instance.collection('report').snapshots();
//   final firestore = FirebaseFirestore.instance;
//   Future<void> orderProduct(OrderModels order, BuildContext context) {
//     CollectionReference products =
//         FirebaseFirestore.instance.collection('keranjang');

//     return products
//         // .doc(docuid.id)
//         .add(order.toMap())
//         // .any(order.toJson())
//         .then((value) => QuickAlert.show(
//               context: context,
//               type: QuickAlertType.success,
//               title: 'Berhasil',
//               text: 'Produk di Masukkan ke Keranjang',
//             ))
//         .catchError((error) => print("Failed to add product: $error"));
//   }

//   final _auth = FirebaseAuth.instance;
//   var jenisProduk;
//   // var kurir;
//   var userName;
//   var namaProduk;
//   var harga;
//   var tanggalDibuat;
//   var poto;
//   var id;
//   var stok;
//   var ket;
//   void initState() {
//     jenisProduk = widget.docuid.get('jenisproduk');
//     // kurir = widget.docuid.get('kurir');
//     userName = widget.docuid.get('name');
//     tanggalDibuat = widget.docuid.get('tanggal');
//     harga = widget.docuid.get('price');
//     namaProduk = widget.docuid.get('namaProduk');
//     poto = widget.docuid.get('imageUrl');
//     id = widget.docuid.get('idUser');
//     stok = widget.docuid.get('stok');
//     ket = widget.docuid.get('keterangan');
//     super.initState();
//     setState(() {});
//   }

//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   CollectionReference users = FirebaseFirestore.instance.collection('products');
//   final CollectionReference produkRef =
//       FirebaseFirestore.instance.collection('products');
//   final CollectionReference ordersRef =
//       FirebaseFirestore.instance.collection('orders');

//   @override
//   Widget build(BuildContext context) {
//     var user = _auth.currentUser;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.teal,
//         title: Text('Detail Produk'),
//         // automaticallyImplyLeading: false,
//       ),
//       body: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               _buildOrderItem(
//                 poto,
//                 namaProduk,
//                 userName,
//                 tanggalDibuat,
//                 harga,
//                 jenisProduk,
//                 stok,
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                       elevation: 5, minimumSize: Size(double.infinity, 50)),
//                   onPressed: () async {
//                     if (_formKey.currentState!.validate()) {
//                       // upToKeranjang();
//                       final userDoc = await FirebaseFirestore.instance
//                           .collection('users')
//                           .doc(user!.uid)
//                           .get();
//                       var usernam = userDoc.data()!['name'];

//                       String namaPembeli = usernam;
//                       String stk = stok;
//                       String price = widget.docuid.get('price');
//                       String nameProduk = widget.docuid.get('namaProduk');
//                       String jenis = widget.docuid.get('jenisproduk');
//                       String idProduk = widget.docuid.get('idUser');
//                       String idUser = _auth.currentUser!.uid;
//                       String image = widget.docuid.get('imageUrl');
//                       // String status = "Dalam Proses";
//                       String entities = _counterr.toString();
//                       String noHp = ' ';
//                       String namaPedagang = widget.docuid.get('name');
//                       String lokasi = ' ';
//                       String tanggal =
//                           DateFormat.yMd().add_jm().format(DateTime.now());
//                       OrderModels orderModels = OrderModels(
//                         id: idUser,
//                         productId: idProduk,
//                         productName: nameProduk,
//                         entiti: entities,
//                         // lokasiPembeli: lokasi,
//                         namaPedagang: namaPedagang,
//                         // buyerPhone: noHp,
//                         jenisDagangan: jenis,
//                         productPrice: price,
//                         productImageUrl: image,
//                         buyerName: namaPembeli,
//                         stok: stk,
//                         buyerAddress: tanggal,
//                         // status: status
//                       );
//                       orderProduct(orderModels, context);
//                       Navigator.pop(context);
//                     }
//                   },
//                   child: Text(
//                     'Masukkan Keranjang',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildOrderItem(
//     var imageUrl,
//     String namaBarang,
//     String name,
//     String orderDate,
//     String price,
//     String jenis,
//     String stk,
//   ) {
//     return Column(
//       children: [
//         Container(
//           margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//           padding: EdgeInsets.all(16.0),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(16.0),
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.5),
//                 blurRadius: 5,
//                 offset: Offset(0, 3),
//               ),
//             ],
//           ),
//           child: Column(
//             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(16.0),
//                 child: Image.network(
//                   imageUrl,
//                   width: 400.0,
//                   height: 200.0,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Container(
//           margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//           padding: EdgeInsets.all(20),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(16.0),
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.blueGrey.withOpacity(0.5),
//                 blurRadius: 5,
//                 offset: Offset(0, 3),
//               ),
//             ],
//           ),
//           child: Column(
//             children: [
//               Container(
//                 height: 2,
//                 width: double.infinity,
//                 color: Colors.blue,
//               ),
//               SizedBox(height: 10),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Jenis Produk: ',
//                     style: TextStyle(
//                       color: Colors.grey.shade600,
//                       fontSize: 16.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     jenis,
//                     style: TextStyle(
//                       fontSize: 16.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 8.0),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Nama pedagang: ',
//                     style: TextStyle(
//                       fontSize: 16.0,
//                       color: Colors.grey.shade600,
//                     ),
//                   ),
//                   Text(
//                     name,
//                     style: TextStyle(fontSize: 16.0),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 8.0),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Nama Produk: ',
//                     style: TextStyle(
//                       fontSize: 16.0,
//                       color: Colors.grey.shade600,
//                     ),
//                   ),
//                   Text(
//                     namaBarang,
//                     style: TextStyle(fontSize: 16.0),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 8.0),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Harga: ',
//                     style: TextStyle(
//                       fontSize: 16.0,
//                       color: Colors.grey.shade600,
//                     ),
//                   ),
//                   Text(
//                     formatRupiah(price),
//                     style: TextStyle(fontSize: 16.0),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 8),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Stok : ',
//                     style: TextStyle(
//                       fontSize: 16.0,
//                       color: Colors.grey.shade600,
//                     ),
//                   ),
//                   Text(
//                     stk,
//                     style: TextStyle(fontSize: 16.0),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 15),
//               Container(
//                 height: 2,
//                 width: double.infinity,
//                 color: Colors.blue,
//               ),
//               SizedBox(height: 20),
//               Container(
//                 height: 35,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   color: Colors.grey.shade200,
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     IconButton(
//                       color: Colors.redAccent,
//                       onPressed: () {
//                         _kurang();
//                       },
//                       icon: Icon(Icons.remove),
//                     ),
//                     Text('$_counterr'),
//                     IconButton(
//                       color: Colors.lightBlue,
//                       onPressed: () {
//                         print('sisa stok $stok');

//                         _tambah();
//                       },
//                       icon: Icon(Icons.add),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   // Future<void> upToKeranjang() async {
//   //   final _authh = FirebaseAuth.instance.currentUser;
//   //   // final userDoc = await FirebaseFirestore.instance
//   //   //     .collection('users')
//   //   //     .doc(_auth!.uid)
//   //   //     .get();
//   //   // var usernam = userDoc.data()!['name'];
//   //   CollectionReference products =
//   //       FirebaseFirestore.instance.collection('products');

//   //   return products
//   //       .doc(docuid.id)
//   //       .update({
//   //         'idProduk': _authh!.uid,
//   //         'keranjang': 'keranjang',
//   //       })
//   //       .then((value) => QuickAlert.show(
//   //             context: context,
//   //             type: QuickAlertType.success,
//   //             title: 'Berhasil',
//   //             text: 'Produk di masukkan ke keranjang',
//   //           ))
//   //       .catchError((error) => print("Failed to add product: $error"));
//   // }
// }
