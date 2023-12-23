import 'package:flutter/material.dart';

class ProductDetailImageSlideShow extends StatefulWidget {
  const ProductDetailImageSlideShow({super.key});

  @override
  State<ProductDetailImageSlideShow> createState() =>
      _ProductDetailImageSlideShowState();
}

class _ProductDetailImageSlideShowState
    extends State<ProductDetailImageSlideShow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.transparent,
            blurRadius: 10.0,
            spreadRadius: -5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.network(
          "https://images.unsplash.com/photo-1517217004452-4ff260cb5598?q=80&w=1964&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
          height: 80,
          width: 80,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
