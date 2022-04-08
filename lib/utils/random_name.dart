import 'dart:convert';
import 'dart:math';

/// Create a random file name, from bytes.
/// 
/// [length] is the length of the file name.
String randomName(int length) {
  var bytes = List<int>.generate(length, (i) => Random().nextInt(256));
  return base64.encode(bytes);
}