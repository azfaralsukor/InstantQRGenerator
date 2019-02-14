import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_qr_demo/components/native_dialog.dart';
import 'package:flutter_android_pip/flutter_android_pip.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

String _dataString = '',
    _active = 'Email',
    _inputEmailText,
    _inputErrorText,
    _email = '',
    _phone = '',
    _wifi = '';
final TextEditingController _emailController = TextEditingController(),
    _phoneController = TextEditingController(),
    _wifiController = TextEditingController();
bool _obscureTextLogin = true;

class _MainScreenState extends State<MainScreen> {
  static const double _topSectionTopPadding = 50.0;
  static const double _topSectionBottomPadding = 20.0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
        body: TabBarView(children: <Widget>[_qrWidget(), _cameraWidget()]),
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
          Platform.isIOS ? null :
          Container(
            child: FlatButton(
              onPressed: () {
                FlutterAndroidPip.enterPictureInPictureMode;
              },
              child: Icon(
                Icons.minimize,
                color: Theme.of(context).indicatorColor,
              ),
            ),
            alignment: Alignment.topRight,
          ),
          const Padding(
            padding: EdgeInsets.only(
              top: _topSectionTopPadding,
              left: 30.0,
              right: 20.0,
              bottom: _topSectionBottomPadding,
            ),
          ),
          Text(
            _active == 'Wifi' ? '' : _dataString,
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
                    _dataString = _email;
                    _inputEmailText = null;
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
                    _dataString = _phone;
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
                    _dataString = _wifi;
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

  void _showSettingsDialog() {
    _obscureTextLogin = true;
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return _Settings(onSubmit: () {
          setState(() {
            switch (_active) {
              case 'Email':
                {
                  _dataString = _emailController.text;
                  _inputErrorText = null;
                }
                break;
              case 'Phone':
                {
                  _dataString = _phoneController.text;
                  _inputErrorText = null;
                }
                break;
              default:
                {
                  _dataString = _wifiController.text;
                  _inputErrorText = null;
                }
                break;
            }
          });
          _email = _emailController.text;
          _phone = _phoneController.text;
          _wifi = _wifiController.text;
          Navigator.of(context).pop();
        });
      },
    );
  }

  Widget _cameraWidget() {
    return Container(
      color: Colors.black,
      child: Column(
        children: const <Widget>[],
      ),
    );
  }
}

class _Settings extends StatefulWidget {
  const _Settings({Key key, this.onSubmit}) : super(key: key);
  final Function onSubmit;

  @override
  State<_Settings> createState() {
    return _SettingsState();
  }
}

class _SettingsState extends State<_Settings> {
  void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }

  void _emailVal(String email) {
    final RegExp exp =
        RegExp(r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)');
    final Iterable<Match> matches = exp.allMatches(email);
    setState(() {
      if (matches.isEmpty) {
        _inputEmailText = '';
      } else {
        _inputEmailText = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return NativeDialog(
      title: const Icon(Icons.settings),
      content: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            NativeTextField(
              controller: _emailController,
              onChanged: _emailVal,
              decoration: InputDecoration(
                  icon: const Icon(Icons.email),
                  errorText: _inputEmailText,
                  errorStyle: const TextStyle(fontSize: 0)),
            ),
            NativeTextField(
              keyboardType: TextInputType.phone,
              controller: _phoneController,
              decoration: InputDecoration(
                icon: const Icon(Icons.phone),
                errorText: _inputErrorText,
              ),
            ),
            NativeTextField(
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
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: const Icon(Icons.clear),
          onPressed: () {
            _emailController.text = _email;
            _phoneController.text = _phone;
            _wifiController.text = _wifi;
            _inputEmailText = null;
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: const Icon(Icons.check),
          onPressed: _inputEmailText == null ? widget.onSubmit : null,
        ),
      ],
    );
  }
}
