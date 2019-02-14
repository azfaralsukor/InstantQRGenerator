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
  })  : assert(contentPadding != null),
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

  Widget createIosDialog(BuildContext context) {
    return CupertinoAlertDialog(
      title: title,
      actions: actions,
      content: content,
      actionScrollController: actionScrollController,
      scrollController: scrollController,
    );
  }

  Widget createAndroidDialog(BuildContext context) {
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
    return Platform.isIOS
        ? createIosDialog(context)
        : createAndroidDialog(context);
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
  }) : super(key: key);

  Widget createIosDialog(BuildContext context) {
    return CupertinoDialogAction(
      child: child,
      onPressed: onPressed,
      isDefaultAction: isDefaultAction,
      textStyle: textStyle,
    );
  }

  Widget createAndroidDialog(BuildContext context) {
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
    return Platform.isIOS
        ? createIosDialog(context)
        : createAndroidDialog(context);
  }
}

class NativeTextField extends StatelessWidget {
  final Function onChanged;

  NativeTextField({
    Key key,
    this.variant,
    this.decoration = const InputDecoration(),
    this.controller,
    this.focusNode,
    TextInputType keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.style,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.onChanged,
    this.autofocus = false,
    this.obscureText = false,
    this.autocorrect = true,
    this.maxLines = 1,
    this.maxLength,
    this.maxLengthEnforced = true,
    this.validator,
    this.onEditingComplete,
    this.onSubmitted,
    this.enabled,
    this.cursorWidth = 2.0,
    this.cursorRadius,
    this.cursorColor,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.enableInteractiveSelection = true,
    this.onTap,
  })  : keyboardType = keyboardType ??
            (maxLines == 1 ? TextInputType.text : TextInputType.multiline),
        super(key: key);

