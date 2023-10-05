import 'package:aplikasi/pages/pages_pedagang/edit_produk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DetailProduk extends StatefulWidget {
  DocumentSnapshot docuid;

  DetailProduk({required this.docuid});

  @override
  _DetailProdukState createState() => _DetailProdukState(docuid: docuid);
}

class _DetailProdukState extends State<DetailProduk> {
  DocumentSnapshot docuid;
  _DetailProdukState({required this.docuid});

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
  var stokk;
  void initState() {
    jenisProduk = widget.docuid.get('jenisproduk');
    // kurir = widget.docuid.get('kurir');
    userName = widget.docuid.get('name');
    tanggalDibuat = widget.docuid.get('tanggal');
    harga = widget.docuid.get('price');
    namaProduk = widget.docuid.get('namaProduk');
    poto = widget.docuid.get('imageUrl');
    stokk = widget.docuid.get('stok');
    super.initState();
    setState(() {});
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Detail Produk'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        // automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildOrderItem(
                poto,
                namaProduk,
                userName,
                tanggalDibuat,
                harga,
                jenisProduk,
                stokk.toString(),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProduk(docid: docuid),
                    ),
                  );
                },
                child: Text('Edit'),
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
    String stok,
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
                    'Stok: ',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Text(
                    stok,
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
