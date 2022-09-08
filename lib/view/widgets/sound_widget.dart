import 'package:flutter/material.dart';
import 'package:youalarm/controller/sound.dart';
import 'package:youalarm/model/sounds_model.dart';
import 'package:youalarm/view/screens/sound_screen.dart';
import 'package:youalarm/view/widgets/devicedialog.dart';
import 'package:youalarm/view/widgets/duration_widget.dart';
import 'package:youalarm/view/widgets/image_reader.dart';

class SoundWidget extends StatelessWidget {
  final Sound sound;

  const SoundWidget({Key? key, required this.sound}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(sound.title!),
      subtitle: Text(sound.author ?? ""),
      leading: ImageReader(
        imageSource: sound.thumbnail,
        fit: BoxFit.fill,
        fromNetwork: true,
        height: 100,
        width: 60,
      ),
      trailing: DurationWidget(
        duration: sound.duration!,
      ),
      onTap: () => Navigator.pushNamed(
        context,
        SoundScreen.routeName,
        arguments: {
          SoundScreen.soundArg: sound,
        },
      ),
      onLongPress: () {
        showDialog(
          context: context,
          builder: ((context) {
            return DeviceAlert(
              title: Text("Delete ${sound.title}"),
              actions: [
                TextButton(
                  onPressed: () {
                    SoundsModel.of(context, listen: false).removeSound(sound);
                    Navigator.pop(context);
                  },
                  child: Text("Yes"),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("No"),
                ),
              ],
            );
          }),
        );
      },
    );
  }
}
