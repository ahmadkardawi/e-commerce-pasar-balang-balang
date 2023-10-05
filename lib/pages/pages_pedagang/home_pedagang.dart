import 'package:aplikasi/service/home_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePedagang extends StatefulWidget {
  HomePedagang({super.key});

  @override
  State<HomePedagang> createState() => _HomePedagangState();
}

class _HomePedagangState extends State<HomePedagang> {
  // TextEditingController _nameController = TextEditingController();

  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(10),
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.asset(
                'assets/images/market.png',
                width: 400.0,
                height: 200.0,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            SingleChildScrollView(child: HomeService()),
          ],
        ),
      ),
    );
  }
}
