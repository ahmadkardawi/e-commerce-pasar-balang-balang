import 'dart:io';
import 'package:aplikasi/core.dart';
import 'package:aplikasi/widgets/bottomBarPedagang.dart';
import 'package:aplikasi/widgets/widgets_Form_Field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:uuid/uuid.dart';

class TambahProduk extends StatefulWidget {
  const TambahProduk({super.key});

  @override
  State<TambahProduk> createState() => _TambahProdukState();
}

CollectionReference collection = FirebaseFirestore.instance.collection('users');
User? user = FirebaseAuth.instance.currentUser;

class _TambahProdukState extends State<TambahProduk> {
  TextEditingController _namaBarang = TextEditingController();
  TextEditingController _hargaBarang = TextEditingController();
  TextEditingController _stokBarang = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance.currentUser;
  // final userDoc = await FirebaseFirestore.instance.collection('user').doc(user!.uid).get();

  var imageUrl;
  var uuid = Uuid();

  final List<String> items = [
    'Sayur',
    'Buah',
    'Ikan',
    'Rempah',
    'Campuran',
    'Pakaian',
  ];
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    _namaBarang = TextEditingController(text: "");
    _hargaBarang = TextEditingController(text: "");
    _stokBarang = TextEditingController(text: "");
  }

  Future<void> addProduct(ProductModel product, BuildContext context) {
    CollectionReference products =
        FirebaseFirestore.instance.collection('products');
    final String newData = _namaBarang.text;
    return products
        .where('namaProduk', isEqualTo: newData)
        .get()
        .then((QuerySnapshot snapshot) {
      if (snapshot.docs.isEmpty) {
        products
            .add(product.toJson())
            .then((value) => QuickAlert.show(
                  context: context,
                  type: QuickAlertType.success,
                  title: 'Berhasil',
                  text: 'Produk Selesai di Posting',
                ))
            .catchError((error) => print("Failed to add product: $error"));
      } else {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.warning,
          title: 'Produk Sudah Ada',
          text: 'Silahkan Ganti Produk Yang Belum Ada',
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text("Tambah Produk")),
        backgroundColor: Colors.teal,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.blueGrey.shade100,
                            spreadRadius: 3.0,
                            blurRadius: 2.0)
                      ]),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      WidgetFormField(
                        hintext: "Nama Barang",
                        controller: _namaBarang,
                      ),
                      SizedBox(height: 10),
                      WidgetFormField(
                        hintext: "Harga Barang",
                        controller: _hargaBarang,
                      ),
                      SizedBox(height: 10),
                      WidgetFormField(
                        hintext: "Stok Barang",
                        controller: _stokBarang,
                      ),
                      SizedBox(height: 10),
                      // WidgetFormField(
                      //   hintext: "Jenis Barang",
                      //   controller: _jenisBarang,
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            // alignment: AlignmentDirectional.center,
                            isExpanded: true,
                            hint: Row(
                              children: const [
                                SizedBox(
                                  width: 4,
                                ),
                                Expanded(
                                  child: Text(
                                    'Jenis Barang',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.teal,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            items: items
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.teal,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ))
                                .toList(),
                            value: selectedValue,
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value as String;
                              });
                            },
                            buttonStyleData: ButtonStyleData(
                              height: 50,
                              // width: 160,
                              padding:
                                  const EdgeInsets.only(left: 14, right: 14),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: Colors.black26,
                                ),
                                color: Colors.white,
                              ),
                              elevation: 2,
                            ),
                            iconStyleData: const IconStyleData(
                              icon: Icon(
                                Icons.arrow_forward_ios_outlined,
                              ),
                              iconSize: 14,
                              iconEnabledColor: Colors.teal,
                              iconDisabledColor: Colors.blueGrey,
                            ),
                            dropdownStyleData: DropdownStyleData(
                                maxHeight: 200,
                                // width: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: Colors.white,
                                ),
                                elevation: 8,
                                // offset: const Offset(50, 0),
                                scrollbarTheme: ScrollbarThemeData(
                                  radius: const Radius.circular(40),
                                  thickness: MaterialStateProperty.all(6),
                                  thumbVisibility:
                                      MaterialStateProperty.all(true),
                                )),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                              padding: EdgeInsets.only(left: 14, right: 14),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                uploadImage();
                              },
                              child: Text(
                                "Gambar Prudok",
                                style: TextStyle(fontSize: 15),
                              ),
                              style: ElevatedButton.styleFrom(
                                shadowColor: Colors.blueGrey,
                                backgroundColor: Colors.blue,
                              ),
                            ),
                            Spacer(),
                            imageUrl == null
                                ? Text('Belum Ada Gambar')
                                : Image.network(
                                    imageUrl!,
                                    width: 100,
                                  ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final userDoc = await FirebaseFirestore.instance
                          .collection('users')
                          .doc(user!.uid)
                          .get();
                      var usernam = userDoc.data()!['name'];
                      String stock = _stokBarang.text;
                      String name = usernam;
                      String price = _hargaBarang.text;
                      String nameProduk = _namaBarang.text;
                      String jenis = selectedValue.toString();
                      String idProduk = uuid.v1();
                      String idUser = auth!.uid;
                      String img = imageUrl;
                      String status = "";
                      String shp = " ";
                      String ket = 'Buka';
                      String tanggal =
                          DateFormat.yMd().add_jm().format(DateTime.now());
                      // Map<String, dynamic> data =
                      ProductModel productModel = ProductModel(
                        idProduk: idProduk,
                        idUser: idUser,
                        tanggal: tanggal.toString(),
                        namaPenjual: name,
                        namaproduk: nameProduk,
                        price: price,
                        jenisproduk: jenis,
                        imageUrl: img,
                        statusBarang: status,
                        keranjang: shp,
                        stok: stock,
                        keterangan: ket,
                      );
                      try {
                        addProduct(productModel, context);
                        // print('Product added successfully!');
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BottomBarAdmin()),
                            (route) => false);
                      } catch (e) {
                        print('Failed to add product: $e');
                      }
                    }
                    // nomor();
                  },
                  child: Text(
                    "simpan",
                    style: TextStyle(fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal, minimumSize: Size(200, 50)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  uploadImage() async {
    final storage = FirebaseStorage.instance;
    final ImagePicker _picker = ImagePicker();
    XFile image;

    image = (await _picker.pickImage(source: ImageSource.gallery))!;

    var file = File(image.path);

    // ignore: unnecessary_null_comparison
    if (image != null) {
      // var id = auth!.uid;
      //Upload to Firebase
      var snapshot = await storage
          .ref()
          .child(uuid.v1())
          .putFile(file)
          .whenComplete(() => null);

      var downloadUrl = await snapshot.ref.getDownloadURL();

      setState(() {
        imageUrl = downloadUrl;
      });

      // return downloadUrl;
    } else {
      print('No Path Received');
    }
  }

  // nomor() {
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(user!.uid)
  //       .get()
  //       .then((DocumentSnapshot querySnapshot) {
  //     if (querySnapshot.exists) {
  //       print(querySnapshot.get('noHp'));
  //     }
  //   });
  // }
}
