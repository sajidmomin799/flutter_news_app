
import 'package:dio/dio.dart';
import 'package:news_flutter_app/model/network_response.dart';


class NetworkProvider {
  static final NetworkProvider _instance = NetworkProvider._internal();

  static NetworkProvider get instance => _instance;

  Dio _dio = Dio();


  NetworkProvider._internal() {
    // Set default configs
    // _dio.options.baseUrl = apiUrl;
    _dio.options.connectTimeout = 30000; //30s
    _dio.options.receiveTimeout = 10000;
  }


  setBaseUrl(url) {
    _dio.options.baseUrl = url;
  }

  Future<NetworkResponse> getJSON(String urlPath,
      {Map<String, dynamic>? queryParameters}) {
    return this.request(urlPath,
        data: null,
        options: Options(method: 'GET', contentType: Headers.jsonContentType),
        queryParameters: queryParameters);
  }

  Future<NetworkResponse>
  postJSON(String urlPath,
      {Map<String, dynamic>? data, Map<String, dynamic>? queryParameters}) {
    return this.request(urlPath,
        data: data,
        options: Options(method: 'POST', contentType: Headers.jsonContentType),
        queryParameters: queryParameters);
  }


  Future<NetworkResponse> request(String urlPath,
      {dynamic data,
      Options? options,
      Map<String, dynamic>? queryParameters}) async {
    try {
      if (options != null) {
        options.responseType = ResponseType.plain;
      }
      final response = await _dio.request(urlPath,
          data: data, queryParameters: queryParameters, options: options);
      return NetworkResponse(
          statusCode: response.statusCode,
          response: response.data,
          errorMsg: null);
    } on DioError catch (e) {
      if (e.response != null) {
        var finalResponse = e.response!;
        return NetworkResponse(
            statusCode: finalResponse.statusCode,
            response: finalResponse.data.toString(),
            errorMsg: null);
      }
      return NetworkResponse();
    }
  }



}
