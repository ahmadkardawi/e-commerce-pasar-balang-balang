// import 'package:aplikasi/cobaa/cobaterusss.dart';
// import 'package:aplikasi/models/orderModels.dart';
// import 'package:aplikasi/service/Firebase_service.dart';
// import 'package:aplikasi/service/userCheckOut.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class Checkoutku extends StatelessWidget {
//   final List<OrderModels> selectedProducts;
//   final int totalHargaKeseluruhan;

//   Checkoutku(
//       {required this.selectedProducts, required this.totalHargaKeseluruhan});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Checkout'),
//         backgroundColor: Colors.teal,
//       ),
//       body: Column(
//         children: [
//           UserCheckOut(),
//           Container(
//             height: 1,
//             color: Colors.grey,
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: selectedProducts.length,
//               itemBuilder: (context, index) {
//                 final product = selectedProducts[index];
//                 return FutureBuilder<DocumentSnapshot>(
//                   future: FirebaseFirestore.instance
//                       .collection('keranjang')
//                       .doc(product.id)
//                       .get(),
//                   builder: (BuildContext context,
//                       AsyncSnapshot<DocumentSnapshot> snapshot) {
//                     if (snapshot.hasError) {
//                       return Text('Error');
//                     }

//                     if (snapshot.connectionState == ConnectionState.done) {
//                       if (snapshot.hasData) {
//                         final data = snapshot.data;
//                         final imageUrl = data?['productImageUrl'];

//                         return Column(
//                           children: [
//                             Container(
//                               // margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
//                               padding: EdgeInsets.all(20.0),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(16.0),
//                                 color: Colors.white,
//                                 // boxShadow: [
//                                 //   BoxShadow(
//                                 //     color: Colors.blueGrey.shade200,
//                                 //     blurRadius: 5,
//                                 //     spreadRadius: 0.2,
//                                 //     offset: Offset(0, 3),
//                                 //   ),
//                                 // ],
//                               ),
//                               child: Row(
//                                 children: [
//                                   Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         product.productName.toString(),
//                                         style: TextStyle(
//                                             fontSize: 20.0,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                       SizedBox(height: 8.0),
//                                       Row(
//                                         children: [
//                                           Text(
//                                             'Total belanja: ',
//                                             style: TextStyle(fontSize: 16),
//                                           ),
//                                           Text(
//                                             formatRupiah(product.totalBelanja
//                                                 .toString()),
//                                             style: TextStyle(fontSize: 16.0),
//                                           ),
//                                         ],
//                                       ),
//                                       SizedBox(height: 8.0),
//                                       Row(
//                                         children: [
//                                           Text(
//                                             'Harga Satuan: ${formatRupiah(product.productPrice.toString())}',
//                                             style: TextStyle(fontSize: 16),
//                                           ),
//                                         ],
//                                       ),
//                                       SizedBox(height: 8),
//                                       Row(
//                                         children: [
//                                           Text(
//                                             'Jumlah: ',
//                                             style: TextStyle(fontSize: 16),
//                                           ),
//                                           Text(
//                                             product.entiti.toString(),
//                                             style: TextStyle(fontSize: 16.0),
//                                           ),
//                                         ],
//                                       ),
//                                       SizedBox(height: 5),
//                                       // Text(
//                                       //   data?['buyerAddress'],
//                                       //   style: TextStyle(
//                                       //       fontSize: 14.0, color: Colors.teal),
//                                       // ),
//                                     ],
//                                   ),
//                                   Spacer(),
//                                   // Tambahkan widget Image.network untuk menampilkan gambar
//                                   Image.network(
//                                     product.productImageUrl.toString(),
//                                     width: 100.0,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               height: 1,
//                               color: Colors.grey,
//                             ),
//                           ],
//                         );
//                       }
//                     }

//                     return Container();
//                   },
//                 );
//               },
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.all(7),
//             padding: EdgeInsets.only(left: 5, right: 5),
//             width: double.infinity,
//             decoration: BoxDecoration(
//               color: Colors.teal,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(top: 16, bottom: 16),
//                   child: Text(
//                     'Total Harga:  Rp. $totalHargaKeseluruhan',
//                     style: TextStyle(
//                       fontSize: 18.0,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: Row(
//                     children: [
//                       Text(
//                         'Beli',
//                         style: TextStyle(
//                             color: Colors.teal,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 18),
//                       ),
//                       Icon(
//                         Icons.shopping_cart_checkout_rounded,
//                         color: Colors.teal,
//                       )
//                     ],
//                   ),
//                   style:
//                       ElevatedButton.styleFrom(backgroundColor: Colors.white),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
