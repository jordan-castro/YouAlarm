import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:youalarm/controller/load_sound.dart';
import 'package:youalarm/controller/sound.dart';
import 'package:youalarm/utils/globals.dart';

class SoundsModel with ChangeNotifier {
  Sounds? sounds;
  bool loading = true;

  void load() async {
    var data = await yadb.getSounds();

    if (data != null) {
      sounds = Sound.fromJsonList(data);
    }

    loading = false;
    notifyListeners();
  }

  /// Slow load is useful when adding to the database and wanting to show
  /// the new data.
  void slowLoad({Duration? duration}) async {
    // Show loading if loading already finished before.
    if (loading = false) {
      loading = true;
      notifyListeners();
    }

    await Future.delayed(duration ?? const Duration(milliseconds: 500));
    load();
  }

  void addSound(Sound sound) {
    yadb.insertSound(sound.toJson(withId: false));
    slowLoad();
  }

  void removeSound(Sound sound) {
    yadb.deleteSound(sound.id!);
    slowLoad();
  }

  /// Download a Sound from YouTube and add it to the database.
  Future<void> downloadNewSound(String url) async {
    loading = true;
    notifyListeners();

    var sound = await loadSound(url);
    if (sound.streamInfo != null) {
      var location = await saveStream(sound.streamInfo!);
      // Create new Sound object with data!
      var newSound = Sound.editLocation(sound, location);

      addSound(newSound);
    }
  }

  static SoundsModel of(BuildContext context, {bool listen = true}) =>
      Provider.of<SoundsModel>(context, listen: listen);
}
