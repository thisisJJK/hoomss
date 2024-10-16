import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:hoomss/data/word/word_data_type.dart';
import 'package:hoomss/data/word/word_model.dart';
import 'package:hoomss/ui/2/bomool_book/bomool_view_model.dart';
import 'package:hoomss/ui/2/quiz/quiz_view_model.dart';

class QuizCard extends StatelessWidget {
  final WordModel word;

  QuizCard({
    super.key,
    required this.word,
  });

  final BomoolViewModel bomoolViewModel = Get.put(BomoolViewModel());

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Obx(
        () => Container(
          height: 250,
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: border(),
            borderRadius: BorderRadius.circular(15),
            color: Colors.black12,
          ),
          child: Center(
            child: Text(
              word.eng,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 50,
              ),
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          //즐겨찾기 -> 보물 단어장
          onTap: () {
            var wordList = Get.find<BomoolViewModel>().wordList;
            int id = 1;
            if (wordList.isNotEmpty) {
              id = wordList.last.id + 1;
            }
            

            Get.find<QuizViewModel>().databaseService.insertBomoolWord(
                  WordModel(
                    id: id,
                    eng: word.eng,
                    kor: word.kor,
                    level: ModeType.bomool.toKo,
                  ),
                );

            Get.snackbar(
              '훔치기 성공!',
              '흐흐... 보물 단어장에서 확인해봐',
              snackPosition: SnackPosition.TOP,
              duration: const Duration(milliseconds: 1500),
              backgroundColor: Colors.white,
            );
          },
          child: const Align(
            alignment: Alignment.centerRight,
            child: Icon(
              FeatherIcons.folderPlus,
              color: Colors.black,
            ),
          ),
        ),
      ),
    ]);
  }

  BoxBorder? border() {
    bool isCorrect = Get.find<QuizViewModel>().isCorrect.value;
    bool isIncorrect = Get.find<QuizViewModel>().isIncorrect.value;
    if (isCorrect) {
      return Border.all(color: Colors.green);
    } else if (isIncorrect) {
      return Border.all(color: Colors.red);
    }
    return null;
  }
}
