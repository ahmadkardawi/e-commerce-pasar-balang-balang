// import 'package:aplikasi/models/checkoutModels.dart';
// import 'package:aplikasi/models/orderModels.dart';
// import 'package:aplikasi/pages/pages_pedagang/tambah_produk.dart';
// import 'package:aplikasi/service/Firebase_service.dart';
// import 'package:aplikasi/service/gps.dart';
// import 'package:aplikasi/theme/style_random.dart';
// import 'package:aplikasi/widgets/bottom_bar_pembeli.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:intl/intl.dart';
// import 'package:uuid/uuid.dart';
// // import 'dart:convert';
// // import 'package:firebase_messaging/firebase_messaging.dart';
// // import 'package:flutter/foundation.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class ChechkOut extends StatefulWidget {
//   DocumentSnapshot snapshot;

//   ChechkOut({required this.snapshot});

//   @override
//   _ChechkOutState createState() => _ChechkOutState(dokUid: snapshot);
// }

// var stokk;

// class _ChechkOutState extends State<ChechkOut> {
//   DocumentSnapshot dokUid;
//   _ChechkOutState({required this.dokUid});

//   TextEditingController lokasii = TextEditingController();
//   TextEditingController tlp = TextEditingController();
//   TextEditingController namaPanjang = TextEditingController();
//   final GlobalKey<FormState> _key = GlobalKey<FormState>();
//   String Address = 'search';
//   String location = 'Null, Press Button';

//   Future<void> GetAddressFromLatLong(Position position) async {
//     List<Placemark> placemarks =
//         await placemarkFromCoordinates(position.latitude, position.longitude);
//     print(placemarks);
//     Placemark place = placemarks[0];
//     Address =
//         '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
//     setState(() {});
//   }

//   var namaProduk;
//   var harga;
//   var poto;
//   var stok;
//   var namapembeli;
//   var totalkeseluruhan;

//   @override
//   void initState() {
//     harga = widget.snapshot.get('productPrice');
//     namaProduk = widget.snapshot.get('productName');
//     poto = widget.snapshot.get('productImageUrl');
//     // stok = widget.snapshot.get('stok');
//     totalkeseluruhan = widget.snapshot.get('totalBelanja');
//     namapembeli = widget.snapshot.get('buyerName');
//     super.initState();
//     // requestPermission();
//     // getToken();
//     // initInfo();
//     setState(() {});
//   }

//   void _tambah() {
//     int stk = int.parse(stok);
//     if (stk > 0 && stk >= 0) {
//       setState(() {
//         _counterr++;
//         newStock;
//         // conterStok--;
//         // buyProduct(dokUid.id);
//       });
//     } else {
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
//     }
//   }

//   void _kurang() {
//     setState(() {
//       _counterr--;
//       // conterStok--;
//     });
//   }

//   void _hasil() {
//     setState(() {
//       hasilnya = int.parse(harga) * _counterr;
//       // hasilStok = int.parse(stokk) - conterStok;
//     });
//   }

//   final FirebaseFirestore firestore = FirebaseFirestore.instance;
//   final CollectionReference productsRef =
//       FirebaseFirestore.instance.collection('products');
//   final _auth = FirebaseAuth.instance;

//   // reduceStock() async {}

//   String? usernam;
//   // void buyProduct(String productId) {
//   //   reduceStock(productId, 1)
//   //       .then((_) => print('Stok barang berhasil diperbarui'))
//   //       .catchError((error) => print('Terjadi kesalahan: $error'));
//   // }
//   int? newStock;
//   int? hasilnya;
//   int _counterr = 0;

