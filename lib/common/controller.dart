import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mole/common/common_strings.dart';
import 'package:mole/common/model.dart';

final modelProvider = StateNotifierProvider<Controller, Model>((ref) {
  return Controller(
    Model(
      players: 3,
      spy: 1,
      word: '',
      sections: List.generate(getSections.length, (index) {
        return index;
      }),
      minutes: 4,
      playersName: List.generate(3, (index) {
        return 'Player #${index + 1}';
      }),
    ),
  );
});

class Controller extends StateNotifier<Model> {
  Controller(super.state);

  void playerIncrement() {
    List<String> tempList = state.playersName;
    tempList.add('Players #${state.playersName.length + 1}');
    state = state.copyWith(players: state.players + 1, playersName: tempList);
  }

  void playerDecrement() {
    List<String> tempList = state.playersName;
    tempList.removeLast();
    state = state.copyWith(players: state.players - 1, playersName: tempList);
  }

  void setPlayers(int oldPlayers, List<String> oldPlayersName) {
    state = state.copyWith(players: oldPlayers, playersName: oldPlayersName);
  }

  void changePlayerName(int index, String newName) {
    List<String> tempList = state.playersName;
    tempList[index] = newName;
    state = state.copyWith(playersName: tempList);
  }

  void spyIncrement() {
    state = state.copyWith(spy: state.spy + 1);
  }

  void spyDecrement() {
    state = state.copyWith(spy: state.spy - 1);
  }

  void setSpy(int oldSpy) {
    state = state.copyWith(spy: oldSpy);
  }

  void minutesIncrement() {
    state = state.copyWith(minutes: state.minutes + 1);
  }

  void minutesDecrement() {
    state = state.copyWith(minutes: state.minutes - 1);
  }

  void setMinutes(int oldminutes) {
    state = state.copyWith(minutes: oldminutes);
  }

  void setSections(List<int> oldSection) {
    state = state.copyWith(sections: oldSection);
  }

  void addOrDeleteSections(int index) {
    List<int> tempList = state.sections;
    if (tempList.contains(index)) {
      tempList.remove(index);
    } else {
      tempList.add(index);
    }
    state = state.copyWith(sections: tempList);
  }
}
