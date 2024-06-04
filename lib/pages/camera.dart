import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // 异步初始化相机控制器
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    // 获取可用的相机列�?
    List<CameraDescription> cameras = await availableCameras();
    // 初始化相机控制器
    _controller = CameraController(cameras[0], ResolutionPreset.medium);
    // 等待相机初始化完�?
    _initializeControllerFuture = _controller.initialize();
    // 更新UI
    setState(() {});
  }

  @override
  void dispose() {
    // 释放相机资源
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera'),
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // 相机初始化完成，显示相机预览
            return CameraPreview(_controller);
          } else {
            // 相机初始化中，显示加载动�?
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
