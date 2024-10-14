import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoomss/data/database_service.dart';
import 'package:hoomss/data/model/word_model.dart';

class QuizViewModel extends GetxController {
  late final FocusNode focusNode = FocusNode();

  var questions = <WordModel>[].obs;
  var currentIndex = 0.obs;
  var isCorrect = false.obs;
  var choices = <String>[].obs;

  int count = 5;

  final DatabaseService databaseService = Get.put(DatabaseService());

  @override
  void onClose() {
    focusNode.dispose();
    super.onClose();
  }

  Future<void> loadRandomWords(String level, int count) async {
    var randomWords = await databaseService
        .databaseConfig()
        .then((_) => databaseService.getRandomWords(level, count));

    for (int i = 0; i < count; i++) {
      questions.insert(i, randomWords[i]);
    }
    currentIndex.value = 0;
    await setChoices();
  }

  Future<void> setChoices() async {
    var allWords = await databaseService
        .databaseConfig()
        .then((_) => databaseService.readWords());
    if (questions.isEmpty) return;

    final correctAns = questions[currentIndex.value].kor;
    final incorrectAns = allWords
        .where((words) => words.kor != correctAns)
        .map((words) => words.kor)
        .toList();

    incorrectAns.shuffle(Random());
    var selectedIncorrectAns = incorrectAns.take(1).toList();

    choices.assignAll([correctAns, ...selectedIncorrectAns]);
    choices.shuffle(Random());
  }

  void nextQuestion(String level, int count) {
    if (currentIndex.value == questions.length - 1) {
      return oneMoreDialog(level, count);
    }
    if (currentIndex.value < questions.length - 1) {
      currentIndex.value++;
    }

    setChoices();
  }

  void oneMoreDialog(String level, int count) {
    Get.dialog(
      AlertDialog(
        title: const Text("흐흐.. 흥미진진하구만"),
        content: const Text("한번 더 훔쳐볼래?"),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              Get.back(); // 다이얼로그 닫기
            },
            child: const Text("아니요"),
          ),
          TextButton(
            onPressed: () {
              questions.value = [];
              choices.value = [];
              currentIndex.value = 0;

              loadRandomWords(level, count);
              Get.back();
            }, // 다이얼로그 닫기
            child: const Text("한번더"),
          ),
        ],
      ),
    );
  }
}
