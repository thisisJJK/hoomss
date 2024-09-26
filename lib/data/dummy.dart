enum ChatMessageType {
  sent,
  received,
}

class Chat {
  final String message;
  final ChatMessageType type;

  Chat({
    required this.message,
    required this.type,
  });

  factory Chat.sent({required message}) =>
      Chat(message: message, type: ChatMessageType.sent);

  static List<Chat> generate() {
    return [
      Chat(
        message: "Hello!",
        type: ChatMessageType.sent,
      ),
      Chat(
        message: "Nice",
        type: ChatMessageType.received,
      ),
      Chat(
        message: "The",
        type: ChatMessageType.sent,
      ),
      // Chat(
      //   message: "Yes, it's a great day to go out.",
      //   type: ChatMessageType.received,
      // ),
      // Chat(
      //   message: "Have a nice day!",
      //   type: ChatMessageType.sent,
      // ),
      // Chat(
      //   message: "What are your plans for the weekend?",
      //   type: ChatMessageType.received,
      // ),
      // Chat(
      //   message: "I'm planning to go to the beach.",
      //   type: ChatMessageType.sent,
      // ),
      // Chat(
      //   message: "That sounds fun!",
      //   type: ChatMessageType.received,
      // ),
      // Chat(
      //   message: "Do you want to come with me?",
      //   type: ChatMessageType.sent,
      // ),
      // Chat(
      //   message: "Sure, I'd love to!",
      //   type: ChatMessageType.received,
      // ),
      // Chat(
      //   message: "What time should we meet?",
      //   type: ChatMessageType.received,
      // ),
      // Chat(
      //   message: "Let's meet at 10am.",
      //   type: ChatMessageType.sent,
      // ),
      // Chat(
      //   message: "Sounds good to me!",
      //   type: ChatMessageType.received,
      // ),
      // Chat(
      //   message: "See you then!",
      //   type: ChatMessageType.sent,
      // ),
      // Chat(
      //   message: "Bye!",
      //   type: ChatMessageType.received,
      // ),
      // Chat(
      //   message: "How was your weekend?",
      //   type: ChatMessageType.received,
      // ),
      // Chat(
      //   message: "It was great! The beach was awesome.",
      //   type: ChatMessageType.sent,
      // ),
      // Chat(
      //   message: "I'm glad to hear that!",
      //   type: ChatMessageType.received,
      // ),
      // Chat(
      //   message: "We should do that again sometime.",
      //   type: ChatMessageType.sent,
      // ),
      // Chat(
      //   message: "Definitely!",
      //   type: ChatMessageType.received,),
    ];
  }
}
