import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  bool isObscure;

  final void Function(String) onChanged;

  CustomTextField({
    required this.hintText,
    required this.controller,
    required this.onChanged,
    this.isObscure = false,
    super.key,
    required int maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 342,
      height: 50,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1.50, color: Color(0xFFE2E8F0)),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: TextField(
        controller: controller,
        obscureText: isObscure ? true : false,
        textAlign: TextAlign.start,
        onChanged: onChanged,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(
            color: const Color(0xFF656565),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        style: GoogleFonts.poppins(
          textStyle: const TextStyle(
            color: Color(0xFF656565),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
