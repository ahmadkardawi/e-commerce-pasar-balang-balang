import 'package:aplikasi/pages/pages_pembeli/kategori/buah.dart';
import 'package:aplikasi/pages/pages_pembeli/kategori/ikan.dart';
import 'package:aplikasi/pages/pages_pembeli/kategori/rempah.dart';
import 'package:aplikasi/pages/pages_pembeli/kategori/sayur.dart';
import 'package:aplikasi/pages/pages_pembeli/profil.dart';
import 'package:aplikasi/service/pesan_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePembeli extends StatefulWidget {
  const HomePembeli({super.key});

  @override
  State<HomePembeli> createState() => _HomePembeliState();
}

class _HomePembeliState extends State<HomePembeli> {
  final List<String> imgList = [
    'assets/images/slide5.jpg',
    'assets/images/slide6.jpg',
    'assets/images/slide7.jpg',
    'assets/images/slide4.jpg',
  ];

  User? user;

  @override
  void initState() {
    super.initState();
    // getUser();
  }

  // getUser() async {
  //   User? firebaseUser = _auth.currentUser;
  //   await firebaseUser?.reload();
  //   firebaseUser = _auth.currentUser;

  //   if (firebaseUser != null) {
  //     // setState(() {
  //     //   this.user = firebaseUser;
  //     // });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            // SizedBox(height: 20),
            Row(
              children: [
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Selamat Datang'),
                    SizedBox(height: 8),
                    Text(
                      'Di Pasar Balang Balang',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    )
                  ],
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Profil(),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: CircleAvatar(
                      radius: 30.0,
                      backgroundImage: AssetImage('assets/images/profil.png'),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            CarouselSlider(
              items: imgList.map((url) {
                return Container(
                  // margin: EdgeInsets.all(10),
                  // height: 170,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueGrey.shade200,
                          blurRadius: 5.0,
                          spreadRadius: 2.0,
                        ),
                      ]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      url,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 16 / 9,
                enlargeCenterPage: true,
                enableInfiniteScroll: true,
                initialPage: 0,
                autoPlayCurve: Curves.fastOutSlowIn,
                // autoPlayDuration: Duration(milliseconds: 2000),
                viewportFraction: 0.8,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text(
                    'Kategory',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800),
                  ),
                  SizedBox(height: 15),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Ikan(),
                              ),
                            );
                          },
                          child: Container(
                            width: 100,
                            margin: EdgeInsets.only(right: 10, bottom: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blueGrey.shade200,
                                  offset: Offset(0, 3),
                                  blurRadius: 5.0,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 40.0,
                                  backgroundImage:
                                      AssetImage('assets/images/ikann.jpg'),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'IKAN',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade800),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Buah(),
                              ),
                            );
                          },
                          child: Container(
                            width: 100,
                            margin: EdgeInsets.only(right: 10, bottom: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blueGrey.shade200,
                                    offset: Offset(0, 3),
                                    blurRadius: 5.0,
                                  ),
                                ]),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 40.0,
                                  backgroundImage:
                                      AssetImage('assets/images/buah.png'),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'BUAH',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade800),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Rempah(),
                              ),
                            );
                          },
                          child: Container(
                            width: 100,
                            margin: EdgeInsets.only(right: 10, bottom: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blueGrey.shade200,
                                    offset: Offset(0, 3),
                                    blurRadius: 5.0,
                                  ),
                                ]),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 40.0,
                                  backgroundImage:
                                      AssetImage('assets/images/rempah.jpg'),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'REMPAH',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade800),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Sayur(),
                              ),
                            );
                          },
                          child: Container(
                            width: 100,
                            margin: EdgeInsets.only(right: 10, bottom: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blueGrey.shade200,
                                    offset: Offset(0, 3),
                                    blurRadius: 5.0,
                                  ),
                                ]),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 40.0,
                                  backgroundImage:
                                      AssetImage('assets/images/sayur.jpg'),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'SAYUR',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade800),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // GestureDetector(
                        //   onTap: () {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //         builder: (context) => Campuran(),
                        //       ),
                        //     );
                        //   },
                        //   child: Container(
                        //     width: 100,
                        //     margin: EdgeInsets.only(right: 10, bottom: 10),
                        //     decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(20),
                        //         color: Colors.white,
                        //         boxShadow: [
                        //           BoxShadow(
                        //             color: Colors.blueGrey.shade200,
                        //             offset: Offset(0, 3),
                        //             blurRadius: 5.0,
                        //           ),
                        //         ]),
                        //     child: Column(
                        //       children: [
                        //         CircleAvatar(
                        //           radius: 40.0,
                        //           backgroundImage:
                        //               AssetImage('assets/images/campuran.jpg'),
                        //         ),
                        //         SizedBox(height: 5),
                        //         Text(
                        //           'CAMPURAN',
                        //           style: TextStyle(
                        //               fontSize: 15,
                        //               fontWeight: FontWeight.bold,
                        //               color: Colors.grey.shade800),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Semua',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800),
                  ),
                  SingleChildScrollView(child: PesanService()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
