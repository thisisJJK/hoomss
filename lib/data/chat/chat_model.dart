import 'package:hoomss/data/chat/chat_data_type.dart';

class ChatModel {
  // final int id;
  final String situation;
  final DifficultyType difficulty; // 'easy', 'medium', 'hard'로 난이도 구분
  final List<ConversationModel> conversations;

  ChatModel({
    // required this.id,
    required this.situation,
    required this.difficulty,
    required this.conversations,
  });

//데이터 => map (db에 저장할때)
  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'situation': situation,
      'difficulty': difficulty.toString().split('.').last,
      'conversations': conversations.map((e) => e.toMap()).toList(),
    };
  }

// map => 데이터 (db에서 불러오기)
  factory ChatModel.fromMap(Map<String, dynamic> map) {
    List<ConversationModel> conversationList = (map['conversations'] as List)
        .map((i) => ConversationModel.fromMap(i))
        .toList();
    return ChatModel(
      // id: map['id'],
      situation: map['situation'],
      difficulty: _difficultyTypeHelper(map['difficulty']),
      conversations: conversationList,
    );
  }
  static DifficultyType _difficultyTypeHelper(String difficultyString) {
    return DifficultyType.values
        .firstWhere((e) => e.toString().split('.').last == difficultyString);
  }

  @override
  String toString() {
    return 'ChatModel{ situation: $situation, difficulty: $difficulty, conversations: $conversations,}';
  }
}

class ConversationModel {
  // final int id;
  final String content;
  final ChatType type; // 'sent' 또는 'received'

  ConversationModel({
    // required this.id,
    required this.content,
    required this.type,
  });

//데이터 => map (db에 저장할때)
  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'content': content,
      'type': type.toString().split('.').last,
    };
  }

// map => 데이터 (db에서 불러오기)
  factory ConversationModel.fromMap(Map<String, dynamic> map) {
    return ConversationModel(
      // id: map['id'],
      content: map['content'],
      type: _chatTypeHelper(map['type']),
    );
  }

  static ChatType _chatTypeHelper(String typeString) {
    return ChatType.values
        .firstWhere((e) => e.toString().split('.').last == typeString);
  }

  @override
  String toString() {
    return 'ConversationModel{ content: $content, type: $type}';
  }
}
