import 'package:flutter/material.dart';
import 'package:ta9sela/core/utils/app_colors.dart';
import 'package:ta9sela/core/utils/textstyles.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final Color color;
  final Widget? leading;
  final VoidCallback onTap;

  const AuthButton({
    required this.text,
    required this.color,
    required this.onTap,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width*0.6,
      height: 70,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (leading != null) leading!,
            Text( text, style: TextStyles.t20.copyWith(color: AppColors.whitecolor,fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
