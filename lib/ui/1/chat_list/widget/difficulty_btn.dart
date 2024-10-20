import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoomss/data/chat/chat_data_type.dart';
import 'package:hoomss/ui/1/chat_list/chat_list_view_model.dart';

//추가 해야할것
//난이도 별 대화방목록 갱신
//버튼누르면 색 수정
//단어 달성률에 따라 난이도 버튼잠금해제

class DifficultyBtn extends StatelessWidget {
  final DifficultyType difficulty;
  final bool isSelected;
  const DifficultyBtn({
    super.key,
    required this.difficulty,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.find<ChatListViewModel>().filterChatsByDifficulty(difficulty);
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(15),
        ),
        width: 120,
        height: 50,
        child: Center(
          child: Text(
            difficulty.toKo,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: isSelected
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.onSecondaryContainer),
          ),
        ),
      ),
    );
  }
}
