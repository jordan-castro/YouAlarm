import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:youalarm/controller/alarm.dart';
import 'package:youalarm/utils/globals.dart';

class AlarmsModel with ChangeNotifier {
  Alarms? alarms;
  bool loading = true;

  void load() async {
    var data = await yadb.getAlarms();

    if (data != null) {
      alarms = Alarm.fromJsonList(data);
    }
    loading = false;
    notifyListeners();
  }

  void addNewAlarm(Alarm alarm) {
    yadb.insertAlarm(
      alarm.toJson(withId: false),
    );
    slowLoad();
  }

  void removeAlarm(Alarm alarm) {
    yadb.deleteAlarm(alarm.id!);
    slowLoad();
  }

  void slowLoad() async {
    if (!loading) {
      loading = true;
      notifyListeners();
  }
    await Future.delayed(const Duration(milliseconds: 500));
    load();
  }

  static AlarmsModel of(BuildContext context, {bool listen = true}) {
    return Provider.of<AlarmsModel>(context, listen: listen);
  }
}