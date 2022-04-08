import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youalarm/model/sounds_model.dart';
import 'package:youalarm/view/widgets/empty_widget.dart';
import 'package:youalarm/view/widgets/loading_widget.dart';
import 'package:youalarm/view/widgets/sound_widget.dart';

class SoundsScreen extends StatelessWidget {
  const SoundsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SoundsModel>(
      builder: (context, model, child) {
        if (model.loading) {
          return const LoadingWidget(
            message: "Loading sounds...",
          );
        } else {
          if (model.sounds != null) {
            return ListView(
              children: [
                for (var sound in model.sounds!) SoundWidget(sound: sound),
              ],
              shrinkWrap: true,
            );
          } else {
            return const EmptyWidget(message: "You have no sounds.");
          }
        }
      },
    );
  }
}
