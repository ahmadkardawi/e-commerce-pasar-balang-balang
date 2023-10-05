import 'package:aplikasi/pages/pages_pedagang/detail_produk.dart';
import 'package:aplikasi/service/Firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeService extends StatefulWidget {
  HomeService({super.key});

  @override
  State<HomeService> createState() => _HomeServiceState();
}

class _HomeServiceState extends State<HomeService> {
  // TextEditingController _nameController = TextEditingController();

  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final _usersStream = FirebaseFirestore.instance
        .collection('products')
        .where('idUser', isEqualTo: auth.currentUser!.uid)
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Masih Kosong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: ((context, index) => Container(
                margin: EdgeInsets.only(bottom: 20, left: 10, right: 10),
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
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data!.docs[index]['jenisproduk'],
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          snapshot.data!.docs[index]['namaProduk'],
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          formatRupiah(snapshot.data!.docs[index]['price']),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          snapshot.data!.docs[index]['tanggal'],
                          style: TextStyle(fontSize: 12, color: Colors.amber),
                        ),
                      ],
                    ),
                    Spacer(),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.network(
                        snapshot.data!.docs[index]['imageUrl'],
                        width: 100.0,
                        // height: 50.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 10),
                    IconButton(
                      icon: Icon(
                        Icons.navigate_next_outlined,
                        color: Colors.teal,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailProduk(
                              docuid: snapshot.data!.docs[index],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }
}
