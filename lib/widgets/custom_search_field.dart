import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    bool isFocused = false;
    return Container(
      width: 268,
      height: 40,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 1,
            color: Color(0xFFDEDEDE),
          ),
          borderRadius: BorderRadius.circular(26),
        ),
      ),
      child: TextField(
        textAlign: TextAlign.right,
        style: GoogleFonts.tajawal(
          color: const Color(0xFF121212),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        onTap: () {
          isFocused = true;
        },
        onEditingComplete: () {
          isFocused = false;
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          suffixIcon: const Icon(
            Icons.search,
            color: Color(0xFFDEDEDE),
            size: 20,
          ),
          hintText: 'البحث',
          hintStyle: GoogleFonts.tajawal(
            color: const Color(0xFFDEDEDE),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
