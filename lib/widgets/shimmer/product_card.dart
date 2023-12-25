import 'package:flutter/material.dart';

class ProductCardShimmer extends StatefulWidget {
  const ProductCardShimmer({super.key});

  @override
  State<ProductCardShimmer> createState() => _ProductCardShimmerState();
}

class _ProductCardShimmerState extends State<ProductCardShimmer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: <Widget>[
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width - 80 - 70,
                height: 16,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              Container(
                width: 180,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                width: 100,
                height: 18,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
              )
            ],
          ),
        ],
      )
    );
  }
}
