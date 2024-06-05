import 'package:ar_app/util/Api.dart';
import 'package:ar_app/util/constant.dart';
import 'package:get_storage/get_storage.dart';

import './http_service.dart'; // 假设 HttpService 的路径为 http_service.dart

class AuthService {
  late final HttpService httpService;
  final GetStorage storage = GetStorage();
  AuthService() {
    // 从配置中读取 baseUrl
    // 初始化 HttpService
    httpService = HttpService(isAuth: false);
    httpService.init(baseUrl: API.BaseUrl,defaultHeaders: null);
  }

  Future<void> login(String username, String password) async {
    try {
      final response = await httpService.post(API.LoginApi, data: {
        'username': username,
        'password': password,
      });

      // 处理登录成功的逻辑
      if (response.statusCode == 200) {
        final tokenInfo = response.data['token_info'];
        // 存储整个 tokenInfo
        storage.write(Constant.TokenInfoKey, tokenInfo);
        // 存储 token
        storage.write(Constant.TokenKEY, tokenInfo['token']);
        // todo 跳转
      } else {
        // 处理登录失败的逻辑
        throw Exception('登录失败');
      }
    } catch (e) {
      // 处理登录失败的逻辑
      rethrow;
    }
  }
  Future<void> register(RegisterReq req) async {
    try {
      final response = await httpService.post(API.RegisterApi, data: {
        'username': req.username,
        'password': req.password,
        'phone': req.phone,
        'email': req.email,
      });
      // 处理注册成功的逻辑
    } catch (e) {
      // 处理注册失败的逻辑
    }
  }
}

class RegisterReq{
  late String username;
  late String password;
  late String phone;
  late String email;
}