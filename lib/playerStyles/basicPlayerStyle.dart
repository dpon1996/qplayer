import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qplayer/convertOperations.dart';
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
    return GestureDetector(
      onTap: () {
        _playerFunctionsProvider.setFunctionVisibility();
      },
      onDoubleTapDown: (details) {
        _playerFunctionsProvider.doubleTapVideoSeek(
            context: context, localPosition: details.localPosition);
      },
      onDoubleTap: () {},
      child: Container(
        color: Colors.transparent,
        alignment: Alignment.center,
        child: Visibility(
          visible: _playerFunctionsProvider.functionVisibility,
          child: Container(
            color: Colors.black38,
            child: Stack(
              children: [
                /// play pause icons
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 60,
                      width: 60,
                      child: Stack(
                        children: [
                          if (_playerFunctionsProvider.bufferLoading)
                            Positioned(
                              left: 10,
                              right: 4,
                              bottom: 0,
                              top: 14,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    _playerProvider.loadingColor),
                              ),
                            ),
                          Positioned(
                            bottom: 8,
                            left: 0,
                            child: IconButton(
                              onPressed: () {
                                _playerFunctionsProvider.playControl();
                              },
                              icon: Icon(
                                _playerFunctionsProvider.playControlIcon,
                                size: 50,
                                color: _playerProvider.iconsColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          SliderTheme(
                            data: SliderThemeData(
                              thumbShape: SliderComponentShape.noThumb,
                            ),
                            child: Slider(
                              onChanged: (val) {},
                              value: _playerFunctionsProvider
                                  .videoBuffered.end.inMilliseconds
                                  .toDouble(),
                              max: _playerFunctionsProvider.getVideoDuration(),
                              min: _playerFunctionsProvider
                                  .videoBuffered.start.inMilliseconds
                                  .toDouble(),
                              activeColor:
                              _playerProvider.progressColor.withOpacity(.4),
                            ),
                          ),
                          Slider(
                            onChanged: (double value) {
                              _playerFunctionsProvider.seekVideoPosition(value);
                            },
                            value:
                            _playerFunctionsProvider.currentVideoPosition(),
                            min: 0,
                            max: _playerFunctionsProvider.getVideoDuration(),
                            activeColor: _playerProvider.progressColor,
                            inactiveColor:
                            _playerProvider.progressColor.withOpacity(.2),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          children: [
                            Text(
                              ConvertOperations().convertToDisplayTimeFormat(
                                  _playerFunctionsProvider
                                      .currentVideoPosition()),
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              "/",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              ConvertOperations().convertToDisplayTimeFormat(
                                  _playerFunctionsProvider.getVideoDuration()),
                              style: TextStyle(color: Colors.white),
                            ),
                            InkWell(
                              onTap: () {
                                _playerFunctionsProvider.muteAndUnMuteFunction(
                                    getStatus: false);
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Icon(
                                  _playerFunctionsProvider
                                      .muteAndUnMuteFunction(
                                      getStatus: true)
                                      ? Icons.volume_up
                                      : Icons.volume_off,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            Text(
                              "-",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              ConvertOperations().remainingTime(
                                endTime:
                                _playerFunctionsProvider.getVideoDuration(),
                                startTime: _playerFunctionsProvider
                                    .currentVideoPosition(),
                              ),
                              style: TextStyle(color: Colors.white),
                            ),
                            InkWell(
                              onTap: () {
                                _playerFunctionsProvider
                                    .switchAspectRatio(context);
                              },
                              child: Padding(
                                padding: EdgeInsets.only(left: 16),
                                child: Icon(
                                  Icons.aspect_ratio,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
