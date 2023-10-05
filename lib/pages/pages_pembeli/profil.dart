import 'package:aplikasi/pages/login_regis/login.dart';
import 'package:aplikasi/service/profil_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Profil Saya'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            onPressed: () async {
              try {
                final auth = FirebaseAuth.instance;
                await auth.signOut();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => LoginPages(),
                    ),
                    (route) => false);
              } catch (e) {
                print('Error logging out: $e');
                // Tampilkan pesan kesalahan kepada pengguna atau lakukan tindakan lain yang sesuai
              }
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 40),
            Center(
              child: CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage('assets/images/profil.png'),
              ),
            ),
            SizedBox(height: 16.0),
            ProfilePage(),
          ],
        ),
      ),
    );
  }
}
