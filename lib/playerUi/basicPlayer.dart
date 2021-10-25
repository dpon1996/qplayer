import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qplayer/appCtrls/timeConvertions.dart';
import 'package:qplayer/model/playerControls.dart';
import 'package:qplayer/provider/playerProvider.dart';
import 'package:qplayer/supportWidgets/QSlider.dart';
import 'package:qplayer/supportWidgets/Qtext.dart';

class BasicPlayer extends StatefulWidget {
  @override
  _BasicPlayerState createState() => _BasicPlayerState();
}

class _BasicPlayerState extends State<BasicPlayer> {
  PlayerProvider _playerProvider = PlayerProvider();

  @override
  Widget build(BuildContext context) {
    _playerProvider = Provider.of(context);
    PlayerControls playerControls = _playerProvider.playerControls!;
    Color uiColor = playerControls.color;
    return Visibility(
      visible: _playerProvider.functionVisibility,
      child: GestureDetector(
        onTap: () {
          _playerProvider.setFunctionVisible(visibility: false);
        },
        child: Container(
          color: Colors.black26,
          child: Stack(
            children: [
              ///appbar
              if (playerControls.appBar != null)
                Positioned(
                  top: -30,
                  left: 0,
                  right: 0,
                  child: playerControls.appBar!,
                ),

              ///video title
              if (playerControls.videoTitle != null &&
                  playerControls.appBar == null)
                Positioned(
                  top: 8,
                  left: 8,
                  child: Text(
                    playerControls.videoTitle!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: uiColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

              ///play control button
              Align(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: IconButton(
                    onPressed: () {
                      _playerProvider.playControlFun();
                    },
                    icon: Icon(
                      _playerProvider.playCtrlIcon,
                      size: 45,
                      color: uiColor,
                    ),
                  ),
                ),
              ),

              ///video progress bar
              Positioned(
                bottom: 20,
                left: 4,
                right: 4,
                child: QSlider(
                  child: Slider(
                    activeColor: uiColor,
                    inactiveColor: uiColor.withOpacity(.15),
                    value: _playerProvider.currentPlayingPosition.inMicroseconds
                        .toDouble(),
                    min: 0,
                    max: _playerProvider.totalVideoTime.inMicroseconds
                        .toDouble(),
                    onChanged: (val) {
                      _playerProvider.seekVideoPosition(val.toInt());
                      _playerProvider.setFunctionVisible();
                    },
                  ),
                ),
              ),

              ///video details
              ///mute
              Positioned(
                left: 6,
                right: 6,
                bottom: 0,
                child: Row(
                  children: [
                    QText(
                      "${convertToDisplayTimeFormat(_playerProvider.currentPlayingPosition)} / ${convertToDisplayTimeFormat(_playerProvider.totalVideoTime)} ",
                      style: playerControls.textStyle,
                      color: uiColor,
                    ),
                    IconButton(
                      onPressed: () {
                        _playerProvider.muteCtrlFunction();
                      },
                      visualDensity: VisualDensity.compact,
                      icon: Icon(
                        _playerProvider.muteCtrlIcon,
                        color: uiColor,
                      ),
                    ),
                    Spacer(),
                    QText(
                      remainingTime(_playerProvider.currentPlayingPosition,
                          _playerProvider.totalVideoTime),
                      style: playerControls.textStyle,
                      color: uiColor,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
