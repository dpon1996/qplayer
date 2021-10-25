library qplayer;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qplayer/appCtrls/printString.dart';
import 'package:qplayer/provider/playerProvider.dart';
import 'package:video_player/video_player.dart';

import 'model/playerControls.dart';
import 'myPlayer.dart';

class QPlayer extends StatefulWidget {
  final PlayerControls playerControls;
  final ValueChanged<VideoPlayerController>? getVideoPlayerController;

  const QPlayer({
    Key? key,
    required this.playerControls,
    this.getVideoPlayerController,
  }) : super(key: key);

  @override
  _QPlayerState createState() => _QPlayerState();
}

class _QPlayerState extends State<QPlayer> {
  PlayerProvider _playerProvider = PlayerProvider();

  @override
  Widget build(BuildContext context) {
    _playerProvider.setPlayerControls(widget.playerControls);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _playerProvider),
      ],
      child: _playerProvider.playerControls != null
          ? MyPlayer()
          : Container(color: Colors.black),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _playerProvider.setPlayerControls(widget.playerControls);
      setState(() {});

      ///send back video player controller
      if (widget.getVideoPlayerController != null) {
        Timer.periodic(Duration(seconds: 1), (timer) {
          if (_playerProvider.videoPlayerController != null) {
            if (!mounted) return;
            setState(() {
              widget.getVideoPlayerController!(
                  _playerProvider.videoPlayerController!);
            });
            timer.cancel();
          }
        });
      }

    });
  }

  @override
  void dispose() {
    _playerProvider.disposeControllers();
    super.dispose();
  }
}
