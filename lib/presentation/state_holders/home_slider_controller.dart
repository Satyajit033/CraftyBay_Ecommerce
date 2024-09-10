import 'package:ecommerce_1/data/models/home_slider_model/home_slider_model.dart';
import 'package:ecommerce_1/data/models/network_response.dart';
import 'package:ecommerce_1/data/services/network_caller.dart';
import 'package:ecommerce_1/data/utility/urls.dart';
import 'package:get/get.dart';

class HomeSliderController extends GetxController {
  bool _getHomeSliderInProgress = false;
  String _message = '';
  HomeSliderModel _homeSliderModel = HomeSliderModel();


  bool get getHomeSliderInProgress => _getHomeSliderInProgress;
  String get message => _message;
  HomeSliderModel get homeSliderModel => _homeSliderModel;

  Future<bool> getHomeSlider() async {
    _getHomeSliderInProgress = true;
    update();
     NetworkResponse response = await NetworkCaller.getRequest(Urls.getHomeSliders);
    _getHomeSliderInProgress = false;
    if (response.isSuccess) {
      _homeSliderModel = HomeSliderModel.fromJson(response.body ?? {});
      update();
      return true;
    } else {
      _message = 'Slider data fetch failed! Try again';
      return false;
    }
  }
}