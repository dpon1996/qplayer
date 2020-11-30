import 'package:flutter/material.dart';
import 'package:qplayer/provider/playerProvider.dart';

class PlayerFunctionsProvider extends ChangeNotifier {
  PlayerProvider playerProvider;
  getVideoProgressValue(){
    print(playerProvider.videoPlayerController.value.position);
  }
}