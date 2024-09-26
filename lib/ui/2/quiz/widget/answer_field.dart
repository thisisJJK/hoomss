import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class AnswerField extends StatelessWidget {
  final FocusNode focusNode;
  const AnswerField({super.key, required this.focusNode});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Container(
        constraints: const BoxConstraints(minHeight: 48),
        decoration: const BoxDecoration(
            border: Border(
                top: BorderSide(
          color: Color(0xffe5e5ea),
        ))),
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                focusNode: focusNode,
                maxLines: 1,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  hintText: '입력 후 정답 선택',
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.only(
                    right: 42,
                    left: 16,
                  ),
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
            IconButton(
              icon: const Icon(FeatherIcons.send),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
