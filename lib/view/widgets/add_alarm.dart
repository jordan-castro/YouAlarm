import 'package:flutter/material.dart';
import 'package:youalarm/controller/alarm.dart';
import 'package:youalarm/view/widgets/devicedialog.dart';

import '../../model/alarms.dart';

// class AddAlarmWidget extends StatefulWidget {
//   final Alarm? alarm;

//   const AddAlarmWidget({Key? key, this.alarm}) : super(key: key);

//   @override
//   State<AddAlarmWidget> createState() => AddAlarmWidgetState();
// }

// class AddAlarmWidgetState extends State<AddAlarmWidget> {
//   Alarm? _alarm;
//   final textStyle = const TextStyle(
//     fontSize: 20,
//   );

//   @override
//   Widget build(BuildContext context) {
//     final initialTime = _alarm?.time ?? const TimeOfDay(hour: 12, minute: 0);

//     return TimePickerDialog(
//       initialTime: initialTime,
//     );
//   }

//   /// This returns the hour:minute for the Alarm
//   Widget alarmTitle() {
//     return Row(
//       children: [
//         individualTime(time: _alarm!.hour),
//         Container(
//           margin: const EdgeInsets.symmetric(horizontal: 10.0),
//           child: Text(
//             ":",
//             style: textStyle,
//           ),
//         ),
//         individualTime(time: _alarm!.minute),
//       ],
//     );
//   }

//   /// This calls when the user clicks on the time

//   Widget individualTime({required String time}) {
//     return Text(
//       time,
//       style: textStyle,
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//     if (widget.alarm != null) {
//       _alarm = widget.alarm;
//     } else {
//       _alarm = Alarm();
//     }
//   }
// }

/// This widget will show the add button for an alarm
class AddAlarmButton extends StatelessWidget {
  final Alarm? alarm;

  const AddAlarmButton({Key? key, this.alarm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => pickTime(context),
      icon: const Icon(Icons.add),
    );
  }

  /// This will show the time picker dialog and set the alarm time.
  void pickTime(context) async {
    final initialTime = alarm?.time ?? const TimeOfDay(hour: 12, minute: 0);
    final newTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (newTime != null) {
      final alarmsModel = AlarmsModel.of(context, listen: false);
      if (alarm != null) {
        // Edit
        alarmsModel.editAlarm(alarm!.copyWith(time: newTime));
      } else {
        // Add
        alarmsModel.addNewAlarm(
          Alarm(
            days: "", // Default is all days
            soundId: 1, // The default sound for alarms is the first one.
            time: newTime,
            enabled: true,
          ),
        );
      }
    }
  }
}
