import 'package:aplikasi/models/userModels.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserCheckOut extends StatefulWidget {
  @override
  State<UserCheckOut> createState() => _UserCheckOutState();
}

final auth = FirebaseAuth.instance;
CollectionReference users = FirebaseFirestore.instance.collection('users');

class _UserCheckOutState extends State<UserCheckOut> {
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
        return Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5),
              Text(
                'Alamat : ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                data['alamat'],
                style: TextStyle(fontSize: 18),
              ),
              Row(
                children: [
                  Text(
                    'Nama : ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    data['name'],
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Text(
                    'Tlp : ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    data['noHp'],
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}
