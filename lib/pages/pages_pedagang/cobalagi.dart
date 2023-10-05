// // import 'package:aplikasi/models/orderModels.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import '../../service/Firebase_service.dart';

// // // class Product {
// // //   final String id;
// // //   final String name;
// // //   final String price;
// // //   bool isSelected;

// // //   Product(
// // //       {required this.id,
// // //       required this.name,
// // //       required this.price,
// // //       this.isSelected = false});
// // // }

// // class EcommerceApp extends StatefulWidget {
// //   @override
// //   _EcommerceAppState createState() => _EcommerceAppState();
// // }

// // class _EcommerceAppState extends State<EcommerceApp> {
// //   List<OrderModels>? products = [];
// //   // var orderModels = OrderModels();
// //   int totalAmount = 0;
// //   FirebaseAuth auth = FirebaseAuth.instance;

// //   void updateTotalAmount() {
// //     // final product = orderModels;
// //     totalAmount = 0;
// //     for (final product in products!) {
// //       String prc = product.productPrice.toString();
// //       if (product.isSelected) {
// //         totalAmount += int.parse(prc);
// //       }
// //     }
// //   }

// //   Future<void> fetchProducts() async {
// //     final snapshot =
// //         await FirebaseFirestore.instance.collection('keranjang').get();
// //     final List<OrderModels> fetchedProducts = [];
// //     snapshot.docs.forEach((doc) {
// //       final product = OrderModels(
// //         id: doc.id,
// //         productName: doc.data()['productName'],
// //         productPrice: doc.data()['productPrice'],
// //       );
// //       fetchedProducts.add(product);
// //     });

// //     setState(() {
// //       products = fetchedProducts;
// //     });
// //   }

