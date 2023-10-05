import 'package:aplikasi/widgets/bottomBarPedagang.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EditProduk extends StatefulWidget {
  DocumentSnapshot docid;

  EditProduk({required this.docid});

  @override
  _EditProdukState createState() => _EditProdukState(docid: docid);
}

class _EditProdukState extends State<EditProduk> {
  DocumentSnapshot docid;
  _EditProdukState({required this.docid});
  TextEditingController jenisProduk = TextEditingController();
  TextEditingController stok = TextEditingController();
  TextEditingController namaproduk = TextEditingController();
  TextEditingController hargaproduk = TextEditingController();

  @override
  void initState() {
    jenisProduk = TextEditingController(text: widget.docid.get('jenisproduk'));
    stok = TextEditingController(text: widget.docid.get('stok'));
    namaproduk = TextEditingController(text: widget.docid.get('namaProduk'));
    hargaproduk = TextEditingController(text: widget.docid.get('price'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Edit Produk'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'stok',
                style:
                    TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: stok,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Jenis Produk',
                style:
                    TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: jenisProduk,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Nama Produk',
                style:
                    TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: namaproduk,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Harga Produk',
                style:
                    TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: hargaproduk,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    widget.docid.reference.delete().whenComplete(() {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BottomBarAdmin()),
                          (route) => false);
                    });
                  },
                  child: Text('Hapus'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shadowColor: Colors.blueAccent),
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.docid.reference.update({
                      'stok': stok.text,
                      'jenisproduk': jenisProduk.text,
                      'namaProduk': namaproduk.text,
                      'price': hargaproduk.text,
                      // 'bukti': subject6.text,
                    }).whenComplete(() {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BottomBarAdmin()),
                          (route) => false);
                    });
                  },
                  child: Text('Simpan'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shadowColor: Colors.orangeAccent),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
