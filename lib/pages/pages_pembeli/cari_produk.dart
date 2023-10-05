import 'package:aplikasi/cobaa/badges.dart';
import 'package:aplikasi/service/Firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  Stream<QuerySnapshot>? _searchResults;
  // List _searchResults = [];

  void _performSearch(String query) {
    // var cari = query = _searchController.text;
    setState(() {
      _searchResults = FirebaseFirestore.instance
          .collection('products')
          .where('namaProduk', isEqualTo: query)
          // .where('jenisproduk', isEqualTo: query)
          // .where('namaProduk', isEqualTo: query + '\uf8ff')
          .orderBy('price')
          .limit(2)
          .snapshots();
      // final result = await FirebaseFirestore.instance
      //     .collection('products')
      //     .where('name', isEqualTo: query)
      //     .where('name', isEqualTo: query + '\uf8ff')
      //     .get()
      // .then((snapshot) {
      // setState(() {
      //   _searchResults = snapshot.docs;
      //   // _search = result.docs.map((e) => e.data()).toList();
      // });
      // }
      // )
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.teal,
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Cari produk',
            border: InputBorder.none,
            suffixIcon: IconButton(
              onPressed: () {
                _searchController.clear();
                setState(() {
                  _searchResults;
                  // _search = [];
                });
              },
              icon: Icon(
                Icons.clear,
                color: Colors.white,
              ),
            ),
          ),
          onChanged: (query) {
            if (query.isNotEmpty) {
              _performSearch(query);
            } else {
              setState(() {
                _searchResults;
                // _search = [];
              });
            }
          },
        ),
      ),
      body: _searchResults != null
          ? StreamBuilder<QuerySnapshot>(
              stream: _searchResults,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final searchResults = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      final data = searchResults[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Badges(
                                docuid: data,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              bottom: 20, left: 10, right: 10, top: 20),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data['name'],
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    data['namaProduk'],
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    formatRupiah(data['price']),
                                  ),
                                ],
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16.0),
                                child: Image.network(
                                  data['imageUrl'],
                                  width: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Container();
                }
              },
            )
          : Center(
              child: Lottie.network(
                'https://assets7.lottiefiles.com/packages/lf20_xbf1be8x.json',
              ),
            ),
    );
  }
}
