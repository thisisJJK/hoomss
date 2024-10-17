import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoomss/data/word/word_data_type.dart';
import 'package:hoomss/ui/2/word/word_view_model.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ModeCard extends StatelessWidget {
  final String mode;
  final int? count;
  final IconData? icon;

  final Function() onTap;

  const ModeCard({
    super.key,
    required this.mode,
    this.icon,
    required this.onTap,
    this.count,
  });

  @override
  Widget build(BuildContext context) {
    double percent = Get.find<WordViewModel>().percent(mode);
    double percent100 = percent * 100;
    bool isBomoolWrong =
        mode == ModeType.bomool.toKo || mode == ModeType.wrong.toKo;
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: 110,
          padding: const EdgeInsets.fromLTRB(25, 20, 20, 20),
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    mode,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  const Spacer(),

                  isBomoolWrong
                      ? Text('$count 개')
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '전체단어  ${Get.find<WordViewModel>().total(mode)}',
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              '남은단어  ${Get.find<WordViewModel>().currentCount(mode)}',
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),

                  //진행률
                  const SizedBox(width: 15),

                  Icon(
                    icon,
                    size: 68,
                  ),
                ],
              ),
              //퍼센트 게이지
              if (!isBomoolWrong)
                Align(
                  alignment: Alignment.centerRight,
                  child: CircularPercentIndicator(
                    radius: 35,
                    percent: percent,
                    lineWidth: 10,
                    animation: true,
                    center: Text('${percent100.toStringAsFixed(1)}%'),
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: Colors.green,
                  ),
                )
            ],
          )),
    );
  }
}
