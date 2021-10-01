import 'package:flutter/material.dart';

String convertToDisplayTimeFormat(Duration val) {
  return val.toString().split(".").first;
}

String remainingTime(Duration startTime,Duration endTime){
  int diff = endTime.inMicroseconds - startTime.inMicroseconds;
  return Duration(microseconds: diff).toString().split(".").first;
}