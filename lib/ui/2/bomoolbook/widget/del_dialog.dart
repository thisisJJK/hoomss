import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoomss/ui/2/bomoolbook/bomool_view_model.dart';

Widget delDialog(int id) {
  return AlertDialog(
    title: const Text("이 단어를 삭제하시겠습니까?"),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {
                Get.find<BomoolViewModel>()
                    .databaseService
                    .deleteBomoolWord(id)
                    .then(
                  (result) {
                    if (result) {
                      Get.find<BomoolViewModel>().readBomoolWordList();
                      Get.back();
                    } else {
                      print("delete error");
                    }
                  },
                );
              },
              child: const Text("예"),
            ),
            ElevatedButton(
              onPressed: () => Get.back(),
              child: const Text("아니오"),
            ),
          ],
        ),
      ],
    ),
  );
}
