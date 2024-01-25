import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:show_time/bloc/time/time_clock_event.dart';
import 'package:show_time/bloc/time/time_clock_state.dart';
import 'package:show_time/repository/time_repository.dart';

class TimeClockBloc extends Bloc<TimeClockEvent, TimeClockState> {
  final TimeRepository _repository = TimeRepository();

  TimeClockBloc() : super(TimeClockInitialState()) {
    on<GetTimeClock>((event, emit) async {
      emit(TimeClockLoadingState());
      try {
        final data = await _repository.getTime();
        emit(TimeClockSuccessInitial(result: data));
      } catch (e) {
        emit(TimeClockFailedInitial(error: e.toString()));
      }
    });
  }
}
