import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:hoomss/data/word/word_data_type.dart';
import 'package:hoomss/ui/2/bomool_book/bomool_view.dart';
import 'package:hoomss/ui/2/quiz/quiz_view.dart';
import 'package:hoomss/ui/2/word/widget/mode_card.dart';
import 'package:hoomss/ui/2/wrong_book/wrong_view.dart';

class WordView extends StatelessWidget {
  const WordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //보물 단어장
              ModeCard(
                title: ModeType.bomool.toKo,
                number: 1000,
                icon: FeatherIcons.star,
                onTap: () {
                  Get.to(() => BomoolView());
                },
              ),
              const SizedBox(height: 12),

              //오답노답
              ModeCard(
                title: ModeType.wrong.toKo,
                number: 1000,
                icon: FeatherIcons.x,
                onTap: () {
                  Get.to(() => WrongView());
                },
              ),
              const SizedBox(height: 12),

              //기초
              ModeCard(
                title: ModeType.basic.toKo,
                number: 1000,
                icon: FeatherIcons.circle,
                onTap: () {
                  Get.to(() => QuizView(
                        mode: ModeType.basic.toKo,
                        level: ModeType.basic.toKo,

                      ));
                },
              ),
              const SizedBox(height: 12),

              //수능
              ModeCard(
                title: ModeType.koreaTest.toKo,
                number: 1000,
                icon: FeatherIcons.circle,
                onTap: () {
                  Get.to(() => QuizView(
                        mode: ModeType.koreaTest.toKo,
                        level: ModeType.koreaTest.toKo,

                      ));
                },
              ),
              const SizedBox(height: 12),

              //토익
              ModeCard(
                title: ModeType.toeic.toKo,
                number: 1000,
                icon: FeatherIcons.circle,
                onTap: () {
                  Get.to(() => QuizView(
                        mode: ModeType.toeic.toKo,
                        level: ModeType.toeic.toKo,

                      ));
                },
              ),
            ],
          ),
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
