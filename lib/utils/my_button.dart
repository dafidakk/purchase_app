import 'package:flutter/material.dart';
import 'const.dart';

class MyElevatedButton extends StatelessWidget {
  final String text;

  final VoidCallback onPressed;

  const MyElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        text,
        style: shopStyle(20, Colors.blue, FontWeight.bold),
      ),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade200),
    );
  }
}
