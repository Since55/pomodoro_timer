import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pomodoro/screens/timer/pomodoro_timer.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pomodoro'),
      ),
      body: SafeArea(
        child: Column(
          children: const [
            SizedBox(height: 25),
            PomodoroTimer(),
          ],
        ),
      ),
    );
  }
}
