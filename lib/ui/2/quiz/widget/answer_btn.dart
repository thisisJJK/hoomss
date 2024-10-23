import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoomss/ui/2/quiz/quiz_view_model.dart';

class AnswerBtn extends StatelessWidget {
  final Function() onTap;
  final String text;
  const AnswerBtn({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    var isSame = Get.find<QuizViewModel>().isSame;
    return Obx(
      () => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.only(left: 5, right: 5),
          width: MediaQuery.of(context).size.width * 0.5 - 25,
          height: MediaQuery.of(context).size.height * 0.085,
          decoration: BoxDecoration(
            border:
                isSame.value ? Border.all() : Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: AutoSizeText(
              text,
              maxLines: 2,
              minFontSize: 12,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                color: isSame.value
                    ? Theme.of(context).colorScheme.onSurface
                    : Colors.transparent,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
