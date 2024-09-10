import 'package:ecommerce_1/presentation/ui/utility/image_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CraftyBayLogo extends StatelessWidget {
  const CraftyBayLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      ImageAssets.craftyBayLogoSVG,
      width: 100,
    );
  }
}