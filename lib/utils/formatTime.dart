String formatTime(milliSeconds) {
  var date = DateTime.fromMillisecondsSinceEpoch(milliSeconds * 1000);
  return date.toString().split(' ')[0];
}

String formatTimeHMS(milliSeconds) {
  var date = DateTime.fromMillisecondsSinceEpoch(milliSeconds * 1000);
  return date.toString().split('.')[0];
}
