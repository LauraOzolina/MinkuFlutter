import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();//initialize Flutter engine, binding setup
  await Permission.camera.request();//Pieprasa piekļuvi kamerai
  runApp(const MyApp());//Startē lietotni
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WebViewPage(),
    );
  }
}

class WebViewPage extends StatefulWidget {
  @override
  State<WebViewPage> createState() => _WebViewPageState();//WebView izveide, kur tiek parādīts weblapas saturs
}

class _WebViewPageState extends State<WebViewPage> {
  @override
  Widget build(BuildContext context) {//izveido aplikācijas skatu, kur ielādē web lapu
    return Scaffold(
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: WebUri("https://viavrarlab.github.io/MinkuFinal/"),//ielādē WEBlapu
        ),
        initialSettings: InAppWebViewSettings(
          mediaPlaybackRequiresUserGesture: false,
          allowsInlineMediaPlayback: true,
        ),
        onPermissionRequest: (controller, request) async {
          //piešķir atļauju, ja tāda ir dota
          return PermissionResponse(
            resources: request.resources,
            action: PermissionResponseAction.GRANT,
          );
        },
      ),
    );
  }
}


