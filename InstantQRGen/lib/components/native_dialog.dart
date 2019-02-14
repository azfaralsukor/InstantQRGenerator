import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';

class NativeDialog extends StatelessWidget {


  const NativeDialog({
    Key key,
    this.title,
    this.titlePadding,
    this.content,
    this.contentPadding = const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
    this.actions,
    this.semanticLabel,
    this.actionScrollController,
    this.scrollController,
    this.shape,
  })
      : assert(contentPadding != null),
        super(key: key);

  final ScrollController actionScrollController;
  final ScrollController scrollController;

  final Widget title;
  final EdgeInsetsGeometry titlePadding;

  final Widget content;

  final EdgeInsetsGeometry contentPadding;

  final List<Widget> actions;

  final String semanticLabel;

  final ShapeBorder shape;

  Widget createIosDialog(context) {
    return CupertinoAlertDialog(
      title: title,
      actions: actions,
      content: content,
      actionScrollController: actionScrollController,
      scrollController: scrollController,
    );
  }

  Widget createAndroidDialog(context) {
    return AlertDialog(
      title: title,
      actions: actions,
      content: content,
      shape: shape,
      contentPadding: contentPadding,
      semanticLabel: semanticLabel,
      titlePadding: titlePadding,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? createIosDialog(context) : createAndroidDialog(context);
  }
}


class NativeDialogAction extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Color color;

  final bool isDefaultAction;

  final TextStyle textStyle;
  final ButtonTextTheme textTheme;

  final EdgeInsets padding;

  final ShapeBorder shape;

  final Color textColor;


  const NativeDialogAction({
    Key key,
    this.child,
    this.color,
    this.textColor,
    this.isDefaultAction,
    this.onPressed,
    this.shape,
    this.textStyle,
    this.textTheme,
    this.padding,
  }) :super(key: key);


  Widget createIosDialog(context) {
    return CupertinoDialogAction(
      child: child,
      onPressed: onPressed,
      isDefaultAction: isDefaultAction,
      textStyle: textStyle,
    );
  }

  Widget createAndroidDialog(context) {

    return FlatButton(
      child: child,
      color: color,
      onPressed: onPressed,
      textTheme: textTheme,
      padding: padding,
      shape: shape,
      textColor: textColor,

    );
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? createIosDialog(context) : createAndroidDialog(context);
  }
}

