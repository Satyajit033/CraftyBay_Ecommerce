import 'package:ecommerce_1/data/models/home_slider_model/home_slider_data.dart';

class HomeSliderModel {
  String? msg;
  List<HomeSliderData>? data;

  HomeSliderModel({this.msg, this.data});

  HomeSliderModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      data = <HomeSliderData>[];
      json['data'].forEach((v) {
        data!.add(HomeSliderData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

