import 'dart:async';
import 'package:flutter/material.dart';

class CountdownTimerWidget extends StatefulWidget {
  final int initialMinutes;
  final String endText;
  final Function onTimerEnd;
  final Color countDownTimerColor;

  const CountdownTimerWidget({
    super.key,
    required this.initialMinutes,
    required this.endText,
    required this.onTimerEnd,
    required this.countDownTimerColor,
  });

  @override
  CountdownTimerWidgetState createState() => CountdownTimerWidgetState();

  static Widget create({
    required int initialMinutes,
    required String endText,
    required Function onTimerEnd,
    required Color countDownTimerColor,
  }) {
    return CountdownTimerWidget(
      initialMinutes: initialMinutes,
      endText: endText,
      onTimerEnd: onTimerEnd,
      countDownTimerColor: countDownTimerColor,
    );
  }
}

class CountdownTimerWidgetState extends State<CountdownTimerWidget>
    with TickerProviderStateMixin {
  late int remainingTime;
  late Timer timer;
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  bool showEndText = false;

  @override
  void initState() {
    super.initState();

    startTimerWithInitialMinutes();
  }

  ///////////////////////////////////////////////
  void startTimerWithInitialMinutes() {
    remainingTime = widget.initialMinutes * 60;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _opacityAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        remainingTime--;

        // Check if countdown is complete
        if (remainingTime == 0) {
          timer.cancel();
          widget.onTimerEnd();

          // Trigger the flashing animation for one minute
          _controller.repeat(reverse: true);
          Timer(const Duration(minutes: 1), () {
            _controller.reset();
            setState(() {
              showEndText = false;
            });
          });

          setState(() {
            showEndText = true;
          });
        }
      });
    });
  }

  ////////////////////////////////////////////////
  @override
  void didUpdateWidget(covariant CountdownTimerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Check if initialMinutes has changed, and restart the timer
    if (widget.initialMinutes != oldWidget.initialMinutes) {
      timer.cancel();
      startTimerWithInitialMinutes();
    }
  }

  @override
  Widget build(BuildContext context) {
    final hours = remainingTime ~/ 3600;
    final minutes = (remainingTime % 3600) ~/ 60;
    final seconds = remainingTime % 60;

    return Center(
        child: !showEndText
            ? CountdownSegment(
                hours: hours,
                minutes: minutes,
                seconds: seconds,
                countDownTimerColor: widget.countDownTimerColor)
            : AnimatedBuilder(
                animation: _opacityAnimation,
                builder: (context, child) {
                  return Opacity(
                    opacity: _opacityAnimation.value,
                    child: Text(
                      widget.endText,
                      style: TextStyle(
                        height: 1,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: widget.countDownTimerColor,
                      ),
                    ),
                  );
                },
              ));
  }

  @override
  void dispose() {
    timer.cancel();
    _controller.dispose();
    super.dispose();
  }
}

class CountdownSegment extends StatelessWidget {
  final int hours;
  final int minutes;
  final int seconds;
  final Color countDownTimerColor;

  const CountdownSegment(
      {super.key,
      required this.hours,
      required this.minutes,
      required this.seconds,
      required this.countDownTimerColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
          style: TextStyle(
            height: 1,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: countDownTimerColor,
          ),
        ),
        Text(
          'باقي على',
          style: TextStyle(
            height: 1,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: countDownTimerColor,
          ),
        )
      ],
    );
  }
}
