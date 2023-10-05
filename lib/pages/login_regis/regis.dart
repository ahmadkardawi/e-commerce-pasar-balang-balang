import 'dart:ui';
import 'package:aplikasi/models/userModels.dart';
import 'package:aplikasi/pages/login_regis/login.dart';
import 'package:aplikasi/service/gps.dart';
import 'package:aplikasi/widgets/widgets_Form_Field.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class RegisPages extends StatefulWidget {
  const RegisPages({super.key});

  @override
  State<RegisPages> createState() => _RegisPagesState();
}

class _RegisPagesState extends State<RegisPages> {
  final _formKey = GlobalKey<FormState>();
  final _authentication = FirebaseAuth.instance;

  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
    _userNameController = TextEditingController(text: "");
    _phoneController = TextEditingController(text: "");
  }

  String Address = 'search';
  String location = 'Null, Press Button';

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    Address =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/Green.png',
              ),
              fit: BoxFit.fill,
            ),
          ),
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 5.0,
                sigmaY: 5.0,
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: Container(
                    // height: 350,
                    margin: EdgeInsets.all(25),
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white.withOpacity(0.4),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              'Daftarkan Akun',
                              style: TextStyle(
                                color: Colors.teal,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              'Masukkan Nama',
                              style: TextStyle(
                                color: Colors.teal,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          WidgetFormField(
                            hintext: "Nama",
                            controller: _userNameController,
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              'Masukkan Email',
                              style: TextStyle(
                                color: Colors.teal,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          WidgetFormField(
                            hintext: "Email",
                            controller: _emailController,
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              'Masukkan Password',
                              style: TextStyle(
                                color: Colors.teal,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          WidgetFormField(
                            hintext: "Password",
                            controller: _passwordController,
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              'Masukkan Nomor Hp/Wa',
                              style: TextStyle(
                                color: Colors.teal,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          WidgetFormField(
                            hintext: "Telephone",
                            controller: _phoneController,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20, right: 20),
                            padding: EdgeInsets.all(10),
                            height: 70,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.cyan)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    Position position =
                                        await GPS.getGeoLocationPosition();
                                    location =
                                        'Lat: ${position.latitude} , Long: ${position.longitude}';
                                    GetAddressFromLatLong(position);
                                  },
                                  child: Text('Get Location'),
                                ),
                                SingleChildScrollView(
                                  controller: ScrollController(),
                                  scrollDirection: Axis.vertical,
                                  child: Container(
                                    width: 150,
                                    child: Text(
                                      '$Address',
                                      style: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontSize: 15),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _register(_emailController.text,
                                  _passwordController.text);
                            },
                            child: Container(
                              height: 50,
                              margin:
                                  EdgeInsets.only(left: 15, right: 15, top: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.lime,
                              ),
                              child: Center(
                                child: Text(
                                  'DAFTAR',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _register(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _authentication
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {addToFirestore()})
          .catchError((e) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Gagal',
          text: 'Gagal Membuat Akun',
        );
        return e;
      });
    }
  }

  Future<void> addToFirestore() async {
    User? user = _authentication.currentUser;
    var firestore = FirebaseFirestore.instance;
    CollectionReference toFirestore = firestore.collection('users');
    var userModel = UserModel();

    userModel.email = user!.email;
    // userModel.token = mtoken.toString();
    userModel.uid = user.uid;
    userModel.name = _userNameController.text;
    userModel.noHp = _phoneController.text;
    userModel.password = _passwordController.text;
    userModel.alamat = Address;
    await toFirestore.doc(user.uid).set(userModel.toMap());
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginPages()),
        (route) => false);
  }
}
