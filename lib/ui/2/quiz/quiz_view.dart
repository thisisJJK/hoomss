import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:hoomss/ui/2/quiz/quiz_view_model.dart';
import 'package:hoomss/ui/2/quiz/widget/answer_btn.dart';
import 'package:hoomss/ui/2/quiz/widget/answer_field.dart';
import 'package:hoomss/ui/2/quiz/widget/quiz_card.dart';

class QuizView extends StatelessWidget {
  final String mode;
  QuizView({super.key, required this.mode});

  final QuizViewModel quizViewModel = Get.put(QuizViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: appbar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Column(
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
            const QuizCard(word: 'word'),
            const SizedBox(height: 12),

            //흘린 단어장 버튼
            const AnswerBtn(),
            const SizedBox(height: 5),

            //보기 버튼 2개
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnswerBtn(),
                SizedBox(width: 5),
                AnswerBtn(),
              ],
            ),
            const SizedBox(height: 12),

            //텍스트 필드
            AnswerField(
              focusNode: Get.find<QuizViewModel>().focusNode,
            ),
          ],
        ),
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
