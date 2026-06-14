import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mole/common/common_strings.dart';
import 'package:mole/common/heading_style.dart';
import 'package:mole/pages/playing_page/playing_container.dart';
import 'package:mole/pages/playing_page/string.dart';
import 'package:mole/pages/timer_page/timer_page.dart';
import 'package:mole/size/size_config.dart';

class PlayingPage extends StatefulWidget {
  final int totalPlayers;
  final List<int> indexesList;
  final int totalSpies;
  final int minutes;
  final List<String> playersName;
  const PlayingPage({
    super.key,
    required this.totalPlayers,
    required this.indexesList,
    required this.totalSpies,
    required this.minutes,
    required this.playersName,
  });

  @override
  State<PlayingPage> createState() => _PlayingPageState();
}

class _PlayingPageState extends State<PlayingPage>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  ValueNotifier<bool> front = ValueNotifier(true);
  int currentPlayer = 1;
  late List<int> spy;
  late String word;
  String spiesNames = '';

  String getRandomWord() {
    Random random = Random();
    final int outerIndex = random.nextInt(widget.indexesList.length);
    final int outer = widget.indexesList[outerIndex];
    final int inner = random.nextInt(15);
    return wordCategories[outer][inner];
  }

  List<int> getSpyIndex() {
    List<int> spiesList = [];
    Random random = Random();
    while (spiesList.length < widget.totalSpies) {
      final int spyIndex = random.nextInt(widget.totalPlayers);
      if (!spiesList.contains(spyIndex)) {
        spiesNames += '${widget.playersName[spyIndex]}\n';
        spiesList.add(spyIndex + 1);
      }
    }

    return spiesList;
  }

  @override
  void initState() {
    super.initState();
    spy = getSpyIndex();
    word = getRandomWord();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    );
    animation = Tween<double>(
      begin: 0,
      end: pi,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.linear));

    controller.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        if (currentPlayer < widget.totalPlayers) {
          setState(() {
            currentPlayer++;
          });
        } else {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return TimerPage(
                  totalSeconds: widget.minutes * 60,
                  name: spiesNames,
                );
              },
            ),
          );
        }
      }
    });
  }

  bool get isFront {
    return animation.value < pi / 2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.playersName[currentPlayer - 1], style: headingStyle),
            SizedBox(height: SizeConfig.h(35)),
            AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(-animation.value),

                  child: Stack(
                    children: [
                      // Back
                      Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()..rotateY(pi),
                        child: Opacity(
                          opacity: isFront ? 0.0 : 1.0,
                          child: PlayingContainer(
                            playingChild: Text(
                              spy.contains(currentPlayer) ? spyString : word,
                              style: TextStyle(
                                fontSize: SizeConfig.w(26),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            color: Colors.black,
                          ),
                        ),
                      ),

                      // Front
                      Opacity(
                        opacity: isFront ? 1.0 : 0.0,
                        child: GestureDetector(
                          onTap: () {
                            if (controller.isCompleted) {
                              controller.reverse();

                              front.value = true;
                            } else if (controller.isDismissed) {
                              controller.forward();
                              front.value = false;
                            }
                          },
                          child: PlayingContainer(
                            playingChild: Image.asset(spyLogo),
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: SizeConfig.h(35)),
            Icon(Icons.touch_app, size: SizeConfig.w(45)),
            ValueListenableBuilder(
              valueListenable: front,
              builder: (context, value, child) {
                return SizedBox(
                  width: SizeConfig.w(150),
                  child: value
                      ? Text(
                          'Tap to show the place that the spy will be guessing',
                          textAlign: TextAlign.center,
                        )
                      : Text(
                          'Tap again to hide your card and pass the phone',
                          textAlign: TextAlign.center,
                        ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
