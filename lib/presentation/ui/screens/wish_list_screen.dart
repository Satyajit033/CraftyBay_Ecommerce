import 'package:ecommerce_1/presentation/state_holders/main_bottom_nav_controller.dart';
import 'package:ecommerce_1/presentation/state_holders/wish_list_state_holders/wishlist_screen_controller.dart';
import 'package:ecommerce_1/presentation/ui/screens/product_details_screen.dart';
import 'package:ecommerce_1/presentation/ui/widgets/wishlist_product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Get.find<WishListScreenController>().getWishlistProducts();
    });
    super.initState();
  }


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
            "Wish List",
            style: TextStyle(color: Colors.black),
          ),
          elevation: 1,
          shadowColor: Colors.white54,
          leading: IconButton(onPressed: (){
            Get.find<MainBottomNavController>().backToHome();
          }, icon: const Icon(Icons.arrow_back_ios,color: Colors.black,),),
        ),
        body: GetBuilder<WishListScreenController>(
          builder: (wishListScreenController) {
            if (wishListScreenController.getWishListProductsInProgress) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (wishListScreenController.wishListProductModel.data != null &&
                wishListScreenController.wishListProductModel.data!.isEmpty) {
              return const Center(
                child: Text('Wish List is Empty!'),
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: GridView.builder(
                  itemCount:
                  wishListScreenController.wishListProductModel.data?.length ??
                      0,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, crossAxisSpacing: 16, mainAxisSpacing: 16),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        Get.to(() => ProductDetailsScreen(
                          productId: wishListScreenController
                              .wishListProductModel.data![index].productId!,
                        ));
                      },
                      child: FittedBox(
                        child: WishListProductCard(
                          productData: wishListScreenController
                              .wishListProductModel.data![index],
                        ),
                      ),
                    );
                  }
                  ),
            );
          }
        ),
      ),
    );
  }
}
