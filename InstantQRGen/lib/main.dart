import 'package:flutter/material.dart';

import 'screens/main.screen.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instant QR Generator',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        indicatorColor: Colors.grey,
      ),
      home: MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
