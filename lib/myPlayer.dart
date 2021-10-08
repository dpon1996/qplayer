import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qplayer/appCtrls/printString.dart';
import 'package:qplayer/playerUi/basicPlayer.dart';
import 'package:qplayer/playerUi/mxPlayer.dart';
import 'package:qplayer/provider/playerProvider.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'model/playerControls.dart';

class MyPlayer extends StatefulWidget {
  @override
  _MyPlayerState createState() => _MyPlayerState();
}

class _MyPlayerState extends State<MyPlayer> {
  PlayerProvider _playerProvider = PlayerProvider();

  @override
  Widget build(BuildContext context) {
    _playerProvider = Provider.of(context);

    return Center(
      child: AspectRatio(
        aspectRatio: _playerProvider.playerControls!.aspectRatio,
        child: Container(
          color: Colors.black,
          child: Stack(
            children: [
              ///core player
              if (_playerProvider.videoPlayerController != null &&
                  _playerProvider.videoPlayerController!.value.isInitialized)
                GestureDetector(
                  onTap: () {
                    _playerProvider.setFunctionVisible();
                  },
                  child: VisibilityDetector(
                    key: Key("key"),
                    onVisibilityChanged: (VisibilityInfo info) {
                      PrintString(info.visibleFraction);
                      var visiblePercentage = info.visibleFraction * 100;
                      if(visiblePercentage <1){
                        if(_playerProvider.videoPlayerController != null){
                          _playerProvider.videoPlayerController!.pause();
                        }
                      }else{
                        if(_playerProvider.videoPlayerController != null){
                          _playerProvider.videoPlayerController!.play();
                        }
                      }
                    },
                    child: VideoPlayer(_playerProvider.videoPlayerController!),
                  ),
                ),

              ///player ui
              if (_playerProvider.videoPlayerController != null &&
                  _playerProvider.videoPlayerController!.value.isInitialized)
                getPlayer(),

              if (_playerProvider.videoPlayerController == null ||
                  !_playerProvider.videoPlayerController!.value.isInitialized)
                Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        _playerProvider.playerControls!.color),
                  ),
                )

              //Container(color: Colors.black),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {});
  }

  Widget getPlayer() {
    PlayerStyle playerStyle = _playerProvider.playerControls!.playerStyle;
    switch (playerStyle) {
      case PlayerStyle.basicStyle:
        return BasicPlayer();

      case PlayerStyle.mxStyle:
        return MXPlayer();

      case PlayerStyle.none:
        return Container();
    }
  }
}
