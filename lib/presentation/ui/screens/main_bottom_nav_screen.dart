import 'package:ecommerce_1/presentation/state_holders/category_controller.dart';
import 'package:ecommerce_1/presentation/state_holders/home_slider_controller.dart';
import 'package:ecommerce_1/presentation/state_holders/main_bottom_nav_controller.dart';
import 'package:ecommerce_1/presentation/state_holders/new_product_controller.dart';
import 'package:ecommerce_1/presentation/state_holders/popular_product_controller.dart';
import 'package:ecommerce_1/presentation/state_holders/special_product_controller.dart';
import 'package:ecommerce_1/presentation/ui/screens/cart_screen.dart';
import 'package:ecommerce_1/presentation/ui/screens/category_list_screen.dart';
import 'package:ecommerce_1/presentation/ui/screens/home_screen.dart';
import 'package:ecommerce_1/presentation/ui/screens/wish_list_screen.dart';
import 'package:ecommerce_1/presentation/ui/utility/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  final List<Widget> _screens = [
    const HomeScreen(),
    const CategoryListScreen(),
    const CartScreen(),
    const WishListScreen()
  ];

  @override
  void initState(){
    WidgetsBinding.instance.addPostFrameCallback((_){
      Get.find<HomeSliderController>().getHomeSlider();
      Get.find<CategoryController>().getCategories();
      Get.find<PopularProductController>().getPopularProducts();
      Get.find<NewProductController>().getNewProducts();
      Get.find<SpecialProductController>().getSpecialProducts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainBottomNavController>(builder: (controller) {
      return Scaffold(
        body: _screens[controller.currentSelectedIndex],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.currentSelectedIndex,
            onTap: controller.changeScreen,
            selectedItemColor: ColorPalette.primaryColor,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            elevation: 4,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard), label: "Categories"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart), label: "Cart"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.card_giftcard_outlined), label: "Wish"),
            ]),
      );
    });
  }
}
