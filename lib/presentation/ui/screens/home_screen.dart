import 'package:ecommerce_1/presentation/state_holders/auth_controller.dart';
import 'package:ecommerce_1/presentation/state_holders/category_controller.dart';
import 'package:ecommerce_1/presentation/state_holders/home_slider_controller.dart';
import 'package:ecommerce_1/presentation/state_holders/main_bottom_nav_controller.dart';
import 'package:ecommerce_1/presentation/state_holders/new_product_controller.dart';
import 'package:ecommerce_1/presentation/state_holders/popular_product_controller.dart';
import 'package:ecommerce_1/presentation/state_holders/auth_state_holders/read_profile_controller.dart';
import 'package:ecommerce_1/presentation/state_holders/special_product_controller.dart';
import 'package:ecommerce_1/presentation/state_holders/theme_manager_controller.dart';
import 'package:ecommerce_1/presentation/ui/screens/auth/email_verification_screen.dart';
import 'package:ecommerce_1/presentation/ui/screens/auth/update_profile_screen.dart';
import 'package:ecommerce_1/presentation/ui/screens/product_list_screen.dart';
import 'package:ecommerce_1/presentation/ui/utility/color_palette.dart';
import 'package:ecommerce_1/presentation/ui/utility/image_assets.dart';
import 'package:ecommerce_1/presentation/ui/widgets/category_card.dart';
import 'package:ecommerce_1/presentation/ui/widgets/circular_icon_button.dart';
import 'package:ecommerce_1/presentation/ui/widgets/home/home_slider.dart';
import 'package:ecommerce_1/presentation/ui/widgets/home/section_header.dart';
import 'package:ecommerce_1/presentation/ui/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ThemeMode? currentThemeMode;

  @override
  void initState() {
    super.initState();
    _loadThemeMode();
  }

  Future<void> _loadThemeMode() async {
    final ThemeMode themeMode = await ThemeManager.getThemeMode();
    setState(() {
      currentThemeMode = themeMode;
    });
  }

  void _toggleTheme() async {
    if (currentThemeMode == ThemeMode.light) {
      currentThemeMode = ThemeMode.dark;
      Get.changeThemeMode(ThemeMode.dark);
    } else {
      currentThemeMode = ThemeMode.light;
      Get.changeThemeMode(ThemeMode.light);
    }
    await ThemeManager.setThemeMode(currentThemeMode!);
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            SvgPicture.asset(
              ImageAssets.craftyBayNavLogoSVG,
            ),
            const Spacer(),
            CircularIconButton(
              icon: currentThemeMode == ThemeMode.light
                  ? Icons.sunny
                  : Icons.nightlight,
              onTap: _toggleTheme,
            ),
            const SizedBox(
              width: 8,
            ),
            CircularIconButton(
              icon: Icons.person,
              onTap: () async{
                await Get.find<ReadProfileController>().readProfileData();
                Get.to(() => const UpdateProfileScreen());
              },
            ),
            const SizedBox(
              width: 8,
            ),
            CircularIconButton(
              icon: Icons.call,
              onTap: () {},
            ),
            const SizedBox(
              width: 8,
            ),
            CircularIconButton(
              icon: Icons.notifications_none,
              onTap: () {},
            ),
            const SizedBox(
              width: 8,
            ),
            CircularIconButton(
              icon: Icons.logout,
              onTap: () async {
                await AuthController.clear();
                await AuthController.getAccessToken();
                Get.offAll(const EmailVerificationScreen());
                Get.snackbar(
                    'Success', 'Logout successful.',
                    backgroundColor: ColorPalette.primaryColor,
                    colorText: Colors.white,
                    borderRadius: 10,
                    snackPosition: SnackPosition.BOTTOM);
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            TextField(
              cursorColor: ColorPalette.primaryColor,
              decoration: InputDecoration(
                fillColor: Colors.grey.shade200,
                filled: true,
                prefixIcon: const Icon(
                  Icons.search,
                  color: ColorPalette.primaryColor,
                ),
                hintText: 'Search',
                border: const OutlineInputBorder(borderSide: BorderSide.none),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            GetBuilder<HomeSliderController>(
                builder: (homeSliderController) {
                  if(homeSliderController.getHomeSliderInProgress){
                    return const SizedBox(
                      height: 180,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return  HomeSlider(
                    sliders: homeSliderController.homeSliderModel.data ?? [],
                  );
                }
            ),
            const SizedBox(
              height: 8,
            ),
            SectionHeader(
              title: "All Categories",
              onTap: () {
                Get.find<MainBottomNavController>().changeScreen(1);
              },
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 90,
              child: GetBuilder<CategoryController>(
                  builder: (categoryController ) {
                    if(categoryController.getCategoriesInProgress){
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.builder(
                        itemCount: categoryController.categoryModel.data?.length ?? 0,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return  CategoryCard(
                            categoryData: categoryController.categoryModel.data![index],
                            onTap: () {
                              Get.to(ProductListScreen(
                                  categoryId: categoryController
                                      .categoryModel.data![index].id!));
                            },
                          );
                        });
                  }
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            SectionHeader(
              title: "Popular",
              onTap: () {
                Get.to(ProductListScreen(
                    productModel: Get.find<PopularProductController>()
                        .popularProductModel));
              },
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 167,
              child: GetBuilder<PopularProductController>(
                  builder: (popularProductController) {
                    if(popularProductController.getPopularProductsInProgress){
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: popularProductController.popularProductModel.data?.length ?? 0,
                        itemBuilder: (context,index){
                          return ProductCard(
                            product: popularProductController.popularProductModel.data![index],
                          );
                        }
                    );
                  }
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            SectionHeader(
              title: "Special",
              onTap: () {
                Get.to(ProductListScreen(
                    productModel: Get.find<SpecialProductController>()
                        .specialProductModel));              },
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 167,
              child: GetBuilder<SpecialProductController>(
                  builder: (specialProductController) {
                    if(specialProductController.getSpecialProductsInProgress){
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: specialProductController.specialProductModel.data?.length ?? 0,
                        itemBuilder: (context,index){
                          return  ProductCard(
                            product: specialProductController.specialProductModel.data![index],
                          );
                        }
                    );
                  }
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            SectionHeader(
              title: "New",
              onTap: () {
                Get.to(ProductListScreen(
                    productModel: Get.find<NewProductController>()
                        .newProductModel));
              },
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 167,
              child: GetBuilder<NewProductController>(
                  builder: (newProductController) {
                    if(newProductController.getNewProductsInProgress){
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: newProductController.newProductModel.data?.length ?? 0,
                        itemBuilder: (context,index){
                          return  ProductCard(
                            product: newProductController.newProductModel.data![index],
                          );
                        }
                    );
                  }
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

