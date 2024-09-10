import 'package:ecommerce_1/presentation/state_holders/product_review_state_holders/product_review_screen_controller.dart';
import 'package:ecommerce_1/presentation/state_holders/auth_state_holders/read_profile_controller.dart';
import 'package:ecommerce_1/presentation/ui/screens/create_review_screen.dart';
import 'package:ecommerce_1/presentation/ui/utility/color_palette.dart';
import 'package:ecommerce_1/presentation/ui/widgets/review_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductReviewScreen extends StatefulWidget {
  final int productId;

  const ProductReviewScreen({super.key, required this.productId});

  @override
  State<ProductReviewScreen> createState() => _ProductReviewScreenState();
}

class _ProductReviewScreenState extends State<ProductReviewScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Get.find<ProductReviewScreenController>()
          .getProductReviews(widget.productId);
    });
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Reviews",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 1,
        shadowColor: Colors.white54,
        leading: IconButton(
          onPressed: () {
            Get.back();
            // Get.find<MainBottomNavController>().backToHome();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: GetBuilder<ProductReviewScreenController>(
          builder: (productReviewScreenController) {
            if (productReviewScreenController.getProductReviewInProgress) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView.builder(
                      itemCount: productReviewScreenController
                          .productReviewModel.data?.length ??
                          0,
                      itemBuilder: (BuildContext context, int index) {
                        return ReviewCard(
                          productReviewData: productReviewScreenController
                              .productReviewModel.data![index],
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                      color: ColorPalette.primaryColor.withOpacity(0.1),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Reviews (${productReviewScreenController.productReviewModel.data?.length ?? 0})',
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.black54),
                      ),
                      InkWell(
                        onTap: () async {
                          await Get.find<ReadProfileController>().readProfileData();
                          Get.to(() => CreateReviewScreen(
                            productId: widget.productId,
                          ));
                        },
                        borderRadius: BorderRadius.circular(30),
                        child: const CircleAvatar(
                          radius: 25,
                          backgroundColor: ColorPalette.primaryColor,
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 20,
                            weight: 50,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          }),
    );
  }
}