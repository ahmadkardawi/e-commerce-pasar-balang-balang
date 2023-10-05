import 'package:aplikasi/service/Firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class DetailPesananMasuk extends StatefulWidget {
  DocumentSnapshot docuid;

  DetailPesananMasuk({required this.docuid});
  @override
  _DetailPesananMasukState createState() =>
      _DetailPesananMasukState(snapshot: docuid);
}

class _DetailPesananMasukState extends State<DetailPesananMasuk> {
  DocumentSnapshot snapshot;
  _DetailPesananMasukState({required this.snapshot});
  var pelanggan;
  var alamat;
  var namaProduk;
  var harga;
  var tanggal;
  var poto;
  var total;
  void initState() {
    pelanggan = widget.docuid.get('namaPembeli');
    alamat = widget.docuid.get('alamat');
    tanggal = widget.docuid.get('tglPembelian');
    harga = widget.docuid.get('productPrice');
    namaProduk = widget.docuid.get('productName');
    poto = widget.docuid.get('productImageUrl');
    total = widget.docuid.get('totalBelanja');
    super.initState();
    setState(() {});
  }

  CollectionReference produk =
      FirebaseFirestore.instance.collection('checkout');
  Future<void> kirim() {
    return produk
        .doc(snapshot.id)
        .update({'status': 'Telah Dikirim'})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Detail Pesanan Masuk'),
      ),
      body: ListView(
        children: [
          _buildOrderItem(pelanggan, alamat, namaProduk, harga, tanggal, poto),
          Padding(
              padding: EdgeInsets.only(left: 30, right: 30, top: 20),
              child: ElevatedButton(
                onPressed: () {
                  kirim();
                  Navigator.pop(context);
                },
                child: Text('KIRIM'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
              ))
        ],
      ),
    );
  }

  Widget _buildOrderItem(
    var pelanggan,
    var alamat,
    var namaProduk,
    var harga,
    var tanggal,
    var poto,
  ) {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Image.network(
              poto,
              width: 400.0,
              height: 200.0,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            'Pelanggan: $pelanggan',
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 8.0),
          Text(
            'Tanggal Pesan: $tanggal',
            style: TextStyle(fontSize: 16.0),
          ),

          SizedBox(height: 8.0),
          Text(
            'Alamat Pelanggan: $alamat',
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 8.0),
          Row(
            children: [
              Text(
                'Harga : ',
                style: TextStyle(fontSize: 16.0),
              ),
              Text(
                formatRupiah(harga),
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Row(
            children: [
              Text(
                'Total: ',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                formatRupiah(total),
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          // Text(
          //   'Status: $status',
          //   style: TextStyle(
          //     fontSize: 16.0,
          //     color: status == 'Menunggu konfirmasi'
          //         ? Colors.orange
          //         : status == 'Dalam proses'
          //             ? Colors.blue
          //             : Colors.green,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
        ],
      ),
    );
  }
}
