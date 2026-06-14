import 'package:flutter/material.dart';
import 'package:mole/common/custom_border_raduis.dart';
import 'package:mole/common/heading_style.dart';

class SectionContainer extends StatelessWidget {
  final Color color;
  final String text;
  const SectionContainer({super.key, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: customBorderRadius, color: color),
      child: Center(child: Text(text, style: headingStyle)),
    );
  }
}
