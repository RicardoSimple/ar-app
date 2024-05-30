import 'package:flutter_template/pages/home.dart';
import 'package:flutter_template/pages/settings.dart';
import 'package:get/get.dart';

final routes = [
  GetPage(name: '/', page: () => HomePage()),
  GetPage(name: '/setting', page: () => SettingPage())
];
