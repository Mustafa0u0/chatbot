import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final Function()? onTap;
  final String title;
  final Color backgroundColor;
  final Color fontColor;
  const CustomButton(
      {super.key,
      this.onTap,
      required this.title,
      required this.backgroundColor,
      required this.fontColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 341,
        height: 56,
        alignment: Alignment.center,
        decoration: ShapeDecoration(
          color: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: fontColor,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
