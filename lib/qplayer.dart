library qplayer;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qplayer/myPlayer.dart';
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
  final Color loadingColor;
  final IconData playIcon;
  final IconData pauseIcon;
  final IconData fullScreeIcon;
  final IconData replayIcon;
  final PlayerStyle playerStyle;
  final Duration functionKeyVisibleTime;
  final Duration quickFastDuration;
  final ValueChanged<VideoPlayerController> getVideoPlayerController;
  const QPlayer({
    Key key,
    @required this.videoUrl,
    this.videoTitle,
    this.videoThumbnail,
    this.iconsColor = Colors.red,
    this.progressColor = Colors.red,
    this.loadingColor = Colors.white,
    this.playIcon = Icons.play_circle_outline,
    this.pauseIcon = Icons.pause,
    this.fullScreeIcon = Icons.fullscreen,
    this.replayIcon = Icons.replay,
    this.playerStyle = PlayerStyle.basicStyle,
    this.functionKeyVisibleTime = const Duration(seconds: 2),
    this.quickFastDuration = const Duration(seconds: 10),
    this.getVideoPlayerController,
  }) : super(key: key);

  @override
  _QPlayerState createState() => _QPlayerState();
}

class _QPlayerState extends State<QPlayer> {
  PlayerProvider playerProvider = PlayerProvider();
  PlayerFunctionsProvider playerFunctionsProvider = PlayerFunctionsProvider();

  @override
  Widget build(BuildContext context) {
    playerProvider = Provider.of<PlayerProvider>(context); //remove
    playerFunctionsProvider =
        Provider.of<PlayerFunctionsProvider>(context); //remove
    return Container(
      alignment: Alignment.center,
      color: Colors.black,
      child: MyPlayer(
        playerStyle: widget.playerStyle,
      ),
    );
  }

  @override
  void initState() {

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ///make player provider access to player function provider
      playerFunctionsProvider.setPlayerProvider(playerProvider);

      ///set initial data of video the video player
      playerProvider.setInitialData(
        videoUrl: widget.videoUrl,
        videoTitle: widget.videoTitle,
        videoThumbnail: widget.videoThumbnail,
        iconsColor: widget.iconsColor,
        progressColor: widget.progressColor,
        playIcon: widget.playIcon,
        pauseIcon: widget.pauseIcon,
        fullScreeIcon: widget.fullScreeIcon,
        replayIcon: widget.replayIcon,
        functionKeyVisibleTime: widget.functionKeyVisibleTime,
        loadingColor: widget.loadingColor,
        quickFastDuration: widget.quickFastDuration,
      );
    });
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      if(playerProvider.videoPlayerController != null){
        setState(() {
          widget.getVideoPlayerController(playerProvider.videoPlayerController);
        });
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    playerProvider.videoPlayerController.dispose();
  }
}

