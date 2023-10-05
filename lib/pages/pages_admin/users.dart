// import 'package:aplikasi/pages/pages_admin/produk.dart';
// import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Users extends StatefulWidget {
  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  CollectionReference firestore =
      FirebaseFirestore.instance.collection('users');
  User? userrr = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData) {
          final users = snapshot.data!.docs;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final userData = users[index];
              final nama = TextEditingController(text: userData.get('name'));
              final noHp = TextEditingController(text: userData.get('noHp'));
              final role = TextEditingController(text: userData.get('role'));
              // nama = TextEditingController(text: "");
              // email = TextEditingController(text: "");
              // role = TextEditingController(text: "");
              return ListTile(
                title: Text(userData.get('name')),
                subtitle: Text(userData.get('noHp')),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Edit User'),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  controller: nama,
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.person),
                                  ),
                                ),
                                TextFormField(
                                  controller: noHp,
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.call_outlined),
                                  ),
                                ),
                                TextFormField(
                                  controller: role,
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.accessibility_new),
                                  ),
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                child: Text('Cancel'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              TextButton(
                                child: Text('Update'),
                                onPressed: () async {
                                  // Perbarui data pada Firestore menggunakan userData['id'] sebagai referensi
                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(userData.id)
                                      .update({
                                        'name': nama.text,
                                        'noHp': noHp.text,
                                        'role': role.text,
                                      })
                                      .then((value) => print('updated'))
                                      .catchError(
                                          (error) => print('Error$error'));

                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.deepOrange,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Delete User'),
                            content: Text(
                                'Are you sure you want to delete this user?'),
                            actions: [
                              TextButton(
                                child: Text('Cancel'),
                                onPressed: () => Navigator.pop(context),
                              ),
                              TextButton(
                                child: Text('Delete'),
                                onPressed: () async {
                                  // Hapus akun user dari Firestore menggunakan userData['id']

                                  FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(userData.id)
                                      .delete();
                                  // if (userData.id == produk) {}
                                  final produkCollection = FirebaseFirestore
                                      .instance
                                      .collection('products')
                                      .get();
                                  await produkCollection.then((value) async {
                                    if (value.docChanges.isNotEmpty) {
                                      for (var docChange in value.docChanges) {
                                        final keranjangData =
                                            docChange.doc.data();
                                        // final idDocument = keranjangData!['idDocument'];
                                        final idUser = keranjangData!['idUser'];
                                        final role = keranjangData['role'];
                                        // final produkId = keranjangData['productId'];

                                        if (idUser == userData.id &&
                                            role == 'pedagang') {
                                          // Hapus data dari tabel keranjang
                                          await FirebaseFirestore.instance
                                              .collection('keranjang')
                                              .doc(docChange.doc.id)
                                              .delete()
                                              .then((value) => print('sukses'))
                                              .catchError(
                                                (error) =>
                                                    print('Error ${error}'),
                                              );
                                        }
                                      }
                                    }
                                  });

                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        }

        return Container();
      },
    );
  }
}
