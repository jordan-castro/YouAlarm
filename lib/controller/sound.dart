import 'package:youalarm/controller/db.dart';
import 'package:youalarm/utils/json_helper.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

typedef Sounds = List<Sound>;

class Sound {
  /// The title of the sound.
  final String? title;

  /// The youtube id
  final String? yId;

  /// Where is this sound located on the device?
  final String? location;

  /// How long is this sound.
  final Duration? duration;

  /// The thumbnail
  final String? thumbnail;

  /// The sounds id
  final int? id;

  /// The stream that handles downloading. This is only active when downloading.
  final AudioOnlyStreamInfo? streamInfo;

  Sound({
    this.title,
    this.yId,
    this.location,
    this.duration,
    this.thumbnail,
    this.id,
    this.streamInfo,
  });

  factory Sound.fromJson(Map<String, dynamic> json) {
    return Sound(
      title: parseString(json[YADB.soundTitle]),
      yId: parseString(json[YADB.soundYId]),
      location: parseString(json[YADB.soundLocation]),
      duration: json[YADB.soundDuration],
      thumbnail: parseString(json[YADB.soundThumbnail]),
      id: parseInt(json[YADB.soundId]),
    );
  }

  Json toJson({bool withId = true}) {
    var map = {
      YADB.soundTitle: title,
      YADB.soundYId: yId,
      YADB.soundLocation: location,
      YADB.soundDuration: duration,
      YADB.soundThumbnail: thumbnail,
    };

    if (withId) {
      map[YADB.soundId] = id;
    }

    return map;
  }

  static Sounds fromJsonList(SQLs json) {
    return json.map((e) => Sound.fromJson(e!)).toList();
  }
}
