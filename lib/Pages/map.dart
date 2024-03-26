import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MapsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OpenStreetView'),
      ),
      body: WebView(
        initialUrl: 'https://www.openstreetmap.org/',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OpenStreetView Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MapsPage(),
    );
  }
}
