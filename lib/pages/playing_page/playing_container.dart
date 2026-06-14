import 'package:flutter/material.dart';
import 'package:mole/pages/playing_page/corner_painter.dart';
import 'package:mole/size/size_config.dart';

class PlayingContainer extends StatelessWidget {
  final Widget playingChild;
  final Color color;
  const PlayingContainer({
    super.key,
    required this.playingChild,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CornerPainter(),
      child: Container(
        height: SizeConfig.h(265),
        width: SizeConfig.w(265),
        decoration: BoxDecoration(color: color),
        child: Center(child: playingChild),
      ),
    );
  }
}
