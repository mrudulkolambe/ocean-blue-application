import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ocean_blue/constants/colors.dart';

class StyledButton extends StatelessWidget {
  final bool loading;
  final String text;

  const StyledButton({super.key, required this.loading, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: blue,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: loading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeCap: StrokeCap.round,
                ),
              )
            : Text(
               text,
                style: GoogleFonts.quicksand(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}
