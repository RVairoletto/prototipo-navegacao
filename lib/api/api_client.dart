import 'dart:convert';
import 'api_request.dart';
import 'api_response.dart';

class ApiClient {
  final String baseUrl = r'http://localhost:3000/';

  Future<ApiResponse> get({required String endPoint, String token = '', Map? filters}) async {
    ApiRequest request = ApiRequest(url: baseUrl + endPoint, requestType: RequestType.GET);

    request.header = {
      'Content-Type': 'application/json',
      //'Authorization': 'Bearer $token',
      'Access-Control-Allow-Origin': '*',
    };

    request.params = jsonEncode(filters);

    ApiResponse response = await request.makeCall();

    return response;
  }

  Future<ApiResponse> post({required String endPoint, String token = '', Map? data}) async {
    ApiRequest request = ApiRequest(url: baseUrl + endPoint, requestType: RequestType.POST);

    request.header = {
      'Content-Type': 'application/json',
      //'Authorization': 'Bearer $token',
      'Access-Control-Allow-Origin': '*',
    };

    if(data != null) {
      request.body = jsonEncode(data);
    }

    ApiResponse response = await request.makeCall();

    return response;
  }

  Future<ApiResponse> put({required String endPoint, String token = '', Map? data}) async {
    ApiRequest request = ApiRequest(url: baseUrl + endPoint, requestType: RequestType.PUT);

    request.header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'Access-Control-Allow-Origin': '*',
    };
    
    request.body = jsonEncode(data);

    ApiResponse response = await request.makeCall();

    return response;
  }

  Future<ApiResponse> delete({required String endPoint, String token = '', Map? filters}) async {
    ApiRequest request = ApiRequest(url: baseUrl + endPoint, requestType: RequestType.DELETE);

    request.header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'Access-Control-Allow-Origin': '*',
    };

    ApiResponse response = await request.makeCall();

    return response;
  }

  Future<ApiResponse> resetPassword({required String endPoint, String token = '', Map? data}) async {
    ApiRequest request = ApiRequest(url: baseUrl + endPoint, requestType: RequestType.PUT);
    
    request.header = {
      'Content-Type': 'application/json',
      'x-reset-token': token,
      'Access-Control-Allow-Origin': '*',
    };

    if(data != null) {
      request.body = jsonEncode(data);
    }

    ApiResponse response = await request.makeCall();

    return response;
  }
}
