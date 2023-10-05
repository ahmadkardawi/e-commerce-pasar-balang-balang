import 'package:aplikasi/service/pesan_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('coba'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              PesanService(),
            ],
          ),
        ),
      ),
    );
  }
}