//   var uuid = Uuid();
//   @override
//   Widget build(BuildContext context) {
//     // int newstok = conterStok - 1;
//     var jawaban = hasilnya;
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           leading: IconButton(
//             icon: Icon(Icons.keyboard_backspace_sharp),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//           actions: [
//             IconButton(
//               icon: const Icon(Icons.delete),
//               tooltip: 'Delete',
//               onPressed: () {
//                 widget.snapshot.reference.delete().whenComplete(() {
//                   Navigator.pop(context);
//                 });
//               },
//             ),
//           ],
//           backgroundColor: Colors.teal,
//           title: Text('Checkout'),
//         ),
//         body: SingleChildScrollView(
//           child: Form(
//             key: _key,
//             child: Column(
//               children: <Widget>[
//                 Container(
//                   padding: EdgeInsets.all(10),
//                   // width: 190,
//                   margin: EdgeInsets.only(left: 15, right: 15, top: 15),
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.blueGrey.shade200,
//                           blurRadius: 2.0,
//                           offset: Offset(0, 3),
//                         ),
//                       ]),
//                   child: Row(
//                     children: [
//                       Image.network(
//                         poto,
//                         width: 60,
//                       ),
//                       SizedBox(height: 5),
//                       Text(
//                         namaProduk,
//                         style: detailpesanan,
//                       ),
//                       SizedBox(height: 5),
//                       Text(
//                         formatRupiah(harga),
//                         style: detailpesanan,
//                       ),
//                       SizedBox(height: 5),
//                       // Row(
//                       //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       //   children: [
//                       //     Text(
//                       //       'Stok:',
//                       //       style: detailpesanan,
//                       //     ),
//                       //     Text(
//                       //       stokk,
//                       //       style: detailpesanan,
//                       //     ),
//                       //   ],
//                       // ),
//                       // SizedBox(height: 5),
//                       // Container(
//                       //   height: 35,
//                       //   decoration: BoxDecoration(
//                       //     borderRadius: BorderRadius.circular(20),
//                       //     color: Colors.grey.shade200,
//                       //   ),
//                       //   child: Row(
//                       //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       //     crossAxisAlignment: CrossAxisAlignment.center,
//                       //     children: [
//                       //       IconButton(
//                       //         color: Colors.redAccent,
//                       //         onPressed: () {
//                       //           _kurang();
//                       //         },
//                       //         icon: Icon(Icons.remove),
//                       //       ),
//                       //       Text('$_counterr'),
//                       //       IconButton(
//                       //         color: Colors.lightBlue,
//                       //         onPressed: () {
//                       //           print('sisa stok $stok');

//                       //           _tambah();
//                       //         },
//                       //         icon: Icon(Icons.add),
//                       //       ),
//                       //     ],
//                       //   ),
//                       // ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.all(15),
//                   // width: 150,
//                   margin: EdgeInsets.only(left: 15, right: 15, top: 15),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(10),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.shade300,
//                         blurRadius: 2.0,
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           ElevatedButton(
//                               onPressed: _hasil, child: Text('Total')),
//                           Text(jawaban != null ? '$hasilnya' : '0'),
//                         ],
//                       ),
//                       SizedBox(height: 10),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.only(left: 20, right: 20),
//                   padding: EdgeInsets.all(10),
//                   height: 70,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       border: Border.all(color: Colors.cyan)),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       ElevatedButton(
//                         onPressed: () async {
//                           Position position =
//                               await GPS.getGeoLocationPosition();
//                           location =
//                               'Lat: ${position.latitude} , Long: ${position.longitude}';
//                           GetAddressFromLatLong(position);
//                         },
//                         child: Text('Get Location'),
//                       ),
//                       SingleChildScrollView(
//                         controller: ScrollController(),
//                         scrollDirection: Axis.vertical,
//                         child: Container(
//                           width: 200,
//                           child: Text(
//                             '$Address',
//                             style: TextStyle(
//                                 color: Colors.grey.shade700, fontSize: 15),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.all(15),
//                   // width: 150,
//                   margin: EdgeInsets.only(left: 15, right: 15),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(10),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.shade300,
//                         blurRadius: 2.0,
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "No.HP/WA",
//                         style: TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black54),
//                       ),
//                       SizedBox(height: 10),
//                       Container(
//                         child: TextFormField(
//                           controller: tlp,
//                           keyboardType: TextInputType.number,
//                           decoration: InputDecoration(
//                             prefixIcon: Icon(
//                               Icons.call,
//                               color: Colors.green,
//                             ),
//                             hintText: 'Telephone...',
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.cyan),
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 InkWell(
//                   onTap: () async {
//                     if (_key.currentState!.validate()) {
//                       // chekoutProduct();
//                       final userDoc = await FirebaseFirestore.instance
//                           .collection('users')
//                           .doc(user!.uid)
//                           .get();
//                       var usernam = userDoc.data()!['name'];
//                       var nohp = userDoc.data()!['noHp'];
//                       DocumentSnapshot productSnapshot =
//                           await productsRef.doc(dokUid.id).get();

//                       if (productSnapshot.exists) {
//                         int currentStock = int.parse(productSnapshot['stok']);
//                         newStock = currentStock - _counterr;

//                         await productsRef
//                             .doc(dokUid.id)
//                             .update({'stok': newStock.toString()});

//                         String namaPembeli = usernam;
//                         String stk = newStock.toString();
//                         String price = widget.snapshot.get('price');
//                         String nameProduk = widget.snapshot.get('namaProduk');
//                         String jenis = widget.snapshot.get('jenisproduk');
//                         String idProduk = widget.snapshot.get('idUser');
//                         // String idUser = _auth.currentUser!.uid;
//                         String image = widget.snapshot.get('imageUrl');
//                         // String status = "Dalam Proses";
//                         // String total = hasilnya.toString();
//                         // String noHp = tlp.text;
//                         String namaPedagang = widget.snapshot.get('name');
//                         // String lokasi = Address;
//                         String tanggal =
//                             DateFormat.yMd().add_jm().format(DateTime.now());
//                         CheckOutModels checkOutModels = CheckOutModels(
//                           id: _auth.currentUser!.uid,
//                           productId: idProduk,
//                           productName: nameProduk,
//                           // totalPrice: total,
//                           // lokasiPembeli: lokasi,
//                           namaPedagang: namaPedagang,
//                           // buyerPhone: noHp,
//                           jenisDagangan: jenis,
//                           productPrice: price,
//                           productImageUrl: image,
//                           buyerName: namaPembeli,
//                           stok: stk,
//                           buyerAddress: tanggal,
//                           // status: status
//                         );
//                         checkOut(checkOutModels, context);
//                         // final usec = await FirebaseFirestore.instance
//                         //     .collection('products')
//                         //     .doc(user!.uid)
//                         //     .get();
//                         // var tken = usec['idUser'];
//                         // print("token sya $tken");
//                         // String name = tlp.text;
//                         String ttl = 'Orderan';
//                         String bd = 'Pesanan Baru Masuk';
//                         // if (name != "") {
//                         DocumentSnapshot snapshot = await FirebaseFirestore
//                             .instance
//                             .collection('users')
//                             .doc(idProduk)
//                             .get();
//                         String token = snapshot['token'];
//                         print(token);
//                         sendNotificationToUser(token, bd, ttl);
//                         // }
//                         Navigator.pushAndRemoveUntil(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => BottomBarPembeli()),
//                             (route) => false);
//                       }
//                     }
//                   },
//                   child: Container(
//                     height: 50,
//                     margin: EdgeInsets.only(
//                         left: 15, right: 15, top: 20, bottom: 10),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       color: Colors.amber,
//                     ),
//                     child: Center(
//                       child: Text(
//                         'CheckOut',
//                         style: TextStyle(
//                             fontSize: 20,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold),
//                       ),
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

//   Future<void> sendNotificationToUser(
//       String token, String body, String title) async {
//     try {
//       await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
//           headers: <String, String>{
//             'Content-Type': 'application/json',
//             'Authorization':
//                 'key=AAAAt2yilIk:APA91bEXprO8GlwAH2G7DOI9KxAKAwYyXj1_ckqg-FX8BGtNbodyyzvml-QxitkeByaKo2JJNnidGi8PyLaCzGrLm0BxQeX0xkYa7VuMnBRq-1gqewHiFnY8Cce274RtLHILXIy-H2wj',
//           },
//           body: jsonEncode(<String, dynamic>{
//             'priority': 'high',
//             'data': <String, dynamic>{
//               'click_action': 'FLUTTER_NOTIFICATION_CLICK',
//               'status': 'done',
//               'body': body,
//               'title': title,
//             },
//             "notification": <String, dynamic>{
//               "title": title,
//               "body": body,
//               "android_channel_id": "dbfood"
//             },
//             "to": token,
//           }));
//     } catch (e) {
//       if (kDebugMode) {
//         print('notif tidak terkirim');
//       }
//     }
//   }
// }
import 'dart:convert';

import 'package:aplikasi/models/orderModels.dart';
import 'package:aplikasi/service/Firebase_service.dart';
import 'package:aplikasi/service/userCheckOut.dart';
import 'package:aplikasi/widgets/bottom_bar_pembeli.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class Checkout extends StatelessWidget {
  final List<OrderModels> selectedProducts;
  final int totalHargaKeseluruhan;

  Checkout(
      {required this.selectedProducts, required this.totalHargaKeseluruhan});

  Future<void> addToCheckoutCollection(
      List<OrderModels> selectedProducts) async {
    final CollectionReference checkoutCollection =
        FirebaseFirestore.instance.collection('checkout');
    String tanggal = DateFormat.yMd().add_jm().format(DateTime.now());
    final auth = FirebaseAuth.instance.currentUser!.uid;
    for (var product in selectedProducts) {
      await checkoutCollection.add({
        'idPembeli': auth,
        'productId': product.productId,
        'status': 'Dalam Proses',
        'alamat': product.alamat,
        'noPembeli': product.noPembeli,
        'namaPembeli': product.buyerName,
        'tglPembelian': tanggal,
        'totalBelanja': product.totalBelanja,
        'productName': product.productName,
        'productPrice': product.productPrice,
        'productImageUrl': product.productImageUrl,
        // tambahkan field lain sesuai kebutuhan
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          UserCheckOut(),
          Container(
            height: 1,
            color: Colors.grey,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: selectedProducts.length,
              itemBuilder: (context, index) {
                final product = selectedProducts[index];
                return FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('keranjang')
                      .doc(product.id)
                      .get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error');
                    }

                    if (snapshot.connectionState == ConnectionState.done) {
                      // if (snapshot.hasData) {
                      //   final data = snapshot.data;
                      //   final imageUrl = data?['productImageUrl'];

                      return Column(
                        children: [
                          Container(
                            // margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                            padding: EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                              color: Colors.white,
                              // boxShadow: [
                              //   BoxShadow(
                              //     color: Colors.blueGrey.shade200,
                              //     blurRadius: 5,
                              //     spreadRadius: 0.2,
                              //     offset: Offset(0, 3),
                              //   ),
                              // ],
                            ),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.productName.toString(),
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      children: [
                                        Text(
                                          'Total belanja: ',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Text(
                                          formatRupiah(
                                              product.totalBelanja.toString()),
                                          style: TextStyle(fontSize: 16.0),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      children: [
                                        Text(
                                          'Harga Satuan: ${formatRupiah(product.productPrice.toString())}',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Text(
                                          'Jumlah: ',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Text(
                                          product.entiti.toString(),
                                          style: TextStyle(fontSize: 16.0),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    // Text(
                                    //   data?['buyerAddress'],
                                    //   style: TextStyle(
                                    //       fontSize: 14.0, color: Colors.teal),
                                    // ),
                                  ],
                                ),
                                Spacer(),
                                // Tambahkan widget Image.network untuk menampilkan gambar
                                Image.network(
                                  product.productImageUrl.toString(),
                                  width: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 1,
                            color: Colors.grey,
                          ),
                        ],
                      );
                    }
                    return Container();
                  },
                );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.all(7),
            padding: EdgeInsets.only(left: 5, right: 5),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 16),
                  child: Row(
                    children: [
                      Text(
                        'Total Harga: ',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        formatRupiah(totalHargaKeseluruhan.toString()),
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    // Dapatkan data produk dari tabel keranjang
                    final keranjangCollection = FirebaseFirestore.instance
                        .collection('keranjang')
                        .get();
                    await keranjangCollection.then((value) async {
                      if (value.docChanges.isNotEmpty) {
                        for (var docChange in value.docChanges) {
                          final keranjangData = docChange.doc.data();
                          final idDocument = keranjangData!['idDocument'];
                          final entitas = keranjangData['entiti'];
                          final select = keranjangData['isSelected'];
                          final produkId = keranjangData['productId'];
                          String ttl = 'Orderan';
                          String bd = 'Pesanan Baru Masuk';

                          final userDoc = await FirebaseFirestore.instance
                              .collection('users')
                              .doc(produkId)
                              .get();
                          String token = userDoc.data()!['token'];
                          print(token);
                          sendNotificationToUser(token, bd, ttl);

                          if (select == true) {
                            // lakukan penjumlahan stok dengan entitas
                            final produkDoc = await FirebaseFirestore.instance
                                .collection('products')
                                .doc(idDocument)
                                .get();
                            final stokSaatIni = produkDoc.get('stok');
                            // final entitas = produkDoc.get('entiti');
                            var stokBaru =
                                int.parse(stokSaatIni) - int.parse(entitas);

                            // Perbarui stok produk di tabel produk
                            await FirebaseFirestore.instance
                                .collection('products')
                                .doc(idDocument)
                                .update({'stok': stokBaru.toString()});
                            // Hapus data dari tabel keranjang
                            await FirebaseFirestore.instance
                                .collection('keranjang')
                                .doc(docChange.doc.id)
                                .delete();
                          }
                        }
                      }
                    });

                    await addToCheckoutCollection(selectedProducts);

                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BottomBarPembeli()),
                        (route) => false);
                  },
                  child: Row(
                    children: [
                      Text(
                        'Beli',
                        style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Icon(
                        Icons.shopping_cart_checkout_rounded,
                        color: Colors.teal,
                      )
                    ],
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

  Future<void> sendNotificationToUser(
      String token, String body, String title) async {
    try {
      await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization':
                'key=AAAAt2yilIk:APA91bEXprO8GlwAH2G7DOI9KxAKAwYyXj1_ckqg-FX8BGtNbodyyzvml-QxitkeByaKo2JJNnidGi8PyLaCzGrLm0BxQeX0xkYa7VuMnBRq-1gqewHiFnY8Cce274RtLHILXIy-H2wj',
          },
          body: jsonEncode(<String, dynamic>{
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'body': body,
              'title': title,
            },
            "notification": <String, dynamic>{
              "title": title,
              "body": body,
              "android_channel_id": "dbfood"
            },
            "to": token,
          }));
    } catch (e) {
      if (kDebugMode) {
        print('notif tidak terkirim');
      }
    }
  }
}
