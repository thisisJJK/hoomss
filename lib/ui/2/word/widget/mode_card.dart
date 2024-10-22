import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoomss/data/word/word_data_type.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ModeCard extends StatelessWidget {
  final ModeType mode;
  final RxInt? count;
  final RxDouble? percent;
  final IconData? icon;

  final Function() onTap;

  const ModeCard({
    super.key,
    required this.mode,
    this.icon,
    required this.onTap,
    this.count,
    this.percent,
  });

  @override
  Widget build(BuildContext context) {
    bool isBomoolWrong = mode == ModeType.bomool || mode == ModeType.wrong;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        padding: const EdgeInsets.fromLTRB(25, 5, 20, 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Theme.of(context).colorScheme.secondaryContainer,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  mode.toKo,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                ),
                const Spacer(),

                isBomoolWrong
                    ? Obx(() => Text('${count!.value} 개'))
                    : Obx(
                        () => Text(
                          '남은단어 : ${count!.value}',
                          style: const TextStyle(
                            fontSize: 12,
                          ),
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
            ),

            //퍼센트 게이지
            if (!isBomoolWrong)
              Align(
                  alignment: Alignment.centerRight,
                  child: Obx(() {
                    var percent100 = percent!.value * 100;

                    return CircularPercentIndicator(
                      radius: 38,
                      percent: percent!.value,
                      lineWidth: 10,
                      animation: true,
                      center: Text('${percent100.toStringAsFixed(1)}%'),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: Theme.of(context).colorScheme.primary,
                    );
                  })),
          ],
        ),
      ),
    );
  }
}
