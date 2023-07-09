import 'package:dio/dio.dart';
import 'package:report_project/data/constant_data.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_multipart.g.dart';

@Riverpod(keepAlive: true)
DioPutusAsa dioPutusAsa(DioPutusAsaRef ref) {
  return DioPutusAsa(Dio());
}

class DioPutusAsa {
  final Dio _dio;

  Options tokenOptions(String token) {
    return Options(
      headers: {
        "Authorization": 'Bearer $token',
      },
    );
  }

  DioPutusAsa(this._dio) {
    _dio
      ..options.baseUrl = ConstantApi.baseUrl + ConstantApi.api
      ..options.connectTimeout = ConstantApi.connectionTimeout
      ..options.receiveTimeout = ConstantApi.receiveTimeout
      ..options.headers = {
        'Accept': 'application/vnd.api+json',
        'Content-Type': 'application/vnd.api+json',
        // 'Content-Type': 'multipart/form-data',
        // 'Content-Type': 'application/x-www-form-urlencoded',
        'Connection': 'keep-alive',
        // 'Content-Type': 'application/json',
        // 'Accept': 'application/json',
      }
      ..options.responseType = ResponseType.json;

    _dio.interceptors.add(LogInterceptor(
      responseBody: true,
      requestBody: true,
      error: true,
    ));
  }

  /// GET
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// POST
  Future<Response> post(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// PUT
  Future<Response> put(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// DELETE
  Future<Response> delete(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}