import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hoomss/data/chat/chat_data_type.dart';
import 'package:hoomss/data/chat/chat_model.dart';

class ChatListViewModel extends GetxController {
  var chats = <ChatModel>[].obs;
  var filterChats = <ChatModel>[].obs;
  var selectedDifficulty = DifficultyType.easy.obs;
  var isBtnTap1 = true.obs;
  var isBtnTap2 = false.obs;
  var isBtnTap3 = false.obs;

  @override
  void onInit() {
    loadChats();

    super.onInit();
  }

  Future<bool> loadChats() async {
    try {
      //chat
      if (chats.isEmpty) {
        String jsonString = await rootBundle.loadString('assets/chat.json');

        Map<String, dynamic> jsonData = jsonDecode(jsonString);

        List<dynamic> chatList = jsonData['chats'];

        chats.value = chatList.map((chat) => ChatModel.fromMap(chat)).toList();
      }

      filterChatsByDifficulty(DifficultyType.easy);

      return true;
    } catch (e) {
      print(e);

      return false;
    }
  }

  void filterChatsByDifficulty(DifficultyType difficulty) {
    selectedDifficulty.value = difficulty;
    filterChats.value = chats.where((c) => c.difficulty == difficulty).toList();
  }

  DifficultyType stringToType(String difficultyString) {
    return DifficultyType.values
        .firstWhere((e) => e.toString().split('.').last == difficultyString);
  }
}
