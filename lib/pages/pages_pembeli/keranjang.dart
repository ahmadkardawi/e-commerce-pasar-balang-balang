// import 'package:aplikasi/cobaa/cobaterusss.dart';
// import 'package:aplikasi/models/checkoutModels.dart';
// import 'package:aplikasi/models/orderModels.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:intl/intl.dart';
// import '../../service/Firebase_service.dart';

// class Keranjang extends StatefulWidget {
//   @override
//   _KeranjangState createState() => _KeranjangState();
// }

// class _KeranjangState extends State<Keranjang> {
//   List<OrderModels>? products = [];
//   int totalAmount = 0;
//   FirebaseAuth auth = FirebaseAuth.instance;
//   User? user = FirebaseAuth.instance.currentUser;

//   void updateTotalAmount() {
//     totalAmount = 0;
//     for (final product in products!) {
//       String prc = product.totalBelanja.toString();
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
//         totalBelanja: doc.data()['totalBelanja'],
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
//             title: Center(child: Text('Keranjang')),
//           ),
//           body: Column(
//             children: [
//               Expanded(
//                 child: ListView.builder(
//                   // physics: NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   itemCount: products!.length,
//                   itemBuilder: ((context, index) => Container(
//                         margin:
//                             EdgeInsets.only(bottom: 10, left: 10, right: 10),
//                         padding: EdgeInsets.all(20.0),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(16.0),
//                           color: Colors.white,
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.blueGrey.shade200,
//                               blurRadius: 5,
//                               spreadRadius: 0.2,
//                               offset: Offset(0, 3),
//                             ),
//                           ],
//                         ),
//                         child: Row(
//                           children: [
//                             Checkbox(
//                               value: products![index].isSelected,
//                               onChanged: (bool? value) {
//                                 setState(() {
//                                   products![index].isSelected = value ?? false;
//                                   updateTotalAmount();
//                                 });
//                               },
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   snapshot.data!.docs[index]['productName'],
//                                   style: TextStyle(
//                                       fontSize: 20.0,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 SizedBox(height: 8.0),
//                                 Row(
//                                   children: [
//                                     Text(
//                                       'Kuantitas: ',
//                                       style: TextStyle(fontSize: 16),
//                                     ),
//                                     Text(
//                                       snapshot.data!.docs[index]['entiti'],
//                                       style: TextStyle(fontSize: 16.0),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(height: 8.0),
//                                 Text(
//                                   formatRupiah(snapshot.data!.docs[index]
//                                       ['totalBelanja']),
//                                 ),
//                                 SizedBox(height: 8.0),
//                                 Text(
//                                   snapshot.data!.docs[index]['buyerAddress'],
//                                   style: TextStyle(
//                                       fontSize: 12, color: Colors.amber),
//                                 ),
//                               ],
//                             ),
//                             Spacer(),
//                             ClipRRect(
//                               borderRadius: BorderRadius.circular(16.0),
//                               child: Image.network(
//                                 snapshot.data!.docs[index]['productImageUrl'],
//                                 width: 100.0,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                             SizedBox(width: 10),
//                           ],
//                         ),
//                       )),
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.only(bottom: 60),
//                 padding: EdgeInsets.only(right: 20, left: 20),
//                 width: double.infinity,
//                 color: Colors.teal,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(top: 16, bottom: 16),
//                       child: Text(
//                         'Total Harga:  Rp. ${totalAmount.toStringAsFixed(2)}',
//                         style: TextStyle(
//                           fontSize: 18.0,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                     ElevatedButton(
//                       onPressed: () async {
//                         final userDoc = await FirebaseFirestore.instance
//                             .collection('keranjang')
//                             .doc(user!.uid)
//                             .get();
//                         var usernam = userDoc.data()!['name'];
//                         var nohp = userDoc.data()!['noHp'];
//                         String namaPembeli = usernam;
//                         // String price = ;
//                         // String lokasi = Address;
//                         String tanggal =
//                             DateFormat.yMd().add_jm().format(DateTime.now());
//                       },
//                       child: Text(
//                         'Checkout',
//                         style: TextStyle(
//                             color: Colors.teal,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 18),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.white),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
// String productName =
//     snapshot.data!.docs[index]['productName'];
// String productPrice =
//     snapshot.data!.docs[index]['totalBelanja'];
// String buyerName =
//     'John Doe'; // Ganti dengan data pembeli
// String buyerAddress =
//     'Alamat Pembeli'; // Ganti dengan data pembeli
// String buyerPhoneNumber =
//     '081234567890'; // Ganti dengan data pembeli
// int totalAmount = int.parse(productPrice);

