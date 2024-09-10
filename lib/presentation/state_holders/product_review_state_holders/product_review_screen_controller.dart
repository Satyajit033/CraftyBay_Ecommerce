import 'package:ecommerce_1/data/models/network_response.dart';
import 'package:ecommerce_1/data/models/product_review_model.dart';
import 'package:ecommerce_1/data/services/network_caller.dart';
import 'package:ecommerce_1/data/utility/urls.dart';
import 'package:get/get.dart';

class ProductReviewScreenController extends GetxController {
  bool _getProductReviewInProgress = false;
  ProductReviewModel _productReviewModel = ProductReviewModel();
  String _message = '';

  ProductReviewModel get productReviewModel => _productReviewModel;

  bool get getProductReviewInProgress => _getProductReviewInProgress;

  String get message => _message;

  Future<bool> getProductReviews(int productId) async {
    _getProductReviewInProgress = true;
    update();
    final NetworkResponse response =
    await NetworkCaller.getRequest(Urls.getReviews(productId));
    _getProductReviewInProgress = false;
    if (response.isSuccess) {
      _productReviewModel =
          ProductReviewModel.fromJson(response.body ?? {});
      update();
      return true;
    } else {
      _message = 'Review data fetch failed!';
      update();
      return false;
    }
  }
}