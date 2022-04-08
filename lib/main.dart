import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:youalarm/model/alarms.dart';
import 'package:youalarm/model/sounds_model.dart';
import 'package:youalarm/view/screens/home.dart';
import 'package:youalarm/view/screens/sound_screen.dart';

void main() {
  runApp(const YouAlarm());
}

class YouAlarm extends StatelessWidget {
  const YouAlarm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AlarmsModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => SoundsModel(),
        ),
      ],
      child: MaterialApp(
        title: "YouAlarm",
        routes: {
          HomeScreen.routeName: (_) => const HomeScreen(),
          SoundScreen.routeName: (_) => const SoundScreen(),
        },
        home: const HomeScreen(),
      ),
    );
  }
}
