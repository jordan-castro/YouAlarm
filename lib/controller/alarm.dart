import 'package:youalarm/controller/db.dart';
import 'package:youalarm/controller/sound.dart';
import 'package:youalarm/utils/globals.dart';
import 'package:youalarm/utils/json_helper.dart';

typedef Alarms = List<Alarm>;

class Alarm {
  final DateTime? date;
  final int? soundId;
  final int? id;

  Alarm({this.date, this.soundId, this.id});

  factory Alarm.fromJson(Map<String, dynamic> json) {
    return Alarm(
        date: json['date'],
        soundId: parseInt(json['sound']),
        id: parseInt(json['id']));
  }

  Json toJson({bool withId = true}) {
    var map = {
      'date': date,
      'sound': soundId,
    };

    if (withId) {
      map['id'] = id;
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

  String get time {
    var hour = date!.hour;
    var minute = date!.minute;

    return '$hour:$minute';
  }

  static Alarms fromJsonList(SQLs json) {
    return json.map((e) => Alarm.fromJson(e!)).toList();
  }
}
