import 'package:dio/dio.dart';
import 'package:show_time/constants/strings.dart';

import '../data/time.dart';

class TimeProvider {
  final dio = Dio();

  Future<Time> getTime() async {
    final response = await dio
        .get('${StringConstants.WORLD_TIME_API_BASE}current/zone', queryParameters: {'timeZone' : 'Asia/Ho_Chi_Minh'});
    return Time.fromJson(response.data);
  }
}
