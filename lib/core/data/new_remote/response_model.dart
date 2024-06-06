import 'dart:convert';

ResponseModel responseModelFromJson(String str) =>
    ResponseModel.fromJson(json.decode(str));

class ResponseModel {
  List<dynamic> list;
  Map<String, dynamic> productModel;

  ResponseModel({required this.list, required this.productModel});

  factory ResponseModel.fromJson(dynamic json) => ResponseModel(
      list: json is List<dynamic> ? json : [],
      productModel: json is List<dynamic> ? {} : json);
}
