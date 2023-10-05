import 'package:aplikasi/models/orderModels.dart';
import 'package:aplikasi/service/Firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

// ignore: must_be_immutable
class Badges extends StatefulWidget {
  DocumentSnapshot docuid;

  Badges({required this.docuid});

  @override
  _BadgesState createState() => _BadgesState(docuid: docuid);
}

class _BadgesState extends State<Badges> {
  DocumentSnapshot docuid;
  _BadgesState({required this.docuid});
  int _counterr = 1;
  void _tambah() {
    int stk = int.parse(stok);
    if (_counterr == stk) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Stok Habis'),
              content: Text('Stok Barang Sudah Habis'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Ok'),
                ),
              ],
            );
          });
    } else {
      setState(() {
        _counterr++;
      });
    }
  }

  void _kurang() {
    if (_counterr == 1) {
      print('tidak dapat ditambah');
    } else {
      setState(() {
        _counterr--;
        // conterStok--;
      });
    }
  }

  // final Stream<QuerySnapshot> _usersStream =
  //     FirebaseFirestore.instance.collection('report').snapshots();
  // final firestore = FirebaseFirestore.instance;

  final _auth = FirebaseAuth.instance;
  var jenisProduk;
  var userName;
  var namaProduk;
  var harga;
  var tanggalDibuat;
  var poto;
  var id;
  var stok;
  var ket;
  void initState() {
    jenisProduk = widget.docuid.get('jenisproduk');
    userName = widget.docuid.get('name');
    tanggalDibuat = widget.docuid.get('tanggal');
    harga = widget.docuid.get('price');
    namaProduk = widget.docuid.get('namaProduk');
    poto = widget.docuid.get('imageUrl');
    id = widget.docuid.get('idUser');
    stok = widget.docuid.get('stok');
    ket = widget.docuid.get('keterangan');
    super.initState();
    setState(() {});
  }

  int? hasilnya;

  void _hasil() {
    setState(() {
      hasilnya = int.parse(harga) * _counterr;
      // hasilStok = int.parse(stokk) - conterStok;
    });
  }

  //Menambahkan Data ke keranjang dengan melakukan pengecekan apakah barang sudah ada atau belum
  Future<void> orderProduct(OrderModels order, BuildContext context) {
    return FirebaseFirestore.instance
        .collection('keranjang')
        .where('namaPedagang', isEqualTo: userName)
        .where('productName', isEqualTo: namaProduk)
        .get()
        .then((QuerySnapshot snapshot) {
      if (snapshot.docs.isEmpty) {
        // Data belum ada, bisa ditambahkan
        FirebaseFirestore.instance
            .collection('keranjang')
            .add(order.toMap())
            .then(
              (value) => QuickAlert.show(
                context: context,
                type: QuickAlertType.success,
                title: 'Berhasil',
                text: 'Produk di Masukkan ke Keranjang',
              ),
            );
      } else {
        // Data sudah ada, tampilkan pesan error
        setState(() {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.warning,
            title: 'Gagal',
            text: 'Barang Sudah Ada',
          );
        });
      }
    });
    // products
    //     // .doc(docuid.id)
    //     .add(order.toMap())
    //     // .any(order.toJson())
    //     .then((value) => QuickAlert.show(
    //           context: context,
    //           type: QuickAlertType.success,
    //           title: 'Berhasil',
    //           text: 'Produk di Masukkan ke Keranjang',
    //         ))
    //     .catchError((error) => print("Failed to add product: $error"));
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // CollectionReference users = FirebaseFirestore.instance.collection('products');
  final CollectionReference produkRef =
      FirebaseFirestore.instance.collection('products');

  @override
  Widget build(BuildContext context) {
    var user = _auth.currentUser;
    return Scaffold(
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
              _buildOrderItem(
                poto,
                namaProduk,
                userName,
                tanggalDibuat,
                harga,
                jenisProduk,
                stok,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 5, minimumSize: Size(double.infinity, 50)),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // upToKeranjang();
                      final userDoc = await FirebaseFirestore.instance
                          .collection('users')
                          .doc(user!.uid)
                          .get();
                      var usernam = userDoc.data()!['name'];
                      var lokasi = userDoc.data()!['alamat'];
                      var tlp = userDoc.data()!['noHp'];

                      String namaPembeli = usernam;
                      String stk = stok;
                      String price = widget.docuid.get('price');
                      String nameProduk = widget.docuid.get('namaProduk');
                      String jenis = widget.docuid.get('jenisproduk');
                      String idProduk = widget.docuid.get('idUser');
                      String idUser = _auth.currentUser!.uid;
                      String image = widget.docuid.get('imageUrl');
                      String total = hasilnya.toString();
                      // String status = "Dalam Proses";
                      String entities = _counterr.toString();
                      String noHp = tlp;
                      String namaPedagang = widget.docuid.get('name');
                      String alamat = lokasi;
                      String tanggal =
                          DateFormat.yMd().add_jm().format(DateTime.now());

                      OrderModels orderModels = OrderModels(
                        id: idUser,
                        productId: idProduk,
                        idDocument: widget.docuid.id,
                        productName: nameProduk,
                        entiti: entities,
                        totalBelanja: total,
                        alamat: alamat,
                        namaPedagang: namaPedagang,
                        noPembeli: noHp,
                        jenisDagangan: jenis,
                        productPrice: price,
                        productImageUrl: image,
                        buyerName: namaPembeli,
                        stok: stk,
                        buyerAddress: tanggal,
                        // status: status
                      );
                      orderProduct(orderModels, context);
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    'Masukkan Keranjang',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
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
    String stk,
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
                    'Nama pedagang: ',
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
                    formatRupiah(price),
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Stok : ',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Text(
                    stk,
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
              SizedBox(height: 20),
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
                        print('sisa stok $stok');

                        _tambah();
                      },
                      icon: Icon(Icons.add),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(15),
                // width: 150,
                margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 2.0,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(onPressed: _hasil, child: Text('Total')),
                        Text(hasilnya != null ? '$hasilnya' : '0'),
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
