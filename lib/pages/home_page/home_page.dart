import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mole/common/controller.dart';
import 'package:mole/common/custom_button.dart';
import 'package:mole/common/heading_style.dart';
import 'package:mole/common/navigation.dart';
import 'package:mole/common/padding.dart';
import 'package:mole/pages/add_player/add_player_page.dart';
import 'package:mole/pages/add_spy/add_spy.dart';
import 'package:mole/pages/home_page/home_container.dart';
import 'package:mole/pages/playing_page/playing_page.dart';
import 'package:mole/pages/sections_page/section_page.dart';
import 'package:mole/pages/timer_page/add_timer.dart';
import 'package:mole/size/size_config.dart';
import 'package:country_flags/country_flags.dart';
import 'package:mole/tutorial/tutorial.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(modelProvider);
    List<Widget> homeContainerList = [
      HomeContainer(
        icon: Icons.groups,
        name: 'Players',
        index: 0,
        count: model.players,
      ),
      HomeContainer(
        icon: Icons.person_search_outlined,
        name: 'Spy',
        index: 1,
        count: model.spy,
      ),
      HomeContainer(
        icon: Icons.timer,
        name: 'Timer',
        index: 1,
        count: model.minutes,
      ),
      HomeContainer(
        icon: Icons.folder_open,
        name: 'Sections',
        index: 0,
        count: model.sections.length,
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: customPadding,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CountryFlag.fromCountryCode(
                  'US',
                  height: SizeConfig.h(35),
                  shape: RoundedRectangle(SizeConfig.w(5)),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            TutorialPage(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                              return SlideTransition(
                                position: Tween<Offset>(
                                  begin: Offset(1, 0),
                                  end: Offset.zero,
                                ).animate(animation),
                                child: child,
                              );
                            },
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: BoxBorder.all(color: Colors.white),
                    ),
                    child: Icon(Icons.question_mark, size: SizeConfig.w(30)),
                  ),
                ),
              ],
            ),
            SizedBox(height: SizeConfig.h(60)),
            Text('Configuration', style: headingStyle),
            SizedBox(
              height: SizeConfig.h(365),
              child: GridView.builder(
                itemCount: homeContainerList.length,

                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: SizeConfig.w(15),
                  crossAxisSpacing: SizeConfig.w(15),
                ),
                itemBuilder: (context, index) {
                  final oldPlayers = model.players;
                  final List<int> oldList = model.sections;
                  final spy = model.spy;
                  final minutes = model.minutes;
                  final oldPlayersName = model.playersName;

                  List<Widget> homeContainersList = [
                    AddPlayer(
                      oldPlayers: oldPlayers,
                      oldPlayersName: oldPlayersName,
                    ),
                    AddSpy(oldSpy: spy),
                    AddTimer(oldTimer: minutes),
                    SectionPage(oldList: oldList),
                  ];
                  Widget child = homeContainersList[index];

                  return GestureDetector(
                    onTap: () {
                      customNavigation(context, child);
                    },
                    child: homeContainerList[index],
                  );
                },
              ),
            ),
            CustomButton(
              onPressed: () {
                customNavigation(
                  context,
                  PlayingPage(
                    totalPlayers: model.players,
                    indexesList: model.sections,
                    totalSpies: model.spy,
                    minutes: model.minutes,
                    playersName: model.playersName,
                  ),
                );
              },
              name: 'Play',
            ),
          ],
        ),
      ),
    );
  }
}
