import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        // margin: EdgeInsets.zero,
        content: Text(
          content,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
}
