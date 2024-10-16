import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:hoomss/data/chat/chat_model.dart';
import 'package:hoomss/ui/1/chat/chat_view_model.dart';
import 'package:hoomss/ui/1/chat/widget/bubble.dart';

class ChatView extends StatelessWidget {
  final ChatModel chat;
  ChatView({
    super.key,
    required this.chat,
  }) {
    Get.put(
      ChatViewModel(
        chatModel: chat,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              FeatherIcons.arrowLeft,
              size: 32,
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          chat.situation,
          style: const TextStyle(
              fontWeight: FontWeight.w700, fontSize: 21, letterSpacing: 0),
        ),
      ),

      //채팅창
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Get.find<ChatViewModel>().focusNode.unfocus();
        },
        child: Obx(
          () => Column(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ListView.separated(
                    padding: const EdgeInsets.only(bottom: 10),
                    controller: Get.find<ChatViewModel>().scrollController,
                    reverse: false,
                    shrinkWrap: true,
                    itemCount: Get.find<ChatViewModel>().currentChats.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 10);
                    },
                    itemBuilder: (BuildContext context, int index) {
                      final String bubble =
                          Get.find<ChatViewModel>().currentChats[index].content;
                      final int count = index;
                      return Bubble(
                        bubble: bubble,
                        count: count,
                      );
                    },
                  ),
                ),
              ),
              const BottomInputField(),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomInputField extends StatelessWidget {
  const BottomInputField({
    super.key,
  });

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
            IconButton(
              icon: const Icon(FeatherIcons.edit),
              onPressed: () {},
            ),
            Expanded(
              child: TextField(
                autofocus: true,
                focusNode: Get.find<ChatViewModel>().focusNode,
                controller: Get.find<ChatViewModel>().textEditingController,
                maxLines: null,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  hintText: '따라써보세요',
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
              onPressed: () {
                if (Get.find<ChatViewModel>()
                        .currentChats[
                            Get.find<ChatViewModel>().currentIndex.value]
                        .content ==
                    Get.find<ChatViewModel>().textEditingController.text) {
                  Get.find<ChatViewModel>().onSubmitted(
                      Get.find<ChatViewModel>().textEditingController.text);

                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Get.find<ChatViewModel>().scrollController.animateTo(
                        Get.find<ChatViewModel>()
                            .scrollController
                            .position
                            .maxScrollExtent,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut);
                  });
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
