import 'package:flutter/material.dart';
import 'package:mole/common/custom_border_raduis.dart';
import 'package:mole/size/size_config.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String name;
  const CustomButton({super.key, required this.onPressed, required this.name});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: Size(SizeConfig.screenWidth, SizeConfig.h(45)),
        backgroundColor: Colors.purpleAccent,
        foregroundColor: Colors.white,
        shape: ContinuousRectangleBorder(borderRadius: customBorderRadius),
      ),
      child: Text(name, style: TextStyle(fontSize: SizeConfig.w(20))),
    );
  }
}
