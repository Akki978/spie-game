import 'package:flutter/material.dart';
import 'package:mole/common/custom_border_raduis.dart';
import 'package:mole/size/size_config.dart';

class PlayerField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onPressed;
  const PlayerField({
    super.key,
    required this.controller,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder border() {
      return OutlineInputBorder(
        borderRadius: customBorderRadius,
        borderSide: BorderSide(width: SizeConfig.w(0.5), color: Colors.grey),
      );
    }

    return TextField(
      controller: controller,
      cursorColor: Colors.purpleAccent,

      onSubmitted: (value) => onPressed(),
      decoration: InputDecoration(
        border: border(),
        enabledBorder: border(),
        focusedBorder: border(),
      ),
    );
  }
}
