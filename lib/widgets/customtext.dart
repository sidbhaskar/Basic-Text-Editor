import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  String editText;
  Color editColor;
  double editSize;
  MyText(
      {required this.editSize,
      required this.editColor,
      required this.editText,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      editText,
      style: TextStyle(
        fontSize: editSize,
        color: editColor,
      ),
    );
  }
}
