import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youalarm/model/alarms.dart';
import 'package:youalarm/view/widgets/alarm_widget.dart';
import 'package:youalarm/view/widgets/empty_widget.dart';
import 'package:youalarm/view/widgets/loading_widget.dart';

class AlarmsScreen extends StatelessWidget {
  const AlarmsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AlarmsModel>(
      builder: (context, model, child) {
        if (model.alarms != null) {
          return ListView(
            children: [
              for (var alarm in model.alarms!) AlarmWidget(alarm: alarm),
            ],
          );
        } else {
          if (model.loading) {
            return const LoadingWidget(message: "Loading alarms...");
          }

          return const EmptyWidget(message: "No alarms");
        }
      },
    );
  }
}
