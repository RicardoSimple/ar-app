import 'package:flutter/material.dart';
import 'package:flutter_template/pages/home.dart';
import 'package:flutter_template/pages/settings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AR APP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainScreen(), // 使用 MainScreen 作为应用程序的主屏幕
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0; // 初始化底部导航栏选中的索引

  // 定义底部导航栏的页面列表
  final List<Widget> _pages = [
    HomePage(), // 主页
    SettingPage(), // 设置页面
    HomePage()
    // 其他页面...
  ];

  // 底部导航栏按钮点击事件处理方法
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // 更新选中的索引
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AR App'),
        leading: IconButton( // 左侧按钮
          icon: Icon(Icons.menu),
          onPressed: () {
            // 处理左侧按钮点击事件，弹出侧边栏或其他操作

          },
        ),
      ),
      body: _pages[_selectedIndex], // 根据选中的索引显示对应页面内容
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Help',
          ),
          // 其他底部导航栏按钮...
        ],
        currentIndex: _selectedIndex, // 当前选中的索引
        onTap: _onItemTapped, // 按钮点击事件处理方法
      ),
    );
  }
}
