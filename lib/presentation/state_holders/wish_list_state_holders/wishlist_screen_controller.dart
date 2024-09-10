import 'package:ecommerce_1/data/models/network_response.dart';
import 'package:ecommerce_1/data/models/wishlist_product_model.dart';
import 'package:ecommerce_1/data/services/network_caller.dart';
import 'package:ecommerce_1/data/utility/urls.dart';
import 'package:get/get.dart';

class WishListScreenController extends GetxController {
  bool _getWishListProductsInProgress = false;
  WishListProductModel _wishListProductModel = WishListProductModel();
  String _errorMessage = '';

  bool get getWishListProductsInProgress => _getWishListProductsInProgress;

  WishListProductModel get wishListProductModel => _wishListProductModel;

  String get errorMessage => _errorMessage;

  Future<bool> getWishlistProducts() async {
    _getWishListProductsInProgress = true;
    update();
    final NetworkResponse response =
    await NetworkCaller.getRequest(Urls.productWishList, isLogin: true);
    _getWishListProductsInProgress = false;
    if (response.isSuccess) {
      _wishListProductModel =
          WishListProductModel.fromJson(response.body ?? {});
      update();
      return true;
    } else {
      _errorMessage = 'WishList product fetch failed! Try again.';
      update();
      return false;
    }
  }
}