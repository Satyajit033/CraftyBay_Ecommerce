import 'package:ecommerce_1/data/models/product.dart';
import 'package:ecommerce_1/presentation/state_holders/wish_list_state_holders/create_wishlist_controller.dart';
import 'package:ecommerce_1/presentation/ui/screens/product_details_screen.dart';
import 'package:ecommerce_1/presentation/ui/utility/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key, required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        Get.to(ProductDetailsScreen(productId: product.id!,));
      },
      child: Card(
        shadowColor: ColorPalette.primaryColor.withOpacity(0.1),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: SizedBox(
          width: 130,
          child: Column(
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                    color: ColorPalette.primaryColor.withOpacity(0.1),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                    ),
                    image:  DecorationImage(
                        image: NetworkImage(product.image ?? ''))),
              ),
               Container(
                 decoration: const BoxDecoration(
                   color:Colors.white ,
                   borderRadius: BorderRadius.only(
                     bottomLeft: Radius.circular(10),
                     bottomRight: Radius.circular(10),
                   ),
                 ),
                 child:  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                       Text(
                       product.title ?? '',
                        maxLines: 1,
                        style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.blueGrey),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           Text(
                            "\$${product.price ?? 0}",
                            style: const TextStyle(
                                fontSize: 13,
                                color: ColorPalette.primaryColor,
                                fontWeight: FontWeight.w500),
                          ),
                           Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              const Icon(
                                Icons.star,
                                size: 15,
                                color: Colors.amber,
                              ),
                              Text(
                                "${product.star ?? 0}",
                                style: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                          GetBuilder<CreateWishListController>(
                              builder: (createWishListController) {
                                return Card(
                                  color: ColorPalette.primaryColor,
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: InkWell(
                                      onTap: () async {
                                        await setThisProductInWishlist(
                                            createWishListController);
                                      },
                                      child: const Icon(
                                        Icons.favorite_border,
                                        size: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                );
                              })
                          /*Card(
                            color: ColorPalette.primaryColor,
                            child: Padding(
                              padding: EdgeInsets.all(2.0),
                              child: Icon(
                                Icons.favorite_border,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          )*/
                        ],
                      ),
                    ],
                  ),
                               ),
               )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> setThisProductInWishlist(
      CreateWishListController createWishListController) async {
    final response =
    await createWishListController.setProductInWishList(product.id!);
    if (response) {
      Get.snackbar('Success', 'Add wishlist successfully.',
          backgroundColor: ColorPalette.primaryColor,
          colorText: Colors.white,
          borderRadius: 10,
          snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar('Failed', 'Add wishlist failed! Try again',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          borderRadius: 10,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

}