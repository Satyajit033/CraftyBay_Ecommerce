import 'package:ecommerce_1/data/models/cart_model/cart_data.dart';
import 'package:ecommerce_1/presentation/state_holders/cart_list_state_holders/cart_list_controller.dart';
import 'package:ecommerce_1/presentation/ui/screens/product_details_screen.dart';
import 'package:ecommerce_1/presentation/ui/utility/color_palette.dart';
import 'package:ecommerce_1/presentation/ui/widgets/custom_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CartProductCard extends StatelessWidget {
  final CartData cartData;
   CartProductCard({
    super.key, required this.cartData,
  });

  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.to(ProductDetailsScreen(productId: cartData.product!.id!));
      },
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image:NetworkImage(cartData.product?.image ?? '')
                  )
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                 Text(
                                 cartData.product?.title ?? '',
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.black,fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                RichText(
                                    text:  TextSpan(
                                        style: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 12),
                                        children: [
                                          TextSpan(text: 'Color: ${cartData.color ?? ''} '),
                                          TextSpan(text: 'Size: ${cartData.size}'),
                                        ]))
                              ],
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                Get.find<CartListController>().removeFromCart(cartData.productId!);
                                Get.snackbar('Success', 'Remove from cart list successful.',
                                    backgroundColor:ColorPalette.primaryColor,
                                    colorText: Colors.white,
                                    borderRadius: 10,
                                    snackPosition: SnackPosition.BOTTOM);
                              },
                              icon: const Icon(Icons.delete,color: Colors.black54,))
                        ],
                      ),
                       Row(
                        children: [
                           Expanded(
                            child: Text( '\$${cartData.product?.price ?? ''}',
                                  style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: ColorPalette.primaryColor,
                                )),
                          ),
                          SizedBox(
                            width: 85,
                            child: FittedBox(
                              child: CustomStepper(
                                  lowerLimit: 1,
                                  upperLimit: 10,
                                  stepValue: 1,
                                  value: cartData.quantity ?? 1,
                                  onChange: (int value) {
                                    Get.find<CartListController>().changeItem(cartData.id!, value);
                                  }),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
