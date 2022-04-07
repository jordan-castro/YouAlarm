import 'package:flutter/material.dart';
import 'package:youalarm/model/alarms.dart';
import 'package:youalarm/view/screens/alarms.dart';
import 'package:youalarm/view/screens/search.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentTab = 0;

  List<String> tabTitles = [
    "Alarms",
    "Search",
  ];

  List<List<Widget>?> actions = [
    [],
    [],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tabTitles[currentTab]),
        actions: actions[currentTab],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.alarm),
            label: tabTitles[0],
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.search),
            label: tabTitles[1],
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
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      var alarmsModel = AlarmsModel.of(context, listen: false);
      alarmsModel.load();
    });
  }
}
