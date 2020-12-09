# Qplayer - video player

Qplayer is a video player package for flutter. The [video_player](https://pub.dev/packages/video_player) plugin gives low level access for the video playback.

![Qplayer](https://user-images.githubusercontent.com/42827184/101625381-53507880-3a41-11eb-904d-6592289af50f.jpg)

Note: This package is still under development, and some Functions might not be available yet.

#### Installation
Add the following dependencies in your pubspec.yaml file of your flutter project.

``` 
qplayer: <latest_version>
video_player: <latest_version>
```
Note: Install the [Video Player](https://pub.dev/packages/video_player) Player Plugin properly as per their documentation.

#### Features
In ``PlayerStyle.basicStyle`` 
* Double tap to seek video.
* Auto hide controls.
* play/pause
* mute/unmute
* fit screen

In ``PlayerStyle.mxStyle`` 
* Double tap to seek video.
* Drag to seek video.
* fast forward/rewind.
* Auto hide controls.
* lock controls and navigation
* playback speed control
* play/pause
* mute/unmute
* fit screen

### Demo
![basicStyle](https://user-images.githubusercontent.com/42827184/101624445-f0121680-3a3f-11eb-915e-a72edd4e6555.gif) 

![mxStyle](https://user-images.githubusercontent.com/42827184/101624615-2ea7d100-3a40-11eb-85d4-24a08cd27273.gif) 

### How to use
```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qplayer/qplayer.dart';
import 'package:video_player/video_player.dart';

class MyVideoPlayerPage extends StatefulWidget {
  @override
  _MyVideoPlayerPageState createState() => _MyVideoPlayerPageState();
}

class _MyVideoPlayerPageState extends State<MyVideoPlayerPage> {
  VideoPlayerController videoPlayerController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QPlayer(
        videoUrl: "video url",
        videoTitle: "Video title",
      ),
    );
  }
  
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]); //change device Orientation
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }
}


```


## Getting Started

This project is a starting point for a Dart
[package](https://flutter.dev/developing-packages/),
a library module containing code that can be shared easily across
multiple Flutter or Dart projects.

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
