import 'package:show_time/data/time.dart';
import 'package:show_time/provider/time_provider.dart';

class TimeRepository {
  final TimeProvider _timeProvider = TimeProvider();

  Future<Time> getTime() async {
    return await _timeProvider.getTime();
  }
}