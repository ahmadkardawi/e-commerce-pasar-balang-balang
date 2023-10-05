// import 'dart:convert';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:http/http.dart' as http;

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   await FirebaseMessaging.instance.getInitialMessage();
//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//   String? mtoken = " ";
//   @override
//   void initState() {
//     super.initState();
//     requestPermission();
//     getToken();
//     initializeFirebaseMessaging();
//     initializeLocalNotifications();
//   }

//   void getToken() async {
//     await FirebaseMessaging.instance.getToken().then((token) {
//       setState(() {
//         mtoken = token;
//         print('Token Sya $token');
//       });
//       savedToken(token!);
//     });
//   }

//   void savedToken(String token) async {
//     await FirebaseFirestore.instance.collection('tokenuser').doc('User2').set({
//       'token': token,
//     });
//   }

//   void requestPermission() async {
//     FirebaseMessaging messaging = FirebaseMessaging.instance;
//     NotificationSettings settings = await messaging.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );

//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       print('User Granted');
//     } else if (settings.authorizationStatus ==
//         AuthorizationStatus.provisional) {
//       print('user granted profesional');
//     } else {
//       print('user declined');
//     }
//   }

//   Future<void> initializeFirebaseMessaging() async {
//     await _firebaseMessaging.requestPermission();
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       showLocalNotification(
//         message.notification?.title ?? '',
//         message.notification?.body ?? '',
//       );
//     });
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print('Notification clicked!');
//     });
//   }

//   Future<void> initializeLocalNotifications() async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//     final InitializationSettings initializationSettings =
//         InitializationSettings(android: initializationSettingsAndroid);
//     await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }

//   Future<void> showLocalNotification(String title, String body) async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//       'channel_id',
//       'channel_name',
//       // 'channel_description',
//       importance: Importance.max,
//       priority: Priority.high,
//       playSound: true,
//     );
//     const NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);
//     await _flutterLocalNotificationsPlugin.show(
//       0,
//       title,
//       body,
//       platformChannelSpecifics,
//     );
//   }

//   Future<void> sendNotificationToUser(
//       String userToken, String title, String body) async {
//     final postUrl = 'https://fcm.googleapis.com/fcm/send';

//     final data = {
//       'notification': {'body': body, 'title': title, 'sound': 'default'},
//       'priority': 'high',
//       'data': {
//         'click_action': 'FLUTTER_NOTIFICATION_CLICK',
//         'id': '1',
//         'status': 'done'
//       }
//     };

//     final headers = {
//       'Content-Type': 'application/json',
//       'Authorization':
//           'key=AAAAt2yilIk:APA91bEXprO8GlwAH2G7DOI9KxAKAwYyXj1_ckqg-FX8BGtNbodyyzvml-QxitkeByaKo2JJNnidGi8PyLaCzGrLm0BxQeX0xkYa7VuMnBRq-1gqewHiFnY8Cce274RtLHILXIy-H2wj' // Ganti dengan server key FCM Anda
//     };

//     await http.post(
//       Uri.parse(postUrl),
//       body: json.encode(data),
//       headers: headers,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Notification Example'),
//         ),
//         body: Center(
//           child: ElevatedButton(
//             child: const Text('Send Notification'),
//             onPressed: () {
//               String userToken =
//                   'ekdi4WsWTb21CX-GavGJAj:APA91bFyVShZLbxQPmxl5yH6sg1UxK76bJUPzbymgBlJk7e78z_QbvQwqaK15ozbXN5Cl8gAYLY0VN1Urb-puOj38gy-yyRCj2ouhlaxzpo7gphoe7VUYyxD2pJv5nIgAwZewi5W9YDH'; // Ganti dengan token FCM pengguna yang ingin Anda kirimi notifikasi
//               String title = 'Judul Notifikasi';
//               String body = 'Ini adalah isi notifikasi';

//               sendNotificationToUser(userToken, title, body);
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

// // import 'package:flutter/material.dart';
// // import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';

// // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// //     FlutterLocalNotificationsPlugin();

// // void main() async {
// //   WidgetsFlutterBinding.ensureInitialized();

// //   // Inisialisasi plugin Flutter Local Notification
// //   var initializationSettingsAndroid =
// //       AndroidInitializationSettings('@mipmap/ic_launcher');
// //   // var initializationSettingsIOS = IOSInitializationSettings();
// //   var initializationSettings = InitializationSettings(
// //     android: initializationSettingsAndroid,
// //     // iOS: initializationSettingsIOS,
// //   );
// //   await flutterLocalNotificationsPlugin.initialize(initializationSettings);

// //   runApp(MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Notification App',
// //       theme: ThemeData(
// //         primarySwatch: Colors.blue,
// //       ),
// //       home: HomePage(),
// //     );
// //   }
// // }

// // class HomePage extends StatefulWidget {
// //   @override
// //   _HomePageState createState() => _HomePageState();
// // }

// // class _HomePageState extends State<HomePage> {
// //   final CollectionReference _itemsCollection =
// //       FirebaseFirestore.instance.collection('items');

// //   bool _isNotificationShown = false; // Tambahkan variabel status

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Notification App'),
// //       ),
// //       body: StreamBuilder<QuerySnapshot>(
// //         stream: _itemsCollection.snapshots(),
// //         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
// //           if (snapshot.hasError) {
// //             return Text('Error: ${snapshot.error}');
// //           }

// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             return CircularProgressIndicator();
// //           }

// //           if (snapshot.hasData) {
// //             // Data baru telah diterima
// //             // Lakukan sesuatu dengan data yang diterima
// //             List<DocumentSnapshot> documents = snapshot.data!.docs;

// //             // Cek apakah ada data baru yang belum ditampilkan sebagai notifikasi
// //             if (documents.isNotEmpty && !_isNotificationShown) {
// //               _isNotificationShown = true; // Set status notifikasi ditampilkan
// //               showNotification('New Data', 'New data has arrived!');
// //             }

// //             // Tampilkan data pada ListView
// //             return ListView.builder(
// //               itemCount: documents.length,
// //               itemBuilder: (BuildContext context, int index) {
// //                 // Tampilkan item data pada index tertentu
// //                 return ListTile(
// //                   title: Text(documents[index]['title']),
// //                 );
// //               },
// //             );
// //           }

// //           // Tidak ada data yang diterima
// //           return Text('No data');
// //         },
// //       ),
// //     );
// //   }

// //   // Fungsi untuk menampilkan notifikasi
// //   void showNotification(String title, String body) async {
// //     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
// //       'channel_id',
// //       'channel_name',
// //       // 'channel_description',
// //       importance: Importance.max,
// //       priority: Priority.high,
// //     );
// //     // var iOSPlatformChannelSpecifics = IOSNotificationDetails();
// //     var platformChannelSpecifics = NotificationDetails(
// //       android: androidPlatformChannelSpecifics,
// //       // iOS: iOSPlatformChannelSpecifics,
// //     );

// //     await flutterLocalNotificationsPlugin.show(
// //       0,
// //       title,
// //       body,
// //       platformChannelSpecifics,
// //     );
// //   }
// // }
