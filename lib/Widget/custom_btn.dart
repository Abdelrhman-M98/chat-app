// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  final String btnText;
  CustomBtn({super.key, required this.btnText, this.onTap});
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            btnText,
          ),
        ),
      ),
    );
  }
}
