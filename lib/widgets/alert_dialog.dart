import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ALertEditDialog extends StatelessWidget {
  ALertEditDialog({super.key});
  TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text('UBAH'),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            TextFormField(
              controller: _nameController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Nama',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _nameController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Nama Produk',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _nameController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Harga',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Batal'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shadowColor: Colors.redAccent),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Simpan'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shadowColor: Colors.greenAccent),
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.tealAccent,
    );
  }
}
