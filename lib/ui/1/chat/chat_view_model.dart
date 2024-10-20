import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoomss/data/chat/chat_model.dart';
import 'package:hoomss/data/database_service.dart';

class ChatViewModel extends GetxController {
  var currentChats = <ConversationModel>[].obs;

  var currentIndex = 0.obs;
  var isLast = false.obs;
  var isEng = true.obs;

  final ChatModel chatModel;

  ChatViewModel({required this.chatModel}) {
    currentChats.add(chatModel.conversations[currentIndex.value]);
  }

  final DatabaseService databaseService = Get.put(DatabaseService());
  late final TextEditingController textEditingController =
      TextEditingController();
  late final ScrollController scrollController = ScrollController();
  late final FocusNode focusNode = FocusNode();

  bool get isTextFieldEnable => textEditingController.text.isNotEmpty;

  void changeBubble() {
    isEng.value ? isEng.value = false : isEng.value = true;
  }

  void onSubmitted(String text) {
    if (!isTextFieldEnable) return;

    if (currentIndex.value < chatModel.conversations.length - 1) {
      currentIndex++;
      currentChats.add(chatModel.conversations[currentIndex.value]);
    }

    if (currentIndex.value == chatModel.conversations.length - 1 &&
        text.toLowerCase() ==
            currentChats[currentIndex.value].content.toLowerCase()) {
      isLast.value = true;
      showEnd();
    }

    textEditingController.text = '';
  }

  Future<dynamic> showEnd() {
    return Get.dialog(
      AlertDialog(
        title: const Text("흐흐.. 흥미진진하구만"),
        content: const Text("한번 더 훔쳐볼래?"),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              Get.back(); // 다이얼로그 닫기
            },
            child: const Text("아니요"),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              currentIndex.value = 0;
              currentChats.clear();
              currentChats.add(chatModel.conversations[currentIndex.value]);
            }, // 다이얼로그 닫기
            child: const Text("한번더"),
          ),
        ],
      ),
    );
  }
}
