import 'package:flutter_template/main.dart';
import 'package:flutter_template/pages/help.dart';
import 'package:flutter_template/pages/home.dart';
import 'package:flutter_template/pages/settings.dart';
import 'package:get/get.dart';

final Routes = {
  '/':(context)=>MainScreen(),
  '/home': (context) => HomePage(), // 主页
  '/settings': (context) => SettingPage(), // 设置页面
  '/help':(context) => HelpPage()
};
