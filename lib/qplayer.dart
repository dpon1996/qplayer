library qplayer;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qplayer/playerStyles/basicPlayerStyle.dart';
import 'package:qplayer/playerStyles/mxPlayerStyle.dart';
import 'package:qplayer/playerStyles/ybPlayerStyle.dart';
import 'package:qplayer/provider/playerFunctionsProvider.dart';
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
  final Duration functionKeyVisibleTime;

  const QPlayer({
    Key key,
    @required this.videoUrl,
    this.videoTitle,
    this.videoThumbnail,
    this.iconsColor = Colors.red,
    this.progressColor = Colors.red,
    this.playIcon = Icons.play_circle_outline,
    this.pauseIcon = Icons.pause,
    this.fullScreeIcon = Icons.fullscreen,
    this.replayIcon = Icons.replay,
    this.playerStyle = PlayerStyle.basicStyle,
    this.functionKeyVisibleTime = const Duration(seconds: 2),
  }) : super(key: key);

  @override
  _QPlayerState createState() => _QPlayerState();
}

class _QPlayerState extends State<QPlayer> {
  PlayerProvider playerProvider = PlayerProvider();
  PlayerFunctionsProvider playerFunctionsProvider = PlayerFunctionsProvider();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: playerProvider),
        ChangeNotifierProvider.value(value: playerFunctionsProvider),
      ],
      child:Stack(
        children: [
          VideoPlayer(playerProvider.videoPlayerController),
          playerStyleSelector(),
        ],
      )
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      playerProvider.videoPlayerController =
          VideoPlayerController.network(widget.videoUrl);
      playerProvider.videoPlayerController.addListener(() {
        setState(() {});
      });
      //playerProvider.videoPlayerController.play();
      playerProvider.videoPlayerController.initialize();
    });

    ///make player provider access to player function provider
    playerFunctionsProvider.setPlayerProvider(playerProvider);

    ///set initial data of video the video player
    playerProvider.setInitialData(
      widget.videoUrl,
      widget.videoTitle,
      widget.videoThumbnail,
      widget.iconsColor,
      widget.progressColor,
      widget.playIcon,
      widget.pauseIcon,
      widget.fullScreeIcon,
      widget.replayIcon,
      widget.functionKeyVisibleTime,
    );
  }

  @override
  void dispose() {
    super.dispose();
    playerProvider.videoPlayerController.dispose();
  }
}
