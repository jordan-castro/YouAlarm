import 'package:flutter/material.dart';
import 'package:youalarm/controller/alarm.dart';

class AlarmWidget extends StatelessWidget {
  final Alarm alarm;

  const AlarmWidget({
    Key? key,
    required this.alarm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Text(alarm.time),
        ],
      ),
    );
  }
}
