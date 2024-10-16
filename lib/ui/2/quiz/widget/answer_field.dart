import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoomss/data/word/word_model.dart';
import 'package:hoomss/ui/2/quiz/quiz_view_model.dart';

class AnswerField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final WordModel word;
  const AnswerField(
      {super.key,
      required this.focusNode,
      required this.controller,
      required this.word});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Color(0xffe5e5ea),
            ),
          ),
        ),
        child: TextField(
          onChanged: (text) {
            if (text == word.eng) {
              Get.find<QuizViewModel>().isSame.value = true;
            } else {
              Get.find<QuizViewModel>().isSame.value = false;
            }
          },
          showCursor: false,
          textAlign: TextAlign.center,
          autofocus: true,
          controller: controller,
          focusNode: focusNode,
          maxLines: 1,
          textAlignVertical: TextAlignVertical.top,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            hintText: '영단어 입력 후 정답 선택',
            hintStyle: const TextStyle(fontSize: 21),
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}
