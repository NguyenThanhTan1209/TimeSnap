// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:show_time/data/time.dart';

abstract class TimeTextState {
  
}

class TimeTextInitialState extends TimeTextState {
  
}

class TimeTextLoadingState extends TimeTextState {
  
}

class TimeTextSuccessInitial extends TimeTextState {
  Time result;
  TimeTextSuccessInitial({
    required this.result,
  });
}

class TimeTextFailedInitial extends TimeTextState {
  String error;
  TimeTextFailedInitial({
    required this.error,
  });
}


