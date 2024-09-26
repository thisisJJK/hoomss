import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuizViewModel extends GetxController {
  late final FocusNode focusNode = FocusNode();

  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(Get.context!).requestFocus(focusNode);
    });
    super.onInit();
  }

  @override
  void onClose() {
    focusNode.dispose();
    super.onClose();
  }
}
