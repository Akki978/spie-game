import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mole/common/common_strings.dart';
import 'package:mole/common/controller.dart';
import 'package:mole/common/custom_button.dart';
import 'package:mole/common/heading_style.dart';
import 'package:mole/common/padding.dart';
import 'package:mole/pages/sections_page/section_container.dart';
import 'package:mole/size/size_config.dart';

// ignore: must_be_immutable
class SectionPage extends ConsumerWidget {
  final List<int> oldList;
  SectionPage({super.key, required this.oldList});

  bool notconfirm = true;
  ValueNotifier<bool> isError = ValueNotifier(false);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(modelProvider);
    final controller = ref.read(modelProvider.notifier);
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (notconfirm == true) {
          controller.setSections(oldList);
        }
      },
      child: Scaffold(
        body: Padding(
          padding: customPadding,
          child: Stack(
            children: [
              Text('Select', style: headingStyle),
              Align(
                alignment: Alignment.topCenter,
                child: ValueListenableBuilder(
                  valueListenable: isError,
                  builder: (context, value, child) {
                    return Padding(
                      padding: EdgeInsets.only(top: SizeConfig.h(60)),
                      child: Text(
                        'Atleast select one section',
                        style: TextStyle(
                          color: isError.value == true
                              ? Colors.red
                              : Colors.transparent,
                          fontSize: SizeConfig.w(12),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 5 * 90,
                  child: GridView.builder(
                    itemCount: getSections.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: SizeConfig.w(15),
                      crossAxisSpacing: SizeConfig.w(15),
                      childAspectRatio: SizeConfig.w(1.2),
                    ),
                    itemBuilder: (context, index) {
                      final word = getSections[index];
                      return GestureDetector(
                        onTap: () {
                          if (model.sections.length == 1 &&
                              index == model.sections[0]) {
                            HapticFeedback.vibrate();
                            isError.value = true;
                          } else {
                            isError.value = false;
                            controller.addOrDeleteSections(index);
                          }
                        },
                        child: SectionContainer(
                          color: model.sections.contains(index)
                              ? Colors.blue
                              : Colors.blueGrey,
                          text: word,
                        ),
                      );
                    },
                  ),
                ),
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
