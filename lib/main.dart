import 'package:flutter/material.dart';
import 'package:pomodoro_app/screens/timer_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: TimerScreen.id,
      routes: {
        TimerScreen.id: (context)=>TimerScreen(),
      },
    );
  }
}