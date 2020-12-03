import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qplayer/convertOperations.dart';
import 'package:qplayer/provider/playerFunctionsProvider.dart';
import 'package:qplayer/provider/playerProvider.dart';

class MxPlayerStyle extends StatefulWidget {
  @override
  _MxPlayerStyleState createState() => _MxPlayerStyleState();
}

class _MxPlayerStyleState extends State<MxPlayerStyle> {
  PlayerFunctionsProvider playerFunPro = PlayerFunctionsProvider();
  PlayerProvider playerPro = PlayerProvider();
  bool lockMode = false;

  @override
  Widget build(BuildContext context) {
    playerFunPro = Provider.of<PlayerFunctionsProvider>(context);
    playerPro = Provider.of<PlayerProvider>(context);
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: _backPressCtrl,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                playerFunPro.setFunctionVisibility();
              },
              onVerticalDragUpdate: (val) {},
              onHorizontalDragUpdate: (val) {
                print(val.delta);
                playerFunPro.videoFastSeekDrag(val.delta.dx);
              },
              onDoubleTapDown: (val) {
                playerFunPro.doubleTapVideoSeek(
                    context: context, localPosition: val.localPosition);
              },
              onDoubleTap: () {},
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          if (lockMode && playerFunPro.functionVisibility)
            Positioned(
              top: 40,
              left: 20,
              child: InkWell(
                onTap: () {
                  setState(() {
                    lockMode = false;
                  });
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.white38,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.lock_open,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ),
          if (playerFunPro.functionVisibility && !lockMode)
            Positioned(
              top: playerPro.videoTitle == null ? 40 : 90,
              left: 0,
              right: 0,
              child: Container(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    CircleAvatar(
                      backgroundColor:
                      playerFunPro.muteAndUnMuteFunction(getStatus: true)
                          ? Colors.white24
                          : null,
                      child: IconButton(
                        onPressed: () {
                          playerFunPro.muteAndUnMuteFunction(getStatus: false);
                        },
                        icon: Icon(
                          playerFunPro.muteAndUnMuteFunction(getStatus: true)
                              ? Icons.volume_up
                              : Icons.volume_off,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    InkWell(
                      onTap: () {
                        playerFunPro.videoSpeedControl(getSpeed: false);
                      },
                      child: CircleAvatar(
                        backgroundColor:
                        playerFunPro.videoSpeedControl(getSpeed: true) == 1
                            ? Colors.white24
                            : null,
                        child: Text(
                          ConvertOperations().convertToVideoSpeed(
                              playerFunPro.videoSpeedControl(getSpeed: true)),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          if (playerPro.videoTitle != null &&
              playerFunPro.functionVisibility &&
              !lockMode)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBar(
                backgroundColor: Colors.black38,
                elevation: 0,
                title: Text('${playerPro.videoTitle}'),
              ),
            ),
          if (playerFunPro.functionVisibility && !lockMode)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                height: 100,
                color: Colors.black38,
                child: Column(
                  children: [
                    ///
                    /// video current position
                    /// video progress slider
                    /// video remaining time
                    ///
                    Container(
                      height: 30,
                      child: Row(
                        children: [
                          Text(
                            ConvertOperations().convertToDisplayTimeFormat(
                              playerFunPro.currentVideoPosition(),
                            ),
                            style: TextStyle(color: Colors.white),
                          ),

                          ///
                          /// video progress slider
                          ///
                          Expanded(
                            child: Stack(
                              children: [
                                SliderTheme(
                                  data: SliderThemeData(
                                    thumbShape: SliderComponentShape.noThumb,
                                  ),
                                  child: Slider(
                                    onChanged: (val) {},
                                    value: playerFunPro
                                        .videoBuffered.end.inMilliseconds
                                        .toDouble(),
                                    max: playerFunPro.getVideoDuration(),
                                    min: playerFunPro
                                        .videoBuffered.start.inMilliseconds
                                        .toDouble(),
                                    activeColor:
                                    playerPro.progressColor.withOpacity(.4),
                                  ),
                                ),
                                Slider(
                                  onChanged: (double value) {
                                    playerFunPro.seekVideoPosition(value);
                                  },
                                  value: playerFunPro.currentVideoPosition(),
                                  min: 0,
                                  max: playerFunPro.getVideoDuration(),
                                  activeColor: playerPro.progressColor,
                                  inactiveColor:
                                  playerPro.progressColor.withOpacity(.2),
                                ),
                              ],
                            ),
                          ),

                          ///
                          /// video remaining time
                          ///
                          Text("-", style: TextStyle(color: Colors.white)),
                          Text(
                            ConvertOperations().remainingTime(
                              endTime: playerFunPro.getVideoDuration(),
                              startTime: playerFunPro.currentVideoPosition(),
                            ),
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    //SizedBox(height: 16),
                    ///
                    /// play control function
                    ///
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              lockMode = !lockMode;
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * .05),
                            child: Icon(
                              Icons.lock,
                              color: playerPro.iconsColor,
                              size: 30,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            playerFunPro.videoFastSeekLeft();
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * .05),
                            child: Icon(
                              Icons.fast_rewind,
                              color: playerPro.iconsColor,
                              size: 35,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            playerFunPro.playControl();
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * .05),
                            child: Icon(
                              playerFunPro.playControlIcon,
                              color: playerPro.iconsColor,
                              size: 45,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            playerFunPro.videoFastSeekRight();
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * .05),
                            child: Icon(
                              Icons.fast_forward,
                              color: playerPro.iconsColor,
                              size: 35,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            playerFunPro.switchAspectRatio(context);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * .05),
                            child: Icon(
                              Icons.fullscreen,
                              color: playerPro.iconsColor,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<bool> _backPressCtrl()async {
    if(lockMode && !playerFunPro.isVideoEnd){
      playerFunPro.setFunctionVisibility();
      return false;
    }
    return true;
  }
}
