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

  bool _obscureTextLogin = true;

  void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
    print('_obsureTextLogin: '+_obscureTextLogin.toString());
  }

  void _showSettingsDialog() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Icon(Icons.settings),
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
                          icon: const Icon(Icons.email),
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
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: false,
                          signed: false,
                        ),
                        controller: _phoneController,
                        decoration: InputDecoration(
                          icon: const Icon(Icons.phone),
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
                        obscureText: _obscureTextLogin,
                        decoration: InputDecoration(
                          icon: const Icon(Icons.wifi),
                          errorText: _inputErrorText,
                          suffixIcon: GestureDetector(
                            onTap: _toggleLogin,
                            child: const Icon(
                              Icons.remove_red_eye,
                              size: 15.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ])),
          actions: <Widget>[
            FlatButton(
              child: const Icon(Icons.clear),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: const Icon(Icons.check),
              onPressed: () {
                switch (_active) {
                  case 'Email':
                    {
                      setState(() {
                        _dataString = _emailController.text;
                        _inputErrorText = null;
                      });
                    }
                    break;
                  case 'Phone':
                    {
                      setState(() {
                        _dataString = _phoneController.text;
                        _inputErrorText = null;
                      });
                    }
                    break;
                  default:
                    {
                      setState(() {
                        _dataString = _wifiController.text;
                        _inputErrorText = null;
                      });
                    }
                    break;
                }
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Instant QR Generator'),
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
        body: TabBarView(children: [_qrWidget(), _cameraWidget()]),
      ),
    );
  }

  @override
  void didUpdateWidget(MainScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {});
  }

  Widget _qrWidget() {
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
          Text(
            _dataString,
            style: TextStyle(
                fontSize: 20,
                fontFamily: 'Arial',
                letterSpacing: 2,
                color: Theme.of(context).primaryColor),
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
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              FloatingActionButton(
                backgroundColor: _active == 'Email'
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).indicatorColor,
                onPressed: () {
                  setState(() {
                    _dataString = _emailController.text;
                    _inputErrorText = null;
                    _active = 'Email';
                  });
                },
                child: const Icon(Icons.email),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  right: 10.0,
                ),
              ),
              FloatingActionButton(
                backgroundColor: _active == 'Phone'
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).indicatorColor,
                onPressed: () {
                  setState(() {
                    _dataString = _phoneController.text;
                    _inputErrorText = null;
                    _active = 'Phone';
                  });
                },
                child: const Icon(Icons.phone),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  right: 10.0,
                ),
              ),
              FloatingActionButton(
                backgroundColor: _active == 'Wifi'
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).indicatorColor,
                onPressed: () {
                  setState(() {
                    _dataString = _wifiController.text;
                    _inputErrorText = null;
                    _active = 'Wifi';
                  });
                },
                child: const Icon(Icons.wifi),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  right: 10.0,
                ),
              ),
              FloatingActionButton(
                backgroundColor: Colors.blueGrey,
                onPressed: _showSettingsDialog,
                child: const Icon(Icons.settings),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(
              bottom: _topSectionBottomPadding,
            ),
          ),
        ],
      ),
    );
  }

  Widget _cameraWidget() {
    return Container(
      color: Colors.black,
      child: Column(
        children: <Widget>[],
      ),
    );
  }
}
