import 'package:flutter/material.dart';

enum PlayerStyle {
  basicStyle,
  mxStyle,
  none,
}

class PlayerControls {
  final  String videoUrl;
  final String? videoTitle;
  final bool looping;
  final String? videoThumbnail;
  final Color color;
  final IconData playIcon;
  final IconData pauseIcon;
  final IconData fullScreeIcon;
  final IconData replayIcon;
  final IconData muteIcon;
  final IconData unMuteIcon;
  final PlayerStyle playerStyle;
  final double functionKeyVisibleMillTime;
  final double quickFastMillisecond;
  final Duration? startingPosition;
  final double aspectRatio;
  final TextStyle? textStyle;
  final bool mute;

  PlayerControls({
    required this.videoUrl,
    this.videoTitle,
    this.videoThumbnail,
    this.looping = false,
    this.color = Colors.white,
    this.playIcon = Icons.play_arrow,
    this.pauseIcon = Icons.pause,
    this.fullScreeIcon = Icons.fullscreen,
    this.replayIcon = Icons.replay,
    this.muteIcon = Icons.volume_up,
    this.unMuteIcon = Icons.volume_off,
    this.playerStyle = PlayerStyle.basicStyle,
    this.functionKeyVisibleMillTime = 3000,
    this.quickFastMillisecond = 1000,
    this.startingPosition,
    this.aspectRatio = 16 / 9,
    this.textStyle,
    this.mute = false,
  });
}
