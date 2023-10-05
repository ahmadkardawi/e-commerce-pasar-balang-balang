import 'package:flutter/material.dart';
import 'package:aplikasi/models/userModels.dart';
import 'package:aplikasi/service/Firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RiwayatPengiriman extends StatefulWidget {
  @override
  State<RiwayatPengiriman> createState() => _RiwayatPengirimanState();
}

class _RiwayatPengirimanState extends State<RiwayatPengiriman> {
  UserModel userModel = UserModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.teal,
        title: Text('Riwayat Pengiriman'),
      ),
      body: ListView(
        children: [
          _buildDeliveryItem(),
        ],
      ),
    );
  }

  Widget _buildDeliveryItem() {
    final auth = FirebaseAuth.instance;
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    // TextEditingController _nameController = TextEditingController();
    @override
    void initState() {
      super.initState();
      users.doc(auth.currentUser!.uid).get().then((value) {
        this.userModel = UserModel.fromJson(value.data());
        setState(() {});
      });
    }

    final _usersStream = FirebaseFirestore.instance
        .collection('checkout')
        .where('productId', isEqualTo: auth.currentUser!.uid)
        .where('status', isEqualTo: 'Telah Dikirim')
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
              itemCount: snapshot.data!.docs.length,
              itemBuilder: ((context, index) => Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    padding: EdgeInsets.all(16.0),
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
                            Row(
                              children: [
                                Text(
                                  'Pelanggan: ',
                                  style: TextStyle(fontSize: 16.0),
                                ),
                                Text(
                                  snapshot.data!.docs[index]['namaPembeli'],
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.0),
                            Row(
                              children: [
                                Text(
                                  'Tanggal: ',
                                  style: TextStyle(fontSize: 16.0),
                                ),
                                Text(
                                  snapshot.data!.docs[index]['tglPembelian'],
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.0),
                            Row(
                              children: [
                                Text(
                                  'Total: ',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  formatRupiah(snapshot.data!.docs[index]
                                      ['totalBelanja']),
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.0),
                            Row(
                              children: [
                                const Text(
                                  'Status: ',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  snapshot.data!.docs[index]['status'],
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: snapshot.data!.docs[index]
                                                ['status'] ==
                                            'Telah Dikirim'
                                        ? Colors.orange
                                        : snapshot.data!.docs[index]
                                                    ['status'] ==
                                                'Dalam proses'
                                            ? Colors.blue
                                            : Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: Image.network(
                            snapshot.data!.docs[index]['productImageUrl'],
                            width: 100.0,
                            // height: 50.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  )));
        });
  }
}

// class PesananMasukService extends StatefulWidget {
//   PesananMasukService({super.key});

//   @override
//   State<PesananMasukService> createState() => _PesananMasukServiceState();
// }

// class _PesananMasukServiceState extends State<PesananMasukService> {
//   @override
//   Widget build(BuildContext context) {
//     String? produk = userModel.uid;
//     final _usersStream = FirebaseFirestore.instance
//         .collection('keranjang')
//         .where('productId', isEqualTo: produk)
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
//           itemBuilder: ((context, index) => SingleChildScrollView(
//                 child: GestureDetector(
//                   onTap: (() {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => DetailPesananMasuk(
//                           docuid: snapshot.data!.docs[index],
//                         ),
//                       ),
//                     );
//                   }),
//                   child: Container(
//                     margin:
//                         EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//                     padding: EdgeInsets.all(16.0),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(16.0),
//                       color: Colors.white,
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.5),
//                           blurRadius: 5,
//                           offset: Offset(0, 3),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(16.0),
//                           child: Image.network(
//                             snapshot.data!.docs[index]['productImageUrl'],
//                             width: 400.0,
//                             height: 150.0,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         SizedBox(height: 16.0),
//                         Row(
//                           children: [
//                             Text(
//                               'Pelanggan: ',
//                               style: TextStyle(fontSize: 16.0),
//                             ),
//                             Text(
//                               snapshot.data!.docs[index]['buyerName'],
//                               style: TextStyle(fontSize: 16.0),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 8.0),
//                         Row(
//                           children: [
//                             Text(
//                               'Tanggal Pesan: ',
//                               style: TextStyle(fontSize: 16.0),
//                             ),
//                             Text(
//                               snapshot.data!.docs[index]['buyerAddress'],
//                               style: TextStyle(fontSize: 16.0),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 8.0),
//                         Row(
//                           children: [
//                             Text(
//                               'Total: ',
//                               style: TextStyle(
//                                 fontSize: 16.0,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             Text(
//                               formatRupiah(
//                                   snapshot.data!.docs[index]['totalPrice']),
//                               style: TextStyle(
//                                 fontSize: 16.0,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 8.0),
//                         Row(
//                           children: [
//                             Text(
//                               'Status: ',
//                               style: TextStyle(
//                                 fontSize: 16.0,
//                                 // color: snapshot.data!.docs[index]['status'] == 'Menunggu konfirmasi'
//                                 //     ? Colors.orange
//                                 //     : snapshot.data!.docs[index]['status'] == 'Dalam proses'
//                                 //         ? Colors.blue
//                                 //         : Colors.green,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             Text(
//                               snapshot.data!.docs[index]['status'],
//                               style: TextStyle(
//                                 fontSize: 16.0,
//                                 color: snapshot.data!.docs[index]['status'] ==
//                                         'Telah Dikirim'
//                                     ? Colors.orange
//                                     : snapshot.data!.docs[index]['status'] ==
//                                             'Dalam proses'
//                                         ? Colors.blue
//                                         : Colors.green,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               )),
//         );
//       },
//     );
//   }
// }
