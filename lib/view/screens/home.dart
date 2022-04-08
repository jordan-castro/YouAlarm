import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:youalarm/model/alarms.dart';
import 'package:youalarm/model/sounds_model.dart';
import 'package:youalarm/view/screens/alarms.dart';
import 'package:youalarm/view/screens/search.dart';
import 'package:youalarm/view/screens/sounds_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentTab = 0;

  List<AppBar> appBars = [
    AppBar(
      title: const Text("Alarms"),
    ),
    AppBar(
      title: const Text("Search"),
    ),
    AppBar(
      title: const Text("Sounds"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBars[currentTab],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.alarm),
            label: "Alarms",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note),
            label: "Sounds",
          ),
        ],
        onTap: (index) => setState(() => currentTab = index),
        currentIndex: currentTab,
      ),
      body: SafeArea(
        child: IndexedStack(
          index: currentTab,
          children: const [
            AlarmsScreen(),
            SearchScreen(),
            SoundsScreen(),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      var alarmsModel = AlarmsModel.of(context, listen: false);
      alarmsModel.load();

      var soundsModel = SoundsModel.of(context, listen: false);
      soundsModel.load();
    });
  }
}
