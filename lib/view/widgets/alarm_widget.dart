import 'package:flutter/material.dart';
import 'package:youalarm/controller/alarm.dart';
import 'package:youalarm/model/theme_model.dart';
import 'package:youalarm/utils/day_reader.dart';
import 'package:youalarm/view/widgets/day_icon.dart';

import '../../model/alarms.dart';

class AlarmWidget extends StatefulWidget {
  final Alarm alarm;

  const AlarmWidget({
    Key? key,
    required this.alarm,
  }) : super(key: key);

  @override
  State<AlarmWidget> createState() => _AlarmWidgetState();
}

class _AlarmWidgetState extends State<AlarmWidget> {
  bool? active;

  @override
  Widget build(BuildContext context) {
    final themeModel = ThemeModel.of(context);
    final alarmsModel = AlarmsModel.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: themeModel.mode == ThemeMode.dark
            ? Colors.deepPurple[800]
            : Colors.deepPurple[200],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const SizedBox(width: 20),
              Text(
                widget.alarm.timeString,
                style: const TextStyle(fontSize: 40),
                textAlign: TextAlign.start,
              ),
              const SizedBox(width: 20),
              Switch(
                onChanged: (bool value) {
                  // Update model
                  alarmsModel.editAlarm(
                    widget.alarm.copyWith(enabled: value),
                  );
                  setState(() => active = value);
                },
                value: active ?? widget.alarm.enabled,
              ),
            ],
          ),
          days(themeModel),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget days(ThemeModel themeModel) {
    var list = [
      SUNDAY,
      MONDAY,
      TUESDAY,
      WEDNESDAY,
      THURSDAY,
      FRIDAY,
      SATURDAY,
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          width: 20,
        ),
        for (var item in list)
          Expanded(
            child: DayIcon(
              alarm: widget.alarm,
              day: item,
            ),
          ),
        const SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
