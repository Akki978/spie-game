import 'package:flutter/material.dart';
import 'package:mole/common/custom_border_raduis.dart';
import 'package:mole/size/size_config.dart';

class HomeContainer extends StatelessWidget {
  final IconData icon;
  final String name;
  final int index;
  final int count;
  const HomeContainer({
    super.key,
    required this.icon,
    required this.name,
    required this.index,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    final double squareSize = SizeConfig.w(145);
    return Container(
      height: squareSize,
      width: squareSize,
      decoration: BoxDecoration(
        color: index == 1 ? Colors.red : Colors.blue,
        borderRadius: customBorderRadius,
      ),
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.w(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, size: SizeConfig.w(50)),
              Text(
                '$count',
                style: TextStyle(
                  fontSize: SizeConfig.w(35),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: SizeConfig.h(15)),
          Text(name, style: TextStyle(fontSize: SizeConfig.w(20))),
          SizedBox(height: SizeConfig.h(15)),
        ],
      ),
    );
  }
}
