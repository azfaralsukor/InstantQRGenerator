import 'package:fast_qr_reader_view/fast_qr_reader_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/main.screen.dart';

List<CameraDescription> cameras;

Future<void> main() async {
  try {
    cameras = await availableCameras();
  } on QRReaderException catch (e) {
    logError(e.code, e.description);
  }
  SystemChrome.setPreferredOrientations(
      <DeviceOrientation>[DeviceOrientation.portraitUp])
      .then((_) => runApp(App()));
}

void logError(String code, String message) =>
    print('Error: $code\nError Message: $message');

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.blue,
        indicatorColor: Colors.grey,
      ),
      home: MainScreen(camera: cameras),
      debugShowCheckedModeBanner: false,
    );
  }
}
