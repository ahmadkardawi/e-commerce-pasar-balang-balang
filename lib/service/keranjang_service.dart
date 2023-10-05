// import 'package:aplikasi/models/userModels.dart';
// import 'package:aplikasi/pages/pages_pembeli/chechkout.dart';
// import 'package:aplikasi/service/Firebase_service.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class KeranjangService extends StatefulWidget {
//   KeranjangService({super.key});

//   @override
//   State<KeranjangService> createState() => _KeranjangServiceState();
// }

// final auth = FirebaseAuth.instance;
// CollectionReference users = FirebaseFirestore.instance.collection('users');

// class _KeranjangServiceState extends State<KeranjangService> {
//   UserModel userModel = UserModel();
//   // TextEditingController _nameController = TextEditingController();
//   @override
//   void initState() {
//     super.initState();
//     users.doc(auth.currentUser!.uid).get().then((value) {
//       this.userModel = UserModel.fromJson(value.data());
//       setState(() {});
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     String? produk = userModel.uid;
//     final _usersStream = FirebaseFirestore.instance
//         .collection('keranjang')
//         .where('id', isEqualTo: produk)
//         // .where('keranjang', isEqualTo: 'keranjang')
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
//         return ListView.builder(
//           shrinkWrap: true,
//           itemCount: snapshot.data!.docs.length,
//           itemBuilder: ((context, index) => Container(
//                 margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
//                 padding: EdgeInsets.all(20.0),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(16.0),
//                   color: Colors.white,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.blueGrey.shade200,
//                       blurRadius: 5,
//                       spreadRadius: 0.2,
//                       offset: Offset(0, 3),
//                     ),
//                   ],
//                 ),
//                 child: Row(
//                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           snapshot.data!.docs[index]['productName'],
//                           style: TextStyle(
//                               fontSize: 20.0, fontWeight: FontWeight.bold),
//                         ),
//                         SizedBox(height: 8.0),
//                         Row(
//                           children: [
//                             Text(
//                               'Kuantitas: ',
//                               style: TextStyle(fontSize: 16),
//                             ),
//                             Text(
//                               snapshot.data!.docs[index]['entiti'],
//                               style: TextStyle(fontSize: 16.0),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 8.0),
//                         Text(
//                           formatRupiah(
//                               snapshot.data!.docs[index]['productPrice']),
//                         ),
//                         SizedBox(height: 8.0),
//                         Text(
//                           snapshot.data!.docs[index]['buyerAddress'],
//                           style: TextStyle(fontSize: 12, color: Colors.amber),
//                         ),
//                       ],
//                     ),
//                     Spacer(),
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(16.0),
//                       child: Image.network(
//                         snapshot.data!.docs[index]['productImageUrl'],
//                         width: 100.0,
//                         // height: 50.0,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     SizedBox(width: 10),
//                     IconButton(
//                       icon: Icon(
//                         Icons.navigate_next_outlined,
//                         color: Colors.teal,
//                         size: 30,
//                       ),
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => ChechkOut(
//                               snapshot: snapshot.data!.docs[index],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               )),
//         );
//       },
//     );
//   }
// }
