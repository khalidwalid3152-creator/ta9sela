
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final double height;
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final TextStyle? textStyle;

  const CustomButton({
    super.key,
    required this.width,
    required this.height,
    required this.text,
    required this.onPressed, this.color, this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30), // نفس الشكل اللي بالصورة
          ),
          backgroundColor: color, // نفس اللون بالصورة
        ),
        child: Text(
          text,
          style: textStyle
        ),
      ),
    );
  }
}
