
import 'package:ecommerce_1/data/models/network_response.dart';
import 'package:ecommerce_1/data/services/network_caller.dart';
import 'package:ecommerce_1/data/utility/urls.dart';
import 'package:get/get.dart';

class CreateWishListController extends GetxController {
  String _message = '';

  String get message => _message;

  Future<bool> setProductInWishList(int productId) async {
    final NetworkResponse response =
    await NetworkCaller.getRequest(Urls.setProductInWishList(productId), isLogin: true);
    if (response.isSuccess) {
      return true;
    } else {
      _message = 'Set product wishList failed!';
      return false;
    }
  }
}