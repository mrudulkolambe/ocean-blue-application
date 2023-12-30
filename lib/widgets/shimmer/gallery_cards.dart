import 'package:flutter/material.dart';

class GalleryCardShimmer extends StatelessWidget {
  const GalleryCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 185,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }
}
