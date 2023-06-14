import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class Controls extends StatelessWidget {
  final AudioPlayer audioPlayer;
  final AnimationController animController;

  const Controls(
      {super.key, required this.audioPlayer, required this.animController});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
      stream: audioPlayer.playerStateStream,
      builder: ((context, snapshot) {
        final playerState = snapshot.data;
        final processingState = playerState?.processingState;
        final playing = playerState?.playing;

        if (!(playing ?? false)) {
          return ElevatedButton(
            onPressed: () {
              animController.repeat(reverse: false);
              audioPlayer.play();
            },
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(10.0),
              backgroundColor: MaterialStateProperty.all(Colors.white),
              minimumSize: MaterialStateProperty.all(const Size(65, 65)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.5),
                ),
              ),
            ),
            child: const Icon(
              Icons.play_arrow_rounded,
              size: 35,
              color: Colors.black,
            ),
          );
        } else if (processingState != ProcessingState.completed) {
          return ElevatedButton(
            onPressed: () {
              animController.stop();
              audioPlayer.pause();
            },
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(10.0),
              backgroundColor: MaterialStateProperty.all(Colors.white),
              minimumSize: MaterialStateProperty.all(const Size(65, 65)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.5),
                ),
              ),
            ),
            child: const Icon(
              Icons.pause_rounded,
              size: 35,
              color: Colors.black,
            ),
          );
        }
        animController.stop();
        return ElevatedButton(
          onPressed: () {
            animController.repeat(reverse: false);
            audioPlayer.seek(null);
          },
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(10.0),
            backgroundColor: MaterialStateProperty.all(Colors.white),
            minimumSize: MaterialStateProperty.all(const Size(65, 65)),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.5),
              ),
            ),
          ),
          child: const Icon(
            Icons.play_arrow_rounded,
            size: 35,
            color: Colors.black,
          ),
        );
      }),
    );
  }
}
