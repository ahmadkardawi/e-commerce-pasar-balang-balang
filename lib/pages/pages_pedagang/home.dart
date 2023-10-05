import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Colors.green,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
            tag: Navigator.of(context),
            child: SizedBox(
              width: 150,
              child: Image.asset("assets/images/ikan.jpg"),
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            'Nama',
            style: const TextStyle(
              color: Colors.green,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            "Produl",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            "Produk",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          const Divider(
            height: 2,
            color: Colors.grey,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: const [
                  Icon(
                    Icons.add_shopping_cart,
                    size: 20,
                    color: Colors.green,
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Text(
                    "Beli",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 8,
              ),
              Row(
                children: const [
                  Icon(
                    Icons.remove_circle_outline,
                    size: 18,
                    color: Colors.green,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text('0'),
                  ),
                  Icon(
                    Icons.add_circle_outline,
                    size: 18,
                    color: Colors.green,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
