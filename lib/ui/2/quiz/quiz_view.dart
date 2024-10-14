import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:hoomss/ui/2/quiz/quiz_view_model.dart';
import 'package:hoomss/ui/2/quiz/widget/answer_btn.dart';
import 'package:hoomss/ui/2/quiz/widget/answer_field.dart';
import 'package:hoomss/ui/2/quiz/widget/quiz_card.dart';

class QuizView extends StatelessWidget {
  final String level;
  final String mode;
  QuizView({super.key, required this.mode, required this.level});

  final QuizViewModel quizViewModel = Get.put(QuizViewModel());
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    quizViewModel.loadRandomWords(level, 5);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: appbar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Obx(() {
          if (quizViewModel.questions.isEmpty ||
              quizViewModel.choices.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
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
              QuizCard(word: currentWord),
              const SizedBox(height: 12),

              //보기 버튼 2개
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnswerBtn(
                    text: quizViewModel.choices[0],
                    onTap: () {
                      if (currentWord.kor == quizViewModel.choices[0] &&
                          currentWord.eng == controller.text) {
                        controller.clear();
                        quizViewModel.nextQuestion(level, quizViewModel.count);
                      }
                    },
                  ),
                  const SizedBox(width: 5),
                  AnswerBtn(
                    text: quizViewModel.choices[1],
                    onTap: () {
                      if (currentWord.kor == quizViewModel.choices[1] &&
                          currentWord.eng == controller.text) {
                        controller.clear();
                        quizViewModel.nextQuestion(level, quizViewModel.count);
                      }
                    },
                  ),
                ],
              ),
              const Spacer(),

              //텍스트 필드
              AnswerField(
                controller: controller,
                focusNode: Get.find<QuizViewModel>().focusNode,
              ),
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
