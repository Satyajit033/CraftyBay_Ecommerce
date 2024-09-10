import 'package:flutter/material.dart';

class ProductDetailsHeadlineText extends StatelessWidget {
  const ProductDetailsHeadlineText({
    super.key, required this.headlineText,
  });

  final String headlineText;

  @override
  Widget build(BuildContext context) {
    return  Text(
      headlineText,
      style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.w700),
    );
  }
}
