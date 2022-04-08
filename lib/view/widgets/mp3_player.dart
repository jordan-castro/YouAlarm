import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:youalarm/controller/mp3.dart';
import 'package:youalarm/view/widgets/loading_widget.dart';

class Mp3Player extends StatefulWidget {
  final MP3 mp3;

  const Mp3Player({Key? key, required this.mp3}) : super(key: key);

  @override
  _Mp3PlayerState createState() => _Mp3PlayerState();
}

class _Mp3PlayerState extends State<Mp3Player> {
  /// The mp3 player
  final audioPlayer = AudioPlayer();

  /// Whether or not the mp3 is currently playing
  bool playing = false;

  /// Para saber si ya ha empezado el negro (mp3 puede jugar?)
  bool? started;

  /// Current duration position
  Duration position = const Duration();

  /// The duration of the audio
  Duration audioDuration = const Duration();

  /// Icon for play or pause
  IconData playIcon = Icons.play_arrow;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        audioPlayer.dispose();
        return true;
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  // Chequea si esta jugando
                  if (playing) {
                    forwardOrBack(false);
                  }
                },
                icon: const Icon(
                  Icons.fast_rewind,
                  size: 40.0,
                ),
                splashRadius: 30.0,
              ),
              const SizedBox(
                width: 8,
              ),
              if (started == null || started == true)
                IconButton(
                  onPressed: () {
                    if (playing) {
                      pause();
                    } else {
                      play();
                    }
                  },
                  icon: Icon(
                    playIcon,
                  ),
                  iconSize: 50.0,
                  splashRadius: 30.0,
                ),
              if (started == false)
                const SizedBox(
                  height: 65.0,
                  width: 65.0,
                  child: LoadingWidget(),
                ),
              IconButton(
                onPressed: () {
                  // Chequea si esta jugando
                  if (playing) {
                    forwardOrBack(true);
                  }
                },
                icon: const Icon(
                  Icons.fast_forward,
                  size: 40.0,
                ),
                splashRadius: 30.0,
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              children: [
                Text(
                  durationToString(position),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: SliderTheme(
                      data: SliderThemeData(
                        trackShape: CustomTrackShape(),
                      ),
                      child: Slider(
                        value: position.inSeconds.toDouble(),
                        max: audioDuration.inSeconds.toDouble(),
                        onChanged: (double position) => goToPosition(position),
                      ),
                    ),
                  ),
                ),
                Text(
                  durationToString(audioDuration),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void play() async {
    // Si no he empezado pon lo en false.
    // Si hay una razon, no recuerdo que es en este momento que estoy
    // escribiendo este commentario pero si hay una razon!!!
    if (started == null) {
      setState(() {
        started = false;
      });
    }
    print("resource source is ${widget.mp3.path}");
    // Chequea si la fila existe o no.

    // Attempt play and await response
    final res = await audioPlayer.play(
      widget.mp3.path,
      // Si no es el mismo entonces viene de local storage
      isLocal: widget.mp3.path.startsWith('/'),
    );

    // Check that it was successfull
    if (res == 1) {
      // Set playing = true and icon to pause
      setState(() {
        playing = true;
        playIcon = Icons.pause;
      });

      // Setup listener for position changed
      audioPlayer.onAudioPositionChanged.listen((event) {
        setState(() {
          started = true;
          if (event.inSeconds == audioDuration.inSeconds) {
            goToPosition(0);
            pause();
          }
          position = event;
        });
      });

      // Setup listener for position
      audioPlayer.onDurationChanged.listen((event) {
        // Set the durtion of the Slider and the position
        setState(() {
          started = true;
          audioDuration = event;
        });
      });
    }
  }

  void pause() async {
    // Attempt to pause and await res
    final res = await audioPlayer.pause();

    // Check success
    if (res == 1) {
      // Set playing to false and icon to play
      setState(() {
        playing = false;
        playIcon = Icons.play_arrow;
      });
    }
  }

  /// Go to the position of the slider.
  void goToPosition(double position) {
    audioPlayer.seek(
      Duration(
        seconds: position.toInt(),
      ),
    );
  }

  /// Para ser fasetForward o revers
  void forwardOrBack(bool forward) async {
    if (forward) {
      goToPosition(position.inSeconds + 10.0);
    } else {
      goToPosition(position.inSeconds - 10.0);
    }
  }

  /// Grab the current position for the slider. Takes a [Duration].
  double createPosition(Duration duration) {
    return duration.inSeconds.toDouble();
  }

  /// Get a string representation of the `Duration duration` passed.
  String durationToString(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

}

/// Fork por StackOverflow
class CustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    @required RenderBox? parentBox,
    Offset offset = Offset.zero,
    @required SliderThemeData? sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double? trackHeight = sliderTheme!.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox!.size.height - trackHeight!) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
