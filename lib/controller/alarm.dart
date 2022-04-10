import 'package:flutter/material.dart';
import 'package:youalarm/controller/db.dart';
import 'package:youalarm/controller/sound.dart';
import 'package:youalarm/utils/globals.dart';
import 'package:youalarm/utils/json_helper.dart';

typedef Alarms = List<Alarm>;

class Alarm {
  /// What time the alarm goes off.
  final TimeOfDay? time;

  /// The sound on the database
  final int? soundId;

  final int? id;

  /// What days the alarm goes off.
  final String? days;

  /// Is the alarm enabled?
  final bool enabled;

  Alarm({this.time, this.soundId, this.id, this.days, required this.enabled});

  factory Alarm.fromJson(Map<String, dynamic> json) {
    return Alarm(
      time: parseTimeOfDay(json[YADB.alarmDate]),
      soundId: parseInt(json[YADB.soundId]),
      id: parseInt(json[YADB.alarmId]),
      days: json[YADB.alarmDays],
      enabled: parseBool(json[YADB.alarmEnabled]),
    );
  }

  Json toJson({bool withId = true}) {
    var map = {
      YADB.alarmDate: "${time!.hour}:${time!.minute}",
      YADB.soundId: soundId,
      YADB.alarmDays: days,
      YADB.alarmEnabled: enabled ? 1 : 0,
    };

    if (withId) {
      map[YADB.alarmId] = id;
    }

    return map;
  }

  /// Load the sound from the sqlite!
  Future<Sound?> get sound async {
    var data = await yadb.getSound(soundId!);
    if (data == null) {
      return null;
    }

    return Sound.fromJson(data);
  }

  String get timeString {
    if (time == null) {
      return "00:00";
    }

    /// Quick lambda to make the time Pretty.
    String addZero(int i) {
      if (i < 10) {
        return "0$i";
      }
      return "$i";
    }

    return "${addZero(time!.hourOfPeriod)}:${addZero(time!.minute)}";
  }

  String get hour {
    return timeString.split(":")[0];
  }

  String get minute {
    return timeString.split(":")[1];
  }

  Alarm copyWith({
    TimeOfDay? time,
    int? soundId,
    int? id,
    String? days,
    bool? enabled,
  }) {
    return Alarm(
      time: time ?? this.time,
      soundId: soundId ?? this.soundId,
      id: id ?? this.id,
      days: days ?? this.days,
      enabled: enabled ?? this.enabled,
    );
  }

  static Alarms fromJsonList(SQLs json) {
    return json.map((e) => Alarm.fromJson(e!)).toList();
  }
}
