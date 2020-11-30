import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qplayer/provider/playerFunctionsProvider.dart';
import 'package:qplayer/provider/playerProvider.dart';

class BasicPlayerStyle extends StatefulWidget {
  @override
  _BasicPlayerStyleState createState() => _BasicPlayerStyleState();
}

class _BasicPlayerStyleState extends State<BasicPlayerStyle> {
  PlayerProvider _playerProvider;
  PlayerFunctionsProvider _playerFunctionsProvider;

  @override
  Widget build(BuildContext context) {
    _playerProvider = Provider.of<PlayerProvider>(context);
    _playerFunctionsProvider = Provider.of<PlayerFunctionsProvider>(context);
    return InkWell(
      onTap: () {
        _playerFunctionsProvider.setFunctionVisibility();
      },
      child: Container(
          alignment: Alignment.center,
          child: Visibility(
            visible: _playerFunctionsProvider.functionVisibility,
            child: Container(
              color: Colors.black12,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: IconButton(
                      onPressed: () {
                        if (_playerProvider
                            .videoPlayerController.value.isPlaying) {
                          _playerProvider.videoPlayerController.pause();
                        } else {
                          _playerProvider.videoPlayerController.play();
                        }
                      },
                      icon: Icon(
                        Icons.play_circle_outline,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        LinearProgressIndicator(
                          value: _playerFunctionsProvider.getVideoProgressValue(),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }


}
