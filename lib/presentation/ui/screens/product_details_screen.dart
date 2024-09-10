import 'package:ecommerce_1/data/models/product_details.dart';
import 'package:ecommerce_1/presentation/state_holders/cart_list_state_holders/add_to_cart_controller.dart';
import 'package:ecommerce_1/presentation/state_holders/wish_list_state_holders/create_wishlist_controller.dart';
import 'package:ecommerce_1/presentation/state_holders/product_details_controller.dart';
import 'package:ecommerce_1/presentation/ui/screens/product_review_screen.dart';
import 'package:ecommerce_1/presentation/ui/utility/color_palette.dart';
import 'package:ecommerce_1/presentation/ui/widgets/custom_stepper.dart';
import 'package:ecommerce_1/presentation/ui/widgets/product_details_headline_text.dart';
import 'package:ecommerce_1/presentation/ui/widgets/product_image_slider.dart';
import 'package:ecommerce_1/presentation/ui/widgets/size_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int productId;

  const ProductDetailsScreen({super.key, required this.productId});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  // List<String> colors = [];

  // List<String> sizes = ['S', 'M', 'L', 'XL', 'XXL', 'XXXL'];

  int quantity = 1;
  int _selectedColorIndex = 0;
  int _selectedSizeIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<ProductDetailsController>().getProductDetails(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ProductDetailsController>(
          builder: (productDetailsController) {
            if (productDetailsController.getProductDetailsInProgress) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              ProductImageSlider(imageList: [
                                productDetailsController.productDetails.img1 ??
                                    '',
                                productDetailsController.productDetails.img2 ??
                                    '',
                                productDetailsController.productDetails.img3 ??
                                    '',
                                productDetailsController.productDetails.img4 ??
                                    '',
                              ]),
                              productDetailsAppBar,
                            ],
                          ),
                          productDetailsBody(
                              productDetailsController.productDetails,
                              productDetailsController.availableColors),
                        ],
                      ),
                    ),
                  ),
                  cartToCartBottomContainer(
                    productDetailsController.productDetails,
                    productDetailsController.availableColors,
                    productDetailsController.availableSizes
                  )
                  /* const ProductDetailsScreenAndCartScreenBottomContainer(
                  paddingVerticalValue: 10,
                  priceText: "Price",
                  sizedBoxHeight: 3,
                  buttonText: "Add To Cart")*/
                ],
              ),
            );
          }),
    );
  }

  //***********************************************************************
  Padding productDetailsBody(ProductDetails productDetails,
      List<String> colors) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  productDetails.product?.title ?? '',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5),
                ),
              ),
              CustomStepper(
                  lowerLimit: 1,
                  upperLimit: 10,
                  stepValue: 1,
                  value: 1,
                  onChange: (newValue) {
                    quantity = newValue;
                  }),
            ],
          ),
          Row(
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const Icon(
                    Icons.star,
                    size: 18,
                    color: Colors.amber,
                  ),
                  Text(
                    "${productDetails.product?.star ?? 0}",
                    style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  Get.to(ProductReviewScreen(productId: widget.productId!));
                },
                child: const Text(
                  "Reviews",
                  style: TextStyle(
                      fontSize: 15,
                      color: ColorPalette.primaryColor,
                      fontWeight: FontWeight.w500),
                ),
              ),
              GetBuilder<CreateWishListController>(
                  builder: (createWishListController) {
                    return Card(
                      color: ColorPalette.primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: InkWell(
                          onTap: () async {
                            await setThisProductInWishlist(createWishListController);
                          },
                          child: const Icon(
                            Icons.favorite_border,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  })
            ],
          ),
          const ProductDetailsHeadlineText(
            headlineText: 'Color',
          ),
          const SizedBox(
            height: 16,
          ),

          SizedBox(
            height: 28,
            child: SizePicker(
                sizes: productDetails.color?.split(',') ?? [],
                onSelected: (int selectedSize) {
                  _selectedColorIndex = selectedSize;
                },
                initialSelected: 0),
          ),
          //*****************
          const SizedBox(
            height: 16,
          ),

          const ProductDetailsHeadlineText(
            headlineText: 'Size',
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 28,
            child: SizePicker(
                sizes: productDetails.size?.split(',') ?? [],
                onSelected: (int selectedSize) {
                  _selectedSizeIndex = selectedSize;
                },
                initialSelected: 0),
          ),
          const SizedBox(
            height: 16,
          ),
          const ProductDetailsHeadlineText(
            headlineText: 'Description',
          ),
          const SizedBox(
            height: 10,
          ),
          Text(productDetails.des ?? '')
        ],
      ),
    );
  }


//***************************************************************************************
  AppBar get productDetailsAppBar {
    return AppBar(
      title: const Text(
        "Product Details",
        style: TextStyle(color: Colors.black),
      ),
      leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          )),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }


//********************************************************************************************
  Container  cartToCartBottomContainer(ProductDetails details,List<String> colors, List<String> sizes){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
          color: ColorPalette.primaryColor.withOpacity(0.1),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Price',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              SizedBox(
                height:4,
              ),
              Text("\$1,000",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: ColorPalette.primaryColor,
                  )),
            ],
          ),
          SizedBox(
              width: 120,
              child: GetBuilder<AddToCartController>(
                builder: (addToCartController) {
                  if(addToCartController.addToCartInProgress){
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ElevatedButton(
                      onPressed: () {
                        addToCartController.addToCart(
                          details.id!,
                          colors[_selectedColorIndex].toString(),
                          sizes[_selectedSizeIndex],
                          quantity

                        ).then((result){
                          if(result){
                            Get.showSnackbar(
                                const GetSnackBar(
                                  title: 'Added To Cart',
                                  message: 'This product has been added to cart',
                                  backgroundColor: ColorPalette.primaryColor,
                                  duration: Duration(
                                    seconds: 3
                                  ),
                                ),
                            );
                          }
                        });
                      },
                      child: const Text(
                        'Add To Cart',
                        style: TextStyle(color: Colors.white),
                      ));
                }
              ))
        ],
      ),
    );
  }

  // added to wish list api calling

  Future<void> setThisProductInWishlist(
      CreateWishListController createWishListController) async {
    final response = await createWishListController
        .setProductInWishList(widget.productId!);
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

//***************************************************
