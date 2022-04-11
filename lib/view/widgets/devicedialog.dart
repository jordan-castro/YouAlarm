import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Checks what phone type and produces alert based on the os, also checks if
/// its on web.
class DeviceAlert extends StatelessWidget {
  final Color? backgroundColor;
  final Widget? title;
  final Widget? content;
  final List<Widget>? actions;

  const DeviceAlert(
      {Key? key, this.backgroundColor, this.title, this.content, this.actions});

  @override
  Widget build(BuildContext context) {
    // Is it web? if not do this
    if (!kIsWeb) {
      return Platform.isAndroid
          ? AlertDialog(
              backgroundColor: backgroundColor,
              title: title,
              content: content,
              actions: actions,
            )
          : CupertinoAlertDialog(
              title: title,
              content: content,
              actions: actions ?? [],
            );
    } else {
      // If is web then return Cupertino
      return AlertDialog(
        backgroundColor: backgroundColor,
        title: title,
        content: content,
        actions: actions,
      );
    }
  }
}
