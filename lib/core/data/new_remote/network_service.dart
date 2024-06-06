import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:wonder_beauties/core/data/new_remote/response_model.dart';
import 'package:wonder_beauties/core/data/new_remote/server_config.dart';

import '../../utils/functions.dart';
import 'network_utils.dart';

enum HttpMethod { get, post, delete, put }

enum BodyType { json, formData }

abstract class NetworkService {
  static Future<T> handleResponse<T>(response,
      {T Function(dynamic data)? successCallback,
      T Function(String error)? errorCallback}) async {
    ResponseModel res = ResponseModel.fromJson(response.data);
    if (!await isNetworkAvailable()) {
      return errorCallback!('No Internet Connection');
    }
    if (response.statusCode == 200) {
      return successCallback!(res);
    } else if (response.statusCode! >= 500) {
      return errorCallback!('Server Error');
    } else {
      return errorCallback!("");
    }
  }

  Uri buildRequestUrl(String endPoint) {
    Uri url = Uri.parse(endPoint);
    if (!endPoint.startsWith('http')) {
      url = Uri.parse('');
    }
    return url;
  }

  Future sendRequest(String endPoint,
      {HttpMethod method = HttpMethod.get,
      Map<String, dynamic>? body,
      BodyType bodyType,
      Map<String, String>? queryParameters});
}

class DioNetworkService extends NetworkService {
  Dio dio = Dio();

  @override
  Future sendRequest(String endPoint,
      {HttpMethod method = HttpMethod.get,
      Map<String, dynamic>? body,
      BodyType bodyType = BodyType.json,
      Map<String, String>? queryParameters}) async {
    dio.options.baseUrl = ServerConfig.baseUrl;
    if (queryParameters != null) {
      dio.options.queryParameters = queryParameters;
    }

    dio.options.receiveTimeout = const Duration(seconds: 10);
    dio.options.sendTimeout = const Duration(seconds: 10);

    Response response;
    switch (method) {
      case HttpMethod.post:
        dio.options.headers.addAll(bodyType == BodyType.formData
            ? {HttpHeaders.contentTypeHeader: "multipart/form-data"}
            : {HttpHeaders.contentTypeHeader: "application/json"});

        response = await dio.post(
          endPoint,
          data: getBody(body!, bodyType),
        );
        break;
      case HttpMethod.get:
        dio.options.headers.addAll(bodyType == BodyType.formData
            ? {HttpHeaders.contentTypeHeader: "multipart/form-data"}
            : {HttpHeaders.contentTypeHeader: "application/json"});

        response = await dio.get(endPoint);
        break;
      case HttpMethod.delete:
        response = await dio.delete(endPoint);
        break;
      case HttpMethod.put:
        dio.options.headers.addAll(bodyType == BodyType.formData
            ? {HttpHeaders.contentTypeHeader: "multipart/form-data"}
            : {HttpHeaders.contentTypeHeader: "application/json"});

        response = await dio.put(
          endPoint,
          data: getBody(body!, bodyType),
        );
        break;
      default:
        dio.options.headers.addAll(bodyType == BodyType.formData
            ? {HttpHeaders.contentTypeHeader: "multipart/form-data"}
            : {HttpHeaders.contentTypeHeader: "application/json"});
        response = await dio.get(endPoint);
    }

    Functions.printNormal(
        'Response (${method.name.toString()}) ${response.statusCode.toString()}:==> ${response.data.toString()}');

    return NetworkService.handleResponse<ResponseModel>(
      response,
      successCallback: (data) => data,
      errorCallback: (error) => throw error,
    );
  }

  getBody(Map<String, dynamic> body, BodyType bodyType) {
    if (bodyType == BodyType.json) {
      return jsonEncode(body);
    } else {
      return FormData.fromMap(body);
    }
  }
}
