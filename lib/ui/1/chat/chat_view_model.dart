import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoomss/data/dummy.dart';

class ChatViewModel extends GetxController {
  List<Chat> chatList = Chat.generate();
  RxInt loadCount = 1.obs;

  late final TextEditingController textEditingController =
      TextEditingController();
  late final ScrollController scrollController = ScrollController();
  late final FocusNode focusNode = FocusNode();

  bool get isTextFieldEnable => textEditingController.text.isNotEmpty;

  void onSubmitted(String text) {
    if (!isTextFieldEnable) return;

    if (loadCount < chatList.length) {
      loadCount++;
    }

    if (loadCount.value == chatList.length &&
        text == chatList[loadCount.value - 1].message) {
      Get.dialog(
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
                loadCount.value = 1;
              }, // 다이얼로그 닫기
              child: const Text("한번더"),
            ),
          ],
        ),
      );
    }

    scrollController.animateTo(0,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);

    textEditingController.text = '';
  }
}
