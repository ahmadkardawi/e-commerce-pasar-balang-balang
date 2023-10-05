import 'package:aplikasi/models/userModels.dart';
import 'package:aplikasi/pages/login_regis/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilPedagang extends StatefulWidget {
  @override
  State<ProfilPedagang> createState() => _ProfilPedagangState();
}

final auth = FirebaseAuth.instance;
CollectionReference usersku = FirebaseFirestore.instance.collection('users');

class _ProfilPedagangState extends State<ProfilPedagang> {
  CollectionReference users = FirebaseFirestore.instance.collection('products');
  final loginUser = FirebaseAuth.instance.currentUser;

  Future<void> datang() async {
    final productsRef = FirebaseFirestore.instance.collection('products');
    final productsSnapshot =
        await productsRef.where('idUser', isEqualTo: loginUser!.uid).get();

    for (final doc in productsSnapshot.docs) {
      await productsRef.doc(doc.id).update({
        'keterangan': 'Buka',
        // tambahkan field-field lain yang ingin diupdate
      });
    }
  }

  Future<void> tidakDatang() async {
    final productsRef = FirebaseFirestore.instance.collection('products');
    final productsSnapshot =
        await productsRef.where('idUser', isEqualTo: loginUser!.uid).get();

    for (final doc in productsSnapshot.docs) {
      await productsRef.doc(doc.id).update({
        'keterangan': 'Tutup',
      });
    }
  }

  // Future<void> datang() {
  //   return users
  //       .doc('UHPvSm1vqb2kH1TMghlr')
  //       .update({'statusBarang': 'Datang'})
  //       .then((value) => print("User Updated"))
  //       .catchError((error) => print("Failed to update user: $error"));
  // }

  UserModel userModel = UserModel();

  // TextEditingController _nameController = TextEditingController();
  @override
  void initState() {
    super.initState();
    usersku.doc(auth.currentUser!.uid).get().then((value) {
      this.userModel = UserModel.fromJson(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    String? uuid = userModel.uid;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(uuid)
            .snapshots(),
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
            children: <Widget>[
              SizedBox(height: 30),
              Center(
                child: CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage('assets/images/profil.png'),
                ),
              ),
              SizedBox(height: 30),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      spreadRadius: 1.0,
                      blurRadius: 0.5,
                      offset: Offset.zero,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Nama: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(data['name']),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Alamat:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('Jln. Poros Malino'),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'No. Telepon:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(data['noHp']),
                      ],
                    ),
                    SizedBox(height: 30),
                    Center(
                      child: Text('Keterangan : '),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            tidakDatang();
                          },
                          child: Text('Tutup'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shadowColor: Colors.greenAccent),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            datang();
                          },
                          child: Text('Buka'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shadowColor: Colors.redAccent),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
