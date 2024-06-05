import 'package:ar_app/pages/camera.dart';
import 'package:ar_app/pages/help.dart';
import 'package:ar_app/pages/home.dart';
import 'package:ar_app/pages/settings.dart';
import 'package:ar_app/components/app_drawer.dart';
import 'package:ar_app/routes.dart';
import 'package:flutter/material.dart'; // 导入 AppDrawer 组件

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
      routes: Routes,
      initialRoute: "/",
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    SettingPage(),
    HelpPage(), // 可以替换成其他页面，例如帮助页面
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AR App'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add_a_photo_outlined), // 这里是按钮图�?
            onPressed: () {
              // 点击按钮时执行的操作
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return CameraPage(); // 显示相机界面
                },
              );
            },
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help),
            label: 'Help',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      drawer: AppDrawer(onItemTapped: _onItemTapped),
    );

  }
}
