class Model {
  final int players;
  final int spy;
  final String word;
  final List<int> sections;
  final int minutes;
  final List<String> playersName;

  Model({
    required this.players,
    required this.spy,
    required this.word,
    required this.sections,
    required this.minutes,
    required this.playersName,
  });

  Model copyWith({
    int? players,
    int? spy,
    String? word,
    List<int>? sections,
    int? minutes,
    List<String>? playersName,
  }) {
    return Model(
      players: players ?? this.players,
      spy: spy ?? this.spy,
      word: word ?? this.word,
      sections: sections ?? this.sections,
      minutes: minutes ?? this.minutes,
      playersName: playersName ?? this.playersName,
    );
  }
}
