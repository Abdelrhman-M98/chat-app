import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String s) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(s),
    ),
  );
}
