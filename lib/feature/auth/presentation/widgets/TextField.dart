import 'package:flutter/material.dart'; // ← أضف ده

class CustomTextField extends StatefulWidget {
  final double? width;
  final double? height;
  final Color? textColor;
  final Color? backgroundColor;
  final Widget? prefixIcon;             // ← Widget? بدل IconData، يقبل SVG أو Icon أو أي حاجة
  final String? hintText;
  final TextInputType? keyboardType;
  final bool isPasswordField;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextAlign textAlign;

  const CustomTextField({
    super.key,
    this.width,
    this.height = 54,
    this.textColor,
    this.backgroundColor,
    this.prefixIcon,                    // هنا نقدر نمرر SvgPicture
    this.hintText,
    this.keyboardType,
    this.isPasswordField = false,
    this.controller,
    this.validator,
    this.textAlign = TextAlign.right, 
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPasswordField;
  }

  void _toggleVisibility() {
    if (!widget.isPasswordField) return;
    setState(() {
      _obscureText = !_obscureText;
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final defaultTextColor = widget.textColor ?? Colors.black87;
    final defaultBgColor = widget.backgroundColor ?? Colors.white;

    Widget? effectivePrefix;

    if (widget.prefixIcon != null) {
      if (widget.isPasswordField) {
        // نعمل clone للـ prefixIcon ونضيف GestureDetector عليه عشان يتقلب
        effectivePrefix = GestureDetector(
          onTap: _toggleVisibility,
          child:  widget.prefixIcon,
          
        );
      } else {
        effectivePrefix = widget.prefixIcon;
      }
    }

    return SizedBox(
      width: widget.width ?? double.infinity,
      height: widget.height,
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: _obscureText,
        textAlign: widget.textAlign,
        validator: widget.validator,
        style: TextStyle(color: defaultTextColor, fontSize: 16),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.grey.shade600, fontSize: 15),
          prefixIcon: effectivePrefix != null
              ? Padding(
                  padding: const EdgeInsetsDirectional.only(start: 12, end: 8),
                  child: effectivePrefix,
                )
              : null,
          filled: true,
          fillColor: defaultBgColor,
          contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.green.shade400, width: 1.8),
          ),
        ),
      ),
    );
  }
}