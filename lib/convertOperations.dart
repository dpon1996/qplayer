class ConvertOperations {
  String convertToDisplayTimeFormat(double val) {
    return Duration(milliseconds: val.toInt()).toString().split(".").first;
  }

  String remainingTime({double endTime,double startTime}){
    int endMil = endTime.toInt();
    int startMil = startTime.toInt();
    int diff = endMil - startMil;
    return Duration(milliseconds: diff.toInt()).toString().split(".").first;
  }

  String convertToVideoSpeed(double val){
    String speed = val.toString();
    return "${speed[0]}X";
  }

}
