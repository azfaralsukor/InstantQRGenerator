import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  static const double _topSectionTopPadding = 50.0;
  static const double _topSectionBottomPadding = 20.0;

  String _dataString = 'Hello World', _active = 'Email', _inputErrorText;
  final TextEditingController _emailController = TextEditingController(),
      _phoneController = TextEditingController(),
      _wifiController = TextEditingController();

  void _showDialog() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Settings'),
          content: Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              errorText: _inputErrorText,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: _phoneController,
                            decoration: InputDecoration(
                              labelText: 'Phone',
                              errorText: _inputErrorText,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: _wifiController,
                            decoration: InputDecoration(
                              labelText: 'Wifi Password',
                              errorText: _inputErrorText,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ])),
          actions: <Widget>[
            FlatButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: const Text('SUBMIT'),
              onPressed: () {
                setState(() {
                  _dataString = _emailController.text;
                  _inputErrorText = null;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instant QR Generator'),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[ButtonBar()],
        ),
      ),
      body: _contentWidget(context),
      resizeToAvoidBottomPadding: true,
    );
  }

  @override
  void didUpdateWidget(MainScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {});
  }

  Widget _contentWidget(BuildContext context) {
    return Container(
      color: const Color(0xFFFFFFFF),
      child: Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(
              top: _topSectionTopPadding,
              left: 30.0,
              right: 20.0,
              bottom: _topSectionBottomPadding,
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: QrImage(
                  data: _dataString,
                  gapless: false,
                  foregroundColor: const Color(0xFF111111),
                  onError: (dynamic ex) {
                    print('[QR] ERROR - $ex');
                    setState(() {
                      _inputErrorText =
                      'Error! Maybe your input value is too long?';
                    });
                  },
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FloatingActionButton(
                backgroundColor: _active == 'Email' ? Colors.teal : Colors.grey,
                onPressed: () {
                  setState(() {
                    _dataString = _emailController.text;
                    _inputErrorText = null;
                    _active = 'Email';
                  });
                },
                child: const Icon(Icons.email),
              ),
              FloatingActionButton(
                backgroundColor: _active == 'Phone' ? Colors.teal : Colors.grey,
                onPressed: () {
                  setState(() {
                    _dataString = _phoneController.text;
                    _inputErrorText = null;
                    _active = 'Phone';
                  });
                },
                child: const Icon(Icons.phone),
              ),
              FloatingActionButton(
                backgroundColor: _active == 'Wifi' ? Colors.teal : Colors.grey,
                onPressed: () {
                  setState(() {
                    _dataString = _wifiController.text;
                    _inputErrorText = null;
                    _active = 'Wifi';
                  });
                },
                child: const Icon(Icons.wifi),
              ),
              FloatingActionButton(
                backgroundColor: Colors.blueGrey,
                onPressed: _showDialog,
                child: const Icon(Icons.settings),
              ),
            ],
          )
        ],
      ),
    );
  }
}
