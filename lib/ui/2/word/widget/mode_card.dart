import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoomss/data/word/word_data_type.dart';
import 'package:hoomss/ui/2/word/word_view_model.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ModeCard extends StatelessWidget {
  final String mode;
  final RxInt? count;
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
    bool isBomoolWrong =
        mode == ModeType.bomool.toKo || mode == ModeType.wrong.toKo;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 110,
        padding: const EdgeInsets.fromLTRB(25, 5, 20, 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Theme.of(context).colorScheme.secondaryContainer,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    mode,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
                  ),
                  const Spacer(),

                  isBomoolWrong
                      ? Text('${count!.value} 개')
                      : Text(
                          '남은단어 : ${Get.find<WordViewModel>().currentCount(mode)}',
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),

                  //진행률
                  const SizedBox(width: 25),

                  Icon(
                    icon,
                    size: 68,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                ],
              );
            }),

            //퍼센트 게이지
            if (!isBomoolWrong)
              Obx(
                () => Align(
                  alignment: Alignment.centerRight,
                  child: CircularPercentIndicator(
                    radius: 38,
                    percent: Get.find<WordViewModel>().percent(mode),
                    lineWidth: 10,
                    animation: true,
                    center: Text(
                        '${Get.find<WordViewModel>().percent100(mode).toStringAsFixed(1)}%'),
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
