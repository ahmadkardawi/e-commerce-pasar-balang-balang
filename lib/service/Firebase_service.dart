// import 'package:aplikasi/core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// void addProduct(ProductModel productModel) async {
//   ProductModel productModel = ProductModel();
//   final user = FirebaseAuth.instance.currentUser;
//   final firestore = FirebaseFirestore.instance;
//   // String? userr = userModel.email = user!.email;
//   String? userId = user!.uid;

//   final productData = {
//     'namproduk': productModel.namaproduk,
//     'pejual': productModel.namaPenjual,
//     'harga': productModel.price,
//     'jenisbarang': productModel.jenisproduk,
//     'userId': userId,
//   };

//   await FirebaseFirestore.instance.collection('products').add(productData);
// }
import 'package:aplikasi/models/checkoutModels.dart';
import 'package:aplikasi/models/orderModels.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

Future<void> order(OrderModels order, BuildContext context) {
  CollectionReference products =
      FirebaseFirestore.instance.collection('keranjang');

  return products
      .add(order.toMap())
      .then((value) => QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            title: 'Berhasil',
            // text: 'Produk Berhasil Di ',
          ))
      .catchError((error) => print("Failed to add product: $error"));
}

Future<void> checkOut(CheckOutModels checkOutModels, BuildContext context) {
  CollectionReference products =
      FirebaseFirestore.instance.collection('checkout');

  return products
      .add(checkOutModels.toMap())
      .then((value) => QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            title: 'Berhasil',
            // text: 'Produk Berhasil Di ',
          ))
      .catchError((error) => print("Failed to add product: $error"));
}

String formatRupiah(String amount) {
  final formatter =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
  return formatter.format(double.parse(amount));
}

// void saveDeviceToken() async {
//   final user = FirebaseAuth.instance.currentUser;
//   final token = await FirebaseMessaging.instance.getToken();

//   if (user != null && token != null) {
//     final deviceTokensRef = FirebaseFirestore.instance.collection('users');
//     // .doc(user.uid);

//     await deviceTokensRef.doc(user.uid).set({
//       'createdAt': FieldValue.serverTimestamp(),
//     });
//   }
// }