  final String variant;

  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController].
  final TextEditingController controller;

  /// Defines the keyboard focus for this widget.
  ///
  /// The [focusNode] is a long-lived object that's typically managed by a
  /// [StatefulWidget] parent. See [FocusNode] for more information.
  ///
  /// To give the keyboard focus to this widget, provide a [focusNode] and then
  /// use the current [FocusScope] to request the focus:
  ///
  /// ```dart
  /// FocusScope.of(context).requestFocus(myFocusNode);
  /// ```
  ///
  /// This happens automatically when the widget is tapped.
  ///
  /// To be notified when the widget gains or loses the focus, add a listener
  /// to the [focusNode]:
  ///
  /// ```dart
  /// focusNode.addListener(() { print(myFocusNode.hasFocus); });
  /// ```
  ///
  /// If null, this widget will create its own [FocusNode].
  ///
  /// ## Keyboard
  ///
  /// Requesting the focus will typically cause the the keyboard to be shown
  /// if it's not showing already.
  ///
  /// On Android, the user can hide the keyboard - withouth changing the focus -
  /// with the system back button. They can restore the keyboard's visibility
  /// by tapping on a text field.  The user might hide the keyboard and
  /// switch to a physical keyboard, or they might just need to get it
  /// out of the way for a moment, to expose something it's
  /// obscuring. In this case requesting the focus again will not
  /// cause the focus to change, and will not make the keyboard visible.
  ///
  /// This widget builds an [EditableText] and will ensure that the keyboard is
  /// showing when it is tapped by calling [EditableTextState.requestKeyboard()].
  final FocusNode focusNode;

  /// The decoration to show around the text field.
  ///
  /// By default, draws a horizontal line under the text field but can be
  /// configured to show an icon, label, hint text, and error text.
  ///
  /// Specify null to remove the decoration entirely (including the
  /// extra padding introduced by the decoration to save space for the labels).
  final InputDecoration decoration;

  /// {@macro flutter.widgets.editableText.keyboardType}
  final TextInputType keyboardType;

  /// The type of action button to use for the keyboard.
  ///
  /// Defaults to [TextInputAction.newline] if [keyboardType] is
  /// [TextInputType.multiline] and [TextInputAction.done] otherwise.
  final TextInputAction textInputAction;

  /// {@macro flutter.widgets.editableText.textCapitalization}
  final TextCapitalization textCapitalization;

  /// The style to use for the text being edited.
  ///
  /// This text style is also used as the base style for the [decoration].
  ///
  /// If null, defaults to the `subhead` text style from the current [Theme].
  final TextStyle style;

  /// {@macro flutter.widgets.editableText.textAlign}
  final TextAlign textAlign;

  /// {@macro flutter.widgets.editableText.textDirection}
  final TextDirection textDirection;

  /// {@macro flutter.widgets.editableText.autofocus}
  final bool autofocus;

  /// {@macro flutter.widgets.editableText.obscureText}
  final bool obscureText;

  /// {@macro flutter.widgets.editableText.autocorrect}
  final bool autocorrect;

  /// {@macro flutter.widgets.editableText.maxLines}
  final int maxLines;

  /// If [maxLength] is set to this value, only the "current input length"
  /// part of the character counter is shown.
  static const int noMaxLength = 9007199254740992; // math.pow(2, 53);

  /// The maximum number of characters (Unicode scalar values) to allow in the
  /// text field.
  ///
  /// If set, a character counter will be displayed below the
  /// field, showing how many characters have been entered and how many are
  /// allowed. After [maxLength] characters have been input, additional input
  /// is ignored, unless [maxLengthEnforced] is set to false. The TextField
  /// enforces the length with a [LengthLimitingTextInputFormatter], which is
  /// evaluated after the supplied [inputFormatters], if any.
  ///
  /// This value must be either null or greater than zero. If set to null
  /// (the default), there is no limit to the number of characters allowed.
  ///
  /// Whitespace characters (e.g. newline, space, tab) are included in the
  /// character count.
  ///
  /// If [maxLengthEnforced] is set to false, then more than [maxLength]
  /// characters may be entered, but the error counter and divider will
  /// switch to the [decoration.errorStyle] when the limit is exceeded.
  ///
  /// ## Limitations
  ///
  /// The TextField does not currently count Unicode grapheme clusters (i.e.
  /// characters visible to the user), it counts Unicode scalar values, which
  /// leaves out a number of useful possible characters (like many emoji and
  /// composed characters), so this will be inaccurate in the presence of those
  /// characters. If you expect to encounter these kinds of characters, be
  /// generous in the maxLength used.
  ///
  /// For instance, the character "ö" can be represented as '\u{006F}\u{0308}',
  /// which is the letter "o" followed by a composed diaeresis "¨", or it can
  /// be represented as '\u{00F6}', which is the Unicode scalar value "LATIN
  /// SMALL LETTER O WITH DIAERESIS". In the first case, the text field will
  /// count two characters, and the second case will be counted as one
  /// character, even though the user can see no difference in the input.
  ///
  /// Similarly, some emoji are represented by multiple scalar values. The
  /// Unicode "THUMBS UP SIGN + MEDIUM SKIN TONE MODIFIER", "👍🏽", should be
  /// counted as a single character, but because it is a combination of two
  /// Unicode scalar values, '\u{1F44D}\u{1F3FD}', it is counted as two
  /// characters.
  ///
  /// See also:
  ///
  ///  * [LengthLimitingTextInputFormatter] for more information on how it
  ///    counts characters, and how it may differ from the intuitive meaning.
  final int maxLength;

  /// If true, prevents the field from allowing more than [maxLength]
  /// characters.
  ///
  /// If [maxLength] is set, [maxLengthEnforced] indicates whether or not to
  /// enforce the limit, or merely provide a character counter and warning when
  /// [maxLength] is exceeded.
  final bool maxLengthEnforced;

  /// {@macro flutter.widgets.editableText.onChanged}
  final ValueChanged<String> validator;

  /// {@macro flutter.widgets.editableText.onEditingComplete}
  final VoidCallback onEditingComplete;

  /// {@macro flutter.widgets.editableText.onSubmitted}
  final ValueChanged<String> onSubmitted;

  /// If false the textfield is "disabled": it ignores taps and its
  /// [decoration] is rendered in grey.
  ///
  /// If non-null this property overrides the [decoration]'s
  /// [Decoration.enabled] property.
  final bool enabled;

  /// {@macro flutter.widgets.editableText.cursorWidth}
  final double cursorWidth;

  /// {@macro flutter.widgets.editableText.cursorRadius}
  final Radius cursorRadius;

  /// The color to use when painting the cursor.
  ///
  /// Defaults to the theme's `cursorColor` when null.
  final Color cursorColor;

  /// The appearance of the keyboard.
  ///
  /// This setting is only honored on iOS devices.
  ///
  /// If unset, defaults to the brightness of [ThemeData.primaryColorBrightness].
  final Brightness keyboardAppearance;

  /// {@macro flutter.widgets.editableText.scrollPadding}
  final EdgeInsets scrollPadding;

  /// {@macro flutter.widgets.editableText.enableInteractiveSelection}
  final bool enableInteractiveSelection;
  final GestureTapCallback onTap;

  InputDecoration getDecoration(BuildContext context) {
    switch (variant) {
      case "outlined":
        return decoration.copyWith(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(6.0))),
            contentPadding: EdgeInsets.all(16),
            fillColor: Theme.of(context).accentColor);
      case "filled":
        return decoration.copyWith(
            fillColor: Colors.grey.shade200, filled: true);
      default:
        return decoration;
    }
  }

  Widget createIosDialog(BuildContext context) {
    return Column(
      children: <Widget>[
        CupertinoTextField(
          obscureText: obscureText,
          controller: controller,
          keyboardType: keyboardType,
          onChanged: onChanged,
          prefix: decoration.icon,
          suffix: decoration.suffixIcon,
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: decoration.errorText == null
                          ? Colors.black12
                          : Colors.red,
                      width: 1))),
        ),
      ],
    );
  }

  Widget createAndroidDialog(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      controller: controller,
      decoration: decoration,
      keyboardType: keyboardType,
      onChanged: onChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? createIosDialog(context)
        : createAndroidDialog(context);
  }
}
