import 'package:youalarm/controller/db.dart';

YADB yadb = YADB.instance;

// ignore: constant_identifier_names
const Map APP_STORAGE_PATH = {
  "Android": "/storage/emulated/0/YouAlarm",
  "iOS": "", // TODO: add IOS
};

// ignore: constant_identifier_names
const String SOUNDS_STORAGE_PATH = "sounds";
