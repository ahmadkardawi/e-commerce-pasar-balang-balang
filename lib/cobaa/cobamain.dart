import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Latar Belakang Background ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(Main());
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  String? mtoken = " ";
  TextEditingController title = TextEditingController();
  TextEditingController usernama = TextEditingController();
  TextEditingController body = TextEditingController();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestPermission();
    getToken();
    initInfo();
  }

  void initInfo() {
    var androidInitialized =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: androidInitialized);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print('.............onMessage.................');
      print(
          'onMessage: ${message.notification?.title}/${message.notification?.body}');
      BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
        message.notification!.body.toString(),
        htmlFormatBigText: true,
        contentTitle: message.notification!.title.toString(),
        htmlFormatContentTitle: true,
      );
      AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails(
        'dbfood',
        'dbfood',
        importance: Importance.max,
        styleInformation: bigTextStyleInformation,
        priority: Priority.max,
        playSound: false,
      );
      NotificationDetails notificationDetails =
          NotificationDetails(android: androidNotificationDetails);
      await flutterLocalNotificationsPlugin.show(0, message.notification?.title,
          message.notification?.body, notificationDetails,
          payload: message.data['title']);
    });
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        mtoken = token;
        print('Token Sya $token');
      });
      savedToken(token!);
    });
  }

  Future<void> sendNotificationToUser(
      String token, String body, String title) async {
    try {
      await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization':
                'key=AAAAt2yilIk:APA91bEXprO8GlwAH2G7DOI9KxAKAwYyXj1_ckqg-FX8BGtNbodyyzvml-QxitkeByaKo2JJNnidGi8PyLaCzGrLm0BxQeX0xkYa7VuMnBRq-1gqewHiFnY8Cce274RtLHILXIy-H2wj',
          },
          body: jsonEncode(<String, dynamic>{
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'body': body,
              'title': title,
            },
            "notification": <String, dynamic>{
              "title": title,
              "body": body,
              "android_channel_id": "dbfood"
            },
            "to": token,
          }));
    } catch (e) {
      if (kDebugMode) {
        print('notif tidak terkirim');
      }
    }
  }

  void savedToken(String token) async {
    await FirebaseFirestore.instance.collection('token').doc('User3').set({
      'token': token,
    });
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User Granted');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('user granted profesional');
    } else {
      print('user declined');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Text('Notif'),
        ),
        body: Center(
          child: Column(
            children: [
              TextFormField(
                controller: usernama,
              ),
              TextFormField(
                controller: title,
              ),
              TextFormField(
                controller: body,
              ),
              GestureDetector(
                onTap: () async {
                  String name = usernama.text.trim();
                  String ttl = 'Notification';
                  String bd = 'Pesanan Masuk';
                  if (name != "") {
                    DocumentSnapshot snapshot = await FirebaseFirestore.instance
                        .collection('token')
                        .doc(name)
                        .get();

                    String token = snapshot['token'];
                    print(token);
                    sendNotificationToUser(token, bd, ttl);
                  }
                },
                child: Container(
                  margin: EdgeInsets.all(20),
                  height: 40,
                  width: 200,
                  decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.purpleAccent.withOpacity(0.5),
                        ),
                      ]),
                  child: Center(
                    child: Text('Send'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
