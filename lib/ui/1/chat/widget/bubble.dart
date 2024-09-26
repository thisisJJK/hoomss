import 'package:flutter/material.dart';
import 'package:hoomss/data/dummy.dart';

class Bubble extends StatelessWidget {
  final Chat chat;
  const Bubble({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Center(
        child: Align(
          alignment: alignType,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: colorType,
            ),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.8,
            ),
            padding: paddingType,
            child: Text(
              chat.message,
              style: TextStyle(
                fontSize: 18,
                color: textColorType,
              ),
            ),
          ),
        ),
      ),
    );
  }

  AlignmentGeometry get alignType {
    switch (chat.type) {
      case ChatMessageType.sent:
        return Alignment.centerRight;
      case ChatMessageType.received:
        return Alignment.centerLeft;
    }
  }

  Color get colorType {
    switch (chat.type) {
      case ChatMessageType.sent:
        return Colors.green;
      case ChatMessageType.received:
        return Colors.black12;
    }
  }

  Color get textColorType {
    switch (chat.type) {
      case ChatMessageType.sent:
        return Colors.white;
      case ChatMessageType.received:
        return Colors.black;
    }
  }

  EdgeInsetsGeometry get paddingType {
    switch (chat.type) {
      case ChatMessageType.sent:
        return const EdgeInsets.fromLTRB(20, 10, 20, 10);
      case ChatMessageType.received:
        return const EdgeInsets.fromLTRB(20, 10, 20, 10);
    }
  }
}
