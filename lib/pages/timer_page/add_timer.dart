import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mole/common/add_player_row.dart';
import 'package:mole/common/controller.dart';
import 'package:mole/common/custom_button.dart';
import 'package:mole/common/heading_style.dart';
import 'package:mole/common/padding.dart';
import 'package:mole/size/size_config.dart';

// ignore: must_be_immutable
class AddTimer extends ConsumerWidget {
  final int oldTimer;
  AddTimer({super.key, required this.oldTimer});

  final ValueNotifier<bool> isError = ValueNotifier(false);

  bool notconfirm = true;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(modelProvider);
    final controller = ref.read(modelProvider.notifier);
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (notconfirm == true) {
          controller.setMinutes(oldTimer);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: customPadding,
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Timer (Minutes)', style: headingStyle),
                  SizedBox(height: SizeConfig.h(20)),
                  AddPlayerRow(
                    value: model.minutes,
                    onPressedMinus: () {
                      if (model.minutes == 1) {
                        HapticFeedback.vibrate();
                        isError.value = true;
                      } else {
                        controller.minutesDecrement();
                      }
                    },
                    onPressedPlus: () {
                      controller.minutesIncrement();
                      isError.value = false;
                    },
                  ),
                  SizedBox(height: SizeConfig.h(10)),
                  ValueListenableBuilder(
                    valueListenable: isError,
                    builder: (context, value, child) {
                      return Text(
                        'At least one minute',
                        style: TextStyle(
                          color: value ? Colors.red : Colors.transparent,
                          fontSize: SizeConfig.w(12),
                        ),
                      );
                    },
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: CustomButton(
                  onPressed: () {
                    notconfirm = false;
                    Navigator.pop(context);
                  },
                  name: 'Confirm',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
