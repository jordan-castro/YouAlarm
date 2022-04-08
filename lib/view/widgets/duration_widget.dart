import 'package:flutter/material.dart';

class DurationWidget extends StatelessWidget {
  final Duration duration;

  const DurationWidget({Key? key, required this.duration}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      getTimeString(),
    );
  }

  String getTimeString() {
    var minutes = duration.inMinutes % 60;
    var seconds = duration.inSeconds % 60;

    return "$minutes:$seconds";
  }
}
