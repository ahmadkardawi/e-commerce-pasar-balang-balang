import 'package:aplikasi/pages/pages_pedagang/home_pedagang.dart';
import 'package:aplikasi/pages/pages_pedagang/pesanan_masuk.dart';
import 'package:aplikasi/pages/pages_pedagang/profil_pedagang.dart';
import 'package:aplikasi/pages/pages_pedagang/riwayat_pengiriman.dart';
import 'package:aplikasi/pages/pages_pedagang/tambah_produk.dart';
import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class BottomBarAdmin extends StatefulWidget {
  @override
  _BottomBarAdminState createState() => _BottomBarAdminState();
}

class _BottomBarAdminState extends State<BottomBarAdmin> {
  int _selectedIndex = 0;
  List _pages = [
    HomePedagang(),
    TambahProduk(),
    PesananMasuk(),
    RiwayatPengiriman(),
    ProfilPedagang(),
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
            bubbleFillStyle: BubbleFillStyle.outlined,
            opacity: 0.6,
          ),
          items: [
            BottomBarItem(
                borderColor: Colors.greenAccent,
                icon: const Icon(
                  Icons.house_outlined,
                  color: Colors.teal,
                ),
                selectedIcon: const Icon(
                  Icons.house_rounded,
                  color: Colors.redAccent,
                ),
                title: const Text(
                  'Home',
                  style: TextStyle(color: Colors.black45),
                )),
            BottomBarItem(
                borderColor: Colors.greenAccent,
                icon: const Icon(
                  Icons.add_circle_sharp,
                  color: Colors.teal,
                ),
                selectedIcon: const Icon(
                  Icons.add_circle,
                  color: Colors.redAccent,
                ),
                selectedColor: Colors.teal,
                backgroundColor: Colors.tealAccent.shade400,
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Tambah',
                      style: TextStyle(color: Colors.black45),
                    ),
                    Text(
                      'Produk',
                      style: TextStyle(color: Colors.black45),
                    ),
                  ],
                )),
            BottomBarItem(
              borderColor: Colors.greenAccent,
              icon: const Icon(
                Icons.notifications_active,
                color: Colors.teal,
              ),
              selectedIcon: const Icon(
                Icons.notifications_active_outlined,
                color: Colors.redAccent,
              ),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Pesanan',
                    style: TextStyle(color: Colors.black45),
                  ),
                  Text(
                    'Masuk',
                    style: TextStyle(color: Colors.black45),
                  ),
                ],
              ),
            ),
            BottomBarItem(
                borderColor: Colors.greenAccent,
                icon: const Icon(
                  Icons.history_sharp,
                  color: Colors.teal,
                ),
                selectedIcon: const Icon(
                  Icons.history_rounded,
                  color: Colors.redAccent,
                ),
                title: const Text(
                  'Riwayat',
                  style: TextStyle(color: Colors.black45),
                )),
            BottomBarItem(
              borderColor: Colors.greenAccent,
              icon: const Icon(
                Icons.person_outline,
                color: Colors.teal,
              ),
              selectedIcon: const Icon(
                Icons.person,
                color: Colors.redAccent,
              ),
              selectedColor: Colors.teal,
              backgroundColor: Colors.tealAccent.shade400,
              title: const Text(
                'Profile',
                style: TextStyle(color: Colors.black45),
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
