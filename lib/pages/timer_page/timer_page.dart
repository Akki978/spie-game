import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mole/common/custom_button.dart';
import 'package:mole/common/padding.dart';
import 'package:mole/size/size_config.dart';
import 'package:vibration/vibration.dart';

class TimerPage extends StatefulWidget {
  final int totalSeconds;
  final String name;
  const TimerPage({super.key, required this.totalSeconds, required this.name});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  late int remainingSeconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _startCountdown();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  _startCountdown() {
    remainingSeconds = widget.totalSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (remainingSeconds == -1) {
        if (await Vibration.hasVibrator()) {
          Vibration.vibrate(duration: 1000);
        }
        timer.cancel();
      } else {
        setState(() {
          remainingSeconds--;
        });
      }
    });
  }

  Widget get _formattedTime {
    if (remainingSeconds == -1) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Time\'s over', style: TextStyle(fontSize: SizeConfig.w(55))),
          Text(
            'Spies\n${widget.name}',
            style: TextStyle(
              fontSize: SizeConfig.w(20),
              color: Colors.purpleAccent,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }
    final minutes = (remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (remainingSeconds % 60).toString().padLeft(2, '0');

    return Text(
      '$minutes:$seconds',
      style: TextStyle(fontSize: SizeConfig.w(55)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: customPadding,
        child: Stack(
          children: [
            Align(alignment: Alignment.center, child: _formattedTime),
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                name: 'New Game',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
