import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlayerProvider extends ChangeNotifier {
  VideoPlayerController videoPlayerController;

  String videoUrl;
  String videoTitle;
  String videoThumbnail;
  Color iconsColor;
  Color progressColor;
  Color loadingColor;
  IconData playIcon;
  IconData pauseIcon;
  IconData fullScreeIcon;
  IconData replayIcon;
  Duration functionKeyVisibleTime;

  setInitialData({
    String videoUrl,
    String videoTitle,
    String videoThumbnail,
    Color iconsColor,
    Color progressColor,
    Color loadingColor,
    IconData playIcon,
    IconData pauseIcon,
    IconData fullScreeIcon,
    IconData replayIcon,
    Duration functionKeyVisibleTime,

  }) {
    this.videoUrl = videoUrl;
    this.videoTitle = videoTitle;
    this.videoThumbnail = videoThumbnail;
    this.iconsColor = iconsColor;
    this.progressColor = progressColor;
    this.loadingColor = loadingColor;
    this.playIcon = playIcon;
    this.pauseIcon = pauseIcon;
    this.fullScreeIcon = fullScreeIcon;
    this.replayIcon = replayIcon;
    this.functionKeyVisibleTime = functionKeyVisibleTime;
    notifyListeners();
  }
}
