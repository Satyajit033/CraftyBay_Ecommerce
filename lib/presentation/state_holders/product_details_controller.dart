import 'package:ecommerce_1/data/models/network_response.dart';
import 'package:ecommerce_1/data/models/product_details.dart';
import 'package:ecommerce_1/data/models/product_details_model.dart';
import 'package:ecommerce_1/data/services/network_caller.dart';
import 'package:ecommerce_1/data/utility/urls.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController{
     bool _getProductDetailsInProgress = false;
     ProductDetails _productDetails = ProductDetails();
     String _errorMessage = '';
     final List<String>_availableColors=[];
     List<String>_availableSizes=[];




     bool get getProductDetailsInProgress => _getProductDetailsInProgress;
     ProductDetails get productDetails => _productDetails;
     String get errorMessage => _errorMessage;
     List<String> get availableColors => _availableColors;
     List<String> get availableSizes => _availableSizes;


     Future<bool>getProductDetails(int id)async{
       _getProductDetailsInProgress = true;
       update();
       final NetworkResponse response = await NetworkCaller.getRequest(Urls.getProductDetails(id));
       _getProductDetailsInProgress=false;
       if(response.isSuccess){
         _productDetails = ProductDetailsModel.fromJson(response.body ?? {}).data!.first;
         _convertStringToColor(_productDetails.color ?? '');
         _convertStringToSizes(_productDetails.size ?? '');
         update();
         return true;
       }else{
         _errorMessage = 'Fetch Product Details has been failed! Try again';
         update();
         return false;
       }
     }



     void _convertStringToColor(String color){
       _availableColors.clear();
       final List<String>splittedColor = color.split(',');
       for (String c in splittedColor){
         if(c.isNotEmpty){
           _availableColors.add(c);
         }
       }
     }

     void _convertStringToSizes(String sizes) {
       _availableSizes = sizes.split(',');
     }

}