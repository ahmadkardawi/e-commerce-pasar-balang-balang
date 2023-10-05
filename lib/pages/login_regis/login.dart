import 'dart:ui';
import 'package:aplikasi/main.dart';
import 'package:aplikasi/pages/login_regis/regis.dart';
import 'package:aplikasi/service/profil_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:aplikasi/widgets/widgets_Form_Field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class LoginPages extends StatefulWidget {
  const LoginPages({super.key});

  @override
  State<LoginPages> createState() => _LoginPagesState();
}

class _LoginPagesState extends State<LoginPages> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
// Obtain shared preferences.
  bool isLoggedIn = false;
  String? userId;

  @override
  void initState() {
    super.initState();
    requestPermission();
    getToken();
    initInfo();
    // loginAkun();
    _emailController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
    // checkLoginStatus();
  }

  String? mtoken = " ";
  TextEditingController title = TextEditingController();
  TextEditingController usernama = TextEditingController();
  TextEditingController body = TextEditingController();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void initInfo() {
    var androidInitialized =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
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

  void savedToken(String token) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentSnapshot snapshots =
        await firestore.collection('users').doc(auth.currentUser!.uid).get();
    if (snapshots.exists) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(auth.currentUser!.uid)
          .update({
        'token': token,
      });
    }
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

  // void savedToken(String token) async {
  //   await FirebaseFirestore.instance.collection('users').doc().update({
  //     'token': token,
  //   });
  // }

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

  loginAkun({String? email, String? password}) async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    final res = await _auth.signInWithEmailAndPassword(
        email: email!, password: password!);
    final user = res.user!.uid;
    //  String token = userCredential.user!.uid;
    // savedToken(user);
    getToken();
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/Green.png',
              ),
              fit: BoxFit.fill,
            ),
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 5.0,
                  sigmaY: 5.0,
                ),
                child: Container(
                  height: 350,
                  margin: const EdgeInsets.only(right: 20, left: 20, bottom: 7),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white.withOpacity(0.4),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black54.withOpacity(0.1),
                            spreadRadius: 2.0,
                            blurRadius: 2.0),
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Masukkan Email',
                          style: TextStyle(
                            color: Colors.teal,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      WidgetFormField(
                        hintext: "Email",
                        controller: _emailController,
                      ),
                      const SizedBox(height: 10),
                      const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Masukkan Password',
                          style: TextStyle(
                            color: Colors.teal,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      WidgetFormField(
                        hintext: "Password",
                        controller: _passwordController,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            const Text(
                              'Belum Punya Akun? ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const RegisPages(),
                                  ),
                                );
                              },
                              child: const Text(
                                ' Daftar',
                                style: TextStyle(
                                  color: Colors.teal,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (_emailController.text.isEmpty ||
                              _passwordController.text.isEmpty) {
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.error,
                              title: 'Oops...',
                              text: 'Email dan Password harus di isi',
                            );
                            return;
                          }

                          final email = _emailController.text;
                          final password = _passwordController.text;

                          try {
                            final userSnapshot = await FirebaseFirestore
                                .instance
                                .collection('users')
                                .where('email', isEqualTo: email)
                                .get();

                            if (userSnapshot.docs.isNotEmpty) {
                              // Email ditemukan pada tabel 'users'
                              // Lakukan proses login
                              final user = await loginAkun(
                                  email: email, password: password);

                              if (user != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MainScreeen()),
                                );
                              }
                            } else {
                              // Email tidak ditemukan pada tabel 'users'
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.error,
                                title: 'Oops...',
                                text: 'Email tidak terdaftar',
                              );
                            }
                          } catch (e) {
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.error,
                              title: 'Oops...',
                              text: 'Terjadi kesalahan',
                            );
                          }
                        },
                        child: Container(
                          height: 50,
                          margin: const EdgeInsets.only(
                              left: 15, right: 15, top: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.lime,
                          ),
                          child: const Center(
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
