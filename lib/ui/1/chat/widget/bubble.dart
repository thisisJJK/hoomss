import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoomss/data/chat/chat_data_type.dart';
import 'package:hoomss/ui/1/chat/chat_view_model.dart';

class Bubble extends StatelessWidget {
  final String bubble;
  final int count;
  const Bubble({
    super.key,
    required this.bubble, required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Center(
        child: Obx(() {
          var type = Get.find<ChatViewModel>().currentChats[count].type;

          return Align(
            alignment:
                type == ChatType.sent ? Alignment.topRight : Alignment.topLeft,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: type == ChatType.sent ? Colors.green : Colors.black12,
              ),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.8,
              ),
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Text(
                bubble,
                style: TextStyle(
                  fontSize: 18,
                  color: type == ChatType.sent ? Colors.white : Colors.black,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

  // AlignmentGeometry get alignType {
  //   ChatType type=  Get.find<ChatViewModel>().contents.type;
  //   }
  // }

  // Color get colorType {
  //   switch (chat.type) {
  //     case ChatMessageType.sent:
  //       return Colors.green;
  //     case ChatMessageType.received:
  //       return Colors.black12;
  //   }
  // }

  // Color get textColorType {
  //   switch (chat.type) {
  //     case ChatMessageType.sent:
  //       return Colors.white;
  //     case ChatMessageType.received:
  //       return Colors.black;
  //   }
  // }

  // EdgeInsetsGeometry get paddingType {
  //   switch (chat.type) {
  //     case ChatMessageType.sent:
  //       return const EdgeInsets.fromLTRB(20, 10, 20, 10);
  //     case ChatMessageType.received:
  //       return const EdgeInsets.fromLTRB(20, 10, 20, 10);
  //   }
  // }

