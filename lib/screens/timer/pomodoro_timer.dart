import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pomodoro/utils/vibration_manager.dart';
import 'package:pomodoro/widgets/button.dart';

enum PomodoroStatus { work, rest }

class PomodoroTimer extends StatefulWidget {
  const PomodoroTimer({super.key});

  @override
  State<PomodoroTimer> createState() => _PomodoroTimerState();
}

class _PomodoroTimerState extends State<PomodoroTimer> {
  Timer? controller;
  late Duration _timeLeft = _workDuration;
  PomodoroStatus? _status = PomodoroStatus.work;
  Duration _workDuration = const Duration(seconds: 10);
  Duration _restDuration = const Duration(seconds: 5);

  void _iteratePomodoro() {
    if (_status == PomodoroStatus.rest) {
      _status = PomodoroStatus.work;
      _timeLeft = _workDuration;
    } else {
      _timeLeft = _restDuration;
      _status = PomodoroStatus.rest;
    }
    controller?.cancel();
    setState(() {});
    VibrationManager.vibrate();
  }

  void _handleTimerUpdate(Timer timer) {
    if (_timeLeft.inSeconds <= 0) {
      _iteratePomodoro();
      return;
    }
    _timeLeft -= const Duration(seconds: 1);
    setState(() {});
  }

  String _format(int data) => data.toString().padLeft(2, '0');

  void _onStart() {
    controller = Timer.periodic(
      const Duration(seconds: 1),
      _handleTimerUpdate,
    );
    setState(() {});
  }

  void _onPause() {
    controller?.cancel();
    setState(() {});
  }

  void _onReset() {
    _timeLeft = _workDuration;
    controller?.cancel();
    _onPause();
  }

  void _onConfigure() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(),
    );
  }

  Widget _buildTitle() {
    final text = _status == PomodoroStatus.work
        ? 'Your work time'
        : 'Time to take a rest';

    return SizedBox(
      height: 60,
      child: Row(
        children: [
          Expanded(
            child: FittedBox(
              fit: BoxFit.fitHeight,
              child: Text(text,
                  style: const TextStyle(fontWeight: FontWeight.w300)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final minutes = (_timeLeft.inSeconds / 60).floor();
    final seconds = _timeLeft.inSeconds - minutes * 60;
    final isActive = controller?.isActive ?? false;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildTitle(),
          Text(
            '${_format(minutes)}:${_format(seconds)}',
            style: const TextStyle(fontWeight: FontWeight.w200, fontSize: 120),
          ),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Button(
                  text: isActive ? 'Pause' : 'Start',
                  onTap: isActive ? _onPause : _onStart,
                  buttonColor: isActive ? null : Colors.green,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Button(
                  text: 'Reset',
                  onTap: _onReset,
                  buttonColor: Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Button(
                  text: 'Configure',
                  onTap: _onConfigure,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
