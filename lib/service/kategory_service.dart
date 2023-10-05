import 'package:aplikasi/cobaa/badges.dart';
import 'package:aplikasi/service/Firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class KategoryService extends StatelessWidget {
  var collection;
  KategoryService({super.key, required this.collection});
  // TextEditingController _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: collection,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.data!.docs.isEmpty) {
          return Center(
            child: Lottie.network(
                'https://assets6.lottiefiles.com/packages/lf20_rc6CDU.json'),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        return ListView.builder(
          shrinkWrap: true,
          // scrollDirection: Axis.vertical,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: ((context, index) =>
              Flex(direction: Axis.vertical, children: [
                Row(
                  children: [
                    Flexible(
                      // flex: 3,
                      child: Container(
                        // width: double.infinity,
                        margin: EdgeInsets.all(10),
                        // height: 170,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueGrey.shade200,
                              blurRadius: 5.0,
                              spreadRadius: 2.0,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                              child: Image.network(
                                snapshot.data!.docs[index]['imageUrl'],
                                height: 100,
                                width: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data!.docs[index]['namaProduk'],
                                  style: const TextStyle(
                                    color: Colors.teal,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  snapshot.data!.docs[index]['name'],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  formatRupiah(
                                      snapshot.data!.docs[index]['price']),
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            // Spacer(),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Badges(docuid: snapshot.data!.docs[index]),
                          ),
                        );
                      },
                      child: Flexible(
                        // flex: 1,
                        child: Container(
                          width: 60,
                          height: 100,
                          // margin: EdgeInsets.only(right: 10),
                          // padding: EdgeInsets.only(top: 5, bottom: 5),
                          decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blueGrey.shade200,
                                  blurRadius: 5.0,
                                  spreadRadius: 2.0,
                                ),
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Beli",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 5),
                              Icon(
                                Icons.shopping_cart_checkout_outlined,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ])),
        );
      },
    );
  }
}
