import 'package:flutter/material.dart';

dialogContent(
  context, {
  String title = 'Pesan',
  String messages = 'Ahlan wa sahlan...',
  bool dismissable = true,
  // bool withProgress = false,
  required Widget contents,
  List<Widget>? actions,
  EdgeInsetsGeometry? contentPadding,
  TextStyle? titleTextStyle,
  Color? backgroundColor,
}) {
  // List<Widget> contents = [];
  // if (withProgress) {
  //   contents.add(const CircularProgressIndicator());
  // }
  // contents.add(Flexible(child: Text(messages)));
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Container(
      child: Text(title),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      color: backgroundColor,
    ),
    titlePadding: EdgeInsets.zero,
    titleTextStyle: titleTextStyle,
    content: contents,
    actions: actions,
    contentPadding: contentPadding ?? const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
  );

  // show the dialog
  showDialog(
    context: context,
    barrierDismissible: dismissable,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => dismissable,
        child: alert,
      );
    },
  );
}

dialogInfo(
  context, {
  String title = 'Pesan',
  String messages = 'Ahlan wa sahlan...',
  bool dismissable = true,
  // bool withProgress = false,
  List<Widget>? actions,
}) {
  // List<Widget> contents = [];
  // if (withProgress) {
  //   contents.add(const CircularProgressIndicator());
  // }
  // contents.add(Flexible(child: Text(messages)));
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(messages),
    actions: actions,
  );

  // show the dialog
  showDialog(
    context: context,
    barrierDismissible: dismissable,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => dismissable,
        child: alert,
      );
    },
  );
}

dialogConfirm(
  context, {
  String title = 'Pesan',
  String messages = 'Ahlan wa sahlan...',
  String? positiveText,
  String? negativeText,
  var positiveAction,
  var negativeAction,
  bool dismissable = true,
  TextStyle? titleTextStyle,
  Color? backgroundColor,
}) {
  List<Widget> actions = [];

  if (negativeText != null) {
    // set up the buttons
    Widget negativeButton = TextButton(
      child: Text(negativeText),
      onPressed: negativeAction ?? () => Navigator.pop(context, false),
    );
    actions.add(negativeButton);
  }

  if (positiveText != null) {
    Widget positiveButton = TextButton(
      child: Text(positiveText),
      onPressed: positiveAction ?? () => Navigator.pop(context, false),
    );
    actions.add(positiveButton);
  }

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Container(
      child: Text(title),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      color: backgroundColor,
    ),
    titlePadding: EdgeInsets.zero,
    titleTextStyle: titleTextStyle,
    content: Text(messages),
    actions: actions,
    // backgroundColor: backgroundColor,
  );

  // show the dialog
  showDialog(
    context: context,
    barrierDismissible: dismissable,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => dismissable,
        child: alert,
      );
    },
  );
}

dialogButtonOptions(
  context, {
  String title = 'Pesan',
  bool dismissable = true,
  required List<Widget> buttons,
  List<Widget>? actions,
}) {
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: IntrinsicHeight(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: buttons,
      ),
    ),
    actions: actions,
  );

  // show the dialog
  showDialog(
    context: context,
    barrierDismissible: dismissable,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => dismissable,
        child: alert,
      );
    },
  );
}
