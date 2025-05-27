import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:webview_flutter/webview_flutter.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minku',
      theme: ThemeData(
        primarySwatch: Colors.purple
      ),
      home: const WebViewDemo(),
    );
  }
}

class WebViewDemo extends StatefulWidget {
  const WebViewDemo({super.key});

  @override
  State<WebViewDemo> createState() => _WebViewDemoState();
}

class _WebViewDemoState extends State<WebViewDemo> {
  List<CameraDescription> cameras = [];
  CameraController? cameraController;
  WebViewController controller = WebViewController(
    onPermissionRequest: (WebViewPermissionRequest request) => request.grant(),
  );

  @override
  void initState(){
    super.initState();
    requestPermissions();
    //_setupCameraController();
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (progress) => {},
        onPageStarted: (url) => {},
        onPageFinished:  (url) => {},
      ))
      ..loadRequest(Uri.parse('https://viavrarlab.github.io/MinkuFinal/'));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minku')
      ),
      body: WebViewWidget(controller: controller),
    );
  }

  Future<void> requestPermissions() async {
    await [
      Permission.camera,
    ].request();
  }
}

