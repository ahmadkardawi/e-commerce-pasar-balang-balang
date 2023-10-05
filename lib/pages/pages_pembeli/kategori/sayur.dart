// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:aplikasi/service/kategory_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Sayur extends StatefulWidget {
  const Sayur({Key? key}) : super(key: key);

  @override
  State<Sayur> createState() => _SayurState();
}

class _SayurState extends State<Sayur> {
  final _usersStream = FirebaseFirestore.instance
      .collection('products')
      .where('jenisproduk', isEqualTo: 'Sayur')
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text("Sayur"),
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
