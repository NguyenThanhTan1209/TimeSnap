import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:show_time/bloc/time/time_text_event.dart';
import 'package:show_time/bloc/time/time_text_state.dart';
import 'package:show_time/repository/time_repository.dart';

class TimeTextBloc extends Bloc<TimeTextEvent, TimeTextState> {
  final TimeRepository _repository = TimeRepository();

  TimeTextBloc() : super(TimeTextInitialState()) {
    on<GetTimeText>((event, emit) async {
      try {
        final data = await _repository.getTime();
        emit(TimeTextSuccessInitial(result: data));
      } catch (e) {
        emit(TimeTextFailedInitial(error: e.toString()));
      }
    });
  }
}
