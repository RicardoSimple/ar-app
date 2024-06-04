import 'package:ar_app/main.dart';
import 'package:ar_app/pages/help.dart';
import 'package:ar_app/pages/home.dart';
import 'package:ar_app/pages/settings.dart';
import 'package:get/get.dart';

final Routes = {
  '/':(context)=>MainScreen(),
  '/home': (context) => HomePage(), // 主页
  '/settings': (context) => SettingPage(), // 设置页面
  '/help':(context) => HelpPage()
};
