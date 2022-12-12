import 'package:flutter/material.dart';
import 'package:pomodoro/core/app_theme.dart';
import 'package:pomodoro/screens/timer/timer_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro',
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
      home: const TimerScreen(),
    );
  }
}
