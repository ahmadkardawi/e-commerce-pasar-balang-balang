import 'package:aplikasi/pages/login_regis/login.dart';
import 'package:aplikasi/widgets/bottomBarPedagang.dart';
import 'package:aplikasi/widgets/bottom_bar_pembeli.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await FirebaseMessaging.instance.getInitialMessage();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPages(),
    );
  }
}

class MainScreeen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection("users")
                .doc(snapshot.data?.uid)
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> asyncSnapshot) {
              if (asyncSnapshot.hasData && asyncSnapshot.data != null) {
                final userDoc = asyncSnapshot.data;
                final user = userDoc?.data() as Map<String, dynamic>;
                if ((user)["role"] == 'pedagang') {
                  return BottomBarAdmin();
                } else {
                  return BottomBarPembeli();
                }
              } else if (asyncSnapshot.hasError) {
                return Material(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                // Akun pengguna belum terdaftar pada tabel users
                // Tampilkan tampilan login atau lakukan tindakan yang sesuai

                return LoginPages();
              }
            },
          );
        }
        return LoginPages();
      },
    );
  }
}
