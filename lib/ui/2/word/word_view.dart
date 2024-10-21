import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hoomss/admob/ad_helper.dart';
import 'package:hoomss/data/word/word_data_type.dart';
import 'package:hoomss/ui/2/bomool_book/bomool_view.dart';
import 'package:hoomss/ui/2/quiz/quiz_view.dart';
import 'package:hoomss/ui/2/word/widget/mode_card.dart';
import 'package:hoomss/ui/2/word/word_view_model.dart';
import 'package:hoomss/ui/2/wrong_book/wrong_view.dart';

class WordView extends StatefulWidget {
  const WordView({super.key});

  @override
  State<WordView> createState() => _WordViewState();
}

class _WordViewState extends State<WordView> {
  final WordViewModel wordViewModel = Get.put(WordViewModel());
  BannerAd? _bannerAd;
  bool isAdReady = false;

  @override
  void initState() {
    wordViewModel.percent(ModeType.basic.toKo);
    wordViewModel.percent(ModeType.koreaTest.toKo);
    wordViewModel.percent(ModeType.toeic.toKo);
    adHelper().configureAdSettings(
      (ad) => {
        setState(() {
          _bannerAd = ad;
          isAdReady = true;
        })
      },
      BannerType.large,
    );

    super.initState();
  }

  @override
  void dispose() {
    adHelper().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: Column(
        children: [
          wordList(),
          //큰 광고
          if (isAdReady)
            SafeArea(
              child: SizedBox(
                width: _bannerAd!.size.width.toDouble(),
                height: _bannerAd!.size.height.toDouble(),
                child: AdWidget(ad: _bannerAd!),
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
                  mode: ModeType.bomool.toKo,
                  icon: Icons.diamond_outlined,
                  count: wordViewModel.bomoolCount,
                  onTap: () {
                    Get.to(() => BomoolView());
                  },
                ),

                const SizedBox(height: 12),

                //오답노답
                ModeCard(
                  mode: ModeType.wrong.toKo,
                  icon: FeatherIcons.meh,
                  count: wordViewModel.wrongCount,
                  onTap: () {
                    Get.to(() => WrongView());
                  },
                ),
                const SizedBox(height: 12),

                //기초
                ModeCard(
                  mode: ModeType.basic.toKo,
                  count: wordViewModel.basicCount,
                  percent: wordViewModel.currentPercent1,
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
                  mode: ModeType.koreaTest.toKo,
                  count: wordViewModel.kTestCount,
                  percent: wordViewModel.currentPercent2,
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
                  mode: ModeType.toeic.toKo,
                  count: wordViewModel.toeicCount,
                  percent: wordViewModel.currentPercent3,
                  onTap: () {
                    Get.to(() => QuizView(
                          mode: ModeType.toeic.toKo,
                          level: ModeType.toeic.toKo,
                        ));
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
