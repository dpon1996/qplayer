import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qplayer/provider/playerProvider.dart';

class BasicPlayerStyle extends StatefulWidget {
  @override
  _BasicPlayerStyleState createState() => _BasicPlayerStyleState();
}

class _BasicPlayerStyleState extends State<BasicPlayerStyle> {
  PlayerProvider _playerProvider;
  @override
  Widget build(BuildContext context) {
    _playerProvider = Provider.of<PlayerProvider>(context);
    return Container(
      color: Colors.black12,
      alignment: Alignment.center,
      child: IconButton(
        onPressed: (){
          if(_playerProvider.videoPlayerController.value.isPlaying){
            _playerProvider.videoPlayerController.pause();
          }else{
            _playerProvider.videoPlayerController.play();
          }
        },
        icon: Icon(Icons.play_circle_outline),
      )
    );
  }
}
