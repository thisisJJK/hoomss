import 'dart:convert';

import 'package:flutter/services.dart';

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

//json -> WordModel
  factory WordModel.fromMap(Map<String, dynamic> map, int id, String level) {
    return WordModel(
      id: id,
      eng: map['eng'],
      kor: map['kor'],
      level: level,
      correct: 0,
    );
  }

  @override
  String toString() {
    return 'WordModel{id:$id, eng: $eng, kor: $kor, level: $level,correct:$correct}';
  }
}

Future<List<WordModel>> parseWords() async {
  String jsonString = await rootBundle.loadString('assets/words.json');
  Map<String, dynamic> jsonData = jsonDecode(jsonString);

  List<WordModel> wordsList = [];
  int idCount = 0;

  jsonData.forEach(
    (level, wordsListData) {
      for (var wordData in wordsListData) {
        wordsList.add(WordModel.fromMap(wordData, idCount++, level));
      }
    },
  );

  return wordsList;
}
