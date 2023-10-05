import 'package:aplikasi/pages/pages_admin/produk.dart';
import 'package:aplikasi/pages/pages_admin/users.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Example());
}

class Example extends StatefulWidget {
  Example({Key? key}) : super(key: key);

  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData.dark(),
        home: SafeArea(
          child: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                title: Center(child: Text("Admin Panel")),
                bottom: TabBar(
                  indicatorColor: Colors.tealAccent,
                  unselectedLabelColor: Colors.grey[300],
                  labelColor: Colors.white,
                  tabs: [
                    Tab(
                      icon: Icon(Icons.people_alt_outlined),
                      text: "Users",
                    ),
                    Tab(
                      icon: Icon(Icons.shopping_cart_rounded),
                      text: "Produk",
                    ),
                  ],
                ),
              ),
              body: TabBarView(
                children: <Widget>[
                  Users(),
                  Produks(),
                ],
              ),
            ),
          ),
        ));
  }
}
