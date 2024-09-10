import 'package:ecommerce_1/presentation/state_holders/cart_list_state_holders/add_to_cart_controller.dart';
import 'package:ecommerce_1/presentation/state_holders/cart_list_state_holders/cart_list_controller.dart';
import 'package:ecommerce_1/presentation/state_holders/category_controller.dart';
import 'package:ecommerce_1/presentation/state_holders/create_invoice_controller.dart';
import 'package:ecommerce_1/presentation/state_holders/auth_state_holders/create_profile_screen_controller.dart';
import 'package:ecommerce_1/presentation/state_holders/product_review_state_holders/create_review_screen_controller.dart';
import 'package:ecommerce_1/presentation/state_holders/wish_list_state_holders/create_wishlist_controller.dart';
import 'package:ecommerce_1/presentation/state_holders/wish_list_state_holders/delete_wishlist_product_controller.dart';
import 'package:ecommerce_1/presentation/state_holders/auth_state_holders/email_verification_controller.dart';
import 'package:ecommerce_1/presentation/state_holders/home_slider_controller.dart';
import 'package:ecommerce_1/presentation/state_holders/main_bottom_nav_controller.dart';
import 'package:ecommerce_1/presentation/state_holders/new_product_controller.dart';
import 'package:ecommerce_1/presentation/state_holders/auth_state_holders/otp_verification_controller.dart';
import 'package:ecommerce_1/presentation/state_holders/popular_product_controller.dart';
import 'package:ecommerce_1/presentation/state_holders/product_details_controller.dart';
import 'package:ecommerce_1/presentation/state_holders/product_list_controller.dart';
import 'package:ecommerce_1/presentation/state_holders/product_review_state_holders/product_review_screen_controller.dart';
import 'package:ecommerce_1/presentation/state_holders/auth_state_holders/read_profile_controller.dart';
import 'package:ecommerce_1/presentation/state_holders/special_product_controller.dart';
import 'package:ecommerce_1/presentation/state_holders/wish_list_state_holders/wishlist_screen_controller.dart';
import 'package:get/get.dart';

class StateHolderBinder extends Bindings{
  @override
  void dependencies() {
    Get.put(MainBottomNavController());
    Get.put(EmailVerificationController());
    Get.put(OtpVerificationController());
    Get.put(HomeSliderController());
    Get.put(CategoryController());
    Get.put(PopularProductController());
    Get.put(NewProductController());
    Get.put(SpecialProductController());
    Get.put(ProductDetailsController());
    Get.put(AddToCartController());
    Get.put(ProductListController());
    Get.put(CartListController());
    Get.put(CreateInvoiceController());
    Get.put(WishListScreenController());
    Get.put(DeleteWishListProductController());
    Get.put(CreateWishListController());
    Get.put(CreateReviewScreenController());
    Get.put(ProductReviewScreenController());
    Get.put(ReadProfileController());
    Get.put(CreateProfileScreenController());
  }

}
