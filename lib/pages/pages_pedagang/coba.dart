import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Cobak extends StatefulWidget {
  DocumentSnapshot docuid;

  Cobak({required this.docuid});

  @override
  _CobakState createState() => _CobakState(docuid: docuid);
}

class _CobakState extends State<Cobak> {
  DocumentSnapshot docuid;
  _CobakState({required this.docuid});

  // final Stream<QuerySnapshot> _usersStream =
  //     FirebaseFirestore.instance.collection('report').snapshots();
  final auth = FirebaseAuth.instance;
  var jenisProduk;
  // var kurir;
  var userName;
  var namaProduk;
  var harga;
  var tanggalDibuat;
  var poto;

  void initState() {
    jenisProduk = widget.docuid.get('jenisproduk');
    // kurir = widget.docuid.get('kurir');
    userName = widget.docuid.get('name');
    tanggalDibuat = widget.docuid.get('tanggal');
    harga = widget.docuid.get('price');
    namaProduk = widget.docuid.get('namaProduk');
    poto = widget.docuid.get('imageUrl');

    super.initState();
    setState(() {});
  }

  void _incrementCounter() {
    setState(() {
      _counterr++;
    });
  }

  void _kurang() {
    setState(() {
      _counterr--;
    });
  }

  void _incrementr() {
    setState(() {
      hasilnya = int.parse(harga) * _counterr;
    });
  }

  int? hasilnya;
  int _counterr = 0;
  Future<void> updateUser() {
    return users
        .doc(docuid.id)
        .update({'price': hasilnya.toString()})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  CollectionReference users = FirebaseFirestore.instance.collection('products');
  final CollectionReference produkRef =
      FirebaseFirestore.instance.collection('products');
  // final CollectionReference ordersRef =
  //     FirebaseFirestore.instance.collection('orders');

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tambah Counter'),
          content: Text('Apakah Anda ingin menambah counter?'),
          actions: <Widget>[
            TextButton(
              child: Text('Tidak'),
              onPressed: () {
                updateUser();
              },
            ),
            TextButton(
              child: Text('Ya'),
              onPressed: () {
                _incrementr();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _showDialog,
        tooltip: 'Tambah Counter',
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50.0,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Detail Produk'),
        // automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                '$hasilnya',
              ),
              Container(
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey.shade200,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      color: Colors.redAccent,
                      onPressed: () {
                        _kurang();
                      },
                      icon: Icon(Icons.remove),
                    ),
                    Text('$_counterr'),
                    IconButton(
                      color: Colors.lightBlue,
                      onPressed: () {
                        _incrementCounter();
                      },
                      icon: Icon(Icons.add),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => EditProduk(docid: docuid),
                  //   ),
                  // );
                },
                child: Text('Kirim'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderItem(
    var imageUrl,
    String namaBarang,
    String name,
    String orderDate,
    String price,
    String jenis,
  ) {
    return Column(
      children: [
        Container(
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
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.network(
                  imageUrl,
                  width: 400.0,
                  height: 200.0,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.blueGrey.withOpacity(0.5),
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                height: 2,
                width: double.infinity,
                color: Colors.blue,
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Jenis Produk: ',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    jenis,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Kurir : ',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Text(
                    'Rizal',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Nama: ',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Text(
                    name,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Nama Produk: ',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Text(
                    namaBarang,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Harga: ',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Text(
                    price,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tanggal Dibuat: ',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Text(
                    orderDate,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Container(
                height: 2,
                width: double.infinity,
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
