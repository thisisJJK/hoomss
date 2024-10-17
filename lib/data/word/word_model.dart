class WordModel {
  final int id;
  final String eng;
  final String kor;
  final String level;
  final int? correct;

  WordModel({
    required this.id,
    required this.eng,
    required this.kor,
    required this.level,
    this.correct,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'eng': eng,
      'kor': kor,
      'level': level,
      'correct': correct,
    };
  }

  factory WordModel.fromMap(Map<String, dynamic> map) {
    return WordModel(
      id: map['id'],
      eng: map['eng'],
      kor: map['kor'],
      level: map['level'],
      correct: map['correct'],
    );
  }

  @override
  String toString() {
    return 'WordModel{id:$id, eng: $eng, kor: $kor, level: $level,correct:$correct}';
  }
}
