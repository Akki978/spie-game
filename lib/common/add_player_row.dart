import 'package:flutter/material.dart';
import 'package:mole/common/add_button.dart';
import 'package:mole/size/size_config.dart';

class AddPlayerRow extends StatelessWidget {
  final VoidCallback onPressedMinus;
  final VoidCallback onPressedPlus;
  final int value;
  const AddPlayerRow({
    super.key,
    required this.onPressedMinus,
    required this.onPressedPlus,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(onTap: onPressedMinus, child: AddButton(side: 0)),
        SizedBox(width: SizeConfig.w(5)),
        AddButton(value: value),
        SizedBox(width: SizeConfig.w(5)),
        GestureDetector(onTap: onPressedPlus, child: AddButton(side: 2)),
      ],
    );
  }
}
