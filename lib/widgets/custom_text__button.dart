import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;

  const CustomTextButton({super.key, required this.onPressed, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed, 
      child: Text(buttonText, 
      style: TextStyle(
        fontSize: 24,
        color: Colors.black,
        fontWeight: FontWeight.w600,
        shadows: [
          Shadow(
            color: Colors.blue.withOpacity(0.8),
            offset: Offset(2, 2),
            blurRadius: 3,
          ),
        ],
      )));
  }
}