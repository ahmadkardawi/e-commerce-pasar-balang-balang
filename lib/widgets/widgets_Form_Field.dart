import 'package:flutter/material.dart';

// ignore: must_be_immutable
class WidgetFormField extends StatelessWidget {
  String hintext;
  var controller;
  WidgetFormField({super.key, required this.hintext, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: hintext,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
