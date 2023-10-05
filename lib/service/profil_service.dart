import 'package:aplikasi/models/userModels.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

final auth = FirebaseAuth.instance;
CollectionReference users = FirebaseFirestore.instance.collection('users');

class _ProfilePageState extends State<ProfilePage> {
  UserModel userModel = UserModel();

  // TextEditingController _nameController = TextEditingController();
  @override
  void initState() {
    super.initState();
    users.doc(auth.currentUser!.uid).get().then((value) {
      this.userModel = UserModel.fromJson(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    String? uuid = userModel.uid;

    return StreamBuilder<DocumentSnapshot>(
      stream:
          FirebaseFirestore.instance.collection('users').doc(uuid).snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (!snapshot.hasData) {
          return Text('No data found!');
        }
        final data = snapshot.data!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              data['name'],
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Email:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              data['email'],
              style: TextStyle(fontSize: 18),
            ),
            // Text('Jln. Poros Malino'),
            SizedBox(height: 16.0),
            Text(
              'No. Telepon:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              data['noHp'],
              style: TextStyle(fontSize: 18),
            ),
          ],
        );
      },
    );
  }
}
