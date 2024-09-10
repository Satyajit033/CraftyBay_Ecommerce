import 'package:ecommerce_1/data/models/category/category_model.dart';
import 'package:ecommerce_1/data/models/network_response.dart';
import 'package:ecommerce_1/data/services/network_caller.dart';
import 'package:ecommerce_1/data/utility/urls.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  bool _getCategoriesInProgress = false;
  String _message = '';
  CategoryModel _categoryModel = CategoryModel();


  bool get getCategoriesInProgress => _getCategoriesInProgress;
  String get message => _message;
  CategoryModel get categoryModel => _categoryModel;

  Future<bool> getCategories() async {
    _getCategoriesInProgress = true;
    update();
     NetworkResponse response = await NetworkCaller.getRequest(Urls.getCategories);
    _getCategoriesInProgress = false;
    if (response.isSuccess) {
      _categoryModel = CategoryModel.fromJson(response.body ?? {});
      update();
      return true;
    } else {
      _message = 'Category list data fetch failed! Try again';
      return false;
    }
  }
}