// Buat objek CheckoutModels
// CheckOutModels checkout = CheckOutModels(
//   productName: productName,
//   productPrice: productPrice,
//   buyerName: buyerName,
//   buyerAddress: buyerAddress,
//   // buyerPhoneNumber: buyerPhoneNumber,
//   // totalAmount: totalAmount,
// );

// Pindah ke halaman detail checkout dengan data yang dikirim
// Navigator.push(
//   context,
//   MaterialPageRoute(
//     builder: (context) => ChechkOut(chech: checkout,
//       // checkout: checkout,
//     ),
//   ),
// );

import 'package:aplikasi/models/orderModels.dart';
import 'package:aplikasi/pages/pages_pembeli/chechkout.dart';
import 'package:aplikasi/service/Firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Keranjang extends StatefulWidget {
  @override
  _KeranjangState createState() => _KeranjangState();
}

class _KeranjangState extends State<Keranjang> {
  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('keranjang');

  List<OrderModels> products = [];
  List<OrderModels> selectedProducts = [];

  void updateSelectedProducts() {
    selectedProducts = products.where((product) => product.isSelected).toList();
  }

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    User? user = FirebaseAuth.instance.currentUser;
    final QuerySnapshot snapshot =
        await productsCollection.where('id', isEqualTo: user!.uid).get();
    final List<OrderModels> fetchedProducts = [];
    snapshot.docs.forEach((doc) {
      final product = OrderModels(
        id: doc.id,
        productId: doc.get('productId'),
        alamat: doc.get('alamat'),
        buyerName: doc.get('buyerName'),
        noPembeli: doc.get('noPembeli'),
        productImageUrl: doc.get('productImageUrl'),
        entiti: doc.get('entiti'),
        productName: doc.get('productName'),
        totalBelanja: doc.get('totalBelanja'),
        productPrice: doc.get('productPrice'),
      );

      fetchedProducts.add(product);
    });

    setState(() {
      products = fetchedProducts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keranjang'),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ListTile(
                    //   title: Text(product.productName.toString()),
                    //   subtitle: Text('Harga: ${product.productPrice}'),
                    //   leading:
                    SizedBox(height: 10),
                    Container(
                      margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                      padding: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueGrey.shade200,
                            blurRadius: 5,
                            spreadRadius: 0.2,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Checkbox(
                            value: product.isSelected,
                            onChanged: (value) {
                              setState(() {
                                product.isSelected = value ?? false;
                                updateSelectedProducts();
                                if (product.isSelected) {
                                  productsCollection.doc(product.id).update({
                                    'isSelected': true,
                                  });
                                } else {
                                  productsCollection.doc(product.id).update({
                                    'isSelected': false,
                                  });
                                }
                                print(product.id);
                              });
                            },
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(product.productName.toString()),
                              Row(
                                children: [
                                  Text('Harga: '),
                                  Text(formatRupiah(
                                      product.productPrice.toString())),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('Total Belanja: '),
                                  Text(formatRupiah(
                                      product.totalBelanja.toString())),
                                ],
                              ),
                            ],
                          ),
                          Spacer(),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16.0),
                            child: Image.network(
                              product.productImageUrl.toString(),
                              width: 100.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // ),
                  ],
                );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 60),
            padding: EdgeInsets.only(right: 20, left: 20),
            width: double.infinity,
            color: Colors.teal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 16),
                  child: Text(
                    'Total Harga: ${NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0).format(selectedProducts.fold(0, (sum, product) => sum + int.parse(product.totalBelanja.toString())))}',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Checkout(
                          selectedProducts: selectedProducts,
                          totalHargaKeseluruhan: selectedProducts.fold(
                              0,
                              (sum, product) =>
                                  sum +
                                  int.parse(product.totalBelanja.toString())),
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'Checkout',
                    style: TextStyle(
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
