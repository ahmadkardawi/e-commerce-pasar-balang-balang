// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:aplikasi/service/kategory_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Buah extends StatefulWidget {
  const Buah({Key? key}) : super(key: key);

  @override
  State<Buah> createState() => _BuahState();
}

class _BuahState extends State<Buah> {
  final _usersStream = FirebaseFirestore.instance
      .collection('products')
      .where('jenisproduk', isEqualTo: 'Buah')
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text("Buah"),
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