// //   @override
// //   void initState() {
// //     super.initState();
// //     fetchProducts();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     var orderModels = OrderModels();
// //     final _usersStream = FirebaseFirestore.instance
// //         .collection('keranjang')
// //         .where('id', isEqualTo: auth.currentUser!.uid)
// //         // .where('keranjang', isEqualTo: 'keranjang')
// //         .snapshots();
// //     return StreamBuilder<QuerySnapshot>(
// //       stream: _usersStream,
// //       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
// //         if (snapshot.hasError) {
// //           return Text('Masih Kosong');
// //         }
// //         if (snapshot.connectionState == ConnectionState.waiting) {
// //           return CircularProgressIndicator();
// //         }
// //         return Column(
// //           children: [
// //             ListView.builder(
// //               physics: NeverScrollableScrollPhysics(),
// //               shrinkWrap: true,
// //               itemCount: products!.length,
// //               itemBuilder: ((context, index) => Container(
// //                     margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
// //                     padding: EdgeInsets.all(20.0),
// //                     decoration: BoxDecoration(
// //                       borderRadius: BorderRadius.circular(16.0),
// //                       color: Colors.white,
// //                       boxShadow: [
// //                         BoxShadow(
// //                           color: Colors.blueGrey.shade200,
// //                           blurRadius: 5,
// //                           spreadRadius: 0.2,
// //                           offset: Offset(0, 3),
// //                         ),
// //                       ],
// //                     ),
// //                     child: Row(
// //                       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                       children: [
// //                         Checkbox(
// //                           value: products![index].isSelected,
// //                           // value: snapshot.data != null,
// //                           onChanged: (bool? value) {
// //                             setState(() {
// //                               products![index].isSelected = value ?? false;
// //                               updateTotalAmount();
// //                             });
// //                           },
// //                         ),
// // //                      ListTile(
// // // //                     title: Text(products),
// // // //                     subtitle: Text('Price: \$${product.price}'),
// // // //                     leading:
// // // //                   );
// //                         Column(
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: [
// //                             Text(
// //                               snapshot.data!.docs[index]['productName'],
// //                               style: TextStyle(
// //                                   fontSize: 20.0, fontWeight: FontWeight.bold),
// //                             ),
// //                             SizedBox(height: 8.0),
// //                             Row(
// //                               children: [
// //                                 Text(
// //                                   'Kuantitas: ',
// //                                   style: TextStyle(fontSize: 16),
// //                                 ),
// //                                 Text(
// //                                   snapshot.data!.docs[index]['entiti'],
// //                                   style: TextStyle(fontSize: 16.0),
// //                                 ),
// //                               ],
// //                             ),
// //                             SizedBox(height: 8.0),
// //                             Text(
// //                               formatRupiah(
// //                                   snapshot.data!.docs[index]['productPrice']),
// //                             ),
// //                             SizedBox(height: 8.0),
// //                             Text(
// //                               snapshot.data!.docs[index]['buyerAddress'],
// //                               style:
// //                                   TextStyle(fontSize: 12, color: Colors.amber),
// //                             ),
// //                           ],
// //                         ),
// //                         Spacer(),
// //                         ClipRRect(
// //                           borderRadius: BorderRadius.circular(16.0),
// //                           child: Image.network(
// //                             snapshot.data!.docs[index]['productImageUrl'],
// //                             width: 100.0,
// //                             // height: 50.0,
// //                             fit: BoxFit.cover,
// //                           ),
// //                         ),
// //                         SizedBox(width: 10),
// //                       ],
// //                     ),
// //                   )),
// //             ),
// //             Container(
// //               width: 100,
// //               color: Colors.blue,
// //               child: Text(
// //                 'Total Harga:  \Rp. ${totalAmount.toStringAsFixed(2)}',
// //                 style: TextStyle(
// //                   fontSize: 18.0,
// //                   fontWeight: FontWeight.bold,
// //                 ),
// //               ),
// //             ),
// //             SizedBox(
// //               height: 70,
// //             ),

// //             // Text('apa saja'),
// //           ],
// //         );
// //       },
// //     );
// //   }
// // }

// import 'package:aplikasi/models/orderModels.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:intl/intl.dart';
// import '../../service/Firebase_service.dart';

// class EcommerceApp extends StatefulWidget {
//   @override
//   _EcommerceAppState createState() => _EcommerceAppState();
// }

// class _EcommerceAppState extends State<EcommerceApp> {
//   List<OrderModels>? products = [];
//   int totalAmount = 0;
//   FirebaseAuth auth = FirebaseAuth.instance;

//   void updateTotalAmount() {
//     totalAmount = 0;
//     for (final product in products!) {
//       String prc = product.productPrice.toString();
//       if (product.isSelected) {
//         totalAmount += int.parse(prc);
//       }
//     }
//   }

//   Future<void> fetchProducts() async {
//     final snapshot =
//         await FirebaseFirestore.instance.collection('keranjang').get();
//     final List<OrderModels> fetchedProducts = [];
//     snapshot.docs.forEach((doc) {
//       final product = OrderModels(
//         id: doc.id,
//         productName: doc.data()['productName'],
//         productPrice: doc.data()['productPrice'],
//       );
//       fetchedProducts.add(product);
//     });

//     setState(() {
//       products = fetchedProducts;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     fetchProducts();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var orderModels = OrderModels();
//     final _usersStream = FirebaseFirestore.instance
//         .collection('keranjang')
//         .where('id', isEqualTo: auth.currentUser!.uid)
//         .snapshots();
//     return StreamBuilder<QuerySnapshot>(
//       stream: _usersStream,
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return Text('Masih Kosong');
//         }
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//         }
//         return Scaffold(
//           appBar: AppBar(
//             backgroundColor: Colors.teal,
//             automaticallyImplyLeading: false,
//             title: Text('Keranjang'),
//           ),
//           body: Stack(
//             children: [
//               SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     ListView.builder(
//                       physics: NeverScrollableScrollPhysics(),
//                       shrinkWrap: true,
//                       itemCount: products!.length,
//                       itemBuilder: ((context, index) => Container(
//                             margin: EdgeInsets.only(
//                                 bottom: 10, left: 10, right: 10),
//                             padding: EdgeInsets.all(20.0),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(16.0),
//                               color: Colors.white,
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.blueGrey.shade200,
//                                   blurRadius: 5,
//                                   spreadRadius: 0.2,
//                                   offset: Offset(0, 3),
//                                 ),
//                               ],
//                             ),
//                             child: Row(
//                               children: [
//                                 Checkbox(
//                                   value: products![index].isSelected,
//                                   onChanged: (bool? value) {
//                                     setState(() {
//                                       products![index].isSelected =
//                                           value ?? false;
//                                       updateTotalAmount();
//                                     });
//                                   },
//                                 ),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       snapshot.data!.docs[index]['productName'],
//                                       style: TextStyle(
//                                           fontSize: 20.0,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     SizedBox(height: 8.0),
//                                     Row(
//                                       children: [
//                                         Text(
//                                           'Kuantitas: ',
//                                           style: TextStyle(fontSize: 16),
//                                         ),
//                                         Text(
//                                           snapshot.data!.docs[index]['entiti'],
//                                           style: TextStyle(fontSize: 16.0),
//                                         ),
//                                       ],
//                                     ),
//                                     SizedBox(height: 8.0),
//                                     Text(
//                                       formatRupiah(snapshot.data!.docs[index]
//                                           ['productPrice']),
//                                     ),
//                                     SizedBox(height: 8.0),
//                                     Text(
//                                       snapshot.data!.docs[index]
//                                           ['buyerAddress'],
//                                       style: TextStyle(
//                                           fontSize: 12, color: Colors.amber),
//                                     ),
//                                   ],
//                                 ),
//                                 Spacer(),
//                                 ClipRRect(
//                                   borderRadius: BorderRadius.circular(16.0),
//                                   child: Image.network(
//                                     snapshot.data!.docs[index]
//                                         ['productImageUrl'],
//                                     width: 100.0,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                                 SizedBox(width: 10),
//                               ],
//                             ),
//                           )),
//                     ),
//                   ],
//                 ),
//               ),
//               Positioned(
//                 bottom: 50,
//                 right: 0,
//                 left: 0,
//                 child: Container(
//                   width: double.infinity,
//                   color: Colors.blue,
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Text(
//                       'Total Harga:  \Rp. ${totalAmount.toStringAsFixed(2)}',
//                       style: TextStyle(
//                         fontSize: 18.0,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

// // String formatRupiah(int price) {
// //   final formatter = NumberFormat('#,###');
// //   return 'Rp. ${formatter.format(price)}';
// // }
