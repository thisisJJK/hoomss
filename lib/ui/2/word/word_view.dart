import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:hoomss/ui/2/bomoolbook/bomool_view.dart';
import 'package:hoomss/ui/2/quiz/quiz_view.dart';
import 'package:hoomss/ui/2/word/widget/mode_card.dart';

enum ModeType {
  wrong(toKo: '흘린 단어장'),
  basic(toKo: '기초 / 중등'),
  koreaTest(toKo: '수능'),
  toeic(toKo: '토익');

  final String toKo;
  const ModeType({required this.toKo});
}

class WordView extends StatelessWidget {
  const WordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ModeCard(
              title: '보물 단어장',
              number: 1000,
              icon: FeatherIcons.plus,
              onTap: () {
                Get.to(() => const BomoolView());
              },
            ),
            const SizedBox(height: 12),
            ModeCard(
              title: ModeType.wrong.toKo,
              number: 1000,
              icon: FeatherIcons.circle,
              onTap: () {
                Get.to(() => QuizView(mode: ModeType.wrong.toKo));
              },
            ),
            const SizedBox(height: 12),
            ModeCard(
              title: ModeType.basic.toKo,
              number: 1000,
              icon: FeatherIcons.circle,
              onTap: () {
                Get.to(() => QuizView(mode: ModeType.basic.toKo));
              },
            ),
            const SizedBox(height: 12),
            ModeCard(
              title: ModeType.koreaTest.toKo,
              number: 1000,
              icon: FeatherIcons.circle,
              onTap: () {
                Get.to(() => QuizView(mode: ModeType.koreaTest.toKo));
              },
            ),
            const SizedBox(height: 12),
            ModeCard(
              title: ModeType.toeic.toKo,
              number: 1000,
              icon: FeatherIcons.circle,
              onTap: () {
                Get.to(() => QuizView(mode: ModeType.toeic.toKo));
              },
            ),
          ],
        ),
      ),
    );
  }

  AppBar appbar() {
    return AppBar(
      centerTitle: true,
      title: const Row(
        children: [
          Icon(FeatherIcons.book),
          SizedBox(width: 3),
          Text(
            '단어 훔치기',
            style: TextStyle(
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
