// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../service/Firebase_service.dart';

class Produks extends StatefulWidget {
  const Produks({Key? key}) : super(key: key);

  @override
  State<Produks> createState() => _ProduksState();
}

class _ProduksState extends State<Produks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error ${snapshot}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            final data = snapshot.data!.docs;
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: ((context, index) {
                  final produkData = data[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Container(
                        margin:
                            EdgeInsets.only(bottom: 10, left: 10, right: 10),
                        padding: EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: Colors.white.withOpacity(0.2),
                        ),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  produkData.get('namaProduk'),
                                  style: TextStyle(fontSize: 22),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Nama Pedagang: ${produkData.get('name')}',
                                  style: TextStyle(fontSize: 17),
                                ),
                                Text(
                                  'Harga: ${formatRupiah(produkData.get('price'))}',
                                  style: TextStyle(fontSize: 17),
                                ),
                                Text(
                                  'Tgl Posting: ${produkData.get('tanggal')}',
                                  style: TextStyle(color: Colors.tealAccent),
                                ),
                              ],
                            ),
                            Spacer(),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: Image.network(
                                produkData.get('imageUrl'),
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
                }));
          }
          return Container();
        },
      ),
    );
  }
}
