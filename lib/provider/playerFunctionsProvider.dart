import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qplayer/provider/playerProvider.dart';
import 'package:video_player/video_player.dart';

class PlayerFunctionsProvider extends ChangeNotifier {
  PlayerProvider playerProvider;
  VideoPlayerController vdoCtrl;
  bool functionVisibility = false;

  IconData playControlIcon;

  bool bufferLoading = false;

  bool isVideoEnd = false;

  double aspectRatioVal = 16 / 9;

  DurationRange videoBuffered = DurationRange(Duration() , Duration());

  setPlayerProvider(provider) {
    playerProvider = provider;

    Timer.periodic(Duration(milliseconds: 200), (timer) {
      initializeVideo();
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

  void initializeVideo()async{
    videoBuffered = DurationRange(Duration() , Duration());
    playerProvider.videoPlayerController = VideoPlayerController.network(playerProvider.videoUrl);
    playerProvider.videoPlayerController.addListener(() {
      isVideoEndCheck();
      notifyListeners();
      checkBufferLoading();
    });
    await playerProvider.videoPlayerController.initialize();
    aspectRatioVal = playerProvider.videoPlayerController.value.aspectRatio;
    await playerProvider.videoPlayerController.play();
    notifyListeners();
  }

  isVideoEndCheck() {
    if(playerProvider.videoPlayerController.value.position == playerProvider.videoPlayerController.value.duration){
      isVideoEnd = true;
      playControlIcon = playerProvider.replayIcon;
    }else{
      isVideoEnd = false;
    }
    notifyListeners();
  }

  double getVideoDuration(){
    int videoDuration = 1;
    if (playerProvider.videoPlayerController.value.initialized &&
        playerProvider.videoPlayerController.value != null) {
      videoDuration = playerProvider.videoPlayerController.value.duration.inMilliseconds;
    }
    return videoDuration.toDouble();
  }

  double currentVideoPosition(){
    int videoPosition = 1;
    if (playerProvider.videoPlayerController.value.initialized &&
        playerProvider.videoPlayerController.value != null) {
      videoPosition = playerProvider.videoPlayerController.value.position.inMilliseconds;
    }
    return videoPosition.toDouble();
  }

  seekVideoPosition(double val){
    functionVisibility = true;
    notifyListeners();
    playerProvider.videoPlayerController.seekTo(Duration(milliseconds: val.toInt()));
    print(Duration(milliseconds: val.toInt()));
  }

  void setFunctionVisibility() {
    functionVisibility = !functionVisibility;
    if (functionVisibility) {
      Timer(playerProvider.functionKeyVisibleTime, () {
        functionVisibility = false;
      });
    }
    notifyListeners();
  }

  void playControl() {
    if(isVideoEnd){
      initializeVideo();
      playControlIcon = playerProvider.pauseIcon;
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

  checkBufferLoading() {
    VideoPlayerController vdoCtrl = playerProvider.videoPlayerController;
    if(playerProvider.videoPlayerController.value.buffered.isNotEmpty){
      videoBuffered = playerProvider.videoPlayerController.value.buffered[0];
    }
    if(!vdoCtrl.value.isPlaying && vdoCtrl == null && playControlIcon != playerProvider.playIcon || vdoCtrl.value.isBuffering){
      bufferLoading = true;
    }else{
      bufferLoading = false;
    }
    notifyListeners();
  }

  switchAspectRatio(BuildContext context){
    Size size = MediaQuery.of(context).size;
    if(aspectRatioVal == playerProvider.videoPlayerController.value.aspectRatio){
      aspectRatioVal = size.width/size.height;
    }else{
      aspectRatioVal = playerProvider.videoPlayerController.value.aspectRatio;
    }
    notifyListeners();
  }

  muteAndUnMuteFunction({@required bool getStatus}) {
    double volume = playerProvider.videoPlayerController.value.volume;
    if (getStatus) {
      if (volume == 1) {
        return true;
      } else {
        return false;
      }
    } else {
      if (volume == 1) {
        playerProvider.videoPlayerController.setVolume(0);
      } else {
        playerProvider.videoPlayerController.setVolume(1);
      }
    }
  }

}
