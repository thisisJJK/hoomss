import 'package:flutter/material.dart';

//추가 해야할것
//난이도 별 대화방목록 갱신
//버튼누르면 색 수정
//단어 달성률에 따라 난이도 버튼잠금해제

class DifficultyBtn extends StatelessWidget {
  final String difficulty;
  const DifficultyBtn({
    super.key,
    required this.difficulty,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        
        color: Colors.black12,
        borderRadius: BorderRadius.circular(15),
      ),
      width: 120,
      height: 50,
      child: Center(
        child: Text(
          difficulty,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Colors.black38,
          ),
        ),
      ),
    );
  }
}
