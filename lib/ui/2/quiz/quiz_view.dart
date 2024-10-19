import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:hoomss/data/word/word_data_type.dart';
import 'package:hoomss/ui/2/bomool_book/bomool_view_model.dart';
import 'package:hoomss/ui/2/quiz/quiz_view_model.dart';
import 'package:hoomss/ui/2/quiz/widget/answer_btn.dart';
import 'package:hoomss/ui/2/quiz/widget/answer_field.dart';
import 'package:hoomss/ui/2/quiz/widget/quiz_card.dart';
import 'package:hoomss/ui/2/word/word_view_model.dart';
import 'package:hoomss/ui/2/wrong_book/wrong_view_model.dart';

class QuizView extends StatelessWidget {
  final String level;
  final String mode;

  QuizView({
    super.key,
    required this.mode,
    required this.level,
  });

  final QuizViewModel quizViewModel = Get.put(QuizViewModel());
  final BomoolViewModel bomoolViewModel = Get.put(BomoolViewModel());
  final WrongViewModel wrongViewModel = Get.put(WrongViewModel());
  final WordViewModel wordViewModel = Get.put(WordViewModel());

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    quizViewModel.loadRandomWords(
        mode, quizViewModel.count, quizViewModel.loadByTable(mode));

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: appbar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Obx(() {
          if (quizViewModel.questions.isEmpty ||
              quizViewModel.choices.isEmpty) {
            return const Center(
              child: Text(
                '나만의 단어로 퀴즈를 풀어보세요',
                style: TextStyle(
                  fontSize: 21,
                ),
              ),
            );
          }
          var currentWord =
              quizViewModel.questions[quizViewModel.currentIndex.value];

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //랜덤 20문제 문구
              const Text(
                '🔥랜덤 20문제🔥',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),

              //단어 카드
              QuizCard(
                word: currentWord,
              ),
              const SizedBox(height: 12),

              //보기 버튼 2개
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //보기 1번
                  AnswerBtn(
                    text: quizViewModel.choices[0],
                    onTap: () {
                      if (currentWord.kor == quizViewModel.choices[0] &&
                          currentWord.eng == controller.text) {
                        //정답
                        quizViewModel.isCorrect.value = true;
                        quizViewModel.databaseService
                            .updateIsCorrectedWord(currentWord);
                        wordViewModel.loadData();

                        controller.clear();
                        Timer(const Duration(milliseconds: 444), () {
                          quizViewModel.isSame.value = false;
                          quizViewModel.isCorrect.value = false;
                          quizViewModel.nextQuestion(level, quizViewModel.count,
                              quizViewModel.loadByTable(mode));
                        });
                      } else if (currentWord.kor != quizViewModel.choices[0] &&
                          currentWord.eng == controller.text) {
                        //오답
                        quizViewModel.incorrectCount++;

                        quizViewModel.databaseService
                            .insertWrongWord(currentWord);
                        wordViewModel.loadData();
                        if (mode != ModeType.bomool.toKo) {
                          quizViewModel.databaseService
                              .deleteWord(currentWord.id);
                        }
                        controller.clear();
                        quizViewModel.isIncorrect.value = true;
                        Timer(
                          const Duration(milliseconds: 444),
                          () {
                            quizViewModel.isIncorrect.value = false;
                            quizViewModel.isSame.value = false;

                            quizViewModel.nextQuestion(
                                level,
                                quizViewModel.count,
                                quizViewModel.loadByTable(mode));
                          },
                        );
                      }
                    },
                  ),
                  const SizedBox(width: 5),

                  //보기 2번
                  AnswerBtn(
                    text: quizViewModel.choices[1],
                    onTap: () {
                      if (currentWord.kor == quizViewModel.choices[1] &&
                          currentWord.eng == controller.text) {
                        //정답
                        controller.clear();
                        quizViewModel.isCorrect.value = true;
                        quizViewModel.databaseService
                            .updateIsCorrectedWord(currentWord);
                        wordViewModel.loadData();
                        Timer(
                          const Duration(milliseconds: 444),
                          () {
                            quizViewModel.isCorrect.value = false;
                            quizViewModel.isSame.value = false;
                            quizViewModel.nextQuestion(
                                level,
                                quizViewModel.count,
                                quizViewModel.loadByTable(mode));
                          },
                        );
                      } else if (currentWord.kor != quizViewModel.choices[1] &&
                          currentWord.eng == controller.text) {
                        //오답
                        quizViewModel.incorrectCount++;

                        quizViewModel.databaseService
                            .insertWrongWord(currentWord);
                        wordViewModel.loadData();
                        if (mode != ModeType.bomool.toKo) {
                          quizViewModel.databaseService
                              .deleteWord(currentWord.id);
                        }
                        controller.clear();
                        quizViewModel.isIncorrect.value = true;
                        Timer(
                          const Duration(milliseconds: 444),
                          () {
                            quizViewModel.isIncorrect.value = false;
                            quizViewModel.isSame.value = false;

                            quizViewModel.nextQuestion(
                                level,
                                quizViewModel.count,
                                quizViewModel.loadByTable(mode));
                          },
                        );
                      }
                    },
                  ),
                ],
              ),

              //텍스트 필드
              AnswerField(
                word: currentWord,
                controller: controller,
                focusNode: Get.find<QuizViewModel>().focusNode,
              ),
              const Spacer(),
            ],
          );
        }),
      ),
    );
  }

  AppBar appbar() {
    return AppBar(
      centerTitle: true,
      title: Row(
        children: [
          const Icon(FeatherIcons.book),
          const SizedBox(width: 3),
          Text(
            mode,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      leading: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              FeatherIcons.arrowLeft,
              size: 32,
            )),
      ),
    );
  }
}
