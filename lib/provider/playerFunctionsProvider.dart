import 'package:flutter/material.dart';
import 'package:qplayer/provider/playerProvider.dart';

class PlayerFunctionsProvider extends ChangeNotifier {
  PlayerProvider playerProvider;
  setPlayerProvider(provider){
    playerProvider = provider;
  }

  getVideoProgressValue(){
    print(playerProvider.videoPlayerController.value.position);
  }
}