import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoomss/data/word/word_data_type.dart';
import 'package:hoomss/data/word/word_model.dart';
import 'package:hoomss/ui/2/wrong_book/wrong_view_model.dart';

Widget delDialog(WordModel word) {
  return AlertDialog(
    title: const Text("이 단어를 삭제하시겠습니까?"),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {
                if (word.level != ModeType.bomool.toKo) {
                  Get.find<WrongViewModel>().databaseService.insertWord(word);
                }
                Get.find<WrongViewModel>()
                    .databaseService
                    .deleteWrongWord(word.id)
                    .then(
                  (result) {
                    if (result) {
                      Get.find<WrongViewModel>().readWrongWordList();
                      Get.back();
                    } else {
                      print("delete error");
                    }
                  },
                );
              },
              child: const Text("예"),
            ),
            ElevatedButton(
              onPressed: () => Get.back(),
              child: const Text("아니오"),
            ),
          ],
        ),
      ],
    ),
  );
}
