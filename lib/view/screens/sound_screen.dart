import 'package:flutter/material.dart';
import 'package:youalarm/controller/mp3.dart';
import 'package:youalarm/controller/sound.dart';
import 'package:youalarm/view/widgets/image_reader.dart';
import 'package:youalarm/view/widgets/mp3_player.dart';

class SoundScreen extends StatelessWidget {
  static const routeName = "/sound";
  static const soundArg = "sound";

  const SoundScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final sound = args[soundArg] as Sound;

    return Scaffold(
      appBar: AppBar(
        title: Text(sound.title!),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              margin: const EdgeInsets.all(30.0),
              child: PhysicalModel(
                color: Colors.black,
                shadowColor: Colors.black,
                elevation: 10.0,
                borderRadius: BorderRadius.circular(20.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: ImageReader(
                    imageSource: sound.thumbnail,
                    height: screenSize.height / 2.5,
                    width: screenSize.width / 1.2,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Container(
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
              child: Center(
                child: Text(
                  sound.title!,
                  style: const TextStyle(
                    fontSize: 25.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Mp3Player(
              mp3: MP3(
                path: sound.location!,
                title: sound.title!,
                image: sound.thumbnail,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
