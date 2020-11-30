library qplayer;

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class QPlayer extends StatefulWidget {
  @override
  _QPlayerState createState() => _QPlayerState();
}

class _QPlayerState extends State<QPlayer> {
  VideoPlayerController _videoPlayerController;

  @override
  Widget build(BuildContext context) {
    return VideoPlayer(_videoPlayerController);
  }

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(
        "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4");
    _videoPlayerController.addListener(() {
      setState(() {});
    });
    _videoPlayerController.initialize();
  }
}
