import 'package:flutter/material.dart';
import 'package:youalarm/controller/alarm.dart';
import 'package:youalarm/model/theme_model.dart';
import 'package:youalarm/utils/day_reader.dart';

import '../../model/alarms.dart';

class DayIcon extends StatefulWidget {
  final Alarm alarm;
  final String day;

  const DayIcon({
    Key? key,
    required this.alarm,
    required this.day,
  }) : super(key: key);

  @override
  State<DayIcon> createState() => _DayIconState();
}

class _DayIconState extends State<DayIcon> {
  bool active = false;

  @override
  Widget build(BuildContext context) {
    final themeModel = ThemeModel.of(context);
    final alarmsModel = AlarmsModel.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      child: FloatingActionButton(
        onPressed: () {
          // Update model 
          alarmsModel.editAlarm(
            widget.alarm.copyWith(enabled: !active),
          );
          // Update widget
          setState(() => active = !active);
        },
        backgroundColor: active
            ? Colors.pink[900]
            : themeModel.mode == ThemeMode.dark
                ? Colors.deepPurple[800]
                : Colors.deepPurple[200],
        child: Text(
          widget.day[0].toUpperCase(),
          style: TextStyle(
            fontSize: 15,
            color: active ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    active = isOfDay(widget.day, widget.alarm.days ?? "");
    super.initState();
  }
}
