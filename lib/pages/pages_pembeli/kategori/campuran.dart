// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:aplikasi/service/kategory_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Campuran extends StatefulWidget {
  const Campuran({Key? key}) : super(key: key);

  @override
  State<Campuran> createState() => _CampuranState();
}

class _CampuranState extends State<Campuran> {
  final _usersStream = FirebaseFirestore.instance
      .collection('products')
      .where('jenisproduk', isEqualTo: 'Campuran')
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text("Campuran"),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              KategoryService(collection: _usersStream),
            ],
          ),
        ),
      ),
    );
  }
}
