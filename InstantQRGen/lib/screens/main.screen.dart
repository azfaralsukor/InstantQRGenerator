import 'package:fast_qr_reader_view/fast_qr_reader_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr_demo/screens/generator.dart';

import 'reader.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key key, this.camera}) : super(key: key);
  final List<CameraDescription> camera;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          title: const Icon(Icons.flip),
        ),
        bottomNavigationBar: TabBar(
          tabs: const <Tab>[
            Tab(
              icon: Icon(
                Icons.memory,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.camera_alt,
              ),
            ),
          ],
          unselectedLabelColor: Theme.of(context).primaryColor,
          labelColor: Colors.white,
          indicator: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Generator(),
            Reader(
              camera: widget.camera,
              scaffoldKey: _scaffoldKey,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(MainScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {});
  }
}
