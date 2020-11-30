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
  bool visibility = false;
  PlayerProvider _playerProvider;
  PlayerFunctionsProvider _playerFunctionsProvider;
  @override
  Widget build(BuildContext context) {
    _playerProvider = Provider.of<PlayerProvider>(context);
    _playerFunctionsProvider = Provider.of<PlayerFunctionsProvider>(context);
    return InkWell(
      onTap: (){
        _playerFunctionsProvider.getVideoProgressValue();
        setState(() {
          visibility = !visibility;
        });
        if(visibility){
          Timer(Duration(seconds: 2), (){
            setState(() {
              visibility = false;
            });
          });
        }
      },
      child: Visibility(
        visible: visibility,
        child: Container(
          color: Colors.black12,
          alignment: Alignment.center,
          child: Stack(
            children: [
              Center(
                child: IconButton(
                  onPressed: (){
                    if(_playerProvider.videoPlayerController.value.isPlaying){
                      _playerProvider.videoPlayerController.pause();
                    }else{
                      _playerProvider.videoPlayerController.play();
                    }
                  },
                  icon: Icon(Icons.play_circle_outline,size: 30,color: Colors.white,),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    LinearProgressIndicator(
                      value: _getVideoPosition(),
                    )
                  ],
                ),
              ),
            ],
          )
        ),
      ),
    );
  }

  double _getVideoPosition() {
    //if(_playerProvider.videoPlayerController.value.position)
    return .5;
  }
}
