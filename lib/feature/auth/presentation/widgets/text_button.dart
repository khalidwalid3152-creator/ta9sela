import 'package:flutter/material.dart';

class TextButtonCustomer extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final BorderRadius? borderRadius;
  final double? elevation;
  final Widget? child; // لو عايز تحط أيقونة + نص أو loading indicator مثلاً
  final bool isLoading; // اختياري: حالة تحميل

  const TextButtonCustomer({
    super.key,
    required this.text,
    this.onPressed,
    this.width,
    this.height = 54,
    this.backgroundColor,
    this.textColor = Colors.white,
    this.fontSize = 18,
    this.fontWeight = FontWeight.bold,
    this.borderRadius,
    this.elevation = 2,
    this.child,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveBgColor = backgroundColor ?? Colors.green.shade500;
    final effectiveRadius = borderRadius ?? BorderRadius.circular(12);

    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: effectiveBgColor,
          foregroundColor: textColor,
          disabledBackgroundColor: effectiveBgColor.withOpacity(0.6),
          shape: RoundedRectangleBorder(borderRadius: effectiveRadius),
          elevation: elevation,
          padding: EdgeInsets.zero, // عشان الـ SizedBox يتحكم في الحجم
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.5,
                  ),
                )
              : (child ??
                    Text(
                      text,
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: fontWeight,
                        color: textColor,
                      ),
                    )),
        ),
      ),
    );
  }
}
