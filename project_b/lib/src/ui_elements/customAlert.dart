import 'package:flutter/material.dart';

class CustomAlert extends StatefulWidget {
  final Widget content;

  const CustomAlert({Key key, this.content}) : super(key: key);

  State<CustomAlert> createState() => CustomAlertState();
}

class CustomAlertState extends State<CustomAlert> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: widget.content,
    );
  }
}
