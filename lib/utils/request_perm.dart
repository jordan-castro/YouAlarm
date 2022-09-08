import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

/// Requesta al usario para descargar en su cellular.
///
/// **Returns** `Future<bool>`
Future<bool> requestDownloadPermission() async {
  if (!Platform.isAndroid || !Platform.isIOS) {
    return false;
  }
  if (!(await _requestPermission(Permission.storage))) {
    return false;
  }
  // Just Android
  if (Platform.isAndroid) {
    // Needed in Android 10/Q
    if (!(await _requestPermission(Permission.accessMediaLocation))) {
      return false;
    }
    // Needed in Android 11/R
    if (!(await _requestPermission(Permission.manageExternalStorage))) {
      return false;
    }
  }
  // We good!
  return true;
}

/// Request permissions
///
/// **Returns** `Future<bool>`
Future<bool> _requestPermission(Permission permission) async {
  var status = await permission.status;

  if (status.isDenied) {
    status = await permission.request();

    if (status.isDenied) {
      return false;
    }
  }
  return true;
}
