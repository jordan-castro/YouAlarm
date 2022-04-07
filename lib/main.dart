import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youalarm/model/alarms.dart';
import 'package:youalarm/view/screens/home.dart';

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
      ],
      child: MaterialApp(
        title: "YouAlarm",
        routes: {
          HomeScreen.routeName: (_) => const HomeScreen(),
        },
        home: const HomeScreen(),
      ),
    );
  }
}
