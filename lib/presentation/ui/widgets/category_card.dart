import 'package:ecommerce_1/data/models/category/category_data.dart';
import 'package:ecommerce_1/presentation/ui/utility/color_palette.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.categoryData, required this.onTap,
  });

  final CategoryData categoryData;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
        //Get.to(const ProductListScreen());
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Container(
              height: 60,
              width: 60,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: ColorPalette.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8)),
              child: Image.network(categoryData.categoryImg ?? '',height: 50,),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              categoryData.categoryName ?? '',
              style: const TextStyle(
                  fontSize: 15,
                  color: ColorPalette.primaryColor,
                  letterSpacing: 0.4),
            )
          ],
        ),
      ),
    );
  }
}
