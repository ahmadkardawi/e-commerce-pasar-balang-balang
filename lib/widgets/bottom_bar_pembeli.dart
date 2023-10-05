// import 'package:aplikasi/pages/pages_pembeli/home_pembeli.dart';
// import 'package:aplikasi/pages/pages_pembeli/profil.dart';
// import 'package:aplikasi/pages/pages_pembeli/riwayat_pesanan.dart';
// import 'package:flutter/material.dart';

// class BottomBarPembeli extends StatefulWidget {
//   @override
//   _BottomBarPembeliState createState() => _BottomBarPembeliState();
// }

// class _BottomBarPembeliState extends State<BottomBarPembeli> {
//   int _selectedIndex = 0;

//   static List<Widget> _widgetOptions = <Widget>[
//     HomePembeli(),
//     RiwayatPesanan(),
//     Profil(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: _widgetOptions.elementAt(_selectedIndex),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.home,
//               color: Colors.white,
//             ),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.add_shopping_cart_sharp,
//               color: Colors.white,
//             ),
//             label: 'Riwayat Pembelian',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.person,
//               color: Colors.white,
//             ),
//             label: 'Profil',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.white,
//         backgroundColor: Colors.green,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }

import 'package:aplikasi/pages/pages_pembeli/cari_produk.dart';
import 'package:aplikasi/pages/pages_pembeli/keranjang.dart';
import 'package:aplikasi/pages/pages_pembeli/riwayat_pesanan.dart';
import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

import '../pages/pages_pembeli/home_pembeli.dart';

class BottomBarPembeli extends StatefulWidget {
  @override
  _BottomBarPembeliState createState() => _BottomBarPembeliState();
}

class _BottomBarPembeliState extends State<BottomBarPembeli> {
  int _selectedIndex = 0;
  List _pages = [
    HomePembeli(),
    SearchScreen(),
    RiwayatPesanan(),
    Keranjang(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 1.0,
            blurRadius: 0.5,
          )
        ]),
        child: StylishBottomBar(
          option: BubbleBarOptions(
            borderRadius: BorderRadius.circular(20),
            inkEffect: true,
            inkColor: Colors.teal,
            bubbleFillStyle: BubbleFillStyle.fill,
            // opacity: 0.6,
          ),
          items: [
            BottomBarItem(
                // borderColor: Colors.greenAccent,
                backgroundColor: Colors.teal,
                icon: const Icon(
                  Icons.house_outlined,
                  color: Colors.teal,
                ),
                selectedIcon: const Icon(
                  Icons.house_rounded,
                  color: Colors.white,
                ),
                title: const Text(
                  'Home',
                  style: TextStyle(color: Colors.white),
                )),
            BottomBarItem(
                // borderColor: Colors.greenAccent,
                icon: const Icon(
                  Icons.search_sharp,
                  color: Colors.teal,
                ),
                selectedIcon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                selectedColor: Colors.teal,
                backgroundColor: Colors.teal,
                title: Text(
                  'Cari',
                  style: TextStyle(color: Colors.white),
                )),
            BottomBarItem(
              borderColor: Colors.greenAccent,
              backgroundColor: Colors.teal,
              icon: const Icon(
                Icons.history_sharp,
                color: Colors.teal,
              ),
              selectedIcon: const Icon(
                Icons.history_rounded,
                color: Colors.white,
              ),
              title: const Text(
                'Riwayat',
                style: TextStyle(color: Colors.white),
              ),
            ),
            BottomBarItem(
              borderColor: Colors.greenAccent,
              icon: const Icon(
                Icons.shopping_cart_outlined,
                color: Colors.teal,
              ),
              selectedIcon: const Icon(
                Icons.shopping_cart_rounded,
                color: Colors.white,
              ),
              selectedColor: Colors.teal,
              backgroundColor: Colors.teal,
              title: const Text(
                'Keranjang',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
          hasNotch: true,
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
              _pages;
            });
          },
        ),
      ),
    );
  }
}
