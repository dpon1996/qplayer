library qplayer;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qplayer/provider/playerProvider.dart';
import 'package:video_player/video_player.dart';

import 'model/playerControls.dart';
import 'myPlayer.dart';

class QP extends StatefulWidget {
  final PlayerControls playerControls;
  final ValueChanged<VideoPlayerController>? getVideoPlayerController;

  const QP(
      {Key? key, required this.playerControls, this.getVideoPlayerController})
      : super(key: key);

  @override
  _QPState createState() => _QPState();
}

class _QPState extends State<QP> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PlayerProvider>.value(value: PlayerProvider()),
      ],
      child: QPlayer(
        playerControls: widget.playerControls,
        getVideoPlayerController: widget.getVideoPlayerController,
      ),
    );
  }

}




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
    _playerProvider = Provider.of(context);
    return _playerProvider.playerControls != null
        ? MyPlayer()
        : Container(color: Colors.black);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _playerProvider.setPlayerControls(widget.playerControls);
      setState(() {});
    });
  }

  // @override
  // void didUpdateWidget(QPlayer oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   setState(() {
  //     widget.getVideoPlayerController!(_playerProvider.videoPlayerController!);
  //   });
  // }

  @override
  void dispose() {
    _playerProvider.disposeControllers();
    super.dispose();
  }
}
