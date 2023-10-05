import 'package:aplikasi/service/pesanan_masuk_service.dart';
import 'package:flutter/material.dart';

class PesananMasuk extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.teal,
        title: Text('Pesanan Masuk'),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          PesananMasukService(),
        ],
      ),
    );
  }

  Widget _buildOrderItem(
    String imageUrl,
    String customerName,
    String orderDate,
    String totalAmount,
    String status,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Image.asset(
              imageUrl,
              width: 400.0,
              height: 200.0,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            'Pelanggan: $customerName',
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 8.0),
          Text(
            'Tanggal Pesan: $orderDate',
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 8.0),
          Text(
            'Total: $totalAmount',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Status: $status',
            style: TextStyle(
              fontSize: 16.0,
              color: status == 'Menunggu konfirmasi'
                  ? Colors.orange
                  : status == 'Dalam proses'
                      ? Colors.blue
                      : Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
