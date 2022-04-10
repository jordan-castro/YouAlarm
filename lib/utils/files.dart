import 'dart:io';

import 'package:path/path.dart';

import 'globals.dart';
import 'request_perm.dart';

/// Extends String
extension FileEndings on String {
  /// Returns the file extension
  fileExtension<String>() {
    if (isEmpty) {
      return "";
    }
    return this.split(".").last.toLowerCase();
  }

  /// Check if is of a certain type
  bool isOfType<String>(String type) {
    var ext = fileExtension();

    type = type.toString().toLowerCase() as String;

    return ext == type;
  }

  /// Check if it is of any type
  bool isOfAnyType<String>(List<String> types) {
    var ext = fileExtension();

    for (var type in types) {
      type = type.toString().toLowerCase() as String;

      if (ext == type) {
        return true;
      }
    }
    return false;
  }
}

/// Get a file based on its path.
File? getFile(String filePath) {
  // Create a file object
  File file = File(filePath);
  // Check if the file exists
  if (file.existsSync()) {
    return file;
  } else {
    return null;
  }
}

/// Get a file asynchronously based on its path.
Future<File?> getFileAsync(String filePath) async {
  // Create a file object
  File file = File(filePath);
  // Check if the file exists
  if (await file.exists()) {
    return file;
  } else {
    return null;
  }
}

/// This handles creating directories.
Future<void> _createDir(Directory dir, bool recurse) async {
  var storage = await requestDownloadPermission();
  if (storage) {
    if (!(await dir.exists())) {
      dir.create(recursive: recurse);
    }
  }
}

/// Create a sub directory in the app directory.
/// If the directory already exists, it will not be created again.
Future<void> createSubDirectory(directory, {bool recurse = false}) async {
  if (!recurse) {
    await createAppDirectory();
  }

  Directory dir = Directory("${APP_STORAGE_PATH['Android']}/$directory");
  await _createDir(dir, recurse);
}

/// Create a NeuroAcademia directory on the phone.
/// If the directory already exists, it will not be created again.
Future<void> createAppDirectory() async {
  // Create a directory
  Directory dir = Directory(APP_STORAGE_PATH['Android']);
  await _createDir(dir, true);
}

/// Move a File from one path to another.
Future<File?> moveFile(currentPath, newPath) async {
  // Open the file
  var file = File(currentPath);
  // Does this file exist?
  if (!(await file.exists())) {
    print("curretnPath: $currentPath Does not house a File.");
    return null;
  }

  // Move it and return the result
  return (await file.rename(newPath));
}

/// Decide the File name.
/// If the file already exists, it will be renamed to (1) or (2) ...
Future<String> unique(String path) async {
  File file = File(path);
  var parent = file.parent.path;
  var name = file.path.split("/").last;
  var ext = name.fileExtension();
  name = name.split(".").first;

  var p = "$parent/$name.$ext";

  var counter = 1;

  while (await File(p).exists()) {
    p = "$parent/$name ($counter).$ext";
    counter++;
  }

  return p;
}

/// Quickly get a File with the app directory's path and parent.
Future<File> createNewFile(String name, String parent) async {
  var appDir = Directory(APP_STORAGE_PATH['Android']);

  var fileName = join(appDir.path, parent, name);

  return File(fileName);
}
