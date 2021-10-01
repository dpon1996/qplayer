library qplayer;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: PlayerProvider()),
      ],
      child: _playerProvider.playerControls != null ? MyPlayer() : Container(color: Colors.blue,),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _playerProvider.setPlayerControls(widget.playerControls);
    });
  }

  @override
  void dispose() {
    _playerProvider.disposeControllers();
    super.dispose();
  }
}
