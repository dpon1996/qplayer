library qplayer;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qplayer/provider/playerProvider.dart';
import 'package:video_player/video_player.dart';

class QPlayer extends StatefulWidget {
  final videoUrl;

  const QPlayer({Key key, this.videoUrl}) : super(key: key);

  @override
  _QPlayerState createState() => _QPlayerState();
}

class _QPlayerState extends State<QPlayer> {
  VideoPlayerController _videoPlayerController;
  PlayerProvider playerProvider = PlayerProvider();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: playerProvider),
      ],
      child: Stack(
        children: [
          InkWell(
            onTap: (){
              playerProvider.setColor(Colors.blue);
            },
            child: VideoPlayer(_videoPlayerController),
          ),
          Container(
            height: 200,
            width: 200,
            color: playerProvider.color,
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    _videoPlayerController.addListener(() {
      setState(() {});
    });
    _videoPlayerController.play();
    _videoPlayerController.initialize();
  }
}
