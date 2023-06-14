import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:ncs_music_app/models/song.dart';
import 'package:ncs_music_app/widgets/controls.dart';
import 'package:rxdart/rxdart.dart';

class Player extends StatefulWidget {
  final Song song;

  const Player({super.key, required this.song});

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  late AudioPlayer _player;

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          _player.positionStream,
          _player.bufferedPositionStream,
          _player.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  @override
  void initState() {
    _player = AudioPlayer()..setUrl(widget.song.content!);
    super.initState();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 100,
            ),
            Center(
              child: Image.network(
                widget.song.thumbnail!,
                fit: BoxFit.cover,
                height: 325,
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 0.5 * width - 162.5),
              child: Text(
                widget.song.title!,
                style: const TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: 20.0,
              margin: EdgeInsets.only(left: 0.5 * width - 162.5),
              child: ListView.separated(
                separatorBuilder: (context, i) => const Text(
                  ", ",
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
                scrollDirection: Axis.horizontal,
                itemCount: widget.song.artists!.length,
                itemBuilder: (context, i) => Text(
                  widget.song.artists![i],
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
            StreamBuilder<PositionData>(
                stream: _positionDataStream,
                builder: (context, snapshot) {
                  final positionData = snapshot.data;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: ProgressBar(
                      barHeight: 8,
                      baseBarColor: Colors.grey[600],
                      bufferedBarColor: Colors.grey,
                      progressBarColor: Colors.green,
                      thumbColor: Colors.green,
                      timeLabelTextStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      progress: positionData?.position ?? Duration.zero,
                      buffered: positionData?.bufferedPosition ?? Duration.zero,
                      total: positionData?.duration ?? Duration.zero,
                      onSeek: _player.seek,
                    ),
                  );
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Controls(audioPlayer: _player),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;
  const PositionData(this.position, this.bufferedPosition, this.duration);
}
