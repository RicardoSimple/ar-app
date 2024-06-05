import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:get_storage/get_storage.dart';
import 'package:ar_app/util/constant.dart';

class HttpService extends GetxService {
  late Dio _dio;
  static HttpService? _instance;
  final bool isAuth;

  HttpService._internal({required this.isAuth});

  factory HttpService({required bool isAuth}) {
    _instance ??= HttpService._internal(isAuth: isAuth);
    return _instance!;
  }

  Future<HttpService> init({
    required String baseUrl,
    Map<String, String>? defaultHeaders,
  }) async {
    _dio = Dio();
    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout = const Duration(milliseconds: 5000);
    _dio.options.receiveTimeout = const Duration(milliseconds: 3000);

    // 设置默认 headers
    if (defaultHeaders != null) {
      _dio.options.headers.addAll(defaultHeaders);
    }

    // 添加拦截器
    _dio.interceptors.addAll([
      // 请求拦截器
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (isAuth) {
            final token = GetStorage().read<String>(Constant.TokenKEY);
            if (token != null && token.isNotEmpty) {
              options.headers['Authorization'] = 'Bearer $token';
            }
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          // 在这里可以处理响应数据
          return handler.next(response);
        },
        onError: (DioError e, handler) {
          // 在这里可以处理错误，比如自动重试
          return handler.next(e);
        },
      ),
      // 日志拦截器
      LogInterceptor(responseBody: true),
    ]);

    return this;
  }

  Future<Response<T>> get<T>(
      String path, {
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      final response = await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioError catch (e) {
      // 处理错误，比如自动重试
      print("Error: ${e.message}");
      rethrow;
    }
  }

  Future<Response<T>> post<T>(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      final response = await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioError catch (e) {
      // 处理错误，比如自动重试
      print("Error: ${e.message}");
      rethrow;
    }
  }
}
void main() async {
  await GetStorage.init(); // 初始化 GetStorage

  final httpService = HttpService(isAuth: true);
  await httpService.init(
    baseUrl: 'https://api.example.com',
    defaultHeaders: {
      'Content-Type': 'application/json',
    },
  );

  // 发起 GET 请求
  final response = await httpService.get('/path');
  print('Response data: ${response.data}');

  // 发起 POST 请求
  final postResponse = await httpService.post('/path', data: {'key': 'value'});
  print('Post response data: ${postResponse.data}');
}
