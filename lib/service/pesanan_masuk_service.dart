import 'package:aplikasi/models/userModels.dart';
import 'package:aplikasi/pages/pages_pedagang/detail_pesanan_masuk.dart';
import 'package:aplikasi/service/Firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PesananMasukService extends StatefulWidget {
  PesananMasukService({super.key});

  @override
  State<PesananMasukService> createState() => _PesananMasukServiceState();
}

final auth = FirebaseAuth.instance;
CollectionReference users = FirebaseFirestore.instance.collection('users');

class _PesananMasukServiceState extends State<PesananMasukService> {
  UserModel userModel = UserModel();
  // TextEditingController _nameController = TextEditingController();
  var dataCount = 0;
  @override
  void initState() {
    super.initState();
    // initializeNotifications();
    users.doc(auth.currentUser!.uid).get().then((value) {
      this.userModel = UserModel.fromJson(value.data());
      setState(() {});
    });
  }

  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();

  // void initializeNotifications() async {
  //   // Inisialisasi notifikasi lokal
  //   const AndroidInitializationSettings initializationSettingsAndroid =
  //       AndroidInitializationSettings('@mipmap/ic_launcher');
  //   final InitializationSettings initializationSettings =
  //       InitializationSettings(android: initializationSettingsAndroid);
  //   await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  // }

  // void notification() async {
  //   String? title;
  //   String? body;
  //   const AndroidNotificationDetails androidPlatformChannelSpecifics =
  //       AndroidNotificationDetails(
  //     'your_channel_id',
  //     'your_channel_name',
  //     // 'your_channel_description',
  //     importance: Importance.max,
  //     priority: Priority.high,
  //   );
  //   const NotificationDetails platformChannelSpecifics =
  //       NotificationDetails(android: androidPlatformChannelSpecifics);

  //   await flutterLocalNotificationsPlugin.periodicallyShow(
  //     // 0, // id notifikasi
  //     // 'Judul Notifikasi', // judul notifikasi
  //     // 'Isi Notifikasi', // isi notifikasi
  //     // platformChannelSpecifics,
  //     0,
  //     title,
  //     body,
  //     RepeatInterval.daily,
  //     platformChannelSpecifics,
  //   );
  // }

  // Future<void> showNotification() async {
  //   const AndroidNotificationDetails androidPlatformChannelSpecifics =
  //       AndroidNotificationDetails(
  //     'channel_id',
  //     'channel_name',
  //     // 'channel_description',
  //     importance: Importance.max,
  //     priority: Priority.high,
  //   );

  //   const NotificationDetails platformChannelSpecifics = NotificationDetails(
  //     android: androidPlatformChannelSpecifics,
  //     // iOS: iOSPlatformChannelSpecifics,
  //   );

  //   // await flutterLocalNotificationsPlugin.show(
  //   //   0, // id notifikasi (dapat diganti dengan id unik)
  //   //   'Judul Notifikasi',
  //   //   'Ini adalah pesan notifikasi',
  //   //   platformChannelSpecifics,
  //   //   payload: 'notif_payload', // data tambahan yang dapat Anda tambahkan
  //   // );

  //   await flutterLocalNotificationsPlugin.periodicallyShow(
  //     // 0, // id notifikasi
  //     // 'Judul Notifikasi', // judul notifikasi
  //     // 'Isi Notifikasi', // isi notifikasi
  //     // platformChannelSpecifics,
  //     0,
  //     'Notif Masuk',
  //     'Masuk',
  //     RepeatInterval.everyMinute,
  //     platformChannelSpecifics,
  //   );
  // }

  // bool _isNotificationShown = true;

  @override
  Widget build(BuildContext context) {
    String? produk = userModel.uid;
    final _usersStream = FirebaseFirestore.instance
        .collection('checkout')
        .where('productId', isEqualTo: produk)
        .where('status', isEqualTo: 'Dalam Proses')
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
        // if (documents.isNotEmpty) {
        //   // _isNotificationShown = true;
        //   // showNotification();
        //   // notification();
        // }
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: ((context, index) => GestureDetector(
                onTap: (() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPesananMasuk(
                        docuid: snapshot.data!.docs[index],
                      ),
                    ),
                  );
                }),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image.network(
                          snapshot.data!.docs[index]['productImageUrl'],
                          width: 400.0,
                          height: 150.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 16.0),
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
                            'Tanggal Pesan: ',
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
                            formatRupiah(
                                snapshot.data!.docs[index]['totalBelanja']),
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      // Row(
                      //   children: [
                      //     Text(
                      //       'Status: ',
                      //       style: TextStyle(
                      //         fontSize: 16.0,
                      //         // color: snapshot.data!.docs[index]['status'] == 'Menunggu konfirmasi'
                      //         //     ? Colors.orange
                      //         //     : snapshot.data!.docs[index]['status'] == 'Dalam proses'
                      //         //         ? Colors.blue
                      //         //         : Colors.green,
                      //         fontWeight: FontWeight.bold,
                      //       ),
                      //     ),
                      //     Text(
                      //       snapshot.data!.docs[index]['status'],
                      //       style: TextStyle(
                      //         fontSize: 16.0,
                      //         color: snapshot.data!.docs[index]['status'] ==
                      //                 'Telah Dikirim'
                      //             ? Colors.orange
                      //             : snapshot.data!.docs[index]['status'] ==
                      //                     'Dalam proses'
                      //                 ? Colors.blue
                      //                 : Colors.green,
                      //         fontWeight: FontWeight.bold,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              )),
        );
      },
    );
  }
}
