import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_analog_clock/flutter_analog_clock.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:show_time/bloc/time/time_time_bloc.dart';
import 'package:show_time/bloc/time/time_clock_bloc.dart';
import 'package:show_time/bloc/time/time_clock_event.dart';
import 'package:show_time/bloc/time/time_clock_state.dart';
import 'package:show_time/bloc/time/time_text_event.dart';
import 'package:show_time/bloc/time/time_text_state.dart';
import 'package:show_time/constants/colors.dart';
import 'package:show_time/constants/number.dart';
import 'package:show_time/constants/strings.dart';

import '../widgets/floating_icon_button.dart';

class ClockScreen extends StatefulWidget {
  const ClockScreen({super.key});

  @override
  State<ClockScreen> createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> with AutomaticKeepAliveClientMixin{
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    context.read<TimeClockBloc>().add(GetTimeClock());
    context.read<TimeTextBloc>().add(GetTimeText());
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (DateTime.now().second == 0) {
        context.read<TimeTextBloc>().add(GetTimeText());
      }
      log('${DateTime.now().second}');
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(NumberConstants.PADDING_40),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FloatingButton(
                  icon: Icons.add,
                  backgroundColor:
                      ColorConstants.ICON_BUTTON_ADD_BACKGROUND_COLOR,
                  foregroundColor:
                      ColorConstants.ICON_BUTTON_ADD_FOREGROUND_COLOR,
                ),
                FloatingButton(
                  icon: Icons.edit_outlined,
                  backgroundColor:
                      ColorConstants.ICON_BUTTON_EDIT_BACKGROUND_COLOR,
                  foregroundColor:
                      ColorConstants.ICON_BUTTON_EDIT_FOREGROUND_COLOR,
                ),
              ],
            ),
            BlocBuilder<TimeClockBloc, TimeClockState>(
                builder: (context, state) {
              if (state is TimeClockLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is TimeClockFailedInitial) {
                return Center(
                  child: Text('Có lỗi xảy ra: ${state.error}'),
                );
              } else if (state is TimeClockSuccessInitial) {
                DateTime currentDateTime = DateTime.parse(state.result.dateTime!);

                return Container(
                  margin: const EdgeInsets.only(
                      top: NumberConstants.MARGIN_60,
                      bottom: NumberConstants.MARGIN_75),
                  decoration:
                      const BoxDecoration(shape: BoxShape.circle, boxShadow: [
                    BoxShadow(
                      offset: Offset(
                          NumberConstants.OFFSET_10, NumberConstants.OFFSET_0),
                      blurRadius: NumberConstants.BLUR_RADIUS_15,
                      color: ColorConstants.CLOCK_RIGHT_SHADOW_COLOR,
                    ),
                    BoxShadow(
                        offset: Offset(NumberConstants.OFFSET_MINUS_10,
                            NumberConstants.OFFSET_0),
                        blurRadius: NumberConstants.BLUR_RADIUS_15,
                        color: ColorConstants.COLOR_WHITE)
                  ]),
                  child: Stack(
                    children: [
                      Positioned.fill(
                          child: Image.asset(
                              StringConstants.CLOCK_FACE_IMAGE_PATH)),
                      AnalogClock(
                        dateTime: currentDateTime,
                        dialColor: null,
                        markingColor: null,
                        hourNumberColor: null,
                        hourHandColor: ColorConstants.HOUR_HAND_COLOR,
                        hourHandWidthFactor:
                            NumberConstants.HOUR_HAND_WIDTH_0_COMMA_5,
                        hourHandLengthFactor:
                            NumberConstants.HOUR_HAND_WIDTH_0_COMMA_6,
                        minuteHandColor: ColorConstants.MINUTE_HAND_COLOR,
                        minuteHandWidthFactor:
                            NumberConstants.MINUTE_HAND_WIDTH,
                        minuteHandLengthFactor:
                            NumberConstants.MINUTE_HAND_LENGTH_0_COMMA_7,
                        secondHandColor: ColorConstants.SECOND_HAND_COLOR,
                        secondHandWidthFactor:
                            NumberConstants.SECOND_HAND_WIDTH_2,
                        secondHandLengthFactor:
                            NumberConstants.SECOND_HAND_LENGTH_0_COMMA_85,
                      ),
                    ],
                  ),
                );
              } else {
                return const SizedBox();
              }
            }),
            BlocBuilder<TimeTextBloc, TimeTextState>(builder: (context, state) {
              if (state is TimeTextSuccessInitial) {
                DateTime now = DateTime.parse(state.result.dateTime!);
                DateFormat formatter = DateFormat('jm');
                String formatted = formatter.format(now);

                return Column(
                  children: [
                    Text(
                      state.result.timeZone!,
                      style: const TextStyle(
                        fontSize: NumberConstants.FONT_SIZE_30,
                        fontWeight: FontWeight.w600,
                        color: ColorConstants.MAIN_TEXT_COLOR,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      formatted,
                      style: const TextStyle(
                          fontSize: NumberConstants.FONT_SIZE_47,
                          fontWeight: FontWeight.w600,
                          color: ColorConstants.SECONDARY_TEXT_COLOR),
                    ),
                  ],
                );
              } else if (state is TimeTextFailedInitial) {
                return Center(
                  child: Text(state.error),
                );
              } else {
                return const SizedBox();
              }
            })
          ],
        ),
      ),
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}
