import 'package:ecommerce_1/data/models/network_response.dart';
import 'package:ecommerce_1/data/services/network_caller.dart';
import 'package:ecommerce_1/data/utility/urls.dart';
import 'package:get/get.dart';

class EmailVerificationController extends GetxController {
  bool _emailVerificationInProgress = false;
  String _message = '';

  bool get emailVerificationInProgress => _emailVerificationInProgress;

  String get message => _message;

  Future<bool> verifyEmail(String email) async {
    _emailVerificationInProgress = true;
    update();
     NetworkResponse response = await NetworkCaller.getRequest(Urls.verifyEmail(email));
    _emailVerificationInProgress = false;
    update();
    if (response.isSuccess) {
      _message = response.body?['data'] ?? '';
      return true;
    } else {
      _message = 'Email verification failed! Try again';
      return false;
    }
  }
}