import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'GamePage.dart';

class CustomDialogs extends StatelessWidget {
  final title;
  final content;
  final VoidCallback callback;
  final actionText;

  CustomDialogs(this.title, this.content, this.callback,
      [this.actionText = "Reset"]);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        FlatButton(
          onPressed: callback,
          child: Text(actionText),
          color: Colors.white,
        )
      ],
    );
  }
}

