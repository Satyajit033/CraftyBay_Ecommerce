import 'package:ecommerce_1/data/models/network_response.dart';
import 'package:ecommerce_1/data/services/network_caller.dart';
import 'package:ecommerce_1/data/utility/urls.dart';
import 'package:get/get.dart';

class AddToCartController extends GetxController{
  bool _addToCartInProgress = false;
  String _message = '';

  bool get addToCartInProgress => _addToCartInProgress;

  String get message => _message;

  Future<bool> addToCart(int productId,String color,String size,int quantity) async {
    _addToCartInProgress = true;
    update();
    NetworkResponse response = await NetworkCaller.postRequest(Urls.addToCart,{
      "product_id":productId,
      "color":color,
      "size":size,
      "qty":quantity
    });
    _addToCartInProgress = false;
    update();
    if (response.isSuccess) {
     // _message = response.body?['data'] ?? '';
      return true;
    } else {
      _message = 'Add to cart failed! Try again';
      return false;
    }
  }
}