import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

/// Requesta al usario para descargar en su cellular.
///
/// **Returns** `Future<bool>`
Future<bool> requestDownloadPermission() async {
  if (Platform.isAndroid) {
    if (await _requestPermission(Permission.storage) &&
        // access media location needed for android 10/Q
        await _requestPermission(Permission.accessMediaLocation) &&
        // manage external storage needed for android 11/R
        await _requestPermission(Permission.manageExternalStorage)) {
      return true;
    } else {
      return false;
    }
  }
  if (Platform.isIOS) {
    if (await _requestPermission(Permission.photos)) {
      return true;
    } else {
      return false;
    }
  } else {
    // not android or ios
    return false;
  }
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
