import 'package:flutter/material.dart';
import 'package:holly_quran/core/resources/styles.dart';

class CustomButton extends StatelessWidget {
  final Color backgroundColor;
  final Color textColor;
  final String title;
  final double? fontSize;
  final BorderRadius? borderRadius;
  const CustomButton({
    super.key,
    required this.backgroundColor,
    required this.textColor,
    required this.title,
    this.fontSize,
    this.borderRadius
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(12),
          )
        ),
        child: Text(title,
          style: Styles.textStyle18.copyWith(
            fontWeight: FontWeight.w900,
            color: textColor,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
