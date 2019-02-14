import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/main.screen.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  .then((_)=>
      runApp(App())
  );
}

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
      home: MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
