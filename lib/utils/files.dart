import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

/// Quickly get a File with the app directory's path.
Future<File> createNewFile(String name) async {
  var appDir = await getApplicationDocumentsDirectory();

  return File(join(appDir.path, name));
}