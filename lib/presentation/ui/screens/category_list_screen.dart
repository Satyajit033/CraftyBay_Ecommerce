import 'package:ecommerce_1/presentation/state_holders/category_controller.dart';
import 'package:ecommerce_1/presentation/state_holders/main_bottom_nav_controller.dart';
import 'package:ecommerce_1/presentation/ui/screens/product_list_screen.dart';
import 'package:ecommerce_1/presentation/ui/utility/color_palette.dart';
import 'package:ecommerce_1/presentation/ui/widgets/category_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen({super.key});

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        Get.find<MainBottomNavController>().backToHome();
        return;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            "Categories",
            style: TextStyle(color: Colors.black),
          ),
          elevation: 1,
          shadowColor: Colors.white54,
          leading: IconButton(
            onPressed: () {
              Get.find<MainBottomNavController>().backToHome();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
        body: RefreshIndicator(color: ColorPalette.primaryColor,
          onRefresh: ()async {
            Get.find<CategoryController>().getCategories();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: GetBuilder<CategoryController>(
              builder: (categoryController) {
                if(categoryController.getCategoriesInProgress){
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return GridView.builder(
                  itemCount: categoryController.categoryModel.data?.length ?? 0,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16),
                  itemBuilder: (context, index) {
                    return FittedBox(
                        child: CategoryCard(
                      categoryData:
                          categoryController.categoryModel.data![index],
                      onTap: () {
                        Get.to(ProductListScreen(
                            categoryId: categoryController
                                .categoryModel.data![index].id!));
                      },
                    ));
                  });
            }
            ),
          ),
        ),
      ),
    );
  }
}
