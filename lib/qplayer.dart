library qplayer;

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class QPlayer extends StatefulWidget {
  final url;

  const QPlayer({Key key, this.url}) : super(key: key);

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
    _videoPlayerController = VideoPlayerController.network(widget.url);
    _videoPlayerController.addListener(() {
      setState(() {});
    });
    _videoPlayerController.play();
    _videoPlayerController.initialize();
  }
}
