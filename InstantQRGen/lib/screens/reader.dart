import 'package:fast_qr_reader_view/fast_qr_reader_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Reader extends StatefulWidget {
  const Reader({Key key, this.camera, this.scaffoldKey}) : super(key: key);
  final List<CameraDescription> camera;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  _ReaderState createState() => _ReaderState();
}

class _ReaderState extends State<Reader> {
  QRReaderController controller;

  @override
  void initState() {
    super.initState();
    controller = QRReaderController(
        widget.camera[0], ResolutionPreset.medium, <CodeFormat>[CodeFormat.qr],
        (dynamic value) {
      widget.scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(value),
        action: SnackBarAction(
          label: 'COPY',
          textColor: Theme.of(context).primaryColor,
          onPressed: () {
            Clipboard.setData(ClipboardData(text: value));
          },
        ),
      ));
      Future<void>.delayed(
          const Duration(seconds: 3), controller.startScanning);
    });
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
      controller.startScanning();
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: QRReaderPreview(controller));
  }
}
