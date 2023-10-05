// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class SearchPage extends StatefulWidget {
//   @override
//   _SearchPageState createState() => _SearchPageState();
// }

// class _SearchPageState extends State<SearchPage> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final TextEditingController _searchController = TextEditingController();
//   String _productName = '';
//   String _cheapestProduct = '';

//   void _search() {
//     String keyword = _searchController.text;

//     // Mengambil data dari Firebase
//     _firestore
//         .collection('products')
//         .where('namaProduk', isEqualTo: keyword)
//         .orderBy('price')
//         .limit(1)
//         .get()
//         .then((QuerySnapshot<Map<String, dynamic>> snapshot) {
//       if (snapshot.docs.isNotEmpty) {
//         setState(() {
//           _productName = snapshot.docs[0]['namaProduk'];
//           _cheapestProduct = snapshot.docs[0]['price'].toString();
//         });
//       } else {
//         setState(() {
//           _productName = 'Produk tidak ditemukan';
//           _cheapestProduct = '';
//         });
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Halaman Pencarian'),
//       ),
//       body: Column(
//         children: [
//           TextFormField(
//             controller: _searchController,
//             decoration: InputDecoration(
//               labelText: 'Keyword Pencarian',
//             ),
//           ),
//           ElevatedButton(
//             onPressed: _search,
//             child: Text('Cari'),
//           ),
//           SizedBox(height: 20),
//           Text(
//             'Produk Terbaru: $_productName',
//             style: TextStyle(fontSize: 16),
//           ),
//           Text(
//             'Harga Termurah: $_cheapestProduct',
//             style: TextStyle(fontSize: 16),
//           ),
//         ],
//       ),
//     );
//   }
// }
