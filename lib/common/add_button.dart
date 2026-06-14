import 'package:flutter/material.dart';
import 'package:mole/size/size_config.dart';

class AddButton extends StatelessWidget {
  final int side;
  final int value;
  const AddButton({super.key, this.side = 1, this.value = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.h(50),
      width: SizeConfig.w(50),
      decoration: BoxDecoration(
        color: side == 1 ? Colors.deepPurple : Colors.purpleAccent,
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(SizeConfig.w(side == 0 ? 40 : 0)),
          right: Radius.circular(SizeConfig.w(side == 2 ? 40 : 0)),
        ),
      ),

      child: Center(
        child: side == 1
            ? Text(
                '$value',
                style: TextStyle(
                  fontSize: SizeConfig.w(22),
                  fontWeight: FontWeight.bold,
                ),
              )
            : side == 0
            ? Icon(Icons.remove)
            : Icon(Icons.add),
      ),
    );
  }
}
