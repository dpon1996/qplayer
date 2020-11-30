library qplayer;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qplayer/playerStyles/basicPlayerStyle.dart';
import 'package:qplayer/playerStyles/mxPlayerStyle.dart';
import 'package:qplayer/playerStyles/ybPlayerStyle.dart';
import 'package:qplayer/provider/playerProvider.dart';
import 'package:video_player/video_player.dart';

enum PlayerStyle {
  basicStyle,
  mxStyle,
  ybStyle,
}

class QPlayer extends StatefulWidget {
  final String videoUrl;
  final String videoTitle;
  final String videoThumbnail;
  final Color iconsColor;
  final Color progressColor;
  final IconData playIcon;
  final IconData pauseIcon;
  final IconData fullScreeIcon;
  final IconData replayIcon;
  final PlayerStyle playerStyle;

  const QPlayer(
      {Key key,
      @required this.videoUrl,
      this.videoTitle,
      this.videoThumbnail,
      this.iconsColor = Colors.red,
      this.progressColor = Colors.red,
      this.playIcon = Icons.play_circle_outline,
      this.pauseIcon = Icons.pause,
      this.fullScreeIcon = Icons.fullscreen,
      this.replayIcon = Icons.replay,
      this.playerStyle = PlayerStyle.basicStyle})
      : super(key: key);

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
            onTap: () {},
            child: VideoPlayer(_videoPlayerController),
          ),
          playerStyleSelector(),
        ],
      ),
    );
  }

  ///video player style selector ///
  ///
  // ignore: missing_return
  Widget playerStyleSelector() {
    switch (widget.playerStyle) {
      case PlayerStyle.basicStyle:
        return BasicPlayerStyle();
      case PlayerStyle.mxStyle:
        return MxPlayerStyle();
      case PlayerStyle.ybStyle:
        return YbPlayerStyle();
    }
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

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
  }
}
