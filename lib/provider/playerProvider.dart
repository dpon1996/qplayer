import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qplayer/model/playerControls.dart';
import 'package:video_player/video_player.dart';

class PlayerProvider extends ChangeNotifier {
  ///initialize video player settings
  PlayerControls? playerControls;

  setInitialControls(PlayerControls playerCtrl, VideoPlayerController ctrl) {
    playerControls = playerCtrl;
    videoPlayerController = ctrl;
    notifyListeners();
    videoInitialize();
  }

  ///play control icons
  IconData? playCtrlIcon;
  IconData? muteCtrlIcon;

  ///video functions
  VideoPlayerController? videoPlayerController;

  bool functionVisibility = false;
  Timer? functionVisibleTimer;

  bool isVideoEnd = false;
  bool isPlaying = false;
  Duration currentPlayingPosition = Duration();
  Duration totalVideoTime = Duration();

  videoInitialize() async {
    ///set icons
    playCtrlIcon = playerControls!.playIcon;
    muteCtrlIcon = playerControls!.muteIcon;
    if (playerControls!.mute) {
      muteCtrlIcon = playerControls!.unMuteIcon;
    }

    ///video player config
    await videoPlayerController!.initialize();
    videoPlayerController!.play();
    videoPlayerController!.setLooping(playerControls!.looping);

    ///function visible
    setFunctionVisible();

    ///video init settings
    videoInitSettings();

    videoPlayerController!.addListener(() {
      isVideoEndCheck();
      isVideoPlaying();
      getVideoPositionalValues();
    });
    notifyListeners();
  }

  videoInitSettings() {
    videoPlayerController!.setVolume(playerControls!.mute ? 0 : 1);
    if (!isVideoEnd) {
      seekVideoPosition(playerControls!.startingPosition!.inMicroseconds);
    }
  }

  ///check the video is end
  isVideoEndCheck() {
    if (videoPlayerController!.value.position ==
        videoPlayerController!.value.duration) {
      isVideoEnd = true;
      setFunctionVisible(always: true);
    } else {
      isVideoEnd = false;
    }
    notifyListeners();
  }

  ///check the playing status
  isVideoPlaying() {
    isPlaying = videoPlayerController!.value.isPlaying;

    if (isVideoEnd) {
      playCtrlIcon = playerControls!.replayIcon;
    } else if (videoPlayerController!.value.isPlaying) {
      playCtrlIcon = playerControls!.pauseIcon;
    } else {
      playCtrlIcon = playerControls!.playIcon;
    }
    notifyListeners();
  }

  ///play start resume function
  playControlFun() {
    if (isVideoEnd) {
      disposeControllers();
      videoInitialize();
    } else if (isPlaying) {
      videoPlayerController!.pause();
    } else {
      videoPlayerController!.play();
    }
    setFunctionVisible();
  }

  ///mute un mute function
  muteCtrlFunction() {
    double volume = videoPlayerController!.value.volume;
    if (volume == 0) {
      videoPlayerController!.setVolume(1);
      muteCtrlIcon = playerControls!.muteIcon;
    } else if (volume <= 1) {
      videoPlayerController!.setVolume(0);
      muteCtrlIcon = playerControls!.unMuteIcon;
    }
    notifyListeners();
  }

  ///video time based positional value
  getVideoPositionalValues() {
    currentPlayingPosition = videoPlayerController!.value.position;
    totalVideoTime = videoPlayerController!.value.duration;
    notifyListeners();
  }

  ///seek  video position
  seekVideoPosition(int microSecond) {
    videoPlayerController!.seekTo(
      Duration(
        microseconds: microSecond.toInt(),
      ),
    );
    videoPlayerController!.play();

    notifyListeners();
  }

  setFunctionVisible({bool visibility = true, bool always = false}) {
    functionVisibility = visibility;
    functionVisibleTimer?.cancel();
    notifyListeners();
    if (!always && functionVisibility) {
      functionVisibleTimer = Timer(
          Duration(
            milliseconds: playerControls!.functionKeyVisibleMillTime.toInt(),
          ), () {
        functionVisibility = false;
        notifyListeners();
      });
    }
  }

  disposeControllers() {
    videoPlayerController!.dispose();
    videoPlayerController = null;
  }
}
