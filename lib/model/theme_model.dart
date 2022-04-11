import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/storage_manager.dart';

/// C
class ThemeModel with ChangeNotifier {
  final darkTheme = ThemeData(
    primarySwatch: Colors.blue,
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    backgroundColor: Colors.black,
    accentColor: Colors.white,
    accentIconTheme: const IconThemeData(color: Colors.black),
    dividerColor: Colors.grey,
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    canvasColor: Colors.black,
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith(
        (states) => Colors.white,
      ),
      trackColor: MaterialStateProperty.resolveWith(
        (states) => Colors.white54,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
    ),
  );

  final lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    primaryColor: Colors.white,
    brightness: Brightness.light,
    backgroundColor: const Color(0xFFE5E5E5),
    accentColor: Colors.black,
    accentIconTheme: const IconThemeData(color: Colors.white),
    dividerColor: Colors.black,
    iconTheme: const IconThemeData(
      color: Colors.black,
    ),
  );

  ThemeMode mode = ThemeMode.system;

  /// La tema nigga.
  ThemeData? _themeData;

  /// El gettor.
  ThemeData getTheme() => _themeData ?? darkTheme;
  // ThemeModel getMode() =>

  ThemeModel() {
    // Synchronizo leando
    StorageManager.readData('themeMode').then((value) {
      // Defaulto es "light" AKA luz
      var themeMode = value ?? 'light';
      // Classifica la _themeData
      if (themeMode == 'light') {
        _themeData = lightTheme;
        mode = ThemeMode.light;
      } else {
        _themeData = darkTheme;
        mode = ThemeMode.dark;
      }
      notifyListeners();
    });
  }

  void setDarkMode() async {
    _themeData = darkTheme;
    StorageManager.saveData('themeMode', 'dark');
    StorageManager.saveData('settheme', true);
    notifyListeners();
  }

  void setLightMode() async {
    _themeData = lightTheme;
    StorageManager.saveData('themeMode', 'light');
    StorageManager.saveData('settheme', true);
    notifyListeners();
  }

  Future<bool> alreadyHasTheme() async {
    var data = await StorageManager.readData('settheme');
    return data == null ? false : data;
  }

  static ThemeModel of(BuildContext context) =>
      Provider.of<ThemeModel>(context);
}
