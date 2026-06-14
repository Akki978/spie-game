import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mole/common/add_player_row.dart';
import 'package:mole/common/controller.dart';
import 'package:mole/common/custom_button.dart';
import 'package:mole/common/heading_style.dart';
import 'package:mole/common/padding.dart';
import 'package:mole/common/player_field.dart';
import 'package:mole/size/size_config.dart';

// ignore: must_be_immutable
class AddPlayer extends ConsumerWidget {
  final int oldPlayers;
  final List<String> oldPlayersName;
  AddPlayer({
    super.key,
    required this.oldPlayers,
    required this.oldPlayersName,
  });

  final ValueNotifier<bool> isError = ValueNotifier(false);

  bool notconfirm = true;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(modelProvider);
    final controller = ref.read(modelProvider.notifier);
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (notconfirm == true) {
          controller.setPlayers(oldPlayers, oldPlayersName);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: customPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Players', style: headingStyle),
              SizedBox(height: SizeConfig.h(20)),
              AddPlayerRow(
                value: model.players,
                onPressedMinus: () {
                  if (model.players == 3) {
                    HapticFeedback.vibrate();
                    isError.value = true;
                  } else {
                    controller.playerDecrement();
                  }
                },
                onPressedPlus: () {
                  isError.value = false;
                  controller.playerIncrement();
                },
              ),
              SizedBox(height: SizeConfig.h(10)),
              ValueListenableBuilder(
                valueListenable: isError,
                builder: (context, value, child) {
                  return Text(
                    'Mininum 3 players required',
                    style: TextStyle(
                      color: isError.value == true
                          ? Colors.red
                          : Colors.transparent,
                      fontSize: SizeConfig.w(12),
                    ),
                  );
                },
              ),
              SizedBox(height: SizeConfig.h(10)),
              SizedBox(
                height: SizeConfig.h(250),
                child: ListView.builder(
                  itemCount: model.playersName.length,
                  itemBuilder: (context, index) {
                    final name = model.playersName[index];
                    final fieldController = TextEditingController();
                    fieldController.text = name;
                    return Column(
                      children: [
                        PlayerField(
                          controller: fieldController,
                          onPressed: () {
                            controller.changePlayerName(
                              index,
                              fieldController.text.trim() == ''
                                  ? name
                                  : fieldController.text.trim(),
                            );
                          },
                        ),
                        SizedBox(height: SizeConfig.h(10)),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: SizeConfig.h(20)),
              CustomButton(
                onPressed: () {
                  notconfirm = false;
                  Navigator.pop(context);
                },
                name: 'Confirm',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
