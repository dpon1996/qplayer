import 'package:flutter/material.dart';

class PlayerProvider extends ChangeNotifier{
  Color color = Colors.red;
  setColor(colors){
    color = colors;
    notifyListeners();
  }
}