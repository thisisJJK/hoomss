import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:hoomss/data/dummy.dart';
import 'package:hoomss/ui/1/chat/chat_view_model.dart';
import 'package:hoomss/ui/1/chat/widget/bubble.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatViewModel chatViewModel = Get.put(ChatViewModel());

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
              Get.delete<ChatViewModel>();
            },
            icon: const Icon(
              FeatherIcons.arrowLeft,
              size: 32,
            ),
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Jack\'s chatroom',
          style: TextStyle(
              fontWeight: FontWeight.w700, fontSize: 21, letterSpacing: 0),
        ),
      ),

      //채팅창
      body: Obx(
        () => Column(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Get.find<ChatViewModel>().focusNode.unfocus();

                },
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ListView.separated(
                    padding: const EdgeInsets.only(bottom: 10),
                    controller: chatViewModel.scrollController,
                    reverse: true,
                    shrinkWrap: true,
                    itemCount: chatViewModel.loadCount.value,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 10);
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return chatViewModel.loadCount.value == 1
                          ? Bubble(
                              chat: chatViewModel
                                  .chatList[chatViewModel.loadCount.value - 1])
                          : Bubble(
                              chat: chatViewModel.chatList[
                                  chatViewModel.loadCount.value - 1 - index]);
                    },
                  ),
                ),
              ),
            ),
            BottomInputField(
                chatViewModel.chatList[chatViewModel.loadCount.value - 1]),
          ],
        ),
      ),
    );
  }
}

class BottomInputField extends StatelessWidget {
  final Chat chat;
  const BottomInputField(this.chat, {super.key});

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
                if (chat.message ==
                    Get.find<ChatViewModel>().textEditingController.text) {
                  Get.find<ChatViewModel>().onSubmitted(
                      Get.find<ChatViewModel>().textEditingController.text);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
