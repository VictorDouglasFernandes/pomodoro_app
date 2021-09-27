import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro_app/utils/constants.dart';

class TimerScreen extends StatefulWidget {
  static final id = 'timer_screen';

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  Timer timer;

  bool isRunning = false;

  int _seconds = 0;
  int _minutes = 0;

  void callbackTimer(Timer timer) {
    if (_seconds > 0) {
      setState(() {
        _seconds--;
      });
    }
    if (_seconds <= 0 && _minutes > 0) {
      setState(() {
        _seconds = 59;
        _minutes--;
      });
    }
    if (_seconds <= 0 && _minutes <= 0) {
      timer.cancel();
    }
    print('minutes: $_minutes seconds: $_seconds');
  }

  String formatText(int minutes, int seconds) {
    String formatedMinutes = minutes.toString();
    String formatedSeconds = seconds.toString();
    if (minutes < 10) {
      formatedMinutes = '0' + minutes.toString();
    }
    if (seconds < 10) {
      formatedSeconds = '0' + seconds.toString();
    }
    return formatedMinutes + ":" + formatedSeconds;
  }

  Widget iconFab() {
    Widget icon;
    if(isRunning) {
      icon = Icon(
        Icons.pause,
        color: kColorTen,
      );
    }else{
      icon = Icon(
        Icons.play_arrow,
        color: kColorTen,
      );
    }
    return icon;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorTen,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: iconFab(),
        backgroundColor: kColorOne,
        splashColor: kColorSix,
        onPressed: () {
          if(!isRunning) {
            timer = Timer.periodic(Duration(seconds: 1), callbackTimer);
          }else{
            timer.cancel();
          }
          setState(() {
            isRunning = !isRunning;
          });
        },
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                formatText(_minutes, _seconds),
                style: TextStyle(
                  fontSize: 60,
                  color: kColorOne,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: kColorOne,
        shape: CircularNotchedRectangle(),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                splashRadius: 26,
                splashColor: kColorSix,
                icon: Icon(
                  Icons.menu_book,
                  size: 30,
                  color: kColorTen,
                ),
                onPressed: () {
                  setState(() {
                    _minutes = 25;
                    _seconds = 0;
                  });
                },
              ),
              IconButton(
                splashRadius: 26,
                splashColor: kColorSix,
                icon: Icon(
                  Icons.snooze,
                  size: 30,
                  color: kColorTen,
                ),
                onPressed: () {
                  setState(() {
                    _minutes = 5;
                    _seconds = 0;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
