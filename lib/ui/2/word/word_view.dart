import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hoomss/data/word/word_data_type.dart';
import 'package:hoomss/ui/2/bomool_book/bomool_view.dart';
import 'package:hoomss/ui/2/quiz/quiz_view.dart';
import 'package:hoomss/ui/2/word/widget/mode_card.dart';
import 'package:hoomss/ui/2/word/word_view_model.dart';
import 'package:hoomss/ui/2/wrong_book/wrong_view.dart';

class WordView extends StatelessWidget {
  WordView({super.key});

  final WordViewModel wordViewModel = Get.find<WordViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: Column(
        children: [
          wordList(),
          //큰 광고
          if (wordViewModel.isAdReady.value)
            SafeArea(
              child: SizedBox(
                width: wordViewModel.bannerAd!.size.width.toDouble(),
                height: wordViewModel.bannerAd!.size.height.toDouble(),
                child: AdWidget(ad: wordViewModel.bannerAd!),
              ),
            )
        ],
      ),
    );
  }

  Expanded wordList() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //보물 단어장
                ModeCard(
                  mode: ModeType.bomool,
                  icon: Icons.diamond_outlined,
                  count: wordViewModel.bomoolCount,
                  onTap: () {
                    Get.to(() => BomoolView());
                  },
                ),

                const SizedBox(height: 12),

                //오답노답

                ModeCard(
                  mode: ModeType.wrong,
                  icon: FeatherIcons.meh,
                  count: wordViewModel.wrongCount,
                  onTap: () {
                    Get.to(() => WrongView());
                  },
                ),

                const SizedBox(height: 12),

                //기초

                ModeCard(
                  mode: ModeType.basic,
                  count: wordViewModel.basicCount,
                  percent: wordViewModel.currentPercent1,
                  onTap: () {
                    Get.to(() => QuizView(
                          mode: ModeType.basic,
                        ));
                  },
                ),
                const SizedBox(height: 12),

                //수능

                ModeCard(
                  mode: ModeType.koreaTest,
                  count: wordViewModel.kTestCount,
                  percent: wordViewModel.currentPercent2,
                  onTap: () {
                    Get.to(() => QuizView(
                          mode: ModeType.koreaTest,
                        ));
                  },
                ),

                const SizedBox(height: 12),

                //토익

                ModeCard(
                  mode: ModeType.toeic,
                  count: wordViewModel.toeicCount,
                  percent: wordViewModel.currentPercent3,
                  onTap: () {
                    Get.to(
                      () => QuizView(
                        mode: ModeType.toeic,
                      ),
                    );
                  },
                ),
              ],
            )),
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
