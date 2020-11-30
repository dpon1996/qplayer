import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qplayer/provider/playerProvider.dart';
import 'package:video_player/video_player.dart';

class PlayerFunctionsProvider extends ChangeNotifier {
  PlayerProvider playerProvider;

  bool functionVisibility = false;

  IconData playControlIcon;

  bool buffering = false;

  setPlayerProvider(provider) {
    playerProvider = provider;
    ///
    Timer.periodic(Duration(milliseconds: 200), (timer) {
      if (playerProvider.videoPlayerController != null &&
          playerProvider.videoPlayerController.value != null) {
        ///call this function after video init
        ///video function visibility set to true
        setFunctionVisibility();

        ///call play control
        playControl();

        timer.cancel();
      }
    });
  }

  void initializeVideo(){
    playerProvider.videoPlayerController = VideoPlayerController.network(playerProvider.videoUrl);
    playerProvider.videoPlayerController.addListener(() {
      buffering = playerProvider.videoPlayerController.value.isBuffering;
      notifyListeners();
    });
    playerProvider.videoPlayerController.initialize();
    notifyListeners();
  }

  double getVideoProgressValue() {
    int videoCurrentPosition = 0;
    int totalDuration = 1;
    double progress = 0;
    if (playerProvider.videoPlayerController.value.initialized &&
        playerProvider.videoPlayerController.value != null) {
      videoCurrentPosition =
          playerProvider.videoPlayerController.value.position.inMicroseconds;
      totalDuration =
          playerProvider.videoPlayerController.value.duration.inMicroseconds;
      progress = videoCurrentPosition / totalDuration;
      if(progress >= 1){
        playControlIcon = playerProvider.replayIcon;
      }
    }

    return progress;
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
    if(getVideoProgressValue() >= 1){
     print("replay clicked");
    }
    else if (playerProvider.videoPlayerController.value.isPlaying) {
      playerProvider.videoPlayerController.pause();
      playControlIcon = playerProvider.playIcon;
    } else {
      playerProvider.videoPlayerController.play();
      playControlIcon = playerProvider.pauseIcon;
    }
    notifyListeners();
  }
}
