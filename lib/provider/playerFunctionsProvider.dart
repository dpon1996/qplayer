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

  DurationRange videoBuffered = DurationRange(Duration(), Duration());

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

  void initializeVideo() async {
    videoBuffered = DurationRange(Duration(), Duration());
    playerProvider.videoPlayerController =
        VideoPlayerController.network(playerProvider.videoUrl);
    playerProvider.videoPlayerController.addListener(() {
      isVideoEndCheck();
      notifyListeners();
      checkBufferLoading();
      isVideoPlaying();
    });
    await playerProvider.videoPlayerController.initialize();
    aspectRatioVal = playerProvider.videoPlayerController.value.aspectRatio;
    await playerProvider.videoPlayerController.seekTo(playerProvider.startingPosition);
    await playerProvider.videoPlayerController.play();
    notifyListeners();
  }

  isVideoEndCheck() {
    if (playerProvider.videoPlayerController.value.position ==
        playerProvider.videoPlayerController.value.duration) {
      isVideoEnd = true;
      playControlIcon = playerProvider.replayIcon;
    } else {
      isVideoEnd = false;
    }
    notifyListeners();
  }

  double getVideoDuration() {
    int videoDuration = 1;
    if (playerProvider.videoPlayerController.value.initialized &&
        playerProvider.videoPlayerController.value != null) {
      videoDuration =
          playerProvider.videoPlayerController.value.duration.inMilliseconds;
    }
    return videoDuration.toDouble();
  }

  double currentVideoPosition() {
    int videoPosition = 0;
    if (playerProvider.videoPlayerController.value.initialized &&
        playerProvider.videoPlayerController.value != null) {
      videoPosition =
          playerProvider.videoPlayerController.value.position.inMilliseconds;
    }
    return videoPosition.toDouble();
  }

  seekVideoPosition(double val) {
    functionVisibility = true;
    notifyListeners();
    playerProvider.videoPlayerController.seekTo(
      Duration(
        milliseconds: val.toInt(),
      ),
    );
    playerProvider.videoPlayerController.play();
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
    if (isVideoEnd) {
      initializeVideo();
      playControlIcon = playerProvider.pauseIcon;
    } else if (playerProvider.videoPlayerController.value.isPlaying) {
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
    if (playerProvider.videoPlayerController.value.buffered.isNotEmpty) {
      videoBuffered = playerProvider.videoPlayerController.value.buffered[0];
    }
    if (!vdoCtrl.value.isPlaying &&
            vdoCtrl == null &&
            playControlIcon != playerProvider.playIcon ||
        vdoCtrl.value.isBuffering) {
      bufferLoading = true;
    } else {
      bufferLoading = false;
    }
    notifyListeners();
  }

  switchAspectRatio(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (aspectRatioVal ==
        playerProvider.videoPlayerController.value.aspectRatio) {
      aspectRatioVal = size.width / size.height;
    } else {
      aspectRatioVal = playerProvider.videoPlayerController.value.aspectRatio;
    }
    notifyListeners();
  }

  isVideoPlaying() {
    if (isVideoEnd) {
      playControlIcon = playerProvider.replayIcon;
    } else if (playerProvider.videoPlayerController.value.isPlaying) {
      playControlIcon = playerProvider.pauseIcon;
    } else {
      playControlIcon = playerProvider.playIcon;
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

  doubleTapVideoSeek(
      {@required BuildContext context, @required Offset localPosition}) {
    double phoneWidth = MediaQuery.of(context).size.width;
    double touchedPosition = localPosition.dx;

    if (touchedPosition > (phoneWidth / 2)) {
      ///check if video position greater than duration
      videoFastSeekRight();
    } else {
      ///check if video position less than than duration
      videoFastSeekLeft();
    }
  }

  videoFastSeekRight() {
    if (getVideoDuration() >
        currentVideoPosition() +
            playerProvider.quickFastDuration.inMilliseconds) {
      seekVideoPosition(currentVideoPosition() +
          playerProvider.quickFastDuration.inMilliseconds);
    } else {
      seekVideoPosition(getVideoDuration());
    }
  }

  videoFastSeekLeft() {
    if (currentVideoPosition() -
            playerProvider.quickFastDuration.inMilliseconds >=
        0) {
      seekVideoPosition(currentVideoPosition() -
          playerProvider.quickFastDuration.inMilliseconds);
    } else {
      seekVideoPosition(0);
    }
  }

  videoFastSeekDrag(double val) {
    if (getVideoDuration() >
        currentVideoPosition() +
            Duration(milliseconds: val.toInt()).inMilliseconds * 100) {
      seekVideoPosition(currentVideoPosition() +
          Duration(milliseconds: val.toInt()).inMilliseconds * 100);
    } else {
      seekVideoPosition(getVideoDuration());
    }
  }

  videoSpeedControl({@required bool getSpeed}){
    double speed = playerProvider.videoPlayerController.value.playbackSpeed;
    double speedCtrl = 1;
    if(getSpeed){
      return speed;
    }else{
      if(speed >= 3){
        speedCtrl = 1;
      }else{
        speedCtrl = speed + 1;
      }
      print(speedCtrl);
      playerProvider.videoPlayerController.setPlaybackSpeed(speedCtrl);
    }
  }


}
