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
  @override
  Widget build(BuildContext context) {
    playerFunPro = Provider.of<PlayerFunctionsProvider>(context);
    playerPro = Provider.of<PlayerProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
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
                      onTap: (){
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.width * .05),
                        child: Icon(
                          Icons.lock,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),

                    InkWell(
                      onTap: (){
                        playerFunPro.videoFastSeekLeft();
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.width * .05),
                        child: Icon(
                          Icons.fast_rewind,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                    ),

                    InkWell(
                      onTap: (){
                        playerFunPro.playControl();
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.width * .05),
                        child: Icon(
                          playerFunPro.playControlIcon,
                          color: Colors.white,
                          size: 45,
                        ),
                      ),
                    ),

                    InkWell(
                      onTap: (){
                        playerFunPro.videoFastSeekRight();
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.width * .05),
                        child: Icon(
                          Icons.fast_forward,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                    ),

                    InkWell(
                      onTap: (){

                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.width * .05),
                        child: Icon(
                          Icons.fullscreen,
                          color: Colors.white,
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
    );
  }
}
