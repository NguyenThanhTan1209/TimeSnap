// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:show_time/data/time.dart';

abstract class TimeClockState {
  
}

class TimeClockInitialState extends TimeClockState {
  
}

class TimeClockLoadingState extends TimeClockState {
  
}

class TimeClockSuccessInitial extends TimeClockState {
  Time result;
  TimeClockSuccessInitial({
    required this.result,
  });
}

class TimeClockFailedInitial extends TimeClockState {
  String error;
  TimeClockFailedInitial({
    required this.error,
  });
}


