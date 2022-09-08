import 'dart:io';

import 'package:youalarm/controller/db.dart';
import 'package:youalarm/utils/json_helper.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../utils/globals.dart';

typedef Sounds = List<Sound>;

class Sound {
  /// The title of the sound.
  final String? title;

  /// The author
  final String? author;

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
    this.author,
  });

  factory Sound.fromJson(Map<String, dynamic> json) {
    return Sound(
      title: parseString(json[YADB.soundTitle]),
      yId: parseString(json[YADB.soundYId]),
      location: parseString(json[YADB.soundLocation]),
      duration: parseDuration(json[YADB.soundDuration]),
      thumbnail: parseString(json[YADB.soundThumbnail]),
      id: parseInt(json[YADB.soundId]),
      author: parseString(json[YADB.soundAuthor]),
    );
  }

  Json toJson({bool withId = true}) {
    var map = {
      YADB.soundTitle: title,
      YADB.soundYId: yId,
      YADB.soundLocation: location,
      YADB.soundDuration: duration?.inMilliseconds,
      YADB.soundThumbnail: thumbnail,
      YADB.soundAuthor: author,
    };

    if (withId) {
      map[YADB.soundId] = id;
    }

    return map;
  }

  Sound copyWith({
    String? title,
    String? author,
    String? yId,
    String? location,
    Duration? duration,
    String? thumbnail,
    int? id,
  }) {
    return Sound(title: title ?? this.title, author: author);
  }

  static Sounds fromJsonList(SQLs json) {
    return json.map((e) => Sound.fromJson(e)).toList();
  }

  /// Fetch a sound from it's id.
  static Future<Sound?> soundFromId(int id) async {
    var sound = await yadb.getSound(id);
    if (sound != null) {
      return Sound.fromJson(sound);
    }
    return null;
  }

  /// Delete the sound from the machine. 
  /// !Important does not delete from local DB.
  void delete() async {
    // Always try
    try {
      File file = File(location!);
      await file.delete();
    } catch (exception) {
      print("Not able to delete $title at $location because of: $exception");
    } 
  }
}
