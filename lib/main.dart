import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:show_time/bloc/time/time_time_bloc.dart';
import 'package:show_time/bloc/time/time_clock_bloc.dart';
import 'package:show_time/constants/colors.dart';
import 'package:show_time/constants/number.dart';
import 'package:show_time/constants/strings.dart';
import 'package:show_time/presentation/clock_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TimeClockBloc>(create: (context) => TimeClockBloc(),),
        BlocProvider<TimeTextBloc>(create: (context) => TimeTextBloc(),),
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: StringConstants.MAIN_FONT_APP_NAME,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = NumberConstants.CURRENT_INDEX_0;
  final List<Widget> _tabs = [
    const ClockScreen(),
    const Center(child: Text('LIST'),),
    const Center(child: Text('SETTINGS'),),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _tabs[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: ColorConstants.ICON_SELECTED_COLOR_BLACK,
        selectedLabelStyle: const TextStyle(fontSize: NumberConstants.SELECTED_FONT_SIZE_14, fontWeight: FontWeight.bold),
        unselectedItemColor: ColorConstants.ICON_UNSELECTED_COLOR_GREY,
        unselectedLabelStyle: const TextStyle(fontSize: NumberConstants.SELECTED_FONT_SIZE_14, fontWeight: FontWeight.bold),
        elevation: NumberConstants.BOTTOM_NAVIGATION_BAR_ELEVATION_0,
        iconSize: NumberConstants.ICON_SIZE_30,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.alarm_rounded),
            label: StringConstants.BOTTOM_NAVIGATION_BAR_CLOCK_LABEL,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_rounded),
            label: StringConstants.BOTTOM_NAVIGATION_BAR_LIST_LABEL,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: StringConstants.BOTTOM_NAVIGATION_BAR_SETTINGS_LABEL,
          )
        ],
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
      ),
    );
  }
}
