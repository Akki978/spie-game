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
class AddSpy extends ConsumerWidget {
  final int oldSpy;
  AddSpy({super.key, required this.oldSpy});

  final ValueNotifier<String> isError = ValueNotifier('');

  bool notconfirm = true;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(modelProvider);
    final controller = ref.read(modelProvider.notifier);
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (notconfirm == true) {
          controller.setSpy(oldSpy);
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
                  Text('Spies', style: headingStyle),
                  SizedBox(height: SizeConfig.h(20)),
                  AddPlayerRow(
                    value: model.spy,
                    onPressedMinus: () {
                      if (model.spy == 1) {
                        HapticFeedback.vibrate();
                        isError.value = 'Minimum one spy';
                      } else {
                        isError.value = '';
                        controller.spyDecrement();
                      }
                    },
                    onPressedPlus: () {
                      if (model.spy + 1 > (model.players / 2)) {
                        isError.value = 'Maximum 50% of total players';
                        HapticFeedback.vibrate();
                      } else {
                        controller.spyIncrement();
                        isError.value = '';
                      }
                    },
                  ),
                  SizedBox(height: SizeConfig.h(10)),
                  ValueListenableBuilder(
                    valueListenable: isError,
                    builder: (context, value, child) {
                      return Text(
                        value,
                        style: TextStyle(
                          color: Colors.red,
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
