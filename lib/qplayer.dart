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
    // return _playerProvider.playerControls != null
    //     ? MyPlayer()
    //     : Container(color: Colors.black);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PlayerProvider>.value(value: PlayerProvider()),
      ],
      child: ChangeNotifierProvider(
        create: (_) => PlayerProvider(),
        child: _playerProvider.playerControls != null
            ? MyPlayer()
            : Container(color: Colors.black),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      PlayerProvider playerProvider = Provider.of(context, listen: false);
      playerProvider.setPlayerControls(widget.playerControls);
      setState(() {});
    });
  }

  @override
  void dispose() {
    _playerProvider.disposeControllers();
    super.dispose();
  }
}
