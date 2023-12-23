import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ocean_blue/constants/colors.dart';

class HeadingText extends StatelessWidget {
  final String text;
  final Color color;

  const HeadingText({super.key, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.quicksand(
        fontSize: 30,
        color: blue,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
