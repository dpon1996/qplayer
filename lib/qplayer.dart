library qplayer;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qplayer/provider/playerProvider.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

import 'model/playerControls.dart';
import 'myPlayer.dart';

class QPlayer extends StatefulWidget {
  final PlayerControls playerControls;
  final ValueChanged<bool>? getFunctionVisibility;
  final VideoPlayerController videoPlayerController;

  const QPlayer({
    Key? key,
    required this.videoPlayerController,
    required this.playerControls,
    this.getFunctionVisibility,
  }) : super(key: key);

  @override
  _QPlayerState createState() => _QPlayerState();
}

class _QPlayerState extends State<QPlayer> {
  PlayerProvider _playerProvider = PlayerProvider();
  Timer? _timer;

  @override
  Widget build(BuildContext context) {
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
    Wakelock.enable();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _playerProvider.setInitialControls(
          widget.playerControls, widget.videoPlayerController);
      setState(() {});

      if (widget.getFunctionVisibility != null) {
        _timer = Timer.periodic(Duration(milliseconds: 200), (timer) {
          if (_playerProvider.videoPlayerController != null) {
            if (!mounted) return;
            setState(() {
              widget.getFunctionVisibility!(_playerProvider.functionVisibility);
            });
          }
        });
      }
    });
  }

  @override
  void dispose() {
    Wakelock.disable();
    _timer?.cancel();
    super.dispose();
  }
}
