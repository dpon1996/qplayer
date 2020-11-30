
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
                  /// play pause icons
                  Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: IconButton(
                      onPressed: () {
                        _playerFunctionsProvider.playControl();
                      },
                      icon: Icon(
                        _playerFunctionsProvider.playControlIcon,
                        size: 40,
                        color: _playerProvider.iconsColor,
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
                          valueColor: AlwaysStoppedAnimation<Color>(_playerProvider.progressColor),
                          backgroundColor: Colors.grey[200],
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
