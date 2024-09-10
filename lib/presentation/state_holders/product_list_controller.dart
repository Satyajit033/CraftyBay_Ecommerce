import 'package:ecommerce_1/data/models/network_response.dart';
import 'package:ecommerce_1/data/models/product_model.dart';
import 'package:ecommerce_1/data/services/network_caller.dart';
import 'package:ecommerce_1/data/utility/urls.dart';
import 'package:get/get.dart';

class ProductListController extends GetxController {
  bool _getProductListInProgress = false;
  String _message = '';
  ProductModel _productModel = ProductModel();


  bool get getProductListInProgress => _getProductListInProgress;
  String get message => _message;
  ProductModel get productModel => _productModel;

  Future<bool> getProductsByCategory(int categoryId) async {
    _getProductListInProgress = true;
    update();
     NetworkResponse response = await NetworkCaller.getRequest(Urls.getProductByCategory(categoryId));
    _getProductListInProgress = false;
    if (response.isSuccess) {
      _productModel = ProductModel.fromJson(response.body ?? {});
      update();
      return true;
    } else {
      _message = 'Product list data fetch failed! Try again';
      update();
      return false;
    }
  }

  void setProducts(ProductModel productModel){
    _productModel = productModel;
    update();
  }
}