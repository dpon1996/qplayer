import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qplayer/provider/playerProvider.dart';

class PlayerFunctionsProvider extends ChangeNotifier {
  PlayerProvider playerProvider;

  bool functionVisibility = false;

  IconData playControlIcon;

  setPlayerProvider(provider) {
    playerProvider = provider;
    if (playerProvider.videoPlayerController != null &&
        playerProvider.videoPlayerController.value != null) {
      ///call this function after video init
      ///video function visibility set to true
      setFunctionVisibility();

      ///call play control
      playControl();
    }
  }

  double getVideoProgressValue() {
    int videoCurrentPosition = 0;
    int totalDuration = 1;
    if (playerProvider.videoPlayerController.value.initialized &&
        playerProvider.videoPlayerController.value != null) {
      videoCurrentPosition =
          playerProvider.videoPlayerController.value.position.inMicroseconds;
      totalDuration =
          playerProvider.videoPlayerController.value.duration.inMicroseconds;
    }
    return videoCurrentPosition / totalDuration;
  }

  void setFunctionVisibility() {
    functionVisibility = !functionVisibility;
    if (functionVisibility) {
      Timer(Duration(seconds: 2), () {
        functionVisibility = false;
      });
    }
    notifyListeners();
  }

  void playControl() {
    if (playerProvider.videoPlayerController.value.isPlaying) {
      playerProvider.videoPlayerController.pause();
      playControlIcon = playerProvider.playIcon;
    } else {
      playerProvider.videoPlayerController.play();
      playControlIcon = playerProvider.pauseIcon;
    }
    notifyListeners();
  }
}
