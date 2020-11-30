import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qplayer/provider/playerProvider.dart';

class PlayerFunctionsProvider extends ChangeNotifier {
  PlayerProvider playerProvider;

  bool functionVisibility = false;

  setPlayerProvider(provider){
    playerProvider = provider;
    ///call this function after video init
    ///video function visibility set to true
    setFunctionVisibility();
  }

  double getVideoProgressValue(){
    int videoCurrentPosition = playerProvider.videoPlayerController.value.position.inMicroseconds;
    int totalDuration = playerProvider.videoPlayerController.value.duration.inMicroseconds;
    return videoCurrentPosition/totalDuration;
  }

  void setFunctionVisibility(){
    functionVisibility = !functionVisibility;
    if(functionVisibility){
      Timer(Duration(seconds: 2), (){
        functionVisibility = false;
      });
    }
  }



}