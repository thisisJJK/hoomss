import 'package:flutter/material.dart';

class AnswerField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  const AnswerField(
      {super.key, required this.focusNode, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Container(
        constraints: const BoxConstraints(minHeight: 50),
        decoration: const BoxDecoration(
            border: Border(
                top: BorderSide(
          color: Color(0xffe5e5ea),
        ))),
        width: double.infinity,
        child: TextField(
          autofocus: true,
          controller: controller,
          focusNode: focusNode,
          maxLines: 1,
          textAlignVertical: TextAlignVertical.top,
          style: const TextStyle(fontSize: 18),
          decoration: InputDecoration(
            hintText: '영단어 입력 후 정답 선택',
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}
