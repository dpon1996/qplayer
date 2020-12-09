import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qplayer/playerStyles/basicPlayerStyle.dart';
import 'package:qplayer/playerStyles/mxPlayerStyle.dart';
import 'package:qplayer/playerStyles/ybPlayerStyle.dart';
import 'package:qplayer/provider/playerFunctionsProvider.dart';
import 'package:qplayer/provider/playerProvider.dart';
import 'package:qplayer/qplayer.dart';
import 'package:video_player/video_player.dart';

class MyPlayer extends StatefulWidget {
  final PlayerStyle playerStyle;

  const MyPlayer({Key key, this.playerStyle}) : super(key: key);
  @override
  _MyPlayerState createState() => _MyPlayerState();
}

class _MyPlayerState extends State<MyPlayer> with WidgetsBindingObserver{
  PlayerProvider playerProvider;
  PlayerFunctionsProvider playerFunctionsProvider;
  AppLifecycleState _appLifecycleState;

  @override
  Widget build(BuildContext context) {
    playerProvider = Provider.of<PlayerProvider>(context);
    playerFunctionsProvider = Provider.of<PlayerFunctionsProvider>(context);

    return Container(
      alignment: Alignment.center,
      color: Colors.black,
      child: Stack(
        children: [
          if (playerProvider.videoPlayerController != null &&
              playerProvider.videoPlayerController.value.initialized)
            Center(
              child: AspectRatio(
                aspectRatio: playerFunctionsProvider.aspectRatioVal,
                child: VideoPlayer(playerProvider.videoPlayerController),
              ),
            ),
          if (playerProvider.videoPlayerController != null)
            playerStyleSelector(),
          if (playerProvider.videoPlayerController == null &&
              playerProvider.videoThumbnail != null)
            Center(child: Image.network(playerProvider.videoThumbnail)),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(milliseconds: 200), (timer) {
      _backgroundPlayControl();
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _appLifecycleState = state;
  }

  _backgroundPlayControl() {
    if (_appLifecycleState == AppLifecycleState.inactive ||
        _appLifecycleState == AppLifecycleState.paused) {
      if (playerProvider.videoPlayerController.value.isPlaying) {
        playerProvider.videoPlayerController.pause();
      }
    }
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
      case PlayerStyle.none:
        return YbPlayerStyle();
    }
  }

}
