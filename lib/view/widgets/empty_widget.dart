import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  final String message;
  final bool center;

  const EmptyWidget({Key? key, required this.message, this.center = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var widget = Text(
      message,
      style: const TextStyle(
        fontSize: 20.0,
      ),
      textAlign: center ? TextAlign.center : null,
    );

    if (center) {
      return Center(child: widget);
    }

    return widget;
  }
}
