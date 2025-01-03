import 'package:assignment_app/core/widgets/app_style.dart';
import 'package:assignment_app/core/widgets/reusable_text.dart';
import 'package:flutter/material.dart';

class CustomOutBtn extends StatelessWidget {
  const CustomOutBtn({
    super.key,
    this.onTap,
    required this.width,
    required this.height,
    this.color2,
    required this.color,
    required this.text,
  });
  final void Function()? onTap;
  final double width;
  final double height;
  final Color? color2;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color2,
          border: Border.all(width: 1, color: color),
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Center(
          child: ReusableText(
              text: text,
              style: appStyle(
                  size: 18, color: color, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
