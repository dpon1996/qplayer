import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlayerProvider extends ChangeNotifier{
  VideoPlayerController videoPlayerController;

  Color color = Colors.red;
  setColor(colors){
    color = colors;
    notifyListeners();
  }
